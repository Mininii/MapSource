import sys
src=sys.argv[1]; dst=sys.argv[2]
s=open(src,encoding='utf-8').read()
i=s.index("</head><body>")+len("</head><body>")
s=s[i:].lstrip("\n")
j=s.rindex("</body></html>")
s=s[:j].rstrip()+"\n"
open(dst,'w',encoding='utf-8').write(s)
print(dst, len(s))
