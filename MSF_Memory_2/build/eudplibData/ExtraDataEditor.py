from eudplib import *
try:
    InitialWireframe
except NameError:

    def init_wireframe():
        WireFrameDataEditor.WireFrameInit()
        WireFrameDataEditor.ChangeWireframe(0, 16)
        WireFrameDataEditor.ChangeTranframe(0, 16)
        WireFrameDataEditor.ChangeGrpframe(0, 16)
        WireFrameDataEditor.ChangeWireframe(1, 16)
        WireFrameDataEditor.ChangeTranframe(1, 16)
        WireFrameDataEditor.ChangeGrpframe(1, 16)
        WireFrameDataEditor.ChangeWireframe(99, 16)
        WireFrameDataEditor.ChangeTranframe(99, 16)
        WireFrameDataEditor.ChangeGrpframe(99, 16)
        WireFrameDataEditor.ChangeWireframe(116, 84)
        WireFrameDataEditor.ChangeGrpframe(116, 0)
        WireFrameDataEditor.ChangeWireframe(117, 84)
        WireFrameDataEditor.ChangeGrpframe(117, 0)
        WireFrameDataEditor.ChangeWireframe(118, 162)
        WireFrameDataEditor.ChangeGrpframe(118, 0)
        WireFrameDataEditor.ChangeWireframe(184, 84)
        WireFrameDataEditor.ChangeWireframe(185, 84)
        WireFrameDataEditor.ChangeWireframe(206, 205)
        WireFrameDataEditor.ChangeWireframe(207, 205)
        WireFrameDataEditor.ChangeWireframe(215, 214)

else:
    InitialWireframe.wirefram(0, 16)
    InitialWireframe.tranwire(0, 16)
    InitialWireframe.grpwire(0, 16)
    InitialWireframe.wirefram(1, 16)
    InitialWireframe.tranwire(1, 16)
    InitialWireframe.grpwire(1, 16)
    InitialWireframe.wirefram(99, 16)
    InitialWireframe.tranwire(99, 16)
    InitialWireframe.grpwire(99, 16)
    InitialWireframe.wirefram(116, 84)
    InitialWireframe.grpwire(116, 0)
    InitialWireframe.wirefram(117, 84)
    InitialWireframe.grpwire(117, 0)
    InitialWireframe.wirefram(118, 162)
    InitialWireframe.grpwire(118, 0)
    InitialWireframe.wirefram(184, 84)
    InitialWireframe.wirefram(185, 84)
    InitialWireframe.wirefram(206, 205)
    InitialWireframe.wirefram(207, 205)
    InitialWireframe.wirefram(215, 214)


def onPluginStart():
    try:
        init_wireframe()
    except NameError:
        pass
    DoActions([ # 스테이터스인포메이션
        SetMemory(0x519914, SetTo, 4344192),
        SetMemory(0x519920, SetTo, 4344192),
        SetMemory(0x51992C, SetTo, 4344192),
        SetMemory(0x519930, SetTo, 4353872),
        SetMemory(0x519C44, SetTo, 4344192),
        SetMemory(0x519C50, SetTo, 4344192),
        SetMemory(0x519D34, SetTo, 4343040),
        SetMemory(0x519D38, SetTo, 4349664),
        SetMemory(0x519DB8, SetTo, 4346240),
        SetMemory(0x519DBC, SetTo, 4356240),
        SetMemory(0x519DF4, SetTo, 4343040),
        SetMemory(0x519DF8, SetTo, 4349664),
    ])
    # 버튼셋
    bytebuffer = bytearray([1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1])
    btnptr0 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1])
    btnptr1 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,228,0,112,134,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,64,134,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,16,134,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,160,141,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,160,141,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,234,0,16,138,66,0,240,154,69,0,0,0,239,0,166,2,0,0,8,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1,9,0,236,0,16,131,66,0,240,51,66,0,0,0,0,0,188,2,0,0])
    btnptr7 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1])
    btnptr16 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,228,0,208,130,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,208,130,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1])
    btnptr99 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,250,0,224,148,66,0,112,63,66,0,4,0,4,0,81,1,10,6,2,0,109,1,96,142,66,0,176,52,66,0,72,0,72,0,94,2,10,6,3,0,214,0,208,130,66,0,240,154,69,0,0,0,240,0,66,5,10,6,4,0,133,1,96,142,66,0,176,52,66,0,50,0,50,0,217,5,10,6,5,0,131,1,96,142,66,0,176,52,66,0,54,0,54,0,218,5,10,6,6,0,132,1,96,142,66,0,176,52,66,0,53,0,53,0,219,5,10,6,7,0,130,1,96,142,66,0,176,52,66,0,22,0,22,0,75,2,10,6,8,0,127,1,96,142,66,0,176,52,66,0,23,0,23,0,116,5,10,6,9,0,56,1,96,142,66,0,240,154,69,0,60,0,243,0,187,5,10,6])
    btnptr107 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,0,0,96,142,66,0,176,52,66,0,8,0,8,0,74,2,10,6,2,0,176,0,96,142,66,0,176,52,66,0,2,0,2,0,76,2,10,6,3,0,7,0,96,142,66,0,176,52,66,0,7,0,7,0,80,2,10,6,4,0,34,0,96,142,66,0,176,52,66,0,9,0,9,0,10,5,10,6,4,0,34,0,96,142,66,0,176,52,66,0,34,0,34,0,10,5,10,6,4,0,34,0,96,142,66,0,176,52,66,0,5,0,5,0,10,5,10,6,4,0,34,0,96,142,66,0,176,52,66,0,10,0,10,0,10,5,10,6,5,0,219,0,96,142,66,0,176,52,66,0,19,0,19,0,77,2,9,6,6,0,16,0,96,142,66,0,176,52,66,0,28,0,28,0,74,5,10,6,7,0,237,0,96,142,66,0,176,52,66,0,71,0,71,0,78,1,10,6,8,0,32,1,80,148,66,0,16,51,66,0,8,0,8,0,207,1,133,5,8,0,229,0,96,142,66,0,176,52,66,0,74,0,74,0,153,2,10,6,8,0,32,1,80,148,66,0,16,51,66,0,7,0,7,0,207,1,133,5,9,0,121,1,80,148,66,0,16,51,66,0,0,0,0,0,200,1,134,5,9,0,121,1,80,148,66,0,16,51,66,0,1,0,1,0,200,1,134,5,9,0,255,0,96,142,66,0,176,52,66,0,75,0,75,0,156,2,10,6])
    btnptr111 = Db(bytebuffer)
    bytebuffer = bytearray([2,0,109,0,96,142,66,0,176,62,66,0,109,0,109,0,135,2,10,6,6,0,124,0,96,142,66,0,176,62,66,0,124,0,124,0,139,2,205,2,8,0,125,0,96,142,66,0,176,62,66,0,125,0,125,0,141,2,206,2,9,0,236,0,208,130,66,0,240,154,69,0,0,0,228,0,176,2,10,6])
    btnptr239 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,53,1,96,142,66,0,176,52,66,0,66,0,66,0,69,5,10,6,2,0,53,1,96,142,66,0,176,52,66,0,67,0,67,0,70,5,10,6,3,0,121,1,96,142,66,0,176,52,66,0,70,0,70,0,73,5,10,6,4,0,53,1,96,142,66,0,176,52,66,0,68,0,68,0,71,5,10,6,5,0,53,1,96,142,66,0,176,52,66,0,69,0,69,0,72,5,10,6,6,0,236,0,48,133,66,0,144,52,66,0,70,0,70,0,181,2,10,6,9,0,236,0,208,130,66,0,240,154,69,0,70,0,228,0,177,2,10,6])
    btnptr240 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,56,1,96,142,66,0,176,52,66,0,63,0,63,0,63,5,10,6,2,0,56,1,96,142,66,0,176,52,66,0,64,0,64,0,64,5,10,6,3,0,56,1,96,142,66,0,176,52,66,0,65,0,65,0,61,5,10,6,7,0,133,1,96,142,66,0,176,52,66,0,61,0,61,0,68,5,10,6,8,0,132,1,96,142,66,0,176,52,66,0,62,0,62,0,67,5,10,6,9,0,236,0,208,130,66,0,240,154,69,0,0,0,228,0,176,2,0,0])
    btnptr243 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,228,0,160,141,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,64,141,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,160,141,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,160,141,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1])
    btnptr244 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,228,0,160,141,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,64,141,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,160,141,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,160,141,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1])
    btnptr245 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,228,0,160,141,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,64,141,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,160,141,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,160,141,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1])
    btnptr246 = Db(bytebuffer)
    bytebuffer = bytearray([1,0,228,0,160,141,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,64,141,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,160,141,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,160,141,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1])
    btnptr247 = Db(bytebuffer)
    DoActions([
        SetMemory(0x5187EC, SetTo, btnptr0),
        SetMemory(0x5187E8, SetTo, 6),
    ])
    DoActions([
        SetMemory(0x5187F8, SetTo, btnptr1),
        SetMemory(0x5187F4, SetTo, 6),
    ])
    DoActions([
        SetMemory(0x518840, SetTo, btnptr7),
        SetMemory(0x51883C, SetTo, 8),
    ])
    DoActions([
        SetMemory(0x5188AC, SetTo, btnptr16),
        SetMemory(0x5188A8, SetTo, 6),
    ])
    DoActions([
        SetMemory(0x518C90, SetTo, btnptr99),
        SetMemory(0x518C8C, SetTo, 6),
    ])
    DoActions([
        SetMemory(0x518CF0, SetTo, btnptr107),
        SetMemory(0x518CEC, SetTo, 9),
    ])
    DoActions([
        SetMemory(0x518D20, SetTo, btnptr111),
        SetMemory(0x518D1C, SetTo, 16),
    ])
    DoActions([
        SetMemory(0x519320, SetTo, btnptr239),
        SetMemory(0x51931C, SetTo, 4),
    ])
    DoActions([
        SetMemory(0x51932C, SetTo, btnptr240),
        SetMemory(0x519328, SetTo, 7),
    ])
    DoActions([
        SetMemory(0x519350, SetTo, btnptr243),
        SetMemory(0x51934C, SetTo, 6),
    ])
    DoActions([
        SetMemory(0x51935C, SetTo, btnptr244),
        SetMemory(0x519358, SetTo, 6),
    ])
    DoActions([
        SetMemory(0x519368, SetTo, btnptr245),
        SetMemory(0x519364, SetTo, 6),
    ])
    DoActions([
        SetMemory(0x519374, SetTo, btnptr246),
        SetMemory(0x519370, SetTo, 6),
    ])
    DoActions([
        SetMemory(0x519380, SetTo, btnptr247),
        SetMemory(0x51937C, SetTo, 6),
    ])
    with open('../temp/RequireData', 'rb') as file:
        inputData = file.read()
        inputData_db = Db(inputData)
        inputDwordN = (len(inputData) + 3) // 4

    addrEPD = EPD(0x514178)
    f_repmovsd_epd(addrEPD, EPD(inputData_db), inputDwordN)


def beforeTriggerExec():
    DoActions([
        SetMemory(0x660A70 + 0, SetTo, 393217),
        SetMemory(0x660A70 + 4, SetTo, 1179661),
        SetMemory(0x660A70 + 8, SetTo, 1572864),
        SetMemory(0x660A70 + 12, SetTo, 2031616),
        SetMemory(0x660A70 + 16, SetTo, 2687012),
        SetMemory(0x660A70 + 20, SetTo, 3211264),
        SetMemory(0x660A70 + 24, SetTo, 56),
        SetMemory(0x660A70 + 28, SetTo, 64),
        SetMemory(0x660A70 + 32, SetTo, 0),
        SetMemory(0x660A70 + 36, SetTo, 0),
        SetMemory(0x660A70 + 40, SetTo, 0),
        SetMemory(0x660A70 + 44, SetTo, 0),
        SetMemory(0x660A70 + 48, SetTo, 0),
        SetMemory(0x660A70 + 52, SetTo, 0),
        SetMemory(0x660A70 + 56, SetTo, 0),
        SetMemory(0x660A70 + 60, SetTo, 0),
        SetMemory(0x660A70 + 64, SetTo, 69),
        SetMemory(0x660A70 + 68, SetTo, 75),
        SetMemory(0x660A70 + 72, SetTo, 5373952),
        SetMemory(0x660A70 + 76, SetTo, 5898326),
        SetMemory(0x660A70 + 80, SetTo, 6160384),
        SetMemory(0x660A70 + 84, SetTo, 6553697),
        SetMemory(0x660A70 + 88, SetTo, 7274603),
        SetMemory(0x660A70 + 92, SetTo, 7798899),
        SetMemory(0x660A70 + 96, SetTo, 0),
        SetMemory(0x660A70 + 100, SetTo, 126),
        SetMemory(0x660A70 + 104, SetTo, 0),
        SetMemory(0x660A70 + 108, SetTo, 0),
        SetMemory(0x660A70 + 112, SetTo, 0),
        SetMemory(0x660A70 + 116, SetTo, 130),
        SetMemory(0x660A70 + 120, SetTo, 9371787),
        SetMemory(0x660A70 + 124, SetTo, 148),
        SetMemory(0x660A70 + 128, SetTo, 10289305),
        SetMemory(0x660A70 + 132, SetTo, 10748064),
        SetMemory(0x660A70 + 136, SetTo, 11010048),
        SetMemory(0x660A70 + 140, SetTo, 11403435),
        SetMemory(0x660A70 + 144, SetTo, 11927730),
        SetMemory(0x660A70 + 148, SetTo, 0),
        SetMemory(0x660A70 + 152, SetTo, 0),
        SetMemory(0x660A70 + 156, SetTo, 0),
        SetMemory(0x660A70 + 160, SetTo, 0),
        SetMemory(0x660A70 + 164, SetTo, 12386304),
        SetMemory(0x660A70 + 168, SetTo, 12910785),
        SetMemory(0x660A70 + 172, SetTo, 0),
        SetMemory(0x660A70 + 176, SetTo, 0),
        SetMemory(0x660A70 + 180, SetTo, 0),
        SetMemory(0x660A70 + 184, SetTo, 0),
        SetMemory(0x660A70 + 188, SetTo, 0),
        SetMemory(0x660A70 + 192, SetTo, 0),
        SetMemory(0x660A70 + 196, SetTo, 0),
        SetMemory(0x660A70 + 200, SetTo, 0),
        SetMemory(0x660A70 + 204, SetTo, 13369344),
        SetMemory(0x660A70 + 208, SetTo, 0),
        SetMemory(0x660A70 + 212, SetTo, 14024914),
        SetMemory(0x660A70 + 216, SetTo, 14811356),
        SetMemory(0x660A70 + 220, SetTo, 15335654),
        SetMemory(0x660A70 + 224, SetTo, 15991023),
        SetMemory(0x660A70 + 228, SetTo, 16646393),
        SetMemory(0x660A70 + 232, SetTo, 17301763),
        SetMemory(0x660A70 + 236, SetTo, 269),
        SetMemory(0x660A70 + 240, SetTo, 274),
        SetMemory(0x660A70 + 244, SetTo, 18612503),
        SetMemory(0x660A70 + 248, SetTo, 19267873),
        SetMemory(0x660A70 + 252, SetTo, 0),
        SetMemory(0x660A70 + 256, SetTo, 0),
        SetMemory(0x660A70 + 260, SetTo, 19595264),
        SetMemory(0x660A70 + 264, SetTo, 20185391),
        SetMemory(0x660A70 + 268, SetTo, 20840761),
        SetMemory(0x660A70 + 272, SetTo, 21496131),
        SetMemory(0x660A70 + 276, SetTo, 22348109),
        SetMemory(0x660A70 + 280, SetTo, 23396704),
        SetMemory(0x660A70 + 284, SetTo, 24641901),
        SetMemory(0x660A70 + 288, SetTo, 380),
        SetMemory(0x660A70 + 292, SetTo, 384),
        SetMemory(0x660A70 + 296, SetTo, 25427968),
        SetMemory(0x660A70 + 300, SetTo, 0),
        SetMemory(0x660A70 + 304, SetTo, 0),
        SetMemory(0x660A70 + 308, SetTo, 25821575),
        SetMemory(0x660A70 + 312, SetTo, 26280334),
        SetMemory(0x660A70 + 316, SetTo, 26476544),
        SetMemory(0x660A70 + 320, SetTo, 408),
        SetMemory(0x660A70 + 324, SetTo, 27263388),
        SetMemory(0x660A70 + 328, SetTo, 27787684),
        SetMemory(0x660A70 + 332, SetTo, 28311980),
        SetMemory(0x660A70 + 336, SetTo, 28573696),
        SetMemory(0x660A70 + 340, SetTo, 29163960),
        SetMemory(0x660A70 + 344, SetTo, 449),
        SetMemory(0x660A70 + 348, SetTo, 0),
        SetMemory(0x660A70 + 352, SetTo, 0),
        SetMemory(0x660A70 + 356, SetTo, 0),
        SetMemory(0x660A70 + 360, SetTo, 0),
        SetMemory(0x660A70 + 364, SetTo, 0),
        SetMemory(0x660A70 + 368, SetTo, 0),
        SetMemory(0x660A70 + 372, SetTo, 0),
        SetMemory(0x660A70 + 376, SetTo, 0),
        SetMemory(0x660A70 + 380, SetTo, 0),
        SetMemory(0x660A70 + 384, SetTo, 0),
        SetMemory(0x660A70 + 388, SetTo, 0),
        SetMemory(0x660A70 + 392, SetTo, 0),
        SetMemory(0x660A70 + 396, SetTo, 0),
        SetMemory(0x660A70 + 400, SetTo, 0),
        SetMemory(0x660A70 + 404, SetTo, 0),
        SetMemory(0x660A70 + 408, SetTo, 0),
        SetMemory(0x660A70 + 412, SetTo, 0),
        SetMemory(0x660A70 + 416, SetTo, 0),
        SetMemory(0x660A70 + 420, SetTo, 0),
        SetMemory(0x660A70 + 424, SetTo, 0),
        SetMemory(0x660A70 + 428, SetTo, 0),
        SetMemory(0x660A70 + 432, SetTo, 0),
        SetMemory(0x660A70 + 436, SetTo, 0),
        SetMemory(0x660A70 + 440, SetTo, 0),
        SetMemory(0x660A70 + 444, SetTo, 0),
        SetMemory(0x660A70 + 448, SetTo, 0),
        SetMemory(0x660A70 + 452, SetTo, 0),
        SetMemory(0x6558C0 + 0, SetTo, 393217),
        SetMemory(0x6558C0 + 4, SetTo, 1572876),
        SetMemory(0x6558C0 + 8, SetTo, 3604518),
        SetMemory(0x6558C0 + 12, SetTo, 5046338),
        SetMemory(0x6558C0 + 16, SetTo, 5767250),
        SetMemory(0x6558C0 + 20, SetTo, 7471204),
        SetMemory(0x6558C0 + 24, SetTo, 9502848),
        SetMemory(0x6558C0 + 28, SetTo, 10944668),
        SetMemory(0x6558C0 + 32, SetTo, 11993266),
        SetMemory(0x6558C0 + 36, SetTo, 12320768),
        SetMemory(0x6558C0 + 40, SetTo, 12976321),
        SetMemory(0x6558C0 + 44, SetTo, 13631691),
        SetMemory(0x6558C0 + 48, SetTo, 14418133),
        SetMemory(0x6558C0 + 52, SetTo, 15335651),
        SetMemory(0x6558C0 + 56, SetTo, 15925486),
        SetMemory(0x6558C0 + 60, SetTo, 16449783),
        SetMemory(0x6558C0 + 64, SetTo, 16974079),
        SetMemory(0x6558C0 + 68, SetTo, 17498375),
        SetMemory(0x6558C0 + 72, SetTo, 18022671),
        SetMemory(0x6558C0 + 76, SetTo, 18546967),
        SetMemory(0x6558C0 + 80, SetTo, 19071263),
        SetMemory(0x6558C0 + 84, SetTo, 19595559),
        SetMemory(0x6558C0 + 88, SetTo, 303),
        SetMemory(0x6558C0 + 92, SetTo, 20119552),
        SetMemory(0x6558C0 + 96, SetTo, 20447232),
        SetMemory(0x6558C0 + 100, SetTo, 20774912),
        SetMemory(0x6558C0 + 104, SetTo, 21496131),
        SetMemory(0x6558C0 + 108, SetTo, 333),
        SetMemory(0x6558C0 + 112, SetTo, 0),
        SetMemory(0x6558C0 + 116, SetTo, 0),
        SetMemory(0x656198 + 0, SetTo, 393217),
        SetMemory(0x656198 + 4, SetTo, 1048587),
        SetMemory(0x656198 + 8, SetTo, 1376256),
        SetMemory(0x656198 + 12, SetTo, 1703936),
        SetMemory(0x656198 + 16, SetTo, 2359327),
        SetMemory(0x656198 + 20, SetTo, 3014697),
        SetMemory(0x656198 + 24, SetTo, 3670016),
        SetMemory(0x656198 + 28, SetTo, 3932160),
        SetMemory(0x656198 + 32, SetTo, 4456512),
        SetMemory(0x656198 + 36, SetTo, 4980808),
        SetMemory(0x656198 + 40, SetTo, 5505104),
        SetMemory(0x656198 + 44, SetTo, 88),
        SetMemory(0x656198 + 48, SetTo, 6422620),
        SetMemory(0x656198 + 52, SetTo, 6750208),
        SetMemory(0x656198 + 56, SetTo, 7077888),
        SetMemory(0x656198 + 60, SetTo, 7798897),
        SetMemory(0x656198 + 64, SetTo, 124),
        SetMemory(0x656198 + 68, SetTo, 0),
        SetMemory(0x656198 + 72, SetTo, 0),
        SetMemory(0x656198 + 76, SetTo, 0),
        SetMemory(0x656198 + 80, SetTo, 0),
        SetMemory(0x656198 + 84, SetTo, 0),
        SetMemory(0x6562F8 + 0, SetTo, 131073),
        SetMemory(0x6562F8 + 4, SetTo, 1900564),
        SetMemory(0x6562F8 + 8, SetTo, 2752551),
        SetMemory(0x6562F8 + 12, SetTo, 4128825),
        SetMemory(0x6562F8 + 16, SetTo, 5701704),
        SetMemory(0x6562F8 + 20, SetTo, 7667808),
        SetMemory(0x6562F8 + 24, SetTo, 10027155),
        SetMemory(0x6562F8 + 28, SetTo, 11075746),
        SetMemory(0x6562F8 + 32, SetTo, 12779699),
        SetMemory(0x6562F8 + 36, SetTo, 14024912),
        SetMemory(0x6562F8 + 40, SetTo, 15401186),
        SetMemory(0x6562F8 + 44, SetTo, 16580852),
        SetMemory(0x6562F8 + 48, SetTo, 17039616),
        SetMemory(0x6562F8 + 52, SetTo, 17629184),
        SetMemory(0x6562F8 + 56, SetTo, 18153745),
        SetMemory(0x6562F8 + 60, SetTo, 18612504),
        SetMemory(0x6562F8 + 64, SetTo, 288),
        SetMemory(0x6562F8 + 68, SetTo, 293),
        SetMemory(0x6562F8 + 72, SetTo, 0),
        SetMemory(0x6562F8 + 76, SetTo, 0),
        SetMemory(0x6562F8 + 80, SetTo, 0),
        SetMemory(0x6562F8 + 84, SetTo, 0),
        SetMemory(0x665580 + 0, SetTo, 327682),
        SetMemory(0x665580 + 4, SetTo, 786440),
        SetMemory(0x665580 + 8, SetTo, 1310736),
        SetMemory(0x665580 + 12, SetTo, 1835032),
        SetMemory(0x665580 + 16, SetTo, 2621476),
        SetMemory(0x665580 + 20, SetTo, 3145772),
        SetMemory(0x665580 + 24, SetTo, 3670068),
        SetMemory(0x665580 + 28, SetTo, 4194364),
        SetMemory(0x665580 + 32, SetTo, 0),
        SetMemory(0x665580 + 36, SetTo, 5308484),
        SetMemory(0x665580 + 40, SetTo, 7405677),
        SetMemory(0x665580 + 44, SetTo, 7929973),
        SetMemory(0x665580 + 48, SetTo, 8126464),
        SetMemory(0x665580 + 52, SetTo, 8650880),
        SetMemory(0x665580 + 56, SetTo, 9568395),
        SetMemory(0x665580 + 60, SetTo, 10289305),
        SetMemory(0x665580 + 64, SetTo, 10813601),
        SetMemory(0x665580 + 68, SetTo, 11337897),
        SetMemory(0x665580 + 72, SetTo, 177),
        SetMemory(0x665580 + 76, SetTo, 11730944),
        SetMemory(0x665580 + 80, SetTo, 12124342),
        SetMemory(0x665580 + 84, SetTo, 0),
        SetMemory(0x665580 + 88, SetTo, 0),
        SetMemory(0x665580 + 92, SetTo, 192),
        SetMemory(0x665580 + 96, SetTo, 12910592),
        SetMemory(0x665580 + 100, SetTo, 13697225),
        SetMemory(0x665580 + 104, SetTo, 15139039),
        SetMemory(0x665580 + 108, SetTo, 16187631),
        SetMemory(0x665580 + 112, SetTo, 17629445),
        SetMemory(0x665580 + 116, SetTo, 18678037),
        SetMemory(0x665580 + 120, SetTo, 19726629),
        SetMemory(0x665580 + 124, SetTo, 309),
        SetMemory(0x665580 + 128, SetTo, 21102909),
        SetMemory(0x665580 + 132, SetTo, 21364736),
        SetMemory(0x665580 + 136, SetTo, 21626880),
        SetMemory(0x665580 + 140, SetTo, 22085965),
        SetMemory(0x665580 + 144, SetTo, 341),
        SetMemory(0x665580 + 148, SetTo, 345),
        SetMemory(0x665580 + 152, SetTo, 22806528),
        SetMemory(0x665580 + 156, SetTo, 23789921),
        SetMemory(0x665580 + 160, SetTo, 24183150),
        SetMemory(0x665580 + 164, SetTo, 372),
        SetMemory(0x665580 + 168, SetTo, 24772983),
        SetMemory(0x665580 + 172, SetTo, 381),
        SetMemory(0x665580 + 176, SetTo, 0),
        SetMemory(0x665580 + 180, SetTo, 384),
        SetMemory(0x665580 + 184, SetTo, 25559427),
        SetMemory(0x665580 + 188, SetTo, 26149260),
        SetMemory(0x665580 + 192, SetTo, 26411008),
        SetMemory(0x665580 + 196, SetTo, 0),
        SetMemory(0x665580 + 200, SetTo, 26804630),
        SetMemory(0x665580 + 204, SetTo, 27787686),
        SetMemory(0x665580 + 208, SetTo, 431),
        SetMemory(0x665580 + 212, SetTo, 28508160),
        SetMemory(0x665580 + 216, SetTo, 439),
        SetMemory(0x665580 + 220, SetTo, 29229056),
        SetMemory(0x665580 + 224, SetTo, 449),
        SetMemory(0x665580 + 228, SetTo, 0),
        SetMemory(0x665580 + 232, SetTo, 0),
        SetMemory(0x665580 + 236, SetTo, 0),
        SetMemory(0x665580 + 240, SetTo, 0),
        SetMemory(0x665580 + 244, SetTo, 29622272),
        SetMemory(0x665580 + 248, SetTo, 29884416),
        SetMemory(0x665580 + 252, SetTo, 30409164),
        SetMemory(0x665580 + 256, SetTo, 30933460),
        SetMemory(0x665580 + 260, SetTo, 31719900),
        SetMemory(0x665580 + 264, SetTo, 32178176),
        SetMemory(0x665580 + 268, SetTo, 32702958),
        SetMemory(0x665580 + 272, SetTo, 504),
        SetMemory(0x665580 + 276, SetTo, 0),
        SetMemory(0x665580 + 280, SetTo, 512),
        SetMemory(0x665580 + 284, SetTo, 0),
        SetMemory(0x665580 + 288, SetTo, 0),
        SetMemory(0x665580 + 292, SetTo, 0),
        SetMemory(0x665580 + 296, SetTo, 0),
        SetMemory(0x665580 + 300, SetTo, 0),
        SetMemory(0x665580 + 304, SetTo, 516),
        SetMemory(0x665580 + 308, SetTo, 34078720),
        SetMemory(0x665580 + 312, SetTo, 34734080),
        SetMemory(0x665580 + 316, SetTo, 0),
        SetMemory(0x665580 + 320, SetTo, 0),
        SetMemory(0x665580 + 324, SetTo, 0),
        SetMemory(0x665580 + 328, SetTo, 34996224),
        SetMemory(0x665580 + 332, SetTo, 36569626),
        SetMemory(0x665580 + 336, SetTo, 38470206),
        SetMemory(0x665580 + 340, SetTo, 40567384),
        SetMemory(0x665580 + 344, SetTo, 0),
        SetMemory(0x665580 + 348, SetTo, 41811968),
        SetMemory(0x665580 + 352, SetTo, 42336898),
        SetMemory(0x665580 + 356, SetTo, 650),
        SetMemory(0x665580 + 360, SetTo, 0),
        SetMemory(0x665580 + 364, SetTo, 654),
        SetMemory(0x665580 + 368, SetTo, 0),
        SetMemory(0x665580 + 372, SetTo, 0),
    ])
    

