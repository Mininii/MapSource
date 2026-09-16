from eudplib import *
import traceback
def tryit(name, fn):
    PushTriggerScope()
    c0 = GetTriggerCounter()
    try:
        fn()
        print(name, "OK  triggers:", GetTriggerCounter() - c0)
    except Exception as e:
        print(name, "ERR", type(e).__name__, str(e).splitlines()[0][:120])
    PopTriggerScope()
v = EUDVariable(); lv = EUDLightVariable(); arr = EUDArray(480)
tryit("lv << const", lambda: lv << 5)
tryit("lv << var", lambda: lv << v)
tryit("SeqCompute(EPD(lv), SetTo, var)", lambda: SeqCompute([(EPD(lv.getValueAddr()), SetTo, v)]))
tryit("var << lv", lambda: v << lv)
tryit("var << f_dwread_epd(EPD(lv))", lambda: v << f_dwread_epd(EPD(lv.getValueAddr())))
tryit("lv += var", lambda: lv.__iadd__(v))
tryit("DoActions(lv.AddNumber(var))", lambda: DoActions(lv.AddNumber(v)))
tryit("EUDIf(lv >= var)", lambda: (EUDIf()(lv >= v), EUDEndIf()))
tryit("EUDIf(lv == 3)", lambda: (EUDIf()(lv == 3), EUDEndIf()))
tryit("arr[var] = var", lambda: arr.set(v, v))
tryit("var << arr[var]", lambda: v << arr.get(v))
tryit("var << arr[3]", lambda: v << arr[3])
