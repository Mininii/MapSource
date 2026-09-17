import re
s=open('atlas.html',encoding='utf-8').read()
a=s.index('var CSLib = (function(){')
b=s.index('/* ===== 아주 작은 Lua 식 평가기 =====')
lib=s[a:b]
# also grab makeLuaEval
c=s.index('function makeLuaEval(CSLib, resolveShape){')
d=s.index('/* ==================== 앱 ====================')
ev=s[c:d]
open('/tmp/cslib.js','w',encoding='utf-8').write(lib+"\n"+ev+"\nmodule.exports={CSLib:CSLib, makeLuaEval:makeLuaEval};\n")
print(len(lib),len(ev))
