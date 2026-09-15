from eudplib import *


VChatIndex = EUDArray(8)

def Reg():
    print('... TERegVar ...')
    EUDRegisterObjectToNamespace("VChatIndex", VChatIndex)
EUDOnStart(Reg)
