"""Probe epScript grammar: compile many tiny snippets, report OK/FAIL + output.

Each snippet is compiled as its own module. Output goes to probe_out.txt.
"""
import io
import os
import sys
import contextlib

import eudplib  # noqa: F401
from eudplib.epscript.epscompile import epsCompile, libeps

HERE = os.path.dirname(os.path.abspath(__file__))

SNIPPETS = {
    # ---- imports
    "imp_dotted_as": "import eudext.i64 as i64;\nfunction f() { i64.foo(); }",
    "imp_dotted_noas": "import eudext.fmt;\nfunction f() { fmt.foo(); }",
    "imp_dotted_noas_full": "import eudext.fmt;\nfunction f() { eudext.fmt.foo(); }",
    "imp_plain": "import mylib;\nfunction f() { mylib.foo(); }",
    "imp_py_prefix": "import py_mylib;\nfunction f() { py_mylib.foo(); }",
    "imp_rel": "import .sibling;\nfunction f() { sibling.foo(); }",
    "imp_rel_as": "import .sibling as sb;\nfunction f() { sb.foo(); }",
    "imp_parent_as": "import ..parentmod as pm;\nfunction f() { pm.foo(); }",
    "imp_from": "from eudext.i64 import Int64;\nfunction f() { Int64(); }",
    "imp_star": "from eudext.i64 import *;",
    # ---- globals
    "g_static_var": "static var sv = 3;",
    "g_var": "var gv;",
    "g_var_init": "var gv = 5;",
    "g_const_int": "const K = 5;",
    "g_const_call": "const arr = EUDArray(10);",
    "g_const_modcall": "import eudext.i64 as i64;\nconst I = i64.Int64(1, 2);",
    "g_const_modcls_attr": "import eudext.i64 as i64;\nconst I = i64.Int64.zero();",
    "g_const_pylist": "const L = py_list();",
    "g_const_list_literal": "const L = [1, 2, 3];",
    "g_const_undefined": "const J = Int64();",
    # ---- object
    "obj_basic": "object Point { var x, y; };\nfunction f() { const p = Point(); p.x = 1; }",
    "obj_method": "object Point { var x, y; function len2() { return this.x * this.x + this.y * this.y; } };",
    "obj_typed_arg": "object Point { var x, y; };\nfunction f(p: Point) { p.x += 1; return p.y; }",
    "obj_cast": "object Point { var x, y; };\nfunction f(a) { const p = Point.cast(a); return p.x; }",
    "obj_alloc": "object Point { var x, y; };\nfunction f() { const p = Point.alloc(); Point.free(p); }",
    "obj_static_field_type": "object Point { var x, y; };\nobject Line { var a: Point; var b: Point; };",
    "obj_const_field": "object P { const x; };",
    "obj_ctor": "object P { var x; function constructor(v) { this.x = v; } };\nfunction f() { const p = P(3); }",
    "obj_array": "object P { var x; };\nconst ps = P.array(10);",
    "obj_mul_array": "object P { var x; };\nconst ps = P * 10;",
    # ---- operators on const objects
    "op_add_const": "const A = py_int(1);\nconst B = py_int(2);\nfunction f() { const z = A + B; }",
    "op_add_var": "function f(a, b) { const z = a + b; var w = a + b; }",
    "op_iadd_const": "const A = EUDArray(1);\nfunction f(b) { A += b; }",
    "op_lshift_const": "const A = EUDArray(1);\nfunction f(b) { A << b; }",
    "op_assign_const": "const A = EUDArray(1);\nfunction f(b) { A = b; }",
    "op_lt_if": "const A = EUDArray(1);\nfunction f(b) { if (A < b) { } }",
    "op_lt_var": "function f(a, b) { if (a < b) { } }",
    "op_sign": "function f(a, b) { if (a <= b) {} if (a == b) {} if (a != b) {} if (a > b) {} }",
    "op_bitshift": "function f(a, b) { const z = a << b; const w = a >> 3; a <<= 2; }",
    "op_ternary": "function f(a, b) { const z = a < b ? a : b; }",
    "op_not": "function f(a, b) { if (!(a < b)) {} if (!a) {} }",
    "op_and_or": "function f(a, b) { if (a < b && b < 5 || a == 0) {} }",
    "op_call_in_cond": "function g(x) { return x; }\nfunction f(a) { if (g(a) && a) {} }",
    "op_method_call": "const A = EUDArray(1);\nfunction f(b) { A.foo(b); const r = A.bar(); }",
    "op_method_in_cond": "const A = EUDArray(1);\nfunction f(b) { if (A.lt(b)) {} while (A.nz()) {} }",
    "op_pow": "function f(a) { const z = a ** 2; }",
    "op_neg": "function f(a) { const z = -a; const w = ~a; }",
    "op_div": "function f(a, b) { const z = a / b; const w = a % b; }",
    "op_multi_ret": "function g(x) { return x, x; }\nfunction f(a) { const q, r = g(a); var s, t = g(a); s, t = g(a); }",
    "op_list_unpack_const": "function f(a) { const q, r = py_tuple([a, a]); }",
    "op_attr_chain": "const A = EUDArray(1);\nfunction f(b) { A.x.y = b; A.x.y += b; A[1].z = b; }",
    "op_index": "const A = EUDArray(3);\nfunction f(b) { A[b] = 1; A[b] += 2; if (A[b] < 3) {} }",
    # ---- python builtins / py_
    "py_str": "const s = py_str('abc');",
    "py_range_foreach": "function f() { var t; foreach (i : py_range(3)) { t += i; } }",
    "py_eval": "const x = py_eval('1+2');",
    "py_exec": "py_exec('print(1)');",
    "py_getattr": "const x = py_getattr(EUDArray, 'cast');",
    "py_kwargs": "function f(a) { const x = EUDVariable(a, SetTo, 0); f_dwwrite(1, 2); SetMemory(1, SetTo, 2); }",
    "kwarg_call": "function f(a) { f_sprintf(a, 'x', ret=1); }",
    "kwarg_call2": "function f(a) { const z = g(a, flag=True); }",
    "none_true": "const x = None; const y = True; const z = False;",
    "string_literal": "function f() { const s = 'abc'; const t = \"def\"; }",
    "float_literal": "const x = 1.5;",
    # ---- typed functions
    "fn_typed_ret": "function f(a) : TrgUnit { return a; }",
    "fn_typed_py": "function f(a: py_int) { return a; }",
    "fn_typed_modtype": "import eudext.i64 as i64;\nfunction f(a: i64.Int64) { return a; }",
    "fn_default_arg": "function f(a, b = 3) { return a; }",
    "fn_varargs": "function f(*args) { }",
    "fn_decorator": "@EUDTracedFunc\nfunction f(a) { }",
    "fn_inline": "inline function f(a) { }",
    "fn_static_local": "function f() { static var s = 0; s += 1; }",
    "fn_const_local_expr": "function f(a) { const q = a * 3; q += 1; }",
    # ---- loops
    "loop_for": "function f() { for (var i = 0; i < 10; i++) {} }",
    "loop_foreach_unit": "function f() { foreach (ptr, epd : EUDLoopUnit()) {} }",
    "loop_once": "function f() { once { } once (Deaths(P1, AtLeast, 1, 0)) {} }",
    "loop_switch": "function f(a) { switch (a) { case 1: break; default: break; } }",
    "loop_do_while": "function f(a) { do { a -= 1; } while (a); }",
    "loop_break_cont": "function f(a) { while (a) { if (a == 3) continue; break; } }",
    # ---- misc
    "setpluginobj": "function afterTriggerExec() {}\nfunction beforeTriggerExec() {}",
    "static_cond_list": "function f(a) { if (Memory(0x58A364, AtLeast, 1)) {} }",
    "py_class_def": "class Foo { }",
    "lambda": "const f = function(x) { return x; };",
    "EUDOnStart": "function f() {}\nEUDOnStart(f);",
    "chunk_call": "const x = 1;\nprint(x);",
    "assign_python_attr": "import eudext.i64 as i64;\nfunction f() { i64.flag = 1; }",
    "var_array_type": "function f() { var arr: EUDArray; }",
    "var_typed": "function f(a) { var x: TrgUnit = a; const y: TrgUnit = a; }",
    "unary_amp": "function f(a) { const z = &a; }",
    "int_hex_big": "const x = 0xFFFFFFFF; const y = 0x100000000;",
}


def main():
    names = sys.argv[1:] or list(SNIPPETS)
    lines = []
    for name in names:
        code = SNIPPETS[name].encode("utf-8")
        err = io.StringIO()
        # capture C-level stdout is not possible via redirect; errors go to console
        out = epsCompile(f"{name}.eps", code)
        n = libeps.getErrorCount()
        status = "OK" if out is not None else f"FAIL(err={n})"
        lines.append(f"##### {name}: {status}")
        lines.append("--- src:")
        lines.append(SNIPPETS[name])
        if out is not None:
            text = out.decode("utf-8")
            # strip boilerplate header
            body = text.split("# (Line 1)", 1)
            lines.append("--- out:")
            lines.append(("# (Line 1)" + body[1]) if len(body) == 2 else text)
        lines.append("")
        print(f"{name}: {status}", flush=True)
    with open(os.path.join(HERE, "probe_out.txt"), "w", encoding="utf-8") as f:
        f.write("\n".join(lines))


if __name__ == "__main__":
    main()
