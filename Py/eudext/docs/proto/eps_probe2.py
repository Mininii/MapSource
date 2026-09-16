"""Second grammar probe (see probe.py). Output: probe2_out.txt"""
import os
import sys

import probe

probe.SNIPPETS = {
    # module attribute call prefix rule
    "mod_call_names": (
        "import eudext.i64 as i64;\n"
        "function f(a) {\n"
        "  i64.foo(a);\n"
        "  i64.f_foo(a);\n"
        "  i64.Foo(a);\n"
        "  i64.EUDFoo(a);\n"
        "  i64.foo_bar(a);\n"
        "  const x = i64.CONST;\n"
        "  const y = i64.foo;\n"
        "  i64.sub.foo(a);\n"
        "  i64.obj.method(a);\n"
        "  i64.Int64.from_var(a);\n"
        "  const z = i64.foo(a) + 1;\n"
        "  if (i64.lt(a, 1)) {}\n"
        "}"
    ),
    "plain_mod_call": "import mylib;\nfunction f(a) { mylib.foo(a); mylib.Foo(a); }",
    # alias a class into eps scope
    "alias_class": (
        "import eudext.i64 as i64;\n"
        "const Int64 = i64.Int64;\n"
        "function f(a) { const x = Int64(a, 0); }"
    ),
    "alias_class_typed": (
        "import eudext.i64 as i64;\n"
        "const Int64 = i64.Int64;\n"
        "function f(a: Int64) { return a; }"
    ),
    "alias_func": (
        "import eudext.i64 as i64;\n"
        "const add = i64.add;\n"
        "function f(a) { add(a, a); }"
    ),
    # var holding python objects
    "var_local_obj": "object P { var x; };\nfunction f() { var p = P(); p.x = 1; }",
    "var_global_obj": "object P { var x; };\nvar p = P();\nfunction f() { p.x = 1; }",
    "var_local_modobj": "import eudext.i64 as i64;\nfunction f(a) { var q = i64.Int64(a, 0); q += a; q = a; }",
    "var_reassign": "function f(a, b) { var q = a; q = b; q += 1; q -= b; q *= 2; q /= 2; q %= 3; q |= 1; q &= 1; q ^= 1; q >>= 1; }",
    "const_method_assign": "import eudext.i64 as i64;\nconst I = i64.Int64();\nfunction f(a) { I.assign(a); I.iadd(a); }",
    # strings
    "str_dq_arg": "function f(a) { f_sprintf(a, \"abc {}\", a); }",
    "str_const_dq": "const s = \"abc\";",
    "str_local_dq": "function f() { const s = \"abc\"; }",
    "str_local_sq": "function f() { const s = 'abc'; }",
    "str_escape": "const s = \"a\\nb\\x01\";",
    "str_concat": "const s = \"a\" + \"b\";",
    "str_fmt": "function f(a) { const s = py_str(\"{}\").format(1); }",
    # conditions returning function
    "cond_func_neg": "import m;\nfunction f(a) { if (!m.cond(a)) {} while (!m.cond(a)) {} }",
    "cond_mixed": "import m;\nfunction f(a) { if (a < 3 && m.cond(a) || !m.cond2(a)) {} }",
    "cond_ternary_call": "import m;\nfunction f(a) { const z = m.cond(a) ? 1 : 2; }",
    "cond_as_value": "function f(a, b) { const z = (a < b); var w = a == b; }",
    "cond_list": "function f(a, b) { if (list(a == 1, b == 2)) {} }",
    # chunk-level statements
    "chunk_py_print": "py_print(1);",
    "chunk_fcall": "import m;\nm.setup(1);",
    "chunk_if": "if (1) {}",
    "chunk_const_after_fn": "function g() {}\nconst x = g;",
    "chunk_on_start": "function g() {}\nEUDOnStart(py_eval('f_g'));",
    # array/struct types
    "earray_typed": "function f(a: EUDArray) { a[0] = 1; }",
    "vararray_typed": "function f(a: EUDVArray(3)) { a[0] = 1; }",
    "struct_arr_field": "object P { var x; };\nobject Q { var ps: P; };\nfunction f(q: Q) { q.ps.x = 1; }",
    "obj_selftype": "object Node { var next: selftype; var v; };",
    "obj_inherit": "object A { var x; };\nobject B extends A { var y; };",
    "obj_static_method": "object P { var x; function f(a) { this.x = a; } };\nconst p = P();\nfunction g() { p.f(1); }",
    "obj_setitem": "object P { var x; };\nfunction g(p: P) { p[0] = 1; }",
    # special functions
    "fn_rettypes_multi": "function f(a) : TrgUnit, TrgPlayer { return a, a; }",
    "fn_mixed_types": "object P { var x; };\nfunction f(a, b: P, c) { }",
    "fn_return_none": "function f(a) { return; }",
    "fn_nested_call_kw": "function f(a) { f_dwwrite(a, 1); }",
    "setcurpl": "function f(a) { setcurpl(a); const c = getcurpl(); }",
    "dwread": "function f(a) { const v = dwread_epd(a); }",
    "unknown_fn": "function f(a) { foo(a); }",
    "unknown_Cap_fn": "function f(a) { Foo(a); }",
    "known_eud_class": "function f(a) { const v = EUDVariable(); const u = TrgUnit(a); }",
    "bool_ops": "function f(a, b) { const z = a & b; const w = a | b; const x = a ^ b; }",
    "compare_result_var": "function f(a, b) { var z = a < b; }",
    "L2V": "function f(a, b) { return a < b; }",
    "L2V_eq": "function f(a, b) { return a == b; }",
    "ret_cond_call": "import m;\nfunction f(a) { return m.cond(a); }",
    "unary_neg_cond": "import m;\nfunction f(a) { const z = !m.cond(a); }",
    "foreach_py": "import m;\nfunction f() { foreach (x, y : m.pairs()) {} }",
    "EUDLoopRange": "function f() { foreach (i : EUDLoopRange(3)) {} }",
    "array_literal_local": "function f(a) { const arr = [a, 1, 2]; }",
    "list_func": "function f(a) { const arr = list(a, 1); }",
}

if __name__ == "__main__":
    import io
    names = sys.argv[1:] or list(probe.SNIPPETS)
    # reuse main but write to probe2_out.txt
    orig_open = open

    def patched_open(path, *a, **k):
        if os.path.basename(str(path)) == "probe_out.txt":
            path = os.path.join(os.path.dirname(str(path)), "probe2_out.txt")
        return orig_open(path, *a, **k)

    probe.open = patched_open  # type: ignore[attr-defined]
    sys.argv = [sys.argv[0]] + names
    probe.main()
