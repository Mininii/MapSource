from eudplib import *


def onPluginStart():
    DoActions([  # Basic DatFile Actions
        SetMemory(0x664500, Add, -131072),# units:Graphics  index:10    from 73 To 71
        SetMemory(0x664504, Add, -553648128),# units:Graphics  index:15    from 71 To 38
        SetMemory(0x66454C, Add, -9),# units:Graphics  index:84    from 50 To 41
        SetMemory(0x664550, Add, 2617245696),# units:Graphics  index:91    from 43 To 199
        SetMemory(0x664554, Add, -9764864),# units:Graphics  index:94    from 199 To 50
        SetMemory(0x664558, Add, -151),# units:Graphics  index:96    from 200 To 49
        SetMemory(0x664570, Add, 11008),# units:Graphics  index:121    from 43 To 86
        SetMemory(0x664578, Add, -256),# units:Graphics  index:129    from 208 To 207
        SetMemory(0x6645A8, Add, 520093696),# units:Graphics  index:179    from 43 To 74
        SetMemory(0x6645B0, Add, 1835008),# units:Graphics  index:186    from 43 To 71
        SetMemory(0x6645B8, Add, 36864),# units:Graphics  index:193    from 43 To 187
        SetMemory(0x6645B8, Add, -2228224),# units:Graphics  index:194    from 122 To 88
        SetMemory(0x6645C0, Add, -100663296),# units:Graphics  index:203    from 179 To 173
        SetMemory(0x6645C4, Add, -21760),# units:Graphics  index:205    from 173 To 88
        SetMemory(0x6645C4, Add, -5636096),# units:Graphics  index:206    from 174 To 88
        SetMemory(0x6645C4, Add, -704643072),# units:Graphics  index:207    from 175 To 133
        SetMemory(0x6645C8, Add, -88),# units:Graphics  index:208    from 176 To 88
        SetMemory(0x6645C8, Add, -23040),# units:Graphics  index:209    from 178 To 88
        SetMemory(0x6645C8, Add, -6029312),# units:Graphics  index:210    from 180 To 88
        SetMemory(0x6645C8, Add, -1577058304),# units:Graphics  index:211    from 182 To 88
        SetMemory(0x6645CC, Add, -93),# units:Graphics  index:212    from 181 To 88
        SetMemory(0x6645D4, Add, 4849664),# units:Graphics  index:222    from 133 To 207
        SetMemory(0x661294, Add, -325),# units:Construction Animation  index:121    from 325 To 0
        SetMemory(0x661398, Add, -325),# units:Construction Animation  index:186    from 325 To 0
        SetMemory(0x660668, Add, 8192),# units:Unit Direction  index:121    from 0 To 32
        SetMemory(0x6606A0, Add, 536870912),# units:Unit Direction  index:179    from 0 To 32
        SetMemory(0x6606A8, Add, 2097152),# units:Unit Direction  index:186    from 0 To 32
        SetMemory(0x6647B8, Add, 65536),# units:Shield Enable  index:10    from 0 To 1
        SetMemory(0x6647B8, Add, 16777216),# units:Shield Enable  index:11    from 0 To 1
        SetMemory(0x6647BC, Add, 1),# units:Shield Enable  index:12    from 0 To 1
        SetMemory(0x6647C0, Add, 256),# units:Shield Enable  index:17    from 0 To 1
        SetMemory(0x6647C4, Add, 256),# units:Shield Enable  index:21    from 0 To 1
        SetMemory(0x6647CC, Add, 256),# units:Shield Enable  index:29    from 0 To 1
        SetMemory(0x6647CC, Add, 65536),# units:Shield Enable  index:30    from 0 To 1
        SetMemory(0x664810, Add, 1),# units:Shield Enable  index:96    from 0 To 1
        SetMemory(0x664818, Add, 16777216),# units:Shield Enable  index:107    from 0 To 1
        SetMemory(0x66482C, Add, 1),# units:Shield Enable  index:124    from 0 To 1
        SetMemory(0x66482C, Add, 256),# units:Shield Enable  index:125    from 0 To 1
        SetMemory(0x664880, Add, 0),# units:Shield Enable  index:211    from 0 To 0
        SetMemory(0x660E14, Add, 8999),# units:Shield Amount  index:10    from 1000 To 9999
        SetMemory(0x660E14, Add, 4288348160),# units:Shield Amount  index:11    from 100 To 65535
        SetMemory(0x660E20, Add, 983040000),# units:Shield Amount  index:17    from 5000 To 20000
        SetMemory(0x660E28, Add, 1835008000),# units:Shield Amount  index:21    from 7000 To 35000
        SetMemory(0x660E3C, Add, -9678),# units:Shield Amount  index:30    from 10000 To 322
        SetMemory(0x660E94, Add, 3639607296),# units:Shield Amount  index:75    from 9999 To 65535
        SetMemory(0x660EC0, Add, 0),# units:Shield Amount  index:96    from 65535 To 65535
        SetMemory(0x66236C, Add, 1267200),# units:Hit Points  index:7    from 12800 To 1280000
        SetMemory(0x66237C, Add, 11377664),# units:Hit Points  index:11    from 8533248 To 19910912
        SetMemory(0x662394, Add, 6656000),# units:Hit Points  index:17    from 2304000 To 8960000
        SetMemory(0x66239C, Add, 14848000),# units:Hit Points  index:19    from 2304000 To 17152000
        SetMemory(0x6623A4, Add, 6656000),# units:Hit Points  index:21    from 2304000 To 8960000
        SetMemory(0x6623AC, Add, 76800000),# units:Hit Points  index:23    from 94720000 To 171520000
        SetMemory(0x6623B4, Add, 10240000),# units:Hit Points  index:25    from 1280000 To 11520000
        SetMemory(0x6623BC, Add, 25600000),# units:Hit Points  index:27    from 3840000 To 29440000
        SetMemory(0x6623C0, Add, 17920000),# units:Hit Points  index:28    from 1536000 To 19456000
        SetMemory(0x6623C4, Add, 51200000),# units:Hit Points  index:29    from 25600000 To 76800000
        SetMemory(0x6623C8, Add, 82167),# units:Hit Points  index:30    from 265 To 82432
        SetMemory(0x662420, Add, 17920000),# units:Hit Points  index:52    from 10240000 To 28160000
        SetMemory(0x662434, Add, 8533248),# units:Hit Points  index:57    from 5688832 To 14222080
        SetMemory(0x662448, Add, 12800000),# units:Hit Points  index:62    from 3840000 To 16640000
        SetMemory(0x66247C, Add, 8960256),# units:Hit Points  index:75    from 2559744 To 11520000
        SetMemory(0x662480, Add, 9856000),# units:Hit Points  index:76    from 1664000 To 11520000
        SetMemory(0x662484, Add, 7347200),# units:Hit Points  index:77    from 2304000 To 9651200
        SetMemory(0x662488, Add, 10188800),# units:Hit Points  index:78    from 1792000 To 11980800
        SetMemory(0x66248C, Add, 17920256),# units:Hit Points  index:79    from 2559744 To 20480000
        SetMemory(0x662490, Add, 17920000),# units:Hit Points  index:80    from 5120000 To 23040000
        SetMemory(0x662494, Add, 22528000),# units:Hit Points  index:81    from 7680000 To 30208000
        SetMemory(0x6624A8, Add, 11213056),# units:Hit Points  index:86    from 2559744 To 13772800
        SetMemory(0x6624B0, Add, 9472000),# units:Hit Points  index:88    from 2048000 To 11520000
        SetMemory(0x6624BC, Add, -16640),# units:Hit Points  index:91    from 32000 To 15360
        SetMemory(0x6624D0, Add, 0),# units:Hit Points  index:96    from 2129920000 To 2129920000
        SetMemory(0x6624D8, Add, 19200256),# units:Hit Points  index:98    from 2559744 To 21760000
        SetMemory(0x6624EC, Add, 2534400),# units:Hit Points  index:103    from 281600 To 2816000
        SetMemory(0x662534, Add, 1215987200),# units:Hit Points  index:121    from 12800 To 1216000000
        SetMemory(0x66255C, Add, 7654400),# units:Hit Points  index:131    from 25600 To 7680000
        SetMemory(0x662560, Add, 12774400),# units:Hit Points  index:132    from 25600 To 12800000
        SetMemory(0x662564, Add, 20454400),# units:Hit Points  index:133    from 25600 To 20480000
        SetMemory(0x66261C, Add, -202752),# units:Hit Points  index:179    from 204800 To 2048
        SetMemory(0x662654, Add, 230400000),# units:Hit Points  index:193    from 25600000 To 256000000
        SetMemory(0x66267C, Add, 255987200),# units:Hit Points  index:203    from 12800 To 256000000
        SetMemory(0x662680, Add, 230400000),# units:Hit Points  index:204    from 25600000 To 256000000
        SetMemory(0x6626C0, Add, -174080),# units:Hit Points  index:220    from 204800 To 30720
        SetMemory(0x663150, Add, 524288),# units:Elevation Level  index:2    from 4 To 12
        SetMemory(0x663150, Add, 134217728),# units:Elevation Level  index:3    from 4 To 12
        SetMemory(0x66316C, Add, 1048576),# units:Elevation Level  index:30    from 4 To 20
        SetMemory(0x663170, Add, 524288),# units:Elevation Level  index:34    from 4 To 12
        SetMemory(0x66318C, Add, 134217728),# units:Elevation Level  index:63    from 4 To 12
        SetMemory(0x663190, Add, 8),# units:Elevation Level  index:64    from 4 To 12
        SetMemory(0x663190, Add, 2048),# units:Elevation Level  index:65    from 4 To 12
        SetMemory(0x663190, Add, 524288),# units:Elevation Level  index:66    from 4 To 12
        SetMemory(0x663190, Add, 134217728),# units:Elevation Level  index:67    from 4 To 12
        SetMemory(0x6631A4, Add, 1),# units:Elevation Level  index:84    from 18 To 19
        SetMemory(0x6631A8, Add, 33554432),# units:Elevation Level  index:91    from 18 To 20
        SetMemory(0x6631AC, Add, 131072),# units:Elevation Level  index:94    from 18 To 20
        SetMemory(0x6631C8, Add, 2048),# units:Elevation Level  index:121    from 4 To 12
        SetMemory(0x6631D0, Add, 16),# units:Elevation Level  index:128    from 4 To 20
        SetMemory(0x6631D0, Add, 2048),# units:Elevation Level  index:129    from 4 To 12
        SetMemory(0x663200, Add, 134217728),# units:Elevation Level  index:179    from 4 To 12
        SetMemory(0x663210, Add, 2816),# units:Elevation Level  index:193    from 1 To 12
        SetMemory(0x663210, Add, 1310720),# units:Elevation Level  index:194    from 0 To 20
        SetMemory(0x66321C, Add, 268435456),# units:Elevation Level  index:207    from 4 To 20
        SetMemory(0x663220, Add, 16),# units:Elevation Level  index:208    from 4 To 20
        SetMemory(0x663220, Add, 1048576),# units:Elevation Level  index:210    from 4 To 20
        SetMemory(0x663220, Add, 268435456),# units:Elevation Level  index:211    from 4 To 20
        SetMemory(0x663224, Add, 16),# units:Elevation Level  index:212    from 4 To 20
        SetMemory(0x663228, Add, 134217728),# units:Elevation Level  index:219    from 4 To 12
        SetMemory(0x66322C, Add, 524288),# units:Elevation Level  index:222    from 4 To 12
        SetMemory(0x661024, Add, -262144),# units:Unknown (old Movement)  index:94    from 197 To 193
        SetMemory(0x661040, Add, 33536),# units:Unknown (old Movement)  index:121    from 0 To 131
        SetMemory(0x661078, Add, 2197815296),# units:Unknown (old Movement)  index:179    from 0 To 131
        SetMemory(0x661080, Add, 12648448),# units:Unknown (old Movement)  index:186    from 0 To 193
        SetMemory(0x661088, Add, 49408),# units:Unknown (old Movement)  index:193    from 0 To 193
        SetMemory(0x661088, Add, 12779520),# units:Unknown (old Movement)  index:194    from 0 To 195
        SetMemory(0x661098, Add, 0),# units:Unknown (old Movement)  index:210    from 0 To 0
        SetMemory(0x663DD8, Add, -720896),# units:Rank/Sublabel  index:10    from 12 To 1
        SetMemory(0x663E3C, Add, 3019898880),# units:Rank/Sublabel  index:111    from 0 To 180
        SetMemory(0x663E48, Add, 50944),# units:Rank/Sublabel  index:121    from 0 To 199
        SetMemory(0x663E88, Add, 12713984),# units:Rank/Sublabel  index:186    from 0 To 194
        SetMemory(0x662EA8, Add, -1526726656),# units:Comp AI Idle  index:11    from 93 To 2
        SetMemory(0x662ED8, Add, -39424),# units:Comp AI Idle  index:57    from 156 To 2
        SetMemory(0x662EE4, Add, -23296),# units:Comp AI Idle  index:69    from 93 To 2
        SetMemory(0x662EF0, Add, -14336),# units:Comp AI Idle  index:81    from 58 To 2
        SetMemory(0x662EF4, Add, -157),# units:Comp AI Idle  index:84    from 159 To 2
        SetMemory(0x662F18, Add, -39424),# units:Comp AI Idle  index:121    from 156 To 2
        SetMemory(0x662F20, Add, -74),# units:Comp AI Idle  index:128    from 97 To 23
        SetMemory(0x662F20, Add, -18944),# units:Comp AI Idle  index:129    from 97 To 23
        SetMemory(0x662F50, Add, -352321536),# units:Comp AI Idle  index:179    from 23 To 2
        SetMemory(0x662F58, Add, -1376256),# units:Comp AI Idle  index:186    from 23 To 2
        SetMemory(0x662F60, Add, -5376),# units:Comp AI Idle  index:193    from 23 To 2
        SetMemory(0x662F60, Add, -1376256),# units:Comp AI Idle  index:194    from 23 To 2
        SetMemory(0x662F70, Add, -36864),# units:Comp AI Idle  index:209    from 167 To 23
        SetMemory(0x662F70, Add, -9437184),# units:Comp AI Idle  index:210    from 167 To 23
        SetMemory(0x662F70, Add, -2415919104),# units:Comp AI Idle  index:211    from 167 To 23
        SetMemory(0x662F74, Add, -144),# units:Comp AI Idle  index:212    from 167 To 23
        SetMemory(0x662F78, Add, -1241513984),# units:Comp AI Idle  index:219    from 97 To 23
        SetMemory(0x662F7C, Add, -4849664),# units:Comp AI Idle  index:222    from 97 To 23
        SetMemory(0x662270, Add, -1526726656),# units:Human AI Idle  index:11    from 93 To 2
        SetMemory(0x6622A0, Add, -23296),# units:Human AI Idle  index:57    from 93 To 2
        SetMemory(0x6622AC, Add, -23296),# units:Human AI Idle  index:69    from 93 To 2
        SetMemory(0x6622B8, Add, -14336),# units:Human AI Idle  index:81    from 58 To 2
        SetMemory(0x6622C4, Add, -10747904),# units:Human AI Idle  index:94    from 166 To 2
        SetMemory(0x6622C8, Add, -164),# units:Human AI Idle  index:96    from 166 To 2
        SetMemory(0x6622E0, Add, -5376),# units:Human AI Idle  index:121    from 23 To 2
        SetMemory(0x6622E8, Add, -74),# units:Human AI Idle  index:128    from 97 To 23
        SetMemory(0x6622E8, Add, -18944),# units:Human AI Idle  index:129    from 97 To 23
        SetMemory(0x662318, Add, -352321536),# units:Human AI Idle  index:179    from 23 To 2
        SetMemory(0x662320, Add, -1376256),# units:Human AI Idle  index:186    from 23 To 2
        SetMemory(0x662328, Add, -5376),# units:Human AI Idle  index:193    from 23 To 2
        SetMemory(0x662328, Add, -1376256),# units:Human AI Idle  index:194    from 23 To 2
        SetMemory(0x662338, Add, -36864),# units:Human AI Idle  index:209    from 167 To 23
        SetMemory(0x662338, Add, -9437184),# units:Human AI Idle  index:210    from 167 To 23
        SetMemory(0x662338, Add, -2415919104),# units:Human AI Idle  index:211    from 167 To 23
        SetMemory(0x66233C, Add, -144),# units:Human AI Idle  index:212    from 167 To 23
        SetMemory(0x662340, Add, -1241513984),# units:Human AI Idle  index:219    from 97 To 23
        SetMemory(0x662344, Add, -4849664),# units:Human AI Idle  index:222    from 97 To 23
        SetMemory(0x6648A0, Add, -1526726656),# units:Return to Idle  index:11    from 93 To 2
        SetMemory(0x6648D0, Add, -23296),# units:Return to Idle  index:57    from 93 To 2
        SetMemory(0x6648DC, Add, -23296),# units:Return to Idle  index:69    from 93 To 2
        SetMemory(0x6648E8, Add, -14336),# units:Return to Idle  index:81    from 58 To 2
        SetMemory(0x6648F4, Add, -10747904),# units:Return to Idle  index:94    from 166 To 2
        SetMemory(0x6648F8, Add, -164),# units:Return to Idle  index:96    from 166 To 2
        SetMemory(0x664910, Add, -5376),# units:Return to Idle  index:121    from 23 To 2
        SetMemory(0x664918, Add, -74),# units:Return to Idle  index:128    from 97 To 23
        SetMemory(0x664918, Add, -18944),# units:Return to Idle  index:129    from 97 To 23
        SetMemory(0x664948, Add, -352321536),# units:Return to Idle  index:179    from 23 To 2
        SetMemory(0x664950, Add, -1376256),# units:Return to Idle  index:186    from 23 To 2
        SetMemory(0x664958, Add, -5376),# units:Return to Idle  index:193    from 23 To 2
        SetMemory(0x664958, Add, -1376256),# units:Return to Idle  index:194    from 23 To 2
        SetMemory(0x664968, Add, -36864),# units:Return to Idle  index:209    from 167 To 23
        SetMemory(0x664968, Add, -9437184),# units:Return to Idle  index:210    from 167 To 23
        SetMemory(0x664968, Add, -2415919104),# units:Return to Idle  index:211    from 167 To 23
        SetMemory(0x66496C, Add, -144),# units:Return to Idle  index:212    from 167 To 23
        SetMemory(0x664970, Add, -1241513984),# units:Return to Idle  index:219    from 97 To 23
        SetMemory(0x664974, Add, -4849664),# units:Return to Idle  index:222    from 97 To 23
        SetMemory(0x663328, Add, -184549376),# units:Attack Unit  index:11    from 21 To 10
        SetMemory(0x66332C, Add, -184549376),# units:Attack Unit  index:15    from 21 To 10
        SetMemory(0x663358, Add, -2816),# units:Attack Unit  index:57    from 21 To 10
        SetMemory(0x66335C, Add, -184549376),# units:Attack Unit  index:63    from 21 To 10
        SetMemory(0x663364, Add, -2816),# units:Attack Unit  index:69    from 21 To 10
        SetMemory(0x663370, Add, -12544),# units:Attack Unit  index:81    from 59 To 10
        SetMemory(0x66337C, Add, -11665408),# units:Attack Unit  index:94    from 188 To 10
        SetMemory(0x663380, Add, -178),# units:Attack Unit  index:96    from 188 To 10
        SetMemory(0x663398, Add, -3328),# units:Attack Unit  index:121    from 23 To 10
        SetMemory(0x6633D0, Add, -218103808),# units:Attack Unit  index:179    from 23 To 10
        SetMemory(0x6633D8, Add, -851968),# units:Attack Unit  index:186    from 23 To 10
        SetMemory(0x6633E0, Add, -3328),# units:Attack Unit  index:193    from 23 To 10
        SetMemory(0x6633E0, Add, -851968),# units:Attack Unit  index:194    from 23 To 10
        SetMemory(0x6633F0, Add, 1024),# units:Attack Unit  index:209    from 19 To 23
        SetMemory(0x6633F0, Add, 262144),# units:Attack Unit  index:210    from 19 To 23
        SetMemory(0x6633F0, Add, 67108864),# units:Attack Unit  index:211    from 19 To 23
        SetMemory(0x6633F4, Add, 4),# units:Attack Unit  index:212    from 19 To 23
        SetMemory(0x663AA0, Add, -14336),# units:Attack Move  index:81    from 58 To 2
        SetMemory(0x663AAC, Add, -12189696),# units:Attack Move  index:94    from 188 To 2
        SetMemory(0x663AB0, Add, -186),# units:Attack Move  index:96    from 188 To 2
        SetMemory(0x663AC8, Add, -5376),# units:Attack Move  index:121    from 23 To 2
        SetMemory(0x663B00, Add, -352321536),# units:Attack Move  index:179    from 23 To 2
        SetMemory(0x663B08, Add, -1376256),# units:Attack Move  index:186    from 23 To 2
        SetMemory(0x663B10, Add, -5376),# units:Attack Move  index:193    from 23 To 2
        SetMemory(0x663B10, Add, -1376256),# units:Attack Move  index:194    from 23 To 2
        SetMemory(0x663B20, Add, 0),# units:Attack Move  index:210    from 23 To 23
        SetMemory(0x6636C0, Add, -1703936),# units:Ground Weapon  index:10    from 26 To 0
        SetMemory(0x6636C0, Add, -671088640),# units:Ground Weapon  index:11    from 130 To 90
        SetMemory(0x6636C4, Add, 73),# units:Ground Weapon  index:12    from 19 To 92
        SetMemory(0x6636C4, Add, -1006632960),# units:Ground Weapon  index:15    from 130 To 70
        SetMemory(0x6636D0, Add, 16777216),# units:Ground Weapon  index:27    from 21 To 22
        SetMemory(0x6636E4, Add, -855638016),# units:Ground Weapon  index:47    from 130 To 79
        SetMemory(0x6636EC, Add, -79),# units:Ground Weapon  index:52    from 130 To 51
        SetMemory(0x6636F0, Add, -5120),# units:Ground Weapon  index:57    from 130 To 110
        SetMemory(0x6636F4, Add, -30),# units:Ground Weapon  index:60    from 130 To 100
        SetMemory(0x6636F4, Add, -1703936),# units:Ground Weapon  index:62    from 130 To 104
        SetMemory(0x6636F4, Add, -704643072),# units:Ground Weapon  index:63    from 130 To 88
        SetMemory(0x6636FC, Add, -25600),# units:Ground Weapon  index:69    from 130 To 30
        SetMemory(0x663708, Add, -10496),# units:Ground Weapon  index:81    from 130 To 89
        SetMemory(0x66370C, Add, -6),# units:Ground Weapon  index:84    from 130 To 124
        SetMemory(0x66370C, Add, -16777216),# units:Ground Weapon  index:87    from 69 To 68
        SetMemory(0x663718, Add, -1966080),# units:Ground Weapon  index:98    from 130 To 100
        SetMemory(0x663730, Add, -256),# units:Ground Weapon  index:121    from 130 To 129
        SetMemory(0x663734, Add, -101),# units:Ground Weapon  index:124    from 130 To 29
        SetMemory(0x663768, Add, -620756992),# units:Ground Weapon  index:179    from 130 To 93
        SetMemory(0x663778, Add, -19200),# units:Ground Weapon  index:193    from 130 To 55
        SetMemory(0x663780, Add, 520093696),# units:Ground Weapon  index:203    from 99 To 130
        SetMemory(0x663784, Add, -1280),# units:Ground Weapon  index:205    from 130 To 125
        SetMemory(0x663784, Add, -262144),# units:Ground Weapon  index:206    from 130 To 126
        SetMemory(0x663788, Add, -3),# units:Ground Weapon  index:208    from 130 To 127
        SetMemory(0x663788, Add, 8192),# units:Ground Weapon  index:209    from 96 To 128
        SetMemory(0x663788, Add, 2031616),# units:Ground Weapon  index:210    from 97 To 128
        SetMemory(0x663788, Add, -117440512),# units:Ground Weapon  index:211    from 98 To 91
        SetMemory(0x66378C, Add, -3),# units:Ground Weapon  index:212    from 97 To 94
        SetMemory(0x6645E8, Add, -196608),# units:Max Ground Hits  index:10    from 3 To 0
        SetMemory(0x6616E8, Add, -8519680),# units:Air Weapon  index:10    from 130 To 0
        SetMemory(0x6616EC, Add, 72),# units:Air Weapon  index:12    from 20 To 92
        SetMemory(0x6616EC, Add, -1006632960),# units:Air Weapon  index:15    from 130 To 70
        SetMemory(0x6616FC, Add, -256),# units:Air Weapon  index:29    from 22 To 21
        SetMemory(0x66170C, Add, 402653184),# units:Air Weapon  index:47    from 55 To 79
        SetMemory(0x66171C, Add, -704643072),# units:Air Weapon  index:63    from 130 To 88
        SetMemory(0x661790, Add, -620756992),# units:Air Weapon  index:179    from 130 To 93
        SetMemory(0x660180, Add, 50331648),# units:AI Internal  index:11    from 0 To 3
        SetMemory(0x660194, Add, 196608),# units:AI Internal  index:30    from 0 To 3
        SetMemory(0x66019C, Add, 768),# units:AI Internal  index:37    from 0 To 3
        SetMemory(0x66019C, Add, 196608),# units:AI Internal  index:38    from 0 To 3
        SetMemory(0x66019C, Add, 50331648),# units:AI Internal  index:39    from 0 To 3
        SetMemory(0x6601A0, Add, 50331648),# units:AI Internal  index:43    from 0 To 3
        SetMemory(0x6601A4, Add, 3),# units:AI Internal  index:44    from 0 To 3
        SetMemory(0x6601A4, Add, 50331648),# units:AI Internal  index:47    from 0 To 3
        SetMemory(0x6601B4, Add, 3),# units:AI Internal  index:60    from 0 To 3
        SetMemory(0x6601BC, Add, 3),# units:AI Internal  index:68    from 0 To 3
        SetMemory(0x6601BC, Add, 768),# units:AI Internal  index:69    from 0 To 3
        SetMemory(0x6601D0, Add, 50331648),# units:AI Internal  index:91    from 0 To 3
        SetMemory(0x6601D8, Add, 196608),# units:AI Internal  index:98    from 0 To 3
        SetMemory(0x6601DC, Add, 50331648),# units:AI Internal  index:103    from 0 To 3
        SetMemory(0x664088, Add, 536870912),# units:Special Ability Flags  index:2    from 1476395008 To 2013265920
        SetMemory(0x66408C, Add, 536870916),# units:Special Ability Flags  index:3    from 1476395008 To 2013265924
        SetMemory(0x66409C, Add, 16376),# units:Special Ability Flags  index:7    from 1476460552 To 1476476928
        SetMemory(0x6640A4, Add, 536870912),# units:Special Ability Flags  index:9    from 1512079620 To 2048950532
        SetMemory(0x6640A8, Add, 16320),# units:Special Ability Flags  index:10    from 402718784 To 402735104
        SetMemory(0x6640AC, Add, 64),# units:Special Ability Flags  index:11    from 1509949444 To 1509949508
        SetMemory(0x6640B0, Add, 49148),# units:Special Ability Flags  index:12    from 1545601028 To 1545650176
        SetMemory(0x6640B4, Add, 4),# units:Special Ability Flags  index:13    from 402653184 To 402653188
        SetMemory(0x6640BC, Add, 64),# units:Special Ability Flags  index:15    from 402718720 To 402718784
        SetMemory(0x6640F8, Add, 68),# units:Special Ability Flags  index:30    from 1107296256 To 1107296324
        SetMemory(0x664108, Add, 536870912),# units:Special Ability Flags  index:34    from 404815872 To 941686784
        SetMemory(0x664114, Add, 64),# units:Special Ability Flags  index:37    from 403768448 To 403768512
        SetMemory(0x664118, Add, 64),# units:Special Ability Flags  index:38    from 403767424 To 403767488
        SetMemory(0x66411C, Add, 64),# units:Special Ability Flags  index:39    from 469827712 To 469827776
        SetMemory(0x66412C, Add, 64),# units:Special Ability Flags  index:43    from 436273284 To 436273348
        SetMemory(0x664130, Add, 64),# units:Special Ability Flags  index:44    from 486604932 To 486604996
        SetMemory(0x66413C, Add, 64),# units:Special Ability Flags  index:47    from 402719876 To 402719940
        SetMemory(0x664164, Add, -32768),# units:Special Ability Flags  index:57    from 436306116 To 436273348
        SetMemory(0x664170, Add, 64),# units:Special Ability Flags  index:60    from 1512046596 To 1512046660
        SetMemory(0x66417C, Add, 536870916),# units:Special Ability Flags  index:63    from 471859456 To 1008730372
        SetMemory(0x664180, Add, 536870912),# units:Special Ability Flags  index:64    from 1476411400 To 2013282312
        SetMemory(0x664184, Add, 536870912),# units:Special Ability Flags  index:65    from 402718720 To 939589632
        SetMemory(0x664188, Add, 536870912),# units:Special Ability Flags  index:66    from 1509949440 To 2046820352
        SetMemory(0x66418C, Add, 536870912),# units:Special Ability Flags  index:67    from 404815872 To 941686784
        SetMemory(0x664190, Add, 64),# units:Special Ability Flags  index:68    from 469762304 To 469762368
        SetMemory(0x664194, Add, 64),# units:Special Ability Flags  index:69    from 1509965828 To 1509965892
        SetMemory(0x66419C, Add, 536870912),# units:Special Ability Flags  index:71    from 1512046596 To 2048917508
        SetMemory(0x6641A8, Add, 64),# units:Special Ability Flags  index:74    from 406913024 To 406913088
        SetMemory(0x6641D0, Add, -4227008),# units:Special Ability Flags  index:84    from 1480638468 To 1476411460
        SetMemory(0x6641EC, Add, 402718724),# units:Special Ability Flags  index:91    from 0 To 402718724
        SetMemory(0x6641F8, Add, 541000192),# units:Special Ability Flags  index:94    from 402718724 To 943718916
        SetMemory(0x664200, Add, 32768),# units:Special Ability Flags  index:96    from 402718720 To 402751488
        SetMemory(0x664214, Add, 32768),# units:Special Ability Flags  index:101    from 4 To 32772
        SetMemory(0x66421C, Add, 64),# units:Special Ability Flags  index:103    from 403767424 To 403767488
        SetMemory(0x66422C, Add, 536903678),# units:Special Ability Flags  index:107    from 1142947843 To 1679851521
        SetMemory(0x66423C, Add, 536870912),# units:Special Ability Flags  index:111    from 3288334369 To 3825205281
        SetMemory(0x664264, Add, -939524031),# units:Special Ability Flags  index:121    from 1140850691 To 201326660
        SetMemory(0x664270, Add, 16512),# units:Special Ability Flags  index:124    from 1409319169 To 1409335681
        SetMemory(0x664274, Add, 16512),# units:Special Ability Flags  index:125    from 3288334337 To 3288350849
        SetMemory(0x664280, Add, 4),# units:Special Ability Flags  index:128    from 536872960 To 536872964
        SetMemory(0x664284, Add, 4),# units:Special Ability Flags  index:129    from 536872960 To 536872964
        SetMemory(0x66428C, Add, -128),# units:Special Ability Flags  index:131    from 2231439489 To 2231439361
        SetMemory(0x664290, Add, -128),# units:Special Ability Flags  index:132    from 2231439489 To 2231439361
        SetMemory(0x664294, Add, -128),# units:Special Ability Flags  index:133    from 2231439489 To 2231439361
        SetMemory(0x664334, Add, -536870912),# units:Special Ability Flags  index:173    from 603979777 To 67108865
        SetMemory(0x66434C, Add, 335538179),# units:Special Ability Flags  index:179    from 603987969 To 939526148
        SetMemory(0x664368, Add, 335544383),# units:Special Ability Flags  index:186    from 67108865 To 402653248
        SetMemory(0x664384, Add, -134217725),# units:Special Ability Flags  index:193    from 536870913 To 402653188
        SetMemory(0x664388, Add, 402655235),# units:Special Ability Flags  index:194    from 536870913 To 939526148
        SetMemory(0x6643AC, Add, -872447996),# units:Special Ability Flags  index:203    from 1409318912 To 536870916
        SetMemory(0x6643B0, Add, 4),# units:Special Ability Flags  index:204    from 536870912 To 536870916
        SetMemory(0x6643B4, Add, 4),# units:Special Ability Flags  index:205    from 536870912 To 536870916
        SetMemory(0x6643B8, Add, 4),# units:Special Ability Flags  index:206    from 536870912 To 536870916
        SetMemory(0x6643BC, Add, 4),# units:Special Ability Flags  index:207    from 536870912 To 536870916
        SetMemory(0x6643C0, Add, 4),# units:Special Ability Flags  index:208    from 536870912 To 536870916
        SetMemory(0x6643C8, Add, -604012540),# units:Special Ability Flags  index:210    from 1140883456 To 536870916
        SetMemory(0x6643CC, Add, -604012540),# units:Special Ability Flags  index:211    from 1140883456 To 536870916
        SetMemory(0x6643D0, Add, -604012540),# units:Special Ability Flags  index:212    from 1140883456 To 536870916
        SetMemory(0x6643EC, Add, 4),# units:Special Ability Flags  index:219    from 545261568 To 545261572
        SetMemory(0x6643F8, Add, 536870916),# units:Special Ability Flags  index:222    from 8390656 To 545261572
        SetMemory(0x662DC0, Add, 65536),# units:Target Acquisition Range  index:10    from 3 To 4
        SetMemory(0x662DC0, Add, 117440512),# units:Target Acquisition Range  index:11    from 0 To 7
        SetMemory(0x662DC4, Add, 117440512),# units:Target Acquisition Range  index:15    from 0 To 7
        SetMemory(0x662DE4, Add, 16777216),# units:Target Acquisition Range  index:47    from 3 To 4
        SetMemory(0x662DEC, Add, 6),# units:Target Acquisition Range  index:52    from 0 To 6
        SetMemory(0x662DF0, Add, 1024),# units:Target Acquisition Range  index:57    from 0 To 4
        SetMemory(0x662DF4, Add, -5),# units:Target Acquisition Range  index:60    from 9 To 4
        SetMemory(0x662DF4, Add, 285212672),# units:Target Acquisition Range  index:63    from 7 To 24
        SetMemory(0x662DFC, Add, 2560),# units:Target Acquisition Range  index:69    from 0 To 10
        SetMemory(0x662E0C, Add, 4),# units:Target Acquisition Range  index:84    from 0 To 4
        SetMemory(0x662E0C, Add, 33554432),# units:Target Acquisition Range  index:87    from 3 To 5
        SetMemory(0x662E10, Add, -134217728),# units:Target Acquisition Range  index:91    from 8 To 0
        SetMemory(0x662E30, Add, 1536),# units:Target Acquisition Range  index:121    from 0 To 6
        SetMemory(0x662E68, Add, 150994944),# units:Target Acquisition Range  index:179    from 0 To 9
        SetMemory(0x662E78, Add, 1280),# units:Target Acquisition Range  index:193    from 0 To 5
        SetMemory(0x662E88, Add, 50331648),# units:Target Acquisition Range  index:211    from 2 To 5
        SetMemory(0x663240, Add, 131072),# units:Sight Range  index:10    from 7 To 9
        SetMemory(0x663240, Add, 50331648),# units:Sight Range  index:11    from 8 To 11
        SetMemory(0x663264, Add, 67108864),# units:Sight Range  index:47    from 5 To 9
        SetMemory(0x663274, Add, 16777216),# units:Sight Range  index:63    from 10 To 11
        SetMemory(0x66327C, Add, -150994944),# units:Sight Range  index:71    from 9 To 0
        SetMemory(0x66328C, Add, -3),# units:Sight Range  index:84    from 9 To 6
        SetMemory(0x663290, Add, -16777216),# units:Sight Range  index:91    from 8 To 7
        SetMemory(0x66329C, Add, 256),# units:Sight Range  index:101    from 10 To 11
        SetMemory(0x6632B0, Add, 768),# units:Sight Range  index:121    from 8 To 11
        SetMemory(0x6632B8, Add, 1536),# units:Sight Range  index:129    from 5 To 11
        SetMemory(0x6632F0, Add, 131072),# units:Sight Range  index:186    from 9 To 11
        SetMemory(0x663308, Add, 50331648),# units:Sight Range  index:211    from 3 To 6
        SetMemory(0x6621D8, Add, -16777216),# units:Unit Size  index:91    from 2 To 1
        SetMemory(0x65FF20, Add, -16777216),# units:Armor  index:91    from 1 To 0
        SetMemory(0x66209C, Add, -67108864),# units:Right-click Action  index:7    from 5 To 1
        SetMemory(0x6620A0, Add, -16777216),# units:Right-click Action  index:11    from 2 To 1
        SetMemory(0x6620A4, Add, -16777216),# units:Right-click Action  index:15    from 2 To 1
        SetMemory(0x6620CC, Add, -1),# units:Right-click Action  index:52    from 2 To 1
        SetMemory(0x6620D0, Add, -256),# units:Right-click Action  index:57    from 2 To 1
        SetMemory(0x6620D4, Add, -16777216),# units:Right-click Action  index:63    from 2 To 1
        SetMemory(0x6620DC, Add, -256),# units:Right-click Action  index:69    from 2 To 1
        SetMemory(0x6620EC, Add, -1),# units:Right-click Action  index:84    from 2 To 1
        SetMemory(0x6620F0, Add, 33554432),# units:Right-click Action  index:91    from 0 To 2
        SetMemory(0x6620F4, Add, -65536),# units:Right-click Action  index:94    from 2 To 1
        SetMemory(0x6620F8, Add, -1),# units:Right-click Action  index:96    from 2 To 1
        SetMemory(0x662110, Add, 256),# units:Right-click Action  index:121    from 0 To 1
        SetMemory(0x662148, Add, 16777216),# units:Right-click Action  index:179    from 0 To 1
        SetMemory(0x662150, Add, 65536),# units:Right-click Action  index:186    from 0 To 1
        SetMemory(0x662158, Add, 256),# units:Right-click Action  index:193    from 0 To 1
        SetMemory(0x662158, Add, 65536),# units:Right-click Action  index:194    from 0 To 1
        SetMemory(0x662168, Add, 0),# units:Right-click Action  index:210    from 0 To 0
        SetMemory(0x661FD4, Add, -87),# units:Ready Sound  index:10    from 295 To 208
        SetMemory(0x661FDC, Add, 13631488),# units:Ready Sound  index:15    from 0 To 208
        SetMemory(0x661FE4, Add, 41746432),# units:Ready Sound  index:19    from 0 To 637
        SetMemory(0x661FF8, Add, 225),# units:Ready Sound  index:28    from 0 To 225
        SetMemory(0x662040, Add, -306),# units:Ready Sound  index:64    from 597 To 291
        SetMemory(0x662040, Add, -32571392),# units:Ready Sound  index:65    from 666 To 169
        SetMemory(0x662044, Add, -212),# units:Ready Sound  index:66    from 492 To 280
        SetMemory(0x662044, Add, -29687808),# units:Ready Sound  index:67    from 622 To 169
        SetMemory(0x66204C, Add, -17760256),# units:Ready Sound  index:71    from 549 To 278
        SetMemory(0x662060, Add, 465),# units:Ready Sound  index:80    from 534 To 999
        SetMemory(0x662070, Add, 999),# units:Ready Sound  index:88    from 0 To 999
        SetMemory(0x65FFC4, Add, -101),# units:What Sound Start  index:10    from 299 To 198
        SetMemory(0x660064, Add, 63963136),# units:What Sound Start  index:91    from 0 To 976
        SetMemory(0x662C04, Add, -101),# units:What Sound End  index:10    from 302 To 201
        SetMemory(0x662CA4, Add, 64094208),# units:What Sound End  index:91    from 0 To 978
        SetMemory(0x663B4C, Add, -110),# units:Piss Sound Start  index:10    from 303 To 193
        SetMemory(0x661EFC, Add, -112),# units:Piss Sound End  index:10    from 309 To 197
        SetMemory(0x663C24, Add, -108),# units:Yes Sound Start  index:10    from 310 To 202
        SetMemory(0x661454, Add, -107),# units:Yes Sound End  index:10    from 313 To 206
        SetMemory(0x662888, Add, -6),# units:StarEdit Placement Box Width  index:10    from 23 To 17
        SetMemory(0x66297C, Add, -43),# units:StarEdit Placement Box Width  index:71    from 44 To 1
        SetMemory(0x6629CC, Add, -31),# units:StarEdit Placement Box Width  index:91    from 32 To 1
        SetMemory(0x6629D8, Add, -31),# units:StarEdit Placement Box Width  index:94    from 32 To 1
        SetMemory(0x662A44, Add, -95),# units:StarEdit Placement Box Width  index:121    from 96 To 1
        SetMemory(0x662B2C, Add, -63),# units:StarEdit Placement Box Width  index:179    from 64 To 1
        SetMemory(0x662B64, Add, -95),# units:StarEdit Placement Box Width  index:193    from 96 To 1
        SetMemory(0x662B90, Add, -255),# units:StarEdit Placement Box Width  index:204    from 256 To 1
        SetMemory(0x662B94, Add, -135),# units:StarEdit Placement Box Width  index:205    from 136 To 1
        SetMemory(0x662B98, Add, -135),# units:StarEdit Placement Box Width  index:206    from 136 To 1
        SetMemory(0x662B9C, Add, -147),# units:StarEdit Placement Box Width  index:207    from 148 To 1
        SetMemory(0x662BA0, Add, -147),# units:StarEdit Placement Box Width  index:208    from 148 To 1
        SetMemory(0x662BA4, Add, -63),# units:StarEdit Placement Box Width  index:209    from 64 To 1
        SetMemory(0x662BA8, Add, -63),# units:StarEdit Placement Box Width  index:210    from 64 To 1
        SetMemory(0x662BAC, Add, -63),# units:StarEdit Placement Box Width  index:211    from 64 To 1
        SetMemory(0x662BB0, Add, -63),# units:StarEdit Placement Box Width  index:212    from 64 To 1
        SetMemory(0x662888, Add, -524288),# units:StarEdit Placement Box Height  index:10    from 28 To 20
        SetMemory(0x66297C, Add, -2883584),# units:StarEdit Placement Box Height  index:71    from 44 To 0
        SetMemory(0x6629CC, Add, -2031616),# units:StarEdit Placement Box Height  index:91    from 32 To 1
        SetMemory(0x6629D8, Add, -2031616),# units:StarEdit Placement Box Height  index:94    from 32 To 1
        SetMemory(0x662A44, Add, -6225920),# units:StarEdit Placement Box Height  index:121    from 96 To 1
        SetMemory(0x662B2C, Add, -4194304),# units:StarEdit Placement Box Height  index:179    from 64 To 0
        SetMemory(0x662B64, Add, -4128768),# units:StarEdit Placement Box Height  index:193    from 64 To 1
        SetMemory(0x662B90, Add, -8323072),# units:StarEdit Placement Box Height  index:204    from 128 To 1
        SetMemory(0x662B94, Add, -8912896),# units:StarEdit Placement Box Height  index:205    from 136 To 0
        SetMemory(0x662B98, Add, -8912896),# units:StarEdit Placement Box Height  index:206    from 136 To 0
        SetMemory(0x662B9C, Add, -6488064),# units:StarEdit Placement Box Height  index:207    from 100 To 1
        SetMemory(0x662BA0, Add, -6553600),# units:StarEdit Placement Box Height  index:208    from 100 To 0
        SetMemory(0x662BA4, Add, -4194304),# units:StarEdit Placement Box Height  index:209    from 64 To 0
        SetMemory(0x662BA8, Add, -4194304),# units:StarEdit Placement Box Height  index:210    from 64 To 0
        SetMemory(0x662BAC, Add, -4194304),# units:StarEdit Placement Box Height  index:211    from 64 To 0
        SetMemory(0x662BB0, Add, -4194304),# units:StarEdit Placement Box Height  index:212    from 64 To 0
        SetMemory(0x661818, Add, -3),# units:Unit Size Left  index:10    from 11 To 8
        SetMemory(0x661AA0, Add, 1),# units:Unit Size Left  index:91    from 15 To 16
        SetMemory(0x661AC8, Add, -5),# units:Unit Size Left  index:96    from 16 To 11
        SetMemory(0x661BC8, Add, -15),# units:Unit Size Left  index:128    from 16 To 1
        SetMemory(0x661BD0, Add, -15),# units:Unit Size Left  index:129    from 16 To 1
        SetMemory(0x661D60, Add, -27),# units:Unit Size Left  index:179    from 32 To 5
        SetMemory(0x661D98, Add, -8),# units:Unit Size Left  index:186    from 16 To 8
        SetMemory(0x661DD0, Add, -38),# units:Unit Size Left  index:193    from 48 To 10
        SetMemory(0x661DD8, Add, -47),# units:Unit Size Left  index:194    from 48 To 1
        SetMemory(0x661818, Add, -262144),# units:Unit Size Up  index:10    from 13 To 9
        SetMemory(0x661AA0, Add, 65536),# units:Unit Size Up  index:91    from 15 To 16
        SetMemory(0x661AC8, Add, -720896),# units:Unit Size Up  index:96    from 16 To 5
        SetMemory(0x661BC8, Add, -983040),# units:Unit Size Up  index:128    from 16 To 1
        SetMemory(0x661BD0, Add, -983040),# units:Unit Size Up  index:129    from 16 To 1
        SetMemory(0x661D60, Add, -1769472),# units:Unit Size Up  index:179    from 32 To 5
        SetMemory(0x661D98, Add, -131072),# units:Unit Size Up  index:186    from 16 To 14
        SetMemory(0x661DD0, Add, -1441792),# units:Unit Size Up  index:193    from 32 To 10
        SetMemory(0x661DD8, Add, -2031616),# units:Unit Size Up  index:194    from 32 To 1
        SetMemory(0x66181C, Add, -3),# units:Unit Size Right  index:10    from 11 To 8
        SetMemory(0x661AA4, Add, -1),# units:Unit Size Right  index:91    from 16 To 15
        SetMemory(0x661ACC, Add, -4),# units:Unit Size Right  index:96    from 15 To 11
        SetMemory(0x661BCC, Add, -14),# units:Unit Size Right  index:128    from 15 To 1
        SetMemory(0x661BD4, Add, -14),# units:Unit Size Right  index:129    from 15 To 1
        SetMemory(0x661D64, Add, -26),# units:Unit Size Right  index:179    from 31 To 5
        SetMemory(0x661D9C, Add, -7),# units:Unit Size Right  index:186    from 15 To 8
        SetMemory(0x661DD4, Add, -37),# units:Unit Size Right  index:193    from 47 To 10
        SetMemory(0x661DDC, Add, -46),# units:Unit Size Right  index:194    from 47 To 1
        SetMemory(0x66181C, Add, -262144),# units:Unit Size Down  index:10    from 14 To 10
        SetMemory(0x661AA4, Add, -65536),# units:Unit Size Down  index:91    from 16 To 15
        SetMemory(0x661ACC, Add, -131072),# units:Unit Size Down  index:96    from 15 To 13
        SetMemory(0x661BCC, Add, -917504),# units:Unit Size Down  index:128    from 15 To 1
        SetMemory(0x661BD4, Add, -917504),# units:Unit Size Down  index:129    from 15 To 1
        SetMemory(0x661D64, Add, -1703936),# units:Unit Size Down  index:179    from 31 To 5
        SetMemory(0x661D9C, Add, -262144),# units:Unit Size Down  index:186    from 15 To 11
        SetMemory(0x661DD4, Add, -1376256),# units:Unit Size Down  index:193    from 31 To 10
        SetMemory(0x661DDC, Add, -1966080),# units:Unit Size Down  index:194    from 31 To 1
        SetMemory(0x662F9C, Add, 13),# units:Portrait  index:10    from 2 To 15
        SetMemory(0x662FA4, Add, 1835008),# units:Portrait  index:15    from 15 To 43
        SetMemory(0x663030, Add, -7),# units:Portrait  index:84    from 55 To 48
        SetMemory(0x66303C, Add, -4288217088),# units:Portrait  index:91    from 65535 To 102
        SetMemory(0x663048, Add, -53),# units:Portrait  index:96    from 103 To 50
        SetMemory(0x663078, Add, 4915200),# units:Portrait  index:121    from 17 To 92
        SetMemory(0x6630EC, Add, -4294836224),# units:Portrait  index:179    from 65535 To 1
        SetMemory(0x6630FC, Add, 2),# units:Portrait  index:186    from 74 To 76
        SetMemory(0x66393C, Add, -6488064),# units:Mineral Cost  index:91    from 100 To 1
        SetMemory(0x65FDB4, Add, -6488064),# units:Vespene Cost  index:91    from 100 To 1
        SetMemory(0x6604DC, Add, -39256064),# units:Build Time  index:91    from 600 To 1
        SetMemory(0x6637D4, Add, 128),# units:Staredit Group Flags  index:52    from 9 To 137
        SetMemory(0x6637F8, Add, 1996488704),# units:Staredit Group Flags  index:91    from 9 To 128
        SetMemory(0x6637FC, Add, -8126464),# units:Staredit Group Flags  index:94    from 136 To 12
        SetMemory(0x663818, Add, -2048),# units:Staredit Group Flags  index:121    from 18 To 10
        SetMemory(0x663820, Add, 0),# units:Staredit Group Flags  index:128    from 128 To 128
        SetMemory(0x663824, Add, 128),# units:Staredit Group Flags  index:132    from 49 To 177
        SetMemory(0x663850, Add, -2248146944),# units:Staredit Group Flags  index:179    from 144 To 10
        SetMemory(0x663858, Add, -8781824),# units:Staredit Group Flags  index:186    from 144 To 10
        SetMemory(0x663860, Add, 1536),# units:Staredit Group Flags  index:193    from 4 To 10
        SetMemory(0x664734, Add, 16777216),# units:Supply Provided  index:111    from 0 To 1
        SetMemory(0x663CF4, Add, -10),# units:Supply Required  index:12    from 12 To 2
        SetMemory(0x663D04, Add, 24),# units:Supply Required  index:28    from 0 To 24
        SetMemory(0x663D24, Add, -134217728),# units:Supply Required  index:63    from 8 To 0
        SetMemory(0x663D3C, Add, -2),# units:Supply Required  index:84    from 2 To 0
        SetMemory(0x66444C, Add, 0),# units:Space Required  index:63    from 4 To 4
        SetMemory(0x660990, Add, -134217728),# units:Space Provided  index:11    from 8 To 0
        SetMemory(0x660A04, Add, 1024),# units:Space Provided  index:125    from 4 To 8
        SetMemory(0x663ECC, Add, 353894400),# units:Destroy Score  index:11    from 600 To 6000
        SetMemory(0x663ED0, Add, 4293263360),# units:Destroy Score  index:13    from 25 To 65535
        SetMemory(0x663ED8, Add, 78643200),# units:Destroy Score  index:17    from 800 To 2000
        SetMemory(0x663EDC, Add, 209715200),# units:Destroy Score  index:19    from 300 To 3500
        SetMemory(0x663EE0, Add, 39321600),# units:Destroy Score  index:21    from 1600 To 2200
        SetMemory(0x663EE4, Add, 458752000),# units:Destroy Score  index:23    from 1400 To 8400
        SetMemory(0x663EE8, Add, 52428800),# units:Destroy Score  index:25    from 1400 To 2200
        SetMemory(0x663EEC, Add, 45875200),# units:Destroy Score  index:27    from 4800 To 5500
        SetMemory(0x663EF0, Add, 1127219200),# units:Destroy Score  index:29    from 4800 To 22000
        SetMemory(0x663EF4, Add, 8709),# units:Destroy Score  index:30    from 700 To 9409
        SetMemory(0x663F00, Add, 6553600),# units:Destroy Score  index:37    from 50 To 150
        SetMemory(0x663F14, Add, 131072000),# units:Destroy Score  index:47    from 200 To 2200
        SetMemory(0x663F1C, Add, 131072000),# units:Destroy Score  index:51    from 4000 To 6000
        SetMemory(0x663F20, Add, 3100),# units:Destroy Score  index:52    from 900 To 4000
        SetMemory(0x663F28, Add, 235929600),# units:Destroy Score  index:57    from 400 To 4000
        SetMemory(0x663F34, Add, 1100),# units:Destroy Score  index:62    from 1100 To 2200
        SetMemory(0x663F40, Add, 235929600),# units:Destroy Score  index:69    from 400 To 4000
        SetMemory(0x663F4C, Add, 209715200),# units:Destroy Score  index:75    from 800 To 4000
        SetMemory(0x663F50, Add, 39321600),# units:Destroy Score  index:77    from 400 To 1000
        SetMemory(0x663F6C, Add, 655360),# units:Destroy Score  index:91    from 0 To 10
        SetMemory(0x663F74, Add, -10),# units:Destroy Score  index:94    from 10 To 0
        SetMemory(0x663F7C, Add, 11700),# units:Destroy Score  index:98    from 1300 To 13000
        SetMemory(0x663F84, Add, 65536000),# units:Destroy Score  index:103    from 500 To 1500
        SetMemory(0x663F88, Add, 400),# units:Destroy Score  index:104    from 700 To 1100
        SetMemory(0x663FA8, Add, 4294901760),# units:Destroy Score  index:121    from 0 To 65535
        SetMemory(0x660730, Add, 16777216),# units:Broodwar Unit Flag  index:91    from 0 To 1
        SetMemory(0x6615CC, Add, 63307776),# units:Staredit Availability Flags  index:91    from 0 To 966
        SetMemory(0x661608, Add, 29818880),# units:Staredit Availability Flags  index:121    from 0 To 455
        SetMemory(0x65731C, Add, -6),# weapons:Label  index:30    from 321 To 315
        SetMemory(0x657390, Add, 2),# weapons:Label  index:88    from 304 To 306
        SetMemory(0x657394, Add, -5111808),# weapons:Label  index:91    from 307 To 229
        SetMemory(0x657398, Add, 481),# weapons:Label  index:92    from 312 To 793
        SetMemory(0x65739C, Add, -83),# weapons:Label  index:94    from 312 To 229
        SetMemory(0x6573BC, Add, 1309),# weapons:Label  index:110    from 229 To 1538
        SetMemory(0x6573D8, Add, 83),# weapons:Label  index:124    from 229 To 312
        SetMemory(0x6573E0, Add, 1900544),# weapons:Label  index:129    from 229 To 258
        SetMemory(0x656D1C, Add, 5),# weapons:Graphics  index:29    from 146 To 151
        SetMemory(0x656E08, Add, 29),# weapons:Graphics  index:88    from 143 To 172
        SetMemory(0x656E10, Add, 62),# weapons:Graphics  index:90    from 146 To 208
        SetMemory(0x656E14, Add, 20),# weapons:Graphics  index:91    from 152 To 172
        SetMemory(0x656E18, Add, 26),# weapons:Graphics  index:92    from 148 To 174
        SetMemory(0x656E20, Add, 20),# weapons:Graphics  index:94    from 152 To 172
        SetMemory(0x656E60, Add, 7),# weapons:Graphics  index:110    from 142 To 149
        SetMemory(0x656E78, Add, 7),# weapons:Graphics  index:116    from 143 To 150
        SetMemory(0x656E98, Add, 13),# weapons:Graphics  index:124    from 142 To 155
        SetMemory(0x656E9C, Add, -24),# weapons:Graphics  index:125    from 142 To 118
        SetMemory(0x656EA0, Add, 30),# weapons:Graphics  index:126    from 142 To 172
        SetMemory(0x656EA4, Add, -36),# weapons:Graphics  index:127    from 142 To 106
        SetMemory(0x656EA8, Add, 22),# weapons:Graphics  index:128    from 142 To 164
        SetMemory(0x656EAC, Add, 27),# weapons:Graphics  index:129    from 142 To 169
        SetMemory(0x657998, Add, 32),# weapons:Target Flags  index:0    from 3 To 35
        SetMemory(0x6579C4, Add, 2),# weapons:Target Flags  index:22    from 1 To 3
        SetMemory(0x6579D0, Add, 131072),# weapons:Target Flags  index:29    from 1 To 3
        SetMemory(0x657A04, Add, 131072),# weapons:Target Flags  index:55    from 1 To 3
        SetMemory(0x657A48, Add, 34),# weapons:Target Flags  index:88    from 1 To 35
        SetMemory(0x657A48, Add, 131072),# weapons:Target Flags  index:89    from 1 To 3
        SetMemory(0x657A4C, Add, 2228224),# weapons:Target Flags  index:91    from 1 To 35
        SetMemory(0x657A50, Add, 34),# weapons:Target Flags  index:92    from 1 To 35
        SetMemory(0x657A50, Add, 2228224),# weapons:Target Flags  index:93    from 1 To 35
        SetMemory(0x657A54, Add, 50),# weapons:Target Flags  index:94    from 1 To 51
        SetMemory(0x657A60, Add, 2),# weapons:Target Flags  index:100    from 1 To 3
        SetMemory(0x657A68, Add, 2),# weapons:Target Flags  index:104    from 1 To 3
        SetMemory(0x657A90, Add, 3145728),# weapons:Target Flags  index:125    from 3 To 51
        SetMemory(0x656A84, Add, -64),# weapons:Minimum Range  index:27    from 64 To 0
        SetMemory(0x657470, Add, 0),# weapons:Maximum Range  index:0    from 128 To 128
        SetMemory(0x6574DC, Add, 96),# weapons:Maximum Range  index:27    from 384 To 480
        SetMemory(0x65753C, Add, 64),# weapons:Maximum Range  index:51    from 128 To 192
        SetMemory(0x65754C, Add, 125),# weapons:Maximum Range  index:55    from 3 To 128
        SetMemory(0x657580, Add, 48),# weapons:Maximum Range  index:68    from 96 To 144
        SetMemory(0x6575C8, Add, 177),# weapons:Maximum Range  index:86    from 15 To 192
        SetMemory(0x6575D0, Add, 7072),# weapons:Maximum Range  index:88    from 128 To 7200
        SetMemory(0x6575D4, Add, 160),# weapons:Maximum Range  index:89    from 32 To 192
        SetMemory(0x6575D8, Add, 96),# weapons:Maximum Range  index:90    from 128 To 224
        SetMemory(0x6575DC, Add, -184),# weapons:Maximum Range  index:91    from 224 To 40
        SetMemory(0x6575E4, Add, 192),# weapons:Maximum Range  index:93    from 128 To 320
        SetMemory(0x6575E8, Add, -120),# weapons:Maximum Range  index:94    from 160 To 40
        SetMemory(0x657660, Add, -88),# weapons:Maximum Range  index:124    from 128 To 40
        SetMemory(0x657668, Add, -88),# weapons:Maximum Range  index:126    from 128 To 40
        SetMemory(0x657674, Add, 64),# weapons:Maximum Range  index:129    from 128 To 192
        SetMemory(0x6571EC, Add, -13568),# weapons:Damage Upgrade  index:29    from 60 To 7
        SetMemory(0x657228, Add, -889192448),# weapons:Damage Upgrade  index:91    from 60 To 7
        SetMemory(0x65722C, Add, -1),# weapons:Damage Upgrade  index:92    from 60 To 59
        SetMemory(0x65722C, Add, -256),# weapons:Damage Upgrade  index:93    from 60 To 59
        SetMemory(0x65722C, Add, -3473408),# weapons:Damage Upgrade  index:94    from 60 To 7
        SetMemory(0x65724C, Add, 7),# weapons:Damage Upgrade  index:124    from 7 To 14
        SetMemory(0x657270, Add, 16777216),# weapons:Weapon Type  index:27    from 1 To 2
        SetMemory(0x6572D4, Add, -3),# weapons:Weapon Type  index:124    from 3 To 0
        SetMemory(0x6566A0, Add, 16777216),# weapons:Weapon Behavior  index:51    from 0 To 1
        SetMemory(0x6566C8, Add, 65536),# weapons:Weapon Behavior  index:90    from 0 To 1
        SetMemory(0x6566CC, Add, 2),# weapons:Weapon Behavior  index:92    from 0 To 2
        SetMemory(0x6566CC, Add, 0),# weapons:Weapon Behavior  index:93    from 0 To 0
        SetMemory(0x6566DC, Add, -65536),# weapons:Weapon Behavior  index:110    from 2 To 1
        SetMemory(0x6566EC, Add, 4),# weapons:Weapon Behavior  index:124    from 2 To 6
        SetMemory(0x6566EC, Add, 117440512),# weapons:Weapon Behavior  index:127    from 2 To 9
        SetMemory(0x6566F0, Add, 7),# weapons:Weapon Behavior  index:128    from 2 To 9
        SetMemory(0x6566FC, Add, 65536),# weapons:Explosion Type  index:6    from 2 To 3
        SetMemory(0x656714, Add, 512),# weapons:Explosion Type  index:29    from 1 To 3
        SetMemory(0x656714, Add, -786432),# weapons:Explosion Type  index:30    from 15 To 3
        SetMemory(0x656728, Add, -16777216),# weapons:Explosion Type  index:51    from 2 To 1
        SetMemory(0x65673C, Add, 2),# weapons:Explosion Type  index:68    from 1 To 3
        SetMemory(0x656750, Add, 2),# weapons:Explosion Type  index:88    from 1 To 3
        SetMemory(0x656750, Add, 33554432),# weapons:Explosion Type  index:91    from 1 To 3
        SetMemory(0x656754, Add, 2),# weapons:Explosion Type  index:92    from 1 To 3
        SetMemory(0x656754, Add, 512),# weapons:Explosion Type  index:93    from 1 To 3
        SetMemory(0x656754, Add, 131072),# weapons:Explosion Type  index:94    from 1 To 3
        SetMemory(0x65676C, Add, 2),# weapons:Explosion Type  index:116    from 1 To 3
        SetMemory(0x656774, Add, 14),# weapons:Explosion Type  index:124    from 1 To 15
        SetMemory(0x656774, Add, 131072),# weapons:Explosion Type  index:126    from 1 To 3
        SetMemory(0x656774, Add, 33554432),# weapons:Explosion Type  index:127    from 1 To 3
        SetMemory(0x656778, Add, 2),# weapons:Explosion Type  index:128    from 1 To 3
        SetMemory(0x656778, Add, 512),# weapons:Explosion Type  index:129    from 1 To 3
        SetMemory(0x656894, Add, 78),# weapons:Inner Splash Range  index:6    from 50 To 128
        SetMemory(0x6568C0, Add, 4194304),# weapons:Inner Splash Range  index:29    from 0 To 64
        SetMemory(0x6568C4, Add, 26),# weapons:Inner Splash Range  index:30    from 0 To 26
        SetMemory(0x6568EC, Add, -655360),# weapons:Inner Splash Range  index:51    from 10 To 0
        SetMemory(0x656910, Add, 64),# weapons:Inner Splash Range  index:68    from 0 To 64
        SetMemory(0x656914, Add, 27),# weapons:Inner Splash Range  index:70    from 3 To 30
        SetMemory(0x656938, Add, 640),# weapons:Inner Splash Range  index:88    from 0 To 640
        SetMemory(0x65693C, Add, 16777216),# weapons:Inner Splash Range  index:91    from 0 To 256
        SetMemory(0x656940, Add, 128),# weapons:Inner Splash Range  index:92    from 0 To 128
        SetMemory(0x656940, Add, 3276800),# weapons:Inner Splash Range  index:93    from 0 To 50
        SetMemory(0x656944, Add, 8192),# weapons:Inner Splash Range  index:94    from 0 To 8192
        SetMemory(0x656950, Add, -2),# weapons:Inner Splash Range  index:100    from 5 To 3
        SetMemory(0x656970, Add, 20),# weapons:Inner Splash Range  index:116    from 0 To 20
        SetMemory(0x656984, Add, 128),# weapons:Inner Splash Range  index:126    from 0 To 128
        SetMemory(0x656984, Add, 6291456),# weapons:Inner Splash Range  index:127    from 0 To 96
        SetMemory(0x656988, Add, 256),# weapons:Inner Splash Range  index:128    from 0 To 256
        SetMemory(0x656988, Add, 16777216),# weapons:Inner Splash Range  index:129    from 0 To 256
        SetMemory(0x6570D4, Add, 53),# weapons:Medium Splash Range  index:6    from 75 To 128
        SetMemory(0x657100, Add, 4194304),# weapons:Medium Splash Range  index:29    from 0 To 64
        SetMemory(0x657104, Add, 26),# weapons:Medium Splash Range  index:30    from 0 To 26
        SetMemory(0x65712C, Add, -1310720),# weapons:Medium Splash Range  index:51    from 20 To 0
        SetMemory(0x657150, Add, 64),# weapons:Medium Splash Range  index:68    from 0 To 64
        SetMemory(0x657154, Add, 15),# weapons:Medium Splash Range  index:70    from 15 To 30
        SetMemory(0x657178, Add, 640),# weapons:Medium Splash Range  index:88    from 0 To 640
        SetMemory(0x65717C, Add, 25165824),# weapons:Medium Splash Range  index:91    from 0 To 384
        SetMemory(0x657180, Add, 192),# weapons:Medium Splash Range  index:92    from 0 To 192
        SetMemory(0x657180, Add, 3276800),# weapons:Medium Splash Range  index:93    from 0 To 50
        SetMemory(0x657184, Add, 8192),# weapons:Medium Splash Range  index:94    from 0 To 8192
        SetMemory(0x657190, Add, -42),# weapons:Medium Splash Range  index:100    from 50 To 8
        SetMemory(0x6571B0, Add, 20),# weapons:Medium Splash Range  index:116    from 0 To 20
        SetMemory(0x6571C4, Add, 192),# weapons:Medium Splash Range  index:126    from 0 To 192
        SetMemory(0x6571C4, Add, 6291456),# weapons:Medium Splash Range  index:127    from 0 To 96
        SetMemory(0x6571C8, Add, 255),# weapons:Medium Splash Range  index:128    from 0 To 255
        SetMemory(0x6571C8, Add, 16777216),# weapons:Medium Splash Range  index:129    from 0 To 256
        SetMemory(0x65778C, Add, 28),# weapons:Outer Splash Range  index:6    from 100 To 128
        SetMemory(0x6577B8, Add, 4194304),# weapons:Outer Splash Range  index:29    from 0 To 64
        SetMemory(0x6577BC, Add, 26),# weapons:Outer Splash Range  index:30    from 0 To 26
        SetMemory(0x6577E4, Add, -1966080),# weapons:Outer Splash Range  index:51    from 30 To 0
        SetMemory(0x657808, Add, 64),# weapons:Outer Splash Range  index:68    from 0 To 64
        SetMemory(0x657830, Add, 640),# weapons:Outer Splash Range  index:88    from 0 To 640
        SetMemory(0x657834, Add, 31457280),# weapons:Outer Splash Range  index:91    from 0 To 480
        SetMemory(0x657838, Add, 256),# weapons:Outer Splash Range  index:92    from 0 To 256
        SetMemory(0x657838, Add, 3276800),# weapons:Outer Splash Range  index:93    from 0 To 50
        SetMemory(0x65783C, Add, 8192),# weapons:Outer Splash Range  index:94    from 0 To 8192
        SetMemory(0x657848, Add, -85),# weapons:Outer Splash Range  index:100    from 100 To 15
        SetMemory(0x657868, Add, 20),# weapons:Outer Splash Range  index:116    from 0 To 20
        SetMemory(0x65787C, Add, 256),# weapons:Outer Splash Range  index:126    from 0 To 256
        SetMemory(0x65787C, Add, 6291456),# weapons:Outer Splash Range  index:127    from 0 To 96
        SetMemory(0x657880, Add, 256),# weapons:Outer Splash Range  index:128    from 0 To 256
        SetMemory(0x657880, Add, 16777216),# weapons:Outer Splash Range  index:129    from 0 To 256
        SetMemory(0x656EE4, Add, -4087349248),# weapons:Damage Amount  index:27    from 62768 To 400
        SetMemory(0x656EEC, Add, 140),# weapons:Damage Amount  index:30    from 260 To 400
        SetMemory(0x656F14, Add, 55050240),# weapons:Damage Amount  index:51    from 10 To 850
        SetMemory(0x656F38, Add, 328),# weapons:Damage Amount  index:68    from 5 To 333
        SetMemory(0x656F60, Add, 65528),# weapons:Damage Amount  index:88    from 7 To 65535
        SetMemory(0x656F60, Add, 14090240),# weapons:Damage Amount  index:89    from 7 To 222
        SetMemory(0x656F64, Add, 59),# weapons:Damage Amount  index:90    from 7 To 66
        SetMemory(0x656F64, Add, 3931635712),# weapons:Damage Amount  index:91    from 7 To 59999
        SetMemory(0x656F68, Add, -7),# weapons:Damage Amount  index:92    from 7 To 0
        SetMemory(0x656F68, Add, 4294443008),# weapons:Damage Amount  index:93    from 7 To 65535
        SetMemory(0x656F6C, Add, 59995),# weapons:Damage Amount  index:94    from 4 To 59999
        SetMemory(0x656F8C, Add, 14),# weapons:Damage Amount  index:110    from 6 To 20
        SetMemory(0x656F98, Add, 32737),# weapons:Damage Amount  index:116    from 30 To 32767
        SetMemory(0x656FA8, Add, 59994),# weapons:Damage Amount  index:124    from 6 To 60000
        SetMemory(0x656FA8, Add, -393216),# weapons:Damage Amount  index:125    from 6 To 0
        SetMemory(0x656FAC, Add, 438),# weapons:Damage Amount  index:126    from 6 To 444
        SetMemory(0x656FAC, Add, 3931766784),# weapons:Damage Amount  index:127    from 6 To 60000
        SetMemory(0x656FB0, Add, 44),# weapons:Damage Amount  index:128    from 6 To 50
        SetMemory(0x656FB0, Add, 254476288),# weapons:Damage Amount  index:129    from 6 To 3889
        SetMemory(0x657684, Add, 10),# weapons:Damage Bonus  index:6    from 0 To 10
        SetMemory(0x6576B0, Add, 655360),# weapons:Damage Bonus  index:29    from 5 To 15
        SetMemory(0x6576DC, Add, 27787264),# weapons:Damage Bonus  index:51    from 1 To 425
        SetMemory(0x657700, Add, 9),# weapons:Damage Bonus  index:68    from 1 To 10
        SetMemory(0x657728, Add, -1),# weapons:Damage Bonus  index:88    from 1 To 0
        SetMemory(0x657728, Add, -65536),# weapons:Damage Bonus  index:89    from 1 To 0
        SetMemory(0x65772C, Add, 5),# weapons:Damage Bonus  index:90    from 1 To 6
        SetMemory(0x65772C, Add, -65536),# weapons:Damage Bonus  index:91    from 1 To 0
        SetMemory(0x657730, Add, 256),# weapons:Damage Bonus  index:92    from 1 To 257
        SetMemory(0x657730, Add, -65536),# weapons:Damage Bonus  index:93    from 1 To 0
        SetMemory(0x657734, Add, -1),# weapons:Damage Bonus  index:94    from 1 To 0
        SetMemory(0x657754, Add, 1),# weapons:Damage Bonus  index:110    from 1 To 2
        SetMemory(0x657760, Add, -1),# weapons:Damage Bonus  index:116    from 1 To 0
        SetMemory(0x657770, Add, -1),# weapons:Damage Bonus  index:124    from 1 To 0
        SetMemory(0x657770, Add, -65536),# weapons:Damage Bonus  index:125    from 1 To 0
        SetMemory(0x657774, Add, -65536),# weapons:Damage Bonus  index:127    from 1 To 0
        SetMemory(0x657778, Add, -1),# weapons:Damage Bonus  index:128    from 1 To 0
        SetMemory(0x657778, Add, 254803968),# weapons:Damage Bonus  index:129    from 1 To 3889
        SetMemory(0x656FC0, Add, -5376),# weapons:Weapon Cooldown  index:9    from 22 To 1
        SetMemory(0x656FD4, Add, 3604480),# weapons:Weapon Cooldown  index:30    from 15 To 70
        SetMemory(0x656FFC, Add, -15),# weapons:Weapon Cooldown  index:68    from 30 To 15
        SetMemory(0x65700C, Add, -1900544),# weapons:Weapon Cooldown  index:86    from 30 To 1
        SetMemory(0x657010, Add, -21),# weapons:Weapon Cooldown  index:88    from 22 To 1
        SetMemory(0x657010, Add, -458752),# weapons:Weapon Cooldown  index:90    from 22 To 15
        SetMemory(0x657010, Add, -117440512),# weapons:Weapon Cooldown  index:91    from 22 To 15
        SetMemory(0x657014, Add, 53),# weapons:Weapon Cooldown  index:92    from 22 To 75
        SetMemory(0x657014, Add, 393216),# weapons:Weapon Cooldown  index:94    from 9 To 15
        SetMemory(0x657034, Add, -917504),# weapons:Weapon Cooldown  index:126    from 15 To 1
        SetMemory(0x657034, Add, -234881024),# weapons:Weapon Cooldown  index:127    from 15 To 1
        SetMemory(0x657038, Add, 11520),# weapons:Weapon Cooldown  index:129    from 15 To 60
        SetMemory(0x6564E4, Add, 65536),# weapons:Damage Factor  index:6    from 1 To 2
        SetMemory(0x6564EC, Add, 1),# weapons:Damage Factor  index:12    from 1 To 2
        SetMemory(0x6564F8, Add, 16777216),# weapons:Damage Factor  index:27    from 1 To 2
        SetMemory(0x6564FC, Add, 256),# weapons:Damage Factor  index:29    from 1 To 2
        SetMemory(0x6564FC, Add, 65536),# weapons:Damage Factor  index:30    from 1 To 2
        SetMemory(0x656538, Add, 1),# weapons:Damage Factor  index:88    from 1 To 2
        SetMemory(0x656538, Add, 16777216),# weapons:Damage Factor  index:91    from 1 To 2
        SetMemory(0x65653C, Add, 1),# weapons:Damage Factor  index:92    from 1 To 2
        SetMemory(0x65653C, Add, 256),# weapons:Damage Factor  index:93    from 1 To 2
        SetMemory(0x65653C, Add, 65536),# weapons:Damage Factor  index:94    from 1 To 2
        SetMemory(0x656560, Add, 256),# weapons:Damage Factor  index:129    from 1 To 2
        SetMemory(0x6569EC, Add, -112),# weapons:Attack Angle  index:92    from 128 To 16
        SetMemory(0x6569EC, Add, 32512),# weapons:Attack Angle  index:93    from 128 To 255
        SetMemory(0x6569EC, Add, -5242880),# weapons:Attack Angle  index:94    from 96 To 16
        SetMemory(0x656A04, Add, 239),# weapons:Attack Angle  index:116    from 16 To 255
        SetMemory(0x656A10, Add, -16),# weapons:Attack Angle  index:128    from 16 To 0
        SetMemory(0x6578FC, Add, 0),# weapons:Launch Spin  index:116    from 0 To 0
        SetMemory(0x656834, Add, 381),# weapons:Icon  index:90    from 0 To 381
        SetMemory(0x656834, Add, 21168128),# weapons:Icon  index:91    from 0 To 323
        SetMemory(0x656838, Add, 311),# weapons:Icon  index:92    from 0 To 311
        SetMemory(0x65683C, Add, 323),# weapons:Icon  index:94    from 0 To 323
        SetMemory(0x65685C, Add, -274),# weapons:Icon  index:110    from 323 To 49
        SetMemory(0x656878, Add, -87),# weapons:Icon  index:124    from 323 To 236
        SetMemory(0x656880, Add, -786432),# weapons:Icon  index:129    from 323 To 311
        SetMemory(0x6CA3C4, Add, -21),# flingy:Sprite  index:86    from 246 To 225
        SetMemory(0x6CA3EC, Add, 95),# flingy:Sprite  index:106    from 249 To 344
        SetMemory(0x6CA404, Add, -12),# flingy:Sprite  index:118    from 279 To 267
        SetMemory(0x6CA468, Add, -6291456),# flingy:Sprite  index:169    from 363 To 267
        SetMemory(0x6CA470, Add, -4784128),# flingy:Sprite  index:173    from 381 To 308
        SetMemory(0x6CA474, Add, -115),# flingy:Sprite  index:174    from 382 To 267
        SetMemory(0x6C9F28, Add, 1494),# flingy:Speed  index:12    from 213 To 1707
        SetMemory(0x6C9FA8, Add, -1133),# flingy:Speed  index:44    from 1133 To 0
        SetMemory(0x6CA018, Add, 10600),# flingy:Speed  index:72    from 1400 To 12000
        SetMemory(0x6CA050, Add, 1042),# flingy:Speed  index:86    from 1280 To 2322
        SetMemory(0x6CA0A0, Add, 4294959295),# flingy:Speed  index:106    from 0 To 4294959295
        SetMemory(0x6CA10C, Add, 1),# flingy:Speed  index:133    from 0 To 1
        SetMemory(0x6CA170, Add, -533),# flingy:Speed  index:158    from 8533 To 8000
        SetMemory(0x6CA180, Add, 133),# flingy:Speed  index:162    from 8533 To 8666
        SetMemory(0x6CA1E4, Add, 18720),# flingy:Speed  index:187    from 1280 To 20000
        SetMemory(0x6CA238, Add, 17067),# flingy:Speed  index:208    from 0 To 17067
        SetMemory(0x6C9C90, Add, 53),# flingy:Acceleration  index:12    from 27 To 80
        SetMemory(0x6C9CD0, Add, -17),# flingy:Acceleration  index:44    from 17 To 0
        SetMemory(0x6C9D08, Add, 11983),# flingy:Acceleration  index:72    from 17 To 12000
        SetMemory(0x6C9D4C, Add, 8000),# flingy:Acceleration  index:106    from 0 To 8000
        SetMemory(0x6C9D80, Add, 65536),# flingy:Acceleration  index:133    from 0 To 1
        SetMemory(0x6C9DB4, Add, -533),# flingy:Acceleration  index:158    from 8533 To 8000
        SetMemory(0x6C9DBC, Add, 7999),# flingy:Acceleration  index:162    from 667 To 8666
        SetMemory(0x6C9DEC, Add, 251658240),# flingy:Acceleration  index:187    from 160 To 4000
        SetMemory(0x6C9E18, Add, 800),# flingy:Acceleration  index:208    from 0 To 800
        SetMemory(0x6C99E0, Add, -37756),# flingy:Halt Distance  index:44    from 37756 To 0
        SetMemory(0x6C9A50, Add, -37756),# flingy:Halt Distance  index:72    from 37756 To 0
        SetMemory(0x6C9AD8, Add, 1),# flingy:Halt Distance  index:106    from 0 To 1
        SetMemory(0x6C9B44, Add, 1),# flingy:Halt Distance  index:133    from 0 To 1
        SetMemory(0x6C9BA8, Add, -4266),# flingy:Halt Distance  index:158    from 4267 To 1
        SetMemory(0x6C9C1C, Add, -5120),# flingy:Halt Distance  index:187    from 5120 To 0
        SetMemory(0x6C9C70, Add, 171343),# flingy:Halt Distance  index:208    from 0 To 171343
        SetMemory(0x6C9E68, Add, 107),# flingy:Turn Radius  index:72    from 20 To 127
        SetMemory(0x6C9E88, Add, 8323072),# flingy:Turn Radius  index:106    from 0 To 127
        SetMemory(0x6C9EA4, Add, 32512),# flingy:Turn Radius  index:133    from 0 To 127
        SetMemory(0x6C9ED8, Add, 503316480),# flingy:Turn Radius  index:187    from 40 To 70
        SetMemory(0x6C9EF0, Add, 127),# flingy:Turn Radius  index:208    from 0 To 127
        SetMemory(0x6C98C0, Add, -131072),# flingy:Movement Control  index:106    from 2 To 0
        SetMemory(0x6C98DC, Add, -512),# flingy:Movement Control  index:133    from 2 To 0
        SetMemory(0x6C98F4, Add, -65536),# flingy:Movement Control  index:158    from 1 To 0
        SetMemory(0x6C9928, Add, -2),# flingy:Movement Control  index:208    from 2 To 0
        SetMemory(0x6663C8, Add, 189),# sprites:Image File  index:308    from 736 To 925
        SetMemory(0x666424, Add, -135),# sprites:Image File  index:354    from 505 To 370
        SetMemory(0x666460, Add, 11927552),# sprites:Image File  index:385    from 754 To 936
        SetMemory(0x666568, Add, -442),# sprites:Image File  index:516    from 959 To 517
        SetMemory(0x66C1C4, Add, -1),# images:Clickable  index:116    from 1 To 0
        SetMemory(0x669EF8, Add, 1114112),# images:Draw Function  index:210    from 0 To 17
        SetMemory(0x669F90, Add, 1),# images:Draw Function  index:360    from 9 To 10
        SetMemory(0x669FB4, Add, 285212672),# images:Draw Function  index:399    from 0 To 17
        SetMemory(0x669FC4, Add, -512),# images:Draw Function  index:413    from 10 To 8
        SetMemory(0x66A02C, Add, 256),# images:Draw Function  index:517    from 9 To 10
        SetMemory(0x66A034, Add, 268435456),# images:Draw Function  index:527    from 0 To 16
        SetMemory(0x66A044, Add, 2560),# images:Draw Function  index:541    from 0 To 10
        SetMemory(0x669C44, Add, -512),# images:Remapping  index:517    from 2 To 0
        SetMemory(0x66EC48, Add, 155),# images:Iscript ID  index:0    from 0 To 155
        SetMemory(0x66ECF0, Add, 2),# images:Iscript ID  index:42    from 25 To 27
        SetMemory(0x66EE20, Add, 4),# images:Iscript ID  index:118    from 157 To 161
        SetMemory(0x66EF90, Add, 187),# images:Iscript ID  index:210    from 193 To 380
        SetMemory(0x66EFBC, Add, 11),# images:Iscript ID  index:221    from 67 To 78
        SetMemory(0x66EFC4, Add, 14),# images:Iscript ID  index:223    from 68 To 82
        SetMemory(0x66F140, Add, 113),# images:Iscript ID  index:318    from 133 To 246
        SetMemory(0x66F1E8, Add, 151),# images:Iscript ID  index:360    from 244 To 395
        SetMemory(0x66F210, Add, 87),# images:Iscript ID  index:370    from 308 To 395
        SetMemory(0x66F284, Add, -94),# images:Iscript ID  index:399    from 225 To 131
        SetMemory(0x66F45C, Add, -64),# images:Iscript ID  index:517    from 298 To 234
        SetMemory(0x66F4BC, Add, 148),# images:Iscript ID  index:541    from 247 To 395
        SetMemory(0x66FAE8, Add, -278),# images:Iscript ID  index:936    from 409 To 131
    ])

