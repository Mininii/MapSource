// MSF_UE_RE.e3s 로 EUD Editor 3 의 빌드 파일(eudplibData)을 GUI 없이 만든다. SCR_DB 판으로 고쳐서:
//   - SCArchive(SCA) 를 끈다 (_SCArchive._IsUsed = false). SCA 서버가 닫혀 SCAFlexible.eps 를
//     만들 수 없고(로그인이 필요하다), 세이브는 이제 Lua 의 SCR_DB 가 맡는다.
//   - TE 메인 파일을 main_scrdb.eps 로 바꾼다 (원본 sca.eps 에서 SCArchive 를 걷어 낸 것).
//   - 입력 맵 경로를 지금 있는 맵으로 바꾼다 (e3s 가 기억하는 MSF_UE_RE_out.scx 는 이제 없다).
// e3s 파일 자체는 건드리지 않는다 - 메모리에서만 고친다.
// EUD Editor 폴더를 ApplicationBase 로 둔 AppDomain 안에서 돌려야 한다 (run_eudgen.ps1).
// 바탕은 DPS 때 만든 EudGen.cs 다 (DPS_Enhance 메모의 reference-eud-editor3-headless-gen).
using System;
using System.Collections;
using System.IO;
using System.Reflection;
using System.Text;

public class EudGenMsf : MarshalByRefObject
{
    StringBuilder log = new StringBuilder();
    Assembly asm;
    const BindingFlags Inst = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

    Type T(string name) { return asm.GetType(name, true); }
    void SetStatic(string type, string field, object value)
    {
        T(type).GetField(field, BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic).SetValue(null, value);
    }
    object New(string type) { return Activator.CreateInstance(T(type), true); }

    static FieldInfo FindField(object o, string name)
    {
        for (Type t = o.GetType(); t != null; t = t.BaseType)
        {
            FieldInfo f = t.GetField(name, Inst | BindingFlags.DeclaredOnly);
            if (f != null) return f;
        }
        throw new Exception("no field " + name + " on " + o.GetType().FullName);
    }
    static object Get(object o, string name) { return FindField(o, name).GetValue(o); }
    static void Set(object o, string name, object v) { FindField(o, name).SetValue(o, v); }

    void Step(string what, Action a)
    {
        try { a(); log.AppendLine("ok   " + what); }
        catch (Exception ex)
        {
            Exception e = ex is TargetInvocationException && ex.InnerException != null ? ex.InnerException : ex;
            log.AppendLine("FAIL " + what + " : " + e.GetType().Name + ": " + e.Message);
            log.AppendLine(e.StackTrace);
            throw;
        }
    }
    void StepSoft(string what, Action a)
    {
        try { a(); log.AppendLine("ok   " + what); }
        catch (Exception ex)
        {
            Exception e = ex is TargetInvocationException && ex.InnerException != null ? ex.InnerException : ex;
            log.AppendLine("soft-FAIL " + what + " : " + e.GetType().Name + ": " + e.Message);
        }
    }

    // SaveData 를 SCR_DB 판으로 고친다. LoadInit 앞(맵 경로)과 뒤(TE/SCA) 두 번 부른다 -
    // LoadInit 이 무엇을 다시 채우는지 몰라서 확실히 해 둔다.
    void Patch(object sd, string code, string openMap, string saveMap)
    {
        Set(sd, "mOpenMapName", openMap);
        Set(sd, "mRelativeOpenMapName", openMap);
        Set(sd, "mSaveMapName", saveMap);
        Set(sd, "mRelativeSaveMapName", saveMap);
        object te = Get(sd, "TEData");
        Set(Get(te, "_SCArchive"), "_IsUsed", false);
        int n = 0;
        object main = Get(te, "_MainFile");
        if (main != null)
        {
            object s = Get(main, "_Scripter");
            if (s != null) { Set(s, "_String", code); n++; }
        }
        object pf = Get(te, "ProjectFile");
        foreach (object f in (IEnumerable)Get(pf, "_Files"))
        {
            object s = Get(f, "_Scripter");
            if (s != null && Get(f, "_FileName") as string == "main") { Set(s, "_String", code); n++; }
        }
        log.AppendLine("     patch: SCA off, TE main x" + n + ", open=" + openMap);
    }

    public string Run(string eudDir, string e3sPath, string outDir, string mainEpsPath, string openMap, string saveMap)
    {
        try
        {
            asm = Assembly.LoadFrom(Path.Combine(eudDir, "EUD Editor 3.exe"));
            string code = File.ReadAllText(mainEpsPath, Encoding.UTF8);
            log.AppendLine("base " + AppDomain.CurrentDomain.BaseDirectory);
            Step("new System.Windows.Application()", () =>
            {
                Type app = Type.GetType("System.Windows.Application, PresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35", true);
                if (app.GetProperty("Current").GetValue(null, null) == null) Activator.CreateInstance(app);
            });
            Step("pgData = new ProgramData()", () => SetStatic("EUD_Editor_3.GlobalObj", "pgData", New("EUD_Editor_3.ProgramData")));
            Step("Tool.OffsetDicInit()", () => T("EUD_Editor_3.Tool.Tool").GetMethod("OffsetDicInit", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic).Invoke(null, null));
            Step("Tool.CodeGrouping", () => T("EUD_Editor_3.Tool.Tool").GetField("CodeGrouping", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic).SetValue(null, New("EUD_Editor_3.CodeGrouping")));
            Step("scData = new StarCraftData()", () => SetStatic("EUD_Editor_3.GlobalObj", "scData", New("EUD_Editor_3.StarCraftData")));
            Step("macro = new MacroManager()", () => SetStatic("EUD_Editor_3.GlobalObj", "macro", New("EUD_Editor_3.MacroManager")));
            Type pjT = T("EUD_Editor_3.ProjectData");
            object pj = New("EUD_Editor_3.ProjectData");
            SetStatic("EUD_Editor_3.GlobalObj", "pjData", pj);
            Step("pj.NewFIle()", () => pjT.GetMethod("NewFIle", Inst).Invoke(pj, null));
            Step("pj.InitData()", () => pjT.GetMethod("InitData", Inst).Invoke(pj, null));
            object sd = null;
            Step("SaveData = Deserialize(e3s)", () =>
            {
                using (FileStream fs = File.OpenRead(e3sPath))
                {
                    sd = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter().Deserialize(fs);
                    pjT.GetField("SaveData", Inst).SetValue(pj, sd);
                }
            });
            Step("patch (before LoadInit)", () => Patch(sd, code, openMap, saveMap));
            Step("pj.LoadInit(e3s)", () => pjT.GetMethod("LoadInit", Inst).Invoke(pj, new object[] { e3sPath }));
            Step("pj.Legacy()", () => pjT.GetMethod("Legacy", Inst).Invoke(pj, null));
            Step("TeFileRefresh(PFIles)", () =>
            {
                object te = pjT.GetProperty("TEData").GetValue(pj, null);
                object pf = te.GetType().GetProperty("PFIles").GetValue(te, null);
                pjT.GetMethod("TeFileRefresh", BindingFlags.Static | BindingFlags.NonPublic).Invoke(null, new object[] { pf });
            });
            Step("patch (after LoadInit)", () => Patch(pjT.GetField("SaveData", Inst).GetValue(pj), code, openMap, saveMap));
            object mapData = pjT.GetProperty("MapData").GetValue(pj, null);
            log.AppendLine("     MapData " + (mapData == null ? "null (base map not loaded!)" : "loaded"));
            Step("TempFileLoc -> outDir", () => pj.GetType().GetProperty("TempFileLoc").SetValue(pj, outDir, null));
            PropertyInfo tf = T("EUD_Editor_3.BuildData").GetProperty("TempFloder", BindingFlags.Static | BindingFlags.Public);
            log.AppendLine("     TempFloder = " + tf.GetValue(null, null));
            object bd = New("EUD_Editor_3.BuildData");
            foreach (string w in new[] { "WriteRequireData", "WriteDatFile", "WriteExtraDatFile", "WriteTbl", "WriteTEFile" })
            {
                string name = w;
                Step(name, () => bd.GetType().GetMethod(name, Inst).Invoke(bd, null));
            }
            foreach (string w in new[] { "WriteBGMData", "WriteDotData" })
            {
                string name = w;
                StepSoft(name, () => bd.GetType().GetMethod(name, Inst).Invoke(bd, null));
            }
            Step("WriteedsFile(false) -> .eds", () => bd.GetType().GetMethod("WriteedsFile", Inst).Invoke(bd, new object[] { false }));
        }
        catch (Exception) { }
        return log.ToString();
    }
}
