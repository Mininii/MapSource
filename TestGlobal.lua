TText1 = "가나다라"
function TestGlobal()
    return CreateCText(FP,TText1)
end
PushValueMsg({GetStrArr(0,TText1),"X"})