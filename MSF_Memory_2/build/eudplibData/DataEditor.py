from eudplib import *


def onPluginStart():
    DoActions([  # Basic DatFile Actions
        SetMemory(0x664504, Add, -31),# units:Graphics  index:12    from 70 To 39
        SetMemory(0x664504, Add, 117440512),# units:Graphics  index:15    from 71 To 78
        SetMemory(0x66450C, Add, 6815744),# units:Graphics  index:22    from 86 To 190
        SetMemory(0x664518, Add, 5),# units:Graphics  index:32    from 73 To 78
        SetMemory(0x664528, Add, 9472),# units:Graphics  index:49    from 13 To 50
        SetMemory(0x664530, Add, 256),# units:Graphics  index:57    from 12 To 13
        SetMemory(0x664534, Add, -121),# units:Graphics  index:60    from 191 To 70
        SetMemory(0x66454C, Add, 327680),# units:Graphics  index:86    from 37 To 42
        SetMemory(0x664554, Add, -10354688),# units:Graphics  index:94    from 199 To 41
        SetMemory(0x664554, Add, 1426063360),# units:Graphics  index:95    from 114 To 199
        SetMemory(0x66456C, Add, 75),# units:Graphics  index:116    from 107 To 182
        SetMemory(0x66456C, Add, 21248),# units:Graphics  index:117    from 98 To 181
        SetMemory(0x66456C, Add, -2818048),# units:Graphics  index:118    from 103 To 60
        SetMemory(0x6645AC, Add, 520093696),# units:Graphics  index:183    from 43 To 74
        SetMemory(0x6645B0, Add, 60),# units:Graphics  index:184    from 121 To 181
        SetMemory(0x6645B0, Add, 35584),# units:Graphics  index:185    from 43 To 182
        SetMemory(0x6645B4, Add, 2382364672),# units:Graphics  index:191    from 43 To 185
        SetMemory(0x6645C4, Add, -21760),# units:Graphics  index:205    from 173 To 88
        SetMemory(0x6645C4, Add, -5636096),# units:Graphics  index:206    from 174 To 88
        SetMemory(0x6645C4, Add, -1459617792),# units:Graphics  index:207    from 175 To 88
        SetMemory(0x6645CC, Add, 234881024),# units:Graphics  index:215    from 126 To 140
        SetMemory(0x6645D4, Add, -43),# units:Graphics  index:220    from 131 To 88
        SetMemory(0x661280, Add, -2),# units:Construction Animation  index:116    from 327 To 325
        SetMemory(0x661284, Add, -5),# units:Construction Animation  index:117    from 330 To 325
        SetMemory(0x661288, Add, -330),# units:Construction Animation  index:118    from 330 To 0
        SetMemory(0x661390, Add, -5),# units:Construction Animation  index:184    from 330 To 325
        SetMemory(0x6613AC, Add, 917),# units:Construction Animation  index:191    from 0 To 917
        SetMemory(0x6606AC, Add, 201326592),# units:Unit Direction  index:191    from 0 To 12
        SetMemory(0x6606C4, Add, -134217728),# units:Unit Direction  index:215    from 8 To 0
        SetMemory(0x6647B0, Add, 65536),# units:Shield Enable  index:2    from 0 To 1
        SetMemory(0x6647B4, Add, 256),# units:Shield Enable  index:5    from 0 To 1
        SetMemory(0x6647BC, Add, 1),# units:Shield Enable  index:12    from 0 To 1
        SetMemory(0x6647BC, Add, 256),# units:Shield Enable  index:13    from 0 To 1
        SetMemory(0x6647C8, Add, 16777216),# units:Shield Enable  index:27    from 0 To 1
        SetMemory(0x6647E0, Add, 256),# units:Shield Enable  index:49    from 0 To 1
        SetMemory(0x66481C, Add, 256),# units:Shield Enable  index:109    from 0 To 1
        SetMemory(0x664824, Add, 256),# units:Shield Enable  index:117    from 0 To 1
        SetMemory(0x664824, Add, 65536),# units:Shield Enable  index:118    from 0 To 1
        SetMemory(0x66482C, Add, 1),# units:Shield Enable  index:124    from 0 To 1
        SetMemory(0x66482C, Add, 256),# units:Shield Enable  index:125    from 0 To 1
        SetMemory(0x66485C, Add, 65536),# units:Shield Enable  index:174    from 0 To 1
        SetMemory(0x66485C, Add, 16777216),# units:Shield Enable  index:175    from 0 To 1
        SetMemory(0x664864, Add, 16777216),# units:Shield Enable  index:183    from 0 To 1
        SetMemory(0x664868, Add, 1),# units:Shield Enable  index:184    from 0 To 1
        SetMemory(0x664878, Add, 1),# units:Shield Enable  index:200    from 0 To 1
        SetMemory(0x660E04, Add, 65435),# units:Shield Amount  index:2    from 100 To 65535
        SetMemory(0x660E08, Add, 4288348160),# units:Shield Amount  index:5    from 100 To 65535
        SetMemory(0x660E18, Add, 9899),# units:Shield Amount  index:12    from 100 To 9999
        SetMemory(0x660E18, Add, 4253286400),# units:Shield Amount  index:13    from 100 To 65000
        SetMemory(0x660E60, Add, 648806400),# units:Shield Amount  index:49    from 100 To 10000
        SetMemory(0x660E80, Add, 65515),# units:Shield Amount  index:64    from 20 To 65535
        SetMemory(0x660E88, Add, 389283840),# units:Shield Amount  index:69    from 60 To 6000
        SetMemory(0x660E94, Add, 65455),# units:Shield Amount  index:74    from 80 To 65535
        SetMemory(0x660EAC, Add, 4275240960),# units:Shield Amount  index:87    from 300 To 65535
        SetMemory(0x660ED8, Add, 58982400),# units:Shield Amount  index:109    from 100 To 1000
        SetMemory(0x660EE8, Add, 648740864),# units:Shield Amount  index:117    from 100 To 9999
        SetMemory(0x660EF8, Add, 900),# units:Shield Amount  index:124    from 100 To 1000
        SetMemory(0x660EF8, Add, 58982400),# units:Shield Amount  index:125    from 100 To 1000
        SetMemory(0x660F34, Add, 64750),# units:Shield Amount  index:154    from 750 To 65500
        SetMemory(0x660F38, Add, 29700),# units:Shield Amount  index:156    from 300 To 30000
        SetMemory(0x660F5C, Add, 2400),# units:Shield Amount  index:174    from 100 To 2500
        SetMemory(0x660F5C, Add, 4286054400),# units:Shield Amount  index:175    from 100 To 65500
        SetMemory(0x660F6C, Add, 648740864),# units:Shield Amount  index:183    from 100 To 9999
        SetMemory(0x660F70, Add, 9899),# units:Shield Amount  index:184    from 100 To 9999
        SetMemory(0x660F90, Add, 9899),# units:Shield Amount  index:200    from 100 To 9999
        SetMemory(0x662358, Add, 1791979520),# units:Hit Points  index:2    from 20480 To 1792000000
        SetMemory(0x662364, Add, 1706628096),# units:Hit Points  index:5    from 38400 To 1706666496
        SetMemory(0x66236C, Add, 240640),# units:Hit Points  index:7    from 15360 To 256000
        SetMemory(0x66237C, Add, 9382400),# units:Hit Points  index:11    from 38400 To 9420800
        SetMemory(0x662380, Add, 2431744),# units:Hit Points  index:12    from 128000 To 2559744
        SetMemory(0x662384, Add, -4864),# units:Hit Points  index:13    from 5120 To 256
        SetMemory(0x66238C, Add, 552960),# units:Hit Points  index:15    from 10240 To 563200
        SetMemory(0x6623A0, Add, 972800),# units:Hit Points  index:20    from 51200 To 1024000
        SetMemory(0x6623C8, Add, 44032),# units:Hit Points  index:30    from 38400 To 82432
        SetMemory(0x6623D0, Add, 499200),# units:Hit Points  index:32    from 12800 To 512000
        SetMemory(0x6623DC, Add, 76032),# units:Hit Points  index:35    from 6400 To 82432
        SetMemory(0x6623E0, Add, 31232),# units:Hit Points  index:36    from 51200 To 82432
        SetMemory(0x6623E4, Add, 62720),# units:Hit Points  index:37    from 8960 To 71680
        SetMemory(0x6623E8, Add, 74240),# units:Hit Points  index:38    from 20480 To 94720
        SetMemory(0x6623EC, Add, 115200),# units:Hit Points  index:39    from 102400 To 217600
        SetMemory(0x6623F0, Add, 30720),# units:Hit Points  index:40    from 7680 To 38400
        SetMemory(0x6623F4, Add, 81920),# units:Hit Points  index:41    from 10240 To 92160
        SetMemory(0x6623F8, Add, 153600),# units:Hit Points  index:42    from 51200 To 204800
        SetMemory(0x6623FC, Add, 84480),# units:Hit Points  index:43    from 30720 To 115200
        SetMemory(0x662400, Add, 128000),# units:Hit Points  index:44    from 38400 To 166400
        SetMemory(0x662404, Add, 12001280),# units:Hit Points  index:45    from 30720 To 12032000
        SetMemory(0x662408, Add, 11499520),# units:Hit Points  index:46    from 20480 To 11520000
        SetMemory(0x66240C, Add, 57600),# units:Hit Points  index:47    from 6400 To 64000
        SetMemory(0x662410, Add, 281600),# units:Hit Points  index:48    from 204800 To 486400
        SetMemory(0x662414, Add, -76544),# units:Hit Points  index:49    from 76800 To 256
        SetMemory(0x662418, Add, 138240),# units:Hit Points  index:50    from 15360 To 153600
        SetMemory(0x66241C, Add, 921600),# units:Hit Points  index:51    from 102400 To 1024000
        SetMemory(0x662424, Add, 138240),# units:Hit Points  index:53    from 40960 To 179200
        SetMemory(0x662428, Add, 84480),# units:Hit Points  index:54    from 30720 To 115200
        SetMemory(0x66242C, Add, 230400),# units:Hit Points  index:55    from 76800 To 307200
        SetMemory(0x662430, Add, 384000),# units:Hit Points  index:56    from 102400 To 486400
        SetMemory(0x66243C, Add, 460800),# units:Hit Points  index:59    from 51200 To 512000
        SetMemory(0x662448, Add, 576000),# units:Hit Points  index:62    from 64000 To 640000
        SetMemory(0x662450, Add, 2129914880),# units:Hit Points  index:64    from 5120 To 2129920000
        SetMemory(0x662464, Add, 6123520),# units:Hit Points  index:69    from 20480 To 6144000
        SetMemory(0x662478, Add, 1228789760),# units:Hit Points  index:74    from 10240 To 1228800000
        SetMemory(0x6624AC, Add, 2042859520),# units:Hit Points  index:87    from 20480 To 2042880000
        SetMemory(0x6624C8, Add, 25584384),# units:Hit Points  index:94    from 15360 To 25599744
        SetMemory(0x6624EC, Add, 288000),# units:Hit Points  index:103    from 32000 To 320000
        SetMemory(0x6624F0, Add, 314880),# units:Hit Points  index:104    from 76800 To 391680
        SetMemory(0x662504, Add, 20352000),# units:Hit Points  index:109    from 128000 To 20480000
        SetMemory(0x662520, Add, -89600),# units:Hit Points  index:116    from 217600 To 128000
        SetMemory(0x662524, Add, 64000),# units:Hit Points  index:117    from 192000 To 256000
        SetMemory(0x662528, Add, -128000),# units:Hit Points  index:118    from 153600 To 25600
        SetMemory(0x662540, Add, 20428800),# units:Hit Points  index:124    from 51200 To 20480000
        SetMemory(0x662544, Add, 30630400),# units:Hit Points  index:125    from 89600 To 30720000
        SetMemory(0x662548, Add, 170487296),# units:Hit Points  index:126    from 179200 To 170666496
        SetMemory(0x66254C, Add, 227043328),# units:Hit Points  index:127    from 512000 To 227555328
        SetMemory(0x662550, Add, -2508800),# units:Hit Points  index:128    from 2560000 To 51200
        SetMemory(0x662558, Add, 189056000),# units:Hit Points  index:130    from 384000 To 189440000
        SetMemory(0x662568, Add, 1472000),# units:Hit Points  index:134    from 64000 To 1536000
        SetMemory(0x66256C, Add, 1036800),# units:Hit Points  index:135    from 217600 To 1254400
        SetMemory(0x662570, Add, 1958400),# units:Hit Points  index:136    from 217600 To 2176000
        SetMemory(0x662574, Add, 2303744),# units:Hit Points  index:137    from 256000 To 2559744
        SetMemory(0x662578, Add, 1702400),# units:Hit Points  index:138    from 217600 To 1920000
        SetMemory(0x66257C, Add, 1728000),# units:Hit Points  index:139    from 192000 To 1920000
        SetMemory(0x662580, Add, 1766400),# units:Hit Points  index:140    from 153600 To 1920000
        SetMemory(0x662584, Add, 1382400),# units:Hit Points  index:141    from 153600 To 1536000
        SetMemory(0x662588, Add, 832000),# units:Hit Points  index:142    from 192000 To 1024000
        SetMemory(0x66258C, Add, 921600),# units:Hit Points  index:143    from 102400 To 1024000
        SetMemory(0x662590, Add, 1177600),# units:Hit Points  index:144    from 102400 To 1280000
        SetMemory(0x662598, Add, 1459200),# units:Hit Points  index:146    from 76800 To 1536000
        SetMemory(0x66259C, Add, 126720000),# units:Hit Points  index:147    from 1280000 To 128000000
        SetMemory(0x6625A0, Add, 88960000),# units:Hit Points  index:148    from 640000 To 89600000
        SetMemory(0x6625A4, Add, 1728000),# units:Hit Points  index:149    from 192000 To 1920000
        SetMemory(0x6625AC, Add, 89574400),# units:Hit Points  index:151    from 25600 To 89600000
        SetMemory(0x6625B0, Add, 170112000),# units:Hit Points  index:152    from 384000 To 170496000
        SetMemory(0x6625B8, Add, 179008000),# units:Hit Points  index:154    from 192000 To 179200000
        SetMemory(0x6625C0, Add, 38323200),# units:Hit Points  index:156    from 76800 To 38400000
        SetMemory(0x6625F0, Add, 178688000),# units:Hit Points  index:168    from 512000 To 179200000
        SetMemory(0x662604, Add, 230400000),# units:Hit Points  index:173    from 25600000 To 256000000
        SetMemory(0x662608, Add, 38016000),# units:Hit Points  index:174    from 384000 To 38400000
        SetMemory(0x66260C, Add, 126720000),# units:Hit Points  index:175    from 1280000 To 128000000
        SetMemory(0x66262C, Add, -202240),# units:Hit Points  index:183    from 204800 To 2560
        SetMemory(0x662630, Add, 51200),# units:Hit Points  index:184    from 204800 To 256000
        SetMemory(0x662634, Add, -76800),# units:Hit Points  index:185    from 204800 To 128000
        SetMemory(0x662644, Add, 179020800),# units:Hit Points  index:189    from 179200 To 179200000
        SetMemory(0x662648, Add, 2129408000),# units:Hit Points  index:190    from 512000 To 2129920000
        SetMemory(0x66264C, Add, -24960000),# units:Hit Points  index:191    from 25600000 To 640000
        SetMemory(0x662670, Add, 2354944),# units:Hit Points  index:200    from 204800 To 2559744
        SetMemory(0x662674, Add, 63360000),# units:Hit Points  index:201    from 640000 To 64000000
        SetMemory(0x6626A8, Add, -179200),# units:Hit Points  index:214    from 204800 To 25600
        SetMemory(0x6626AC, Add, -25574400),# units:Hit Points  index:215    from 25600000 To 25600
        SetMemory(0x6626C0, Add, 25395200),# units:Hit Points  index:220    from 204800 To 25600000
        SetMemory(0x66316C, Add, 1048576),# units:Elevation Level  index:30    from 4 To 20
        SetMemory(0x663170, Add, 512),# units:Elevation Level  index:33    from 18 To 20
        SetMemory(0x663190, Add, 8),# units:Elevation Level  index:64    from 4 To 12
        SetMemory(0x6631AC, Add, 268435456),# units:Elevation Level  index:95    from 4 To 20
        SetMemory(0x6631C4, Add, 16),# units:Elevation Level  index:116    from 4 To 20
        SetMemory(0x6631C4, Add, 4096),# units:Elevation Level  index:117    from 4 To 20
        SetMemory(0x6631D0, Add, 8),# units:Elevation Level  index:128    from 4 To 12
        SetMemory(0x663204, Add, 268435456),# units:Elevation Level  index:183    from 4 To 20
        SetMemory(0x663208, Add, 16),# units:Elevation Level  index:184    from 4 To 20
        SetMemory(0x663208, Add, 4096),# units:Elevation Level  index:185    from 4 To 20
        SetMemory(0x66320C, Add, 285212672),# units:Elevation Level  index:191    from 1 To 18
        SetMemory(0x66321C, Add, 2048),# units:Elevation Level  index:205    from 4 To 12
        SetMemory(0x66321C, Add, 524288),# units:Elevation Level  index:206    from 4 To 12
        SetMemory(0x66321C, Add, 134217728),# units:Elevation Level  index:207    from 4 To 12
        SetMemory(0x663224, Add, 720896),# units:Elevation Level  index:214    from 1 To 12
        SetMemory(0x663224, Add, 134217728),# units:Elevation Level  index:215    from 4 To 12
        SetMemory(0x66322C, Add, 16),# units:Elevation Level  index:220    from 4 To 20
        SetMemory(0x66103C, Add, 50432),# units:Unknown (old Movement)  index:117    from 0 To 197
        SetMemory(0x66107C, Add, 3305111552),# units:Unknown (old Movement)  index:183    from 0 To 197
        SetMemory(0x661080, Add, 197),# units:Unknown (old Movement)  index:184    from 0 To 197
        SetMemory(0x661080, Add, 50432),# units:Unknown (old Movement)  index:185    from 0 To 197
        SetMemory(0x661084, Add, 3305111552),# units:Unknown (old Movement)  index:191    from 0 To 197
        SetMemory(0x661094, Add, 49920),# units:Unknown (old Movement)  index:205    from 0 To 195
        SetMemory(0x661094, Add, 12779520),# units:Unknown (old Movement)  index:206    from 0 To 195
        SetMemory(0x661094, Add, 3271557120),# units:Unknown (old Movement)  index:207    from 0 To 195
        SetMemory(0x66109C, Add, -3305111552),# units:Unknown (old Movement)  index:215    from 197 To 0
        SetMemory(0x6610A4, Add, -2),# units:Unknown (old Movement)  index:220    from 197 To 195
        SetMemory(0x663DD0, Add, 91),# units:Rank/Sublabel  index:0    from 2 To 93
        SetMemory(0x663DD0, Add, 22528),# units:Rank/Sublabel  index:1    from 5 To 93
        SetMemory(0x663DE0, Add, 75),# units:Rank/Sublabel  index:16    from 18 To 93
        SetMemory(0x663DE4, Add, 75),# units:Rank/Sublabel  index:20    from 17 To 92
        SetMemory(0x663DF0, Add, 88),# units:Rank/Sublabel  index:32    from 4 To 92
        SetMemory(0x663E30, Add, 1258291200),# units:Rank/Sublabel  index:99    from 18 To 93
        SetMemory(0x663E44, Add, 199),# units:Rank/Sublabel  index:116    from 0 To 199
        SetMemory(0x663E44, Add, 50688),# units:Rank/Sublabel  index:117    from 0 To 198
        SetMemory(0x663E84, Add, 3321888768),# units:Rank/Sublabel  index:183    from 0 To 198
        SetMemory(0x663E88, Add, 198),# units:Rank/Sublabel  index:184    from 0 To 198
        SetMemory(0x663E88, Add, 50944),# units:Rank/Sublabel  index:185    from 0 To 199
        SetMemory(0x662EA8, Add, -1526726656),# units:Comp AI Idle  index:11    from 93 To 2
        SetMemory(0x662ED8, Add, -39424),# units:Comp AI Idle  index:57    from 156 To 2
        SetMemory(0x662EE4, Add, -23296),# units:Comp AI Idle  index:69    from 93 To 2
        SetMemory(0x662EF0, Add, -14336),# units:Comp AI Idle  index:81    from 58 To 2
        SetMemory(0x662F14, Add, -154),# units:Comp AI Idle  index:116    from 156 To 2
        SetMemory(0x662F14, Add, -39424),# units:Comp AI Idle  index:117    from 156 To 2
        SetMemory(0x662F14, Add, -9043968),# units:Comp AI Idle  index:118    from 156 To 18
        SetMemory(0x662F20, Add, -95),# units:Comp AI Idle  index:128    from 97 To 2
        SetMemory(0x662F54, Add, -352321536),# units:Comp AI Idle  index:183    from 23 To 2
        SetMemory(0x662F58, Add, -21),# units:Comp AI Idle  index:184    from 23 To 2
        SetMemory(0x662F58, Add, -5376),# units:Comp AI Idle  index:185    from 23 To 2
        SetMemory(0x662F5C, Add, -352321536),# units:Comp AI Idle  index:191    from 23 To 2
        SetMemory(0x662F6C, Add, -5376),# units:Comp AI Idle  index:205    from 23 To 2
        SetMemory(0x662F6C, Add, -1376256),# units:Comp AI Idle  index:206    from 23 To 2
        SetMemory(0x662F6C, Add, -352321536),# units:Comp AI Idle  index:207    from 23 To 2
        SetMemory(0x662F74, Add, -1241513984),# units:Comp AI Idle  index:215    from 97 To 23
        SetMemory(0x662F7C, Add, -95),# units:Comp AI Idle  index:220    from 97 To 2
        SetMemory(0x662270, Add, -1526726656),# units:Human AI Idle  index:11    from 93 To 2
        SetMemory(0x6622A0, Add, -23296),# units:Human AI Idle  index:57    from 93 To 2
        SetMemory(0x6622AC, Add, -23296),# units:Human AI Idle  index:69    from 93 To 2
        SetMemory(0x6622B8, Add, -14336),# units:Human AI Idle  index:81    from 58 To 2
        SetMemory(0x6622C4, Add, -10747904),# units:Human AI Idle  index:94    from 166 To 2
        SetMemory(0x6622DC, Add, -21),# units:Human AI Idle  index:116    from 23 To 2
        SetMemory(0x6622DC, Add, -5376),# units:Human AI Idle  index:117    from 23 To 2
        SetMemory(0x6622DC, Add, -327680),# units:Human AI Idle  index:118    from 23 To 18
        SetMemory(0x6622E8, Add, -95),# units:Human AI Idle  index:128    from 97 To 2
        SetMemory(0x66231C, Add, -352321536),# units:Human AI Idle  index:183    from 23 To 2
        SetMemory(0x662320, Add, -21),# units:Human AI Idle  index:184    from 23 To 2
        SetMemory(0x662320, Add, -5376),# units:Human AI Idle  index:185    from 23 To 2
        SetMemory(0x662324, Add, -352321536),# units:Human AI Idle  index:191    from 23 To 2
        SetMemory(0x662334, Add, -5376),# units:Human AI Idle  index:205    from 23 To 2
        SetMemory(0x662334, Add, -1376256),# units:Human AI Idle  index:206    from 23 To 2
        SetMemory(0x662334, Add, -352321536),# units:Human AI Idle  index:207    from 23 To 2
        SetMemory(0x66233C, Add, -1241513984),# units:Human AI Idle  index:215    from 97 To 23
        SetMemory(0x662344, Add, -95),# units:Human AI Idle  index:220    from 97 To 2
        SetMemory(0x6648A0, Add, -1526726656),# units:Return to Idle  index:11    from 93 To 2
        SetMemory(0x6648D0, Add, -23296),# units:Return to Idle  index:57    from 93 To 2
        SetMemory(0x6648DC, Add, -23296),# units:Return to Idle  index:69    from 93 To 2
        SetMemory(0x6648E8, Add, -14336),# units:Return to Idle  index:81    from 58 To 2
        SetMemory(0x6648F4, Add, -10747904),# units:Return to Idle  index:94    from 166 To 2
        SetMemory(0x66490C, Add, -21),# units:Return to Idle  index:116    from 23 To 2
        SetMemory(0x66490C, Add, -5376),# units:Return to Idle  index:117    from 23 To 2
        SetMemory(0x66490C, Add, -327680),# units:Return to Idle  index:118    from 23 To 18
        SetMemory(0x664918, Add, -95),# units:Return to Idle  index:128    from 97 To 2
        SetMemory(0x66494C, Add, -352321536),# units:Return to Idle  index:183    from 23 To 2
        SetMemory(0x664950, Add, -21),# units:Return to Idle  index:184    from 23 To 2
        SetMemory(0x664950, Add, -5376),# units:Return to Idle  index:185    from 23 To 2
        SetMemory(0x664954, Add, -352321536),# units:Return to Idle  index:191    from 23 To 2
        SetMemory(0x664964, Add, -5376),# units:Return to Idle  index:205    from 23 To 2
        SetMemory(0x664964, Add, -1376256),# units:Return to Idle  index:206    from 23 To 2
        SetMemory(0x664964, Add, -352321536),# units:Return to Idle  index:207    from 23 To 2
        SetMemory(0x66496C, Add, -1241513984),# units:Return to Idle  index:215    from 97 To 23
        SetMemory(0x664974, Add, -95),# units:Return to Idle  index:220    from 97 To 2
        SetMemory(0x663328, Add, -184549376),# units:Attack Unit  index:11    from 21 To 10
        SetMemory(0x66332C, Add, -184549376),# units:Attack Unit  index:15    from 21 To 10
        SetMemory(0x663350, Add, -4352),# units:Attack Unit  index:49    from 27 To 10
        SetMemory(0x663358, Add, -2816),# units:Attack Unit  index:57    from 21 To 10
        SetMemory(0x66335C, Add, -184549376),# units:Attack Unit  index:63    from 21 To 10
        SetMemory(0x663364, Add, -2816),# units:Attack Unit  index:69    from 21 To 10
        SetMemory(0x663370, Add, -12544),# units:Attack Unit  index:81    from 59 To 10
        SetMemory(0x66337C, Add, -11665408),# units:Attack Unit  index:94    from 188 To 10
        SetMemory(0x663394, Add, -13),# units:Attack Unit  index:116    from 23 To 10
        SetMemory(0x663394, Add, -3328),# units:Attack Unit  index:117    from 23 To 10
        SetMemory(0x663394, Add, -262144),# units:Attack Unit  index:118    from 23 To 19
        SetMemory(0x6633A0, Add, -13),# units:Attack Unit  index:128    from 23 To 10
        SetMemory(0x6633D4, Add, -218103808),# units:Attack Unit  index:183    from 23 To 10
        SetMemory(0x6633D8, Add, -13),# units:Attack Unit  index:184    from 23 To 10
        SetMemory(0x6633D8, Add, -3328),# units:Attack Unit  index:185    from 23 To 10
        SetMemory(0x6633DC, Add, -218103808),# units:Attack Unit  index:191    from 23 To 10
        SetMemory(0x663AA0, Add, -14336),# units:Attack Move  index:81    from 58 To 2
        SetMemory(0x663AAC, Add, -12189696),# units:Attack Move  index:94    from 188 To 2
        SetMemory(0x663AC4, Add, -21),# units:Attack Move  index:116    from 23 To 2
        SetMemory(0x663AC4, Add, -5376),# units:Attack Move  index:117    from 23 To 2
        SetMemory(0x663AD0, Add, -21),# units:Attack Move  index:128    from 23 To 2
        SetMemory(0x663B04, Add, -352321536),# units:Attack Move  index:183    from 23 To 2
        SetMemory(0x663B08, Add, -21),# units:Attack Move  index:184    from 23 To 2
        SetMemory(0x663B08, Add, -5376),# units:Attack Move  index:185    from 23 To 2
        SetMemory(0x663B0C, Add, -352321536),# units:Attack Move  index:191    from 23 To 2
        SetMemory(0x663B1C, Add, -5376),# units:Attack Move  index:205    from 23 To 2
        SetMemory(0x663B1C, Add, -1376256),# units:Attack Move  index:206    from 23 To 2
        SetMemory(0x663B1C, Add, -352321536),# units:Attack Move  index:207    from 23 To 2
        SetMemory(0x663B2C, Add, -21),# units:Attack Move  index:220    from 23 To 2
        SetMemory(0x6636BC, Add, 1),# units:Ground Weapon  index:4    from 7 To 8
        SetMemory(0x6636C0, Add, -1),# units:Ground Weapon  index:8    from 16 To 15
        SetMemory(0x6636C0, Add, -704643072),# units:Ground Weapon  index:11    from 130 To 88
        SetMemory(0x6636C4, Add, 111),# units:Ground Weapon  index:12    from 19 To 130
        SetMemory(0x6636C4, Add, -687865856),# units:Ground Weapon  index:15    from 130 To 89
        SetMemory(0x6636CC, Add, -2293760),# units:Ground Weapon  index:22    from 130 To 95
        SetMemory(0x6636D4, Add, 256),# units:Ground Weapon  index:29    from 21 To 22
        SetMemory(0x6636D8, Add, -25),# units:Ground Weapon  index:32    from 25 To 0
        SetMemory(0x6636E4, Add, -134217728),# units:Ground Weapon  index:47    from 130 To 122
        SetMemory(0x6636EC, Add, -79),# units:Ground Weapon  index:52    from 130 To 51
        SetMemory(0x6636F0, Add, -11008),# units:Ground Weapon  index:57    from 130 To 87
        SetMemory(0x6636F4, Add, -9),# units:Ground Weapon  index:60    from 130 To 121
        SetMemory(0x6636F4, Add, -1703936),# units:Ground Weapon  index:62    from 130 To 104
        SetMemory(0x6636F4, Add, -973078528),# units:Ground Weapon  index:63    from 130 To 72
        SetMemory(0x6636F8, Add, -1040187392),# units:Ground Weapon  index:67    from 130 To 68
        SetMemory(0x6636FC, Add, -10240),# units:Ground Weapon  index:69    from 130 To 90
        SetMemory(0x6636FC, Add, 65536),# units:Ground Weapon  index:70    from 73 To 74
        SetMemory(0x663708, Add, 16),# units:Ground Weapon  index:80    from 75 To 91
        SetMemory(0x663708, Add, -9216),# units:Ground Weapon  index:81    from 130 To 94
        SetMemory(0x66370C, Add, 922746880),# units:Ground Weapon  index:87    from 69 To 124
        SetMemory(0x663714, Add, -327680),# units:Ground Weapon  index:94    from 130 To 125
        SetMemory(0x663718, Add, -1966080),# units:Ground Weapon  index:98    from 130 To 100
        SetMemory(0x66371C, Add, -65536),# units:Ground Weapon  index:102    from 21 To 20
        SetMemory(0x66372C, Add, -3276800),# units:Ground Weapon  index:118    from 130 To 80
        SetMemory(0x663734, Add, -101),# units:Ground Weapon  index:124    from 130 To 29
        SetMemory(0x66376C, Add, -117440512),# units:Ground Weapon  index:183    from 130 To 123
        SetMemory(0x663770, Add, 37),# units:Ground Weapon  index:184    from 93 To 130
        SetMemory(0x663774, Add, -436207616),# units:Ground Weapon  index:191    from 130 To 104
        SetMemory(0x663784, Add, -1024),# units:Ground Weapon  index:205    from 130 To 126
        SetMemory(0x663784, Add, -6553600),# units:Ground Weapon  index:206    from 130 To 30
        SetMemory(0x663784, Add, -50331648),# units:Ground Weapon  index:207    from 130 To 127
        SetMemory(0x663794, Add, -1),# units:Ground Weapon  index:220    from 130 To 129
        SetMemory(0x664600, Add, -1),# units:Max Ground Hits  index:32    from 3 To 2
        SetMemory(0x664654, Add, 65536),# units:Max Ground Hits  index:118    from 0 To 1
        SetMemory(0x664698, Add, -1),# units:Max Ground Hits  index:184    from 1 To 0
        SetMemory(0x6616EC, Add, 110),# units:Air Weapon  index:12    from 20 To 130
        SetMemory(0x6616F0, Add, -65536),# units:Air Weapon  index:18    from 10 To 9
        SetMemory(0x6616F4, Add, 256),# units:Air Weapon  index:21    from 17 To 18
        SetMemory(0x6616F8, Add, -16777216),# units:Air Weapon  index:27    from 22 To 21
        SetMemory(0x6616FC, Add, -1),# units:Air Weapon  index:28    from 24 To 23
        SetMemory(0x661700, Add, -130),# units:Air Weapon  index:32    from 130 To 0
        SetMemory(0x66170C, Add, 1258291200),# units:Air Weapon  index:47    from 55 To 130
        SetMemory(0x66171C, Add, 21),# units:Air Weapon  index:60    from 100 To 121
        SetMemory(0x661724, Add, 0),# units:Air Weapon  index:70    from 74 To 74
        SetMemory(0x661730, Add, 15),# units:Air Weapon  index:80    from 76 To 91
        SetMemory(0x661738, Add, -1),# units:Air Weapon  index:88    from 115 To 114
        SetMemory(0x661744, Add, -131072),# units:Air Weapon  index:102    from 22 To 20
        SetMemory(0x661754, Add, -3211264),# units:Air Weapon  index:118    from 130 To 81
        SetMemory(0x661794, Add, -117440512),# units:Air Weapon  index:183    from 130 To 123
        SetMemory(0x66179C, Add, -436207616),# units:Air Weapon  index:191    from 130 To 104
        SetMemory(0x65FC8C, Add, 65536),# units:Max Air Hits  index:118    from 0 To 1
        SetMemory(0x65FCD4, Add, 16777216),# units:Max Air Hits  index:191    from 0 To 1
        SetMemory(0x660178, Add, 196608),# units:AI Internal  index:2    from 0 To 3
        SetMemory(0x66017C, Add, 768),# units:AI Internal  index:5    from 0 To 3
        SetMemory(0x660180, Add, 50331648),# units:AI Internal  index:11    from 0 To 3
        SetMemory(0x660194, Add, 196608),# units:AI Internal  index:30    from 0 To 3
        SetMemory(0x6601A4, Add, 50331648),# units:AI Internal  index:47    from 0 To 3
        SetMemory(0x6601B0, Add, 0),# units:AI Internal  index:57    from 3 To 3
        SetMemory(0x6601B4, Add, 50331648),# units:AI Internal  index:63    from 0 To 3
        SetMemory(0x6601B8, Add, 768),# units:AI Internal  index:65    from 0 To 3
        SetMemory(0x6601B8, Add, 196608),# units:AI Internal  index:66    from 0 To 3
        SetMemory(0x6601B8, Add, 50331648),# units:AI Internal  index:67    from 0 To 3
        SetMemory(0x6601BC, Add, 3),# units:AI Internal  index:68    from 0 To 3
        SetMemory(0x6601BC, Add, 768),# units:AI Internal  index:69    from 0 To 3
        SetMemory(0x6601BC, Add, 196608),# units:AI Internal  index:70    from 0 To 3
        SetMemory(0x6601BC, Add, 50331648),# units:AI Internal  index:71    from 0 To 3
        SetMemory(0x660234, Add, -50331648),# units:AI Internal  index:191    from 3 To 0
        SetMemory(0x664080, Add, 64),# units:Special Ability Flags  index:0    from 402718720 To 402718784
        SetMemory(0x664084, Add, 64),# units:Special Ability Flags  index:1    from 404816384 To 404816448
        SetMemory(0x664088, Add, 64),# units:Special Ability Flags  index:2    from 1476395008 To 1476395072
        SetMemory(0x664094, Add, 64),# units:Special Ability Flags  index:5    from 1509949440 To 1509949504
        SetMemory(0x6640B4, Add, 4),# units:Special Ability Flags  index:13    from 402653184 To 402653188
        SetMemory(0x6640D8, Add, -32768),# units:Special Ability Flags  index:22    from 1512079684 To 1512046916
        SetMemory(0x6640EC, Add, 4194816),# units:Special Ability Flags  index:27    from 1545601092 To 1549795908
        SetMemory(0x6640F8, Add, 68),# units:Special Ability Flags  index:30    from 1107296256 To 1107296324
        SetMemory(0x664144, Add, 0),# units:Special Ability Flags  index:49    from 438370500 To 438370500
        SetMemory(0x664164, Add, -32768),# units:Special Ability Flags  index:57    from 436306116 To 436273348
        SetMemory(0x664180, Add, 60),# units:Special Ability Flags  index:64    from 1476411400 To 1476411460
        SetMemory(0x664194, Add, 64),# units:Special Ability Flags  index:69    from 1509965828 To 1509965892
        SetMemory(0x6641A8, Add, 64),# units:Special Ability Flags  index:74    from 406913024 To 406913088
        SetMemory(0x6641D0, Add, 536870912),# units:Special Ability Flags  index:84    from 1480638468 To 2017509380
        SetMemory(0x6641D8, Add, 4194816),# units:Special Ability Flags  index:86    from 1512046660 To 1516241476
        SetMemory(0x6641F8, Add, 536870976),# units:Special Ability Flags  index:94    from 402718724 To 939589700
        SetMemory(0x6641FC, Add, 4),# units:Special Ability Flags  index:95    from 402718720 To 402718724
        SetMemory(0x66422C, Add, 536903678),# units:Special Ability Flags  index:107    from 1142947843 To 1679851521
        SetMemory(0x66423C, Add, 536903680),# units:Special Ability Flags  index:111    from 3288334369 To 3825238049
        SetMemory(0x664250, Add, -134217693),# units:Special Ability Flags  index:116    from 1140850721 To 1006633028
        SetMemory(0x664254, Add, -671088575),# units:Special Ability Flags  index:117    from 1140850691 To 469762116
        SetMemory(0x664258, Add, 268959742),# units:Special Ability Flags  index:118    from 1140850691 To 1409810433
        SetMemory(0x664278, Add, 4194816),# units:Special Ability Flags  index:126    from 1140850689 To 1145045505
        SetMemory(0x66427C, Add, 4194816),# units:Special Ability Flags  index:127    from 1140850689 To 1145045505
        SetMemory(0x664280, Add, 4),# units:Special Ability Flags  index:128    from 536872960 To 536872964
        SetMemory(0x664288, Add, 4194816),# units:Special Ability Flags  index:130    from 67174561 To 71369377
        SetMemory(0x66428C, Add, -128),# units:Special Ability Flags  index:131    from 2231439489 To 2231439361
        SetMemory(0x664290, Add, -128),# units:Special Ability Flags  index:132    from 2231439489 To 2231439361
        SetMemory(0x664294, Add, -128),# units:Special Ability Flags  index:133    from 2231439489 To 2231439361
        SetMemory(0x6642CC, Add, 4194816),# units:Special Ability Flags  index:147    from 84115585 To 88310401
        SetMemory(0x6642D0, Add, 4194816),# units:Special Ability Flags  index:148    from 84115585 To 88310401
        SetMemory(0x6642D8, Add, 4194816),# units:Special Ability Flags  index:150    from 84082817 To 88277633
        SetMemory(0x6642DC, Add, 4194816),# units:Special Ability Flags  index:151    from 84115585 To 88310401
        SetMemory(0x6642E8, Add, 4194816),# units:Special Ability Flags  index:154    from 3288338433 To 3292533249
        SetMemory(0x664308, Add, -32768),# units:Special Ability Flags  index:162    from 1409843201 To 1409810433
        SetMemory(0x664320, Add, 2097152),# units:Special Ability Flags  index:168    from 1140850689 To 1142947841
        SetMemory(0x664334, Add, -536870912),# units:Special Ability Flags  index:173    from 603979777 To 67108865
        SetMemory(0x664338, Add, 4194816),# units:Special Ability Flags  index:174    from 67108865 To 71303681
        SetMemory(0x66433C, Add, 4194816),# units:Special Ability Flags  index:175    from 67108865 To 71303681
        SetMemory(0x664340, Add, -536870912),# units:Special Ability Flags  index:176    from 603987969 To 67117057
        SetMemory(0x664344, Add, -536870912),# units:Special Ability Flags  index:177    from 603987969 To 67117057
        SetMemory(0x664348, Add, -536870912),# units:Special Ability Flags  index:178    from 603987969 To 67117057
        SetMemory(0x66435C, Add, -134215613),# units:Special Ability Flags  index:183    from 1140850689 To 1006635076
        SetMemory(0x664360, Add, -671088573),# units:Special Ability Flags  index:184    from 1140850689 To 469762116
        SetMemory(0x664364, Add, 402653251),# units:Special Ability Flags  index:185    from 67108865 To 469762116
        SetMemory(0x664374, Add, 4194816),# units:Special Ability Flags  index:189    from 1140850689 To 1145045505
        SetMemory(0x66437C, Add, 486606979),# units:Special Ability Flags  index:191    from 536870913 To 1023477892
        SetMemory(0x6643A4, Add, 2064384),# units:Special Ability Flags  index:201    from 84115585 To 86179969
        SetMemory(0x6643AC, Add, 536870912),# units:Special Ability Flags  index:203    from 1409318912 To 1946189824
        SetMemory(0x6643B0, Add, 4),# units:Special Ability Flags  index:204    from 536870912 To 536870916
        SetMemory(0x6643B4, Add, 402653188),# units:Special Ability Flags  index:205    from 536870912 To 939524100
        SetMemory(0x6643B8, Add, 402653188),# units:Special Ability Flags  index:206    from 536870912 To 939524100
        SetMemory(0x6643BC, Add, 402653188),# units:Special Ability Flags  index:207    from 536870912 To 939524100
        SetMemory(0x6643D8, Add, 536868867),# units:Special Ability Flags  index:214    from 4097 To 536872964
        SetMemory(0x6643DC, Add, 4),# units:Special Ability Flags  index:215    from 536872960 To 536872964
        SetMemory(0x6643F0, Add, 931133444),# units:Special Ability Flags  index:220    from 8390656 To 939524100
        SetMemory(0x662DB8, Add, 3),# units:Target Acquisition Range  index:0    from 4 To 7
        SetMemory(0x662DB8, Add, 131072),# units:Target Acquisition Range  index:2    from 5 To 7
        SetMemory(0x662DB8, Add, 50331648),# units:Target Acquisition Range  index:3    from 6 To 9
        SetMemory(0x662DBC, Add, 1),# units:Target Acquisition Range  index:4    from 6 To 7
        SetMemory(0x662DC0, Add, 393216),# units:Target Acquisition Range  index:10    from 3 To 9
        SetMemory(0x662DC0, Add, 100663296),# units:Target Acquisition Range  index:11    from 0 To 6
        SetMemory(0x662DC4, Add, 83886080),# units:Target Acquisition Range  index:15    from 0 To 5
        SetMemory(0x662DC8, Add, 1),# units:Target Acquisition Range  index:16    from 6 To 7
        SetMemory(0x662DCC, Add, 1),# units:Target Acquisition Range  index:20    from 5 To 6
        SetMemory(0x662DCC, Add, 393216),# units:Target Acquisition Range  index:22    from 0 To 6
        SetMemory(0x662DD8, Add, 2),# units:Target Acquisition Range  index:32    from 3 To 5
        SetMemory(0x662DE4, Add, 16777216),# units:Target Acquisition Range  index:47    from 3 To 4
        SetMemory(0x662DEC, Add, 9),# units:Target Acquisition Range  index:52    from 0 To 9
        SetMemory(0x662DF0, Add, 1536),# units:Target Acquisition Range  index:57    from 0 To 6
        SetMemory(0x662DF4, Add, 768),# units:Target Acquisition Range  index:61    from 3 To 6
        SetMemory(0x662DF8, Add, 5),# units:Target Acquisition Range  index:64    from 1 To 6
        SetMemory(0x662DF8, Add, 256),# units:Target Acquisition Range  index:65    from 3 To 4
        SetMemory(0x662DF8, Add, 16777216),# units:Target Acquisition Range  index:67    from 3 To 4
        SetMemory(0x662DFC, Add, 1536),# units:Target Acquisition Range  index:69    from 0 To 6
        SetMemory(0x662DFC, Add, 196608),# units:Target Acquisition Range  index:70    from 4 To 7
        SetMemory(0x662E00, Add, 131072),# units:Target Acquisition Range  index:74    from 3 To 5
        SetMemory(0x662E08, Add, 2),# units:Target Acquisition Range  index:80    from 4 To 6
        SetMemory(0x662E10, Add, 1),# units:Target Acquisition Range  index:88    from 4 To 5
        SetMemory(0x662E14, Add, 262144),# units:Target Acquisition Range  index:94    from 0 To 4
        SetMemory(0x662E18, Add, 16777216),# units:Target Acquisition Range  index:99    from 6 To 7
        SetMemory(0x662E1C, Add, 1),# units:Target Acquisition Range  index:100    from 6 To 7
        SetMemory(0x662E2C, Add, 458752),# units:Target Acquisition Range  index:118    from 0 To 7
        SetMemory(0x662E6C, Add, 134217728),# units:Target Acquisition Range  index:183    from 0 To 8
        SetMemory(0x662E70, Add, -4),# units:Target Acquisition Range  index:184    from 4 To 0
        SetMemory(0x662E74, Add, 117440512),# units:Target Acquisition Range  index:191    from 0 To 7
        SetMemory(0x6632A0, Add, 16777216),# units:Sight Range  index:107    from 10 To 11
        SetMemory(0x6632AC, Add, -1),# units:Sight Range  index:116    from 10 To 9
        SetMemory(0x6632AC, Add, 256),# units:Sight Range  index:117    from 8 To 9
        SetMemory(0x6632AC, Add, 196608),# units:Sight Range  index:118    from 8 To 11
        SetMemory(0x6632F4, Add, 33554432),# units:Sight Range  index:191    from 8 To 10
        SetMemory(0x663304, Add, 4),# units:Sight Range  index:204    from 7 To 11
        SetMemory(0x66330C, Add, -67108864),# units:Sight Range  index:215    from 5 To 1
        SetMemory(0x663314, Add, -4),# units:Sight Range  index:220    from 5 To 1
        SetMemory(0x6635E8, Add, 0),# units:Armor Upgrade  index:24    from 1 To 1
        SetMemory(0x66363C, Add, -1006632960),# units:Armor Upgrade  index:111    from 60 To 0
        SetMemory(0x66368C, Add, -939524096),# units:Armor Upgrade  index:191    from 60 To 4
        SetMemory(0x6621F4, Add, 6),# units:Unit Size  index:116    from 3 To 9
        SetMemory(0x6621F4, Add, 1536),# units:Unit Size  index:117    from 3 To 9
        SetMemory(0x662234, Add, 150994944),# units:Unit Size  index:183    from 0 To 9
        SetMemory(0x662238, Add, 9),# units:Unit Size  index:184    from 0 To 9
        SetMemory(0x662238, Add, 2304),# units:Unit Size  index:185    from 0 To 9
        SetMemory(0x66223C, Add, 50331648),# units:Unit Size  index:191    from 0 To 3
        SetMemory(0x65FF3C, Add, -1),# units:Armor  index:116    from 1 To 0
        SetMemory(0x65FF3C, Add, -256),# units:Armor  index:117    from 1 To 0
        SetMemory(0x65FF3C, Add, -65536),# units:Armor  index:118    from 1 To 0
        SetMemory(0x65FF84, Add, 33554432),# units:Armor  index:191    from 0 To 2
        SetMemory(0x6620A0, Add, 0),# units:Right-click Action  index:8    from 1 To 1
        SetMemory(0x6620A0, Add, -16777216),# units:Right-click Action  index:11    from 2 To 1
        SetMemory(0x6620A4, Add, -16777216),# units:Right-click Action  index:15    from 2 To 1
        SetMemory(0x6620AC, Add, -65536),# units:Right-click Action  index:22    from 2 To 1
        SetMemory(0x6620C8, Add, -256),# units:Right-click Action  index:49    from 2 To 1
        SetMemory(0x6620CC, Add, -1),# units:Right-click Action  index:52    from 2 To 1
        SetMemory(0x6620D0, Add, -256),# units:Right-click Action  index:57    from 2 To 1
        SetMemory(0x6620D4, Add, -16777216),# units:Right-click Action  index:63    from 2 To 1
        SetMemory(0x6620D8, Add, -16777216),# units:Right-click Action  index:67    from 2 To 1
        SetMemory(0x6620DC, Add, -256),# units:Right-click Action  index:69    from 2 To 1
        SetMemory(0x6620F4, Add, -65536),# units:Right-click Action  index:94    from 2 To 1
        SetMemory(0x66210C, Add, -1),# units:Right-click Action  index:116    from 2 To 1
        SetMemory(0x66210C, Add, 256),# units:Right-click Action  index:117    from 0 To 1
        SetMemory(0x66210C, Add, 196608),# units:Right-click Action  index:118    from 0 To 3
        SetMemory(0x662118, Add, 1),# units:Right-click Action  index:128    from 0 To 1
        SetMemory(0x66214C, Add, 16777216),# units:Right-click Action  index:183    from 0 To 1
        SetMemory(0x662150, Add, 1),# units:Right-click Action  index:184    from 0 To 1
        SetMemory(0x662150, Add, 256),# units:Right-click Action  index:185    from 0 To 1
        SetMemory(0x662154, Add, 16777216),# units:Right-click Action  index:191    from 0 To 1
        SetMemory(0x662164, Add, 256),# units:Right-click Action  index:205    from 0 To 1
        SetMemory(0x662164, Add, 65536),# units:Right-click Action  index:206    from 0 To 1
        SetMemory(0x662164, Add, 16777216),# units:Right-click Action  index:207    from 0 To 1
        SetMemory(0x662174, Add, 1),# units:Right-click Action  index:220    from 0 To 1
        SetMemory(0x661FC4, Add, -57),# units:Ready Sound  index:2    from 352 To 295
        SetMemory(0x661FD0, Add, 19),# units:Ready Sound  index:8    from 256 To 275
        SetMemory(0x661FE4, Add, 41746432),# units:Ready Sound  index:19    from 0 To 637
        SetMemory(0x662000, Add, -20),# units:Ready Sound  index:32    from 295 To 275
        SetMemory(0x66204C, Add, -17760256),# units:Ready Sound  index:71    from 549 To 278
        SetMemory(0x662054, Add, -559),# units:Ready Sound  index:74    from 728 To 169
        SetMemory(0x662054, Add, 11075584),# units:Ready Sound  index:75    from 0 To 169
        SetMemory(0x65FFF0, Add, -12),# units:What Sound Start  index:32    from 299 To 287
        SetMemory(0x660098, Add, -380),# units:What Sound Start  index:116    from 395 To 15
        SetMemory(0x660098, Add, -24576000),# units:What Sound Start  index:117    from 390 To 15
        SetMemory(0x66009C, Add, 87),# units:What Sound Start  index:118    from 398 To 485
        SetMemory(0x66012C, Add, 71172096),# units:What Sound Start  index:191    from 15 To 1101
        SetMemory(0x66014C, Add, -2),# units:What Sound Start  index:206    from 26 To 24
        SetMemory(0x66014C, Add, -262144),# units:What Sound Start  index:207    from 28 To 24
        SetMemory(0x660168, Add, 9),# units:What Sound Start  index:220    from 15 To 24
        SetMemory(0x662C30, Add, -12),# units:What Sound End  index:32    from 302 To 290
        SetMemory(0x662CD8, Add, -380),# units:What Sound End  index:116    from 395 To 15
        SetMemory(0x662CD8, Add, -24576000),# units:What Sound End  index:117    from 390 To 15
        SetMemory(0x662CDC, Add, 87),# units:What Sound End  index:118    from 398 To 485
        SetMemory(0x662D6C, Add, 71303168),# units:What Sound End  index:191    from 15 To 1103
        SetMemory(0x662D8C, Add, -2),# units:What Sound End  index:206    from 27 To 25
        SetMemory(0x662D8C, Add, -262144),# units:What Sound End  index:207    from 29 To 25
        SetMemory(0x662DA8, Add, 10),# units:What Sound End  index:220    from 15 To 25
        SetMemory(0x663B78, Add, -23),# units:Piss Sound Start  index:32    from 303 To 280
        SetMemory(0x661F28, Add, -23),# units:Piss Sound End  index:32    from 309 To 286
        SetMemory(0x663C50, Add, -19),# units:Yes Sound Start  index:32    from 310 To 291
        SetMemory(0x661480, Add, -19),# units:Yes Sound End  index:32    from 313 To 294
        SetMemory(0x6628E4, Add, -26),# units:StarEdit Placement Box Width  index:33    from 27 To 1
        SetMemory(0x6629B0, Add, -31),# units:StarEdit Placement Box Width  index:84    from 32 To 1
        SetMemory(0x662A30, Add, -127),# units:StarEdit Placement Box Width  index:116    from 128 To 1
        SetMemory(0x662A34, Add, -63),# units:StarEdit Placement Box Width  index:117    from 64 To 1
        SetMemory(0x662B3C, Add, -32),# units:StarEdit Placement Box Width  index:183    from 32 To 0
        SetMemory(0x662B40, Add, -63),# units:StarEdit Placement Box Width  index:184    from 64 To 1
        SetMemory(0x662B44, Add, -31),# units:StarEdit Placement Box Width  index:185    from 32 To 1
        SetMemory(0x662B5C, Add, -95),# units:StarEdit Placement Box Width  index:191    from 96 To 1
        SetMemory(0x662B90, Add, -255),# units:StarEdit Placement Box Width  index:204    from 256 To 1
        SetMemory(0x662B94, Add, -136),# units:StarEdit Placement Box Width  index:205    from 136 To 0
        SetMemory(0x662B98, Add, -136),# units:StarEdit Placement Box Width  index:206    from 136 To 0
        SetMemory(0x662B9C, Add, -148),# units:StarEdit Placement Box Width  index:207    from 148 To 0
        SetMemory(0x662BB8, Add, -127),# units:StarEdit Placement Box Width  index:214    from 128 To 1
        SetMemory(0x662BBC, Add, -31),# units:StarEdit Placement Box Width  index:215    from 32 To 1
        SetMemory(0x662BD0, Add, -32),# units:StarEdit Placement Box Width  index:220    from 32 To 0
        SetMemory(0x6628E4, Add, -1966080),# units:StarEdit Placement Box Height  index:33    from 31 To 1
        SetMemory(0x6629B0, Add, -2031616),# units:StarEdit Placement Box Height  index:84    from 32 To 1
        SetMemory(0x662A30, Add, -6225920),# units:StarEdit Placement Box Height  index:116    from 96 To 1
        SetMemory(0x662A34, Add, -4128768),# units:StarEdit Placement Box Height  index:117    from 64 To 1
        SetMemory(0x662B3C, Add, -2031616),# units:StarEdit Placement Box Height  index:183    from 32 To 1
        SetMemory(0x662B40, Add, -4128768),# units:StarEdit Placement Box Height  index:184    from 64 To 1
        SetMemory(0x662B44, Add, -2031616),# units:StarEdit Placement Box Height  index:185    from 32 To 1
        SetMemory(0x662B5C, Add, -4128768),# units:StarEdit Placement Box Height  index:191    from 64 To 1
        SetMemory(0x662B90, Add, -8323072),# units:StarEdit Placement Box Height  index:204    from 128 To 1
        SetMemory(0x662B94, Add, -8847360),# units:StarEdit Placement Box Height  index:205    from 136 To 1
        SetMemory(0x662B98, Add, -8847360),# units:StarEdit Placement Box Height  index:206    from 136 To 1
        SetMemory(0x662B9C, Add, -6488064),# units:StarEdit Placement Box Height  index:207    from 100 To 1
        SetMemory(0x662BB8, Add, -6225920),# units:StarEdit Placement Box Height  index:214    from 96 To 1
        SetMemory(0x662BBC, Add, -2031616),# units:StarEdit Placement Box Height  index:215    from 32 To 1
        SetMemory(0x662BD0, Add, -2031616),# units:StarEdit Placement Box Height  index:220    from 32 To 1
        SetMemory(0x66270C, Add, -128),# units:Addon Horizontal (X) Position  index:11    from 128 To 0
        SetMemory(0x662710, Add, -128),# units:Addon Horizontal (X) Position  index:12    from 128 To 0
        SetMemory(0x66270C, Add, -2097152),# units:Addon Vertical (Y) Position  index:11    from 32 To 0
        SetMemory(0x662710, Add, -2097152),# units:Addon Vertical (Y) Position  index:12    from 32 To 0
        SetMemory(0x661820, Add, -21),# units:Unit Size Left  index:11    from 24 To 3
        SetMemory(0x6618C8, Add, -3),# units:Unit Size Left  index:32    from 11 To 8
        SetMemory(0x6618D0, Add, -12),# units:Unit Size Left  index:33    from 13 To 1
        SetMemory(0x6618F0, Add, -4),# units:Unit Size Left  index:37    from 8 To 4
        SetMemory(0x6618F8, Add, -4),# units:Unit Size Left  index:38    from 10 To 6
        SetMemory(0x661900, Add, -9),# units:Unit Size Left  index:39    from 19 To 10
        SetMemory(0x661908, Add, -3),# units:Unit Size Left  index:40    from 9 To 6
        SetMemory(0x661948, Add, -9),# units:Unit Size Left  index:48    from 19 To 10
        SetMemory(0x661950, Add, -23),# units:Unit Size Left  index:49    from 24 To 1
        SetMemory(0x661970, Add, -4),# units:Unit Size Left  index:53    from 10 To 6
        SetMemory(0x661978, Add, -4),# units:Unit Size Left  index:54    from 8 To 4
        SetMemory(0x6619C8, Add, -10),# units:Unit Size Left  index:64    from 11 To 1
        SetMemory(0x6619F0, Add, -17),# units:Unit Size Left  index:69    from 20 To 3
        SetMemory(0x661A68, Add, -15),# units:Unit Size Left  index:84    from 16 To 1
        SetMemory(0x661AB8, Add, -15),# units:Unit Size Left  index:94    from 16 To 1
        SetMemory(0x661AC0, Add, -15),# units:Unit Size Left  index:95    from 16 To 1
        SetMemory(0x661B68, Add, -47),# units:Unit Size Left  index:116    from 48 To 1
        SetMemory(0x661B70, Add, -46),# units:Unit Size Left  index:117    from 47 To 1
        SetMemory(0x661B78, Add, -27),# units:Unit Size Left  index:118    from 47 To 20
        SetMemory(0x661BC8, Add, -15),# units:Unit Size Left  index:128    from 16 To 1
        SetMemory(0x661C40, Add, 5),# units:Unit Size Left  index:143    from 24 To 29
        SetMemory(0x661C48, Add, 5),# units:Unit Size Left  index:144    from 24 To 29
        SetMemory(0x661C58, Add, 5),# units:Unit Size Left  index:146    from 24 To 29
        SetMemory(0x661D80, Add, -15),# units:Unit Size Left  index:183    from 16 To 1
        SetMemory(0x661D88, Add, -31),# units:Unit Size Left  index:184    from 32 To 1
        SetMemory(0x661D90, Add, -15),# units:Unit Size Left  index:185    from 16 To 1
        SetMemory(0x661DC0, Add, -47),# units:Unit Size Left  index:191    from 48 To 1
        SetMemory(0x661E28, Add, -127),# units:Unit Size Left  index:204    from 128 To 1
        SetMemory(0x661E30, Add, -24),# units:Unit Size Left  index:205    from 25 To 1
        SetMemory(0x661E38, Add, -43),# units:Unit Size Left  index:206    from 44 To 1
        SetMemory(0x661E40, Add, -40),# units:Unit Size Left  index:207    from 41 To 1
        SetMemory(0x661E78, Add, -47),# units:Unit Size Left  index:214    from 48 To 1
        SetMemory(0x661E80, Add, -15),# units:Unit Size Left  index:215    from 16 To 1
        SetMemory(0x661EA8, Add, -15),# units:Unit Size Left  index:220    from 16 To 1
        SetMemory(0x661820, Add, -851968),# units:Unit Size Up  index:11    from 16 To 3
        SetMemory(0x6618C8, Add, 131072),# units:Unit Size Up  index:32    from 7 To 9
        SetMemory(0x6618D0, Add, -786432),# units:Unit Size Up  index:33    from 13 To 1
        SetMemory(0x6618F8, Add, -262144),# units:Unit Size Up  index:38    from 10 To 6
        SetMemory(0x661900, Add, -393216),# units:Unit Size Up  index:39    from 16 To 10
        SetMemory(0x661908, Add, -196608),# units:Unit Size Up  index:40    from 9 To 6
        SetMemory(0x661948, Add, -393216),# units:Unit Size Up  index:48    from 16 To 10
        SetMemory(0x661950, Add, -1507328),# units:Unit Size Up  index:49    from 24 To 1
        SetMemory(0x661970, Add, -262144),# units:Unit Size Up  index:53    from 10 To 6
        SetMemory(0x6619C8, Add, -655360),# units:Unit Size Up  index:64    from 11 To 1
        SetMemory(0x6619F0, Add, -851968),# units:Unit Size Up  index:69    from 16 To 3
        SetMemory(0x661A68, Add, -983040),# units:Unit Size Up  index:84    from 16 To 1
        SetMemory(0x661AB8, Add, -983040),# units:Unit Size Up  index:94    from 16 To 1
        SetMemory(0x661AC0, Add, -983040),# units:Unit Size Up  index:95    from 16 To 1
        SetMemory(0x661B68, Add, -2424832),# units:Unit Size Up  index:116    from 38 To 1
        SetMemory(0x661B70, Add, -1507328),# units:Unit Size Up  index:117    from 24 To 1
        SetMemory(0x661B78, Add, -524288),# units:Unit Size Up  index:118    from 24 To 16
        SetMemory(0x661BC8, Add, -983040),# units:Unit Size Up  index:128    from 16 To 1
        SetMemory(0x661C40, Add, 327680),# units:Unit Size Up  index:143    from 24 To 29
        SetMemory(0x661C48, Add, 327680),# units:Unit Size Up  index:144    from 24 To 29
        SetMemory(0x661C58, Add, 327680),# units:Unit Size Up  index:146    from 24 To 29
        SetMemory(0x661D80, Add, -983040),# units:Unit Size Up  index:183    from 16 To 1
        SetMemory(0x661D88, Add, -2031616),# units:Unit Size Up  index:184    from 32 To 1
        SetMemory(0x661D90, Add, -983040),# units:Unit Size Up  index:185    from 16 To 1
        SetMemory(0x661DC0, Add, -2031616),# units:Unit Size Up  index:191    from 32 To 1
        SetMemory(0x661E28, Add, -4128768),# units:Unit Size Up  index:204    from 64 To 1
        SetMemory(0x661E30, Add, -1048576),# units:Unit Size Up  index:205    from 17 To 1
        SetMemory(0x661E38, Add, -1048576),# units:Unit Size Up  index:206    from 17 To 1
        SetMemory(0x661E40, Add, -1048576),# units:Unit Size Up  index:207    from 17 To 1
        SetMemory(0x661E78, Add, -2031616),# units:Unit Size Up  index:214    from 32 To 1
        SetMemory(0x661E80, Add, -983040),# units:Unit Size Up  index:215    from 16 To 1
        SetMemory(0x661EA8, Add, -983040),# units:Unit Size Up  index:220    from 16 To 1
        SetMemory(0x661824, Add, -21),# units:Unit Size Right  index:11    from 24 To 3
        SetMemory(0x6618CC, Add, -3),# units:Unit Size Right  index:32    from 11 To 8
        SetMemory(0x6618D4, Add, -12),# units:Unit Size Right  index:33    from 13 To 1
        SetMemory(0x6618F4, Add, -3),# units:Unit Size Right  index:37    from 7 To 4
        SetMemory(0x6618FC, Add, -4),# units:Unit Size Right  index:38    from 10 To 6
        SetMemory(0x661904, Add, -8),# units:Unit Size Right  index:39    from 18 To 10
        SetMemory(0x66190C, Add, -3),# units:Unit Size Right  index:40    from 9 To 6
        SetMemory(0x66194C, Add, -8),# units:Unit Size Right  index:48    from 18 To 10
        SetMemory(0x661954, Add, -22),# units:Unit Size Right  index:49    from 23 To 1
        SetMemory(0x661974, Add, -4),# units:Unit Size Right  index:53    from 10 To 6
        SetMemory(0x66197C, Add, -3),# units:Unit Size Right  index:54    from 7 To 4
        SetMemory(0x6619CC, Add, -10),# units:Unit Size Right  index:64    from 11 To 1
        SetMemory(0x6619F4, Add, -16),# units:Unit Size Right  index:69    from 19 To 3
        SetMemory(0x661A6C, Add, -14),# units:Unit Size Right  index:84    from 15 To 1
        SetMemory(0x661ABC, Add, -14),# units:Unit Size Right  index:94    from 15 To 1
        SetMemory(0x661AC4, Add, -14),# units:Unit Size Right  index:95    from 15 To 1
        SetMemory(0x661B6C, Add, -47),# units:Unit Size Right  index:116    from 48 To 1
        SetMemory(0x661B74, Add, -27),# units:Unit Size Right  index:117    from 28 To 1
        SetMemory(0x661B7C, Add, -8),# units:Unit Size Right  index:118    from 28 To 20
        SetMemory(0x661BCC, Add, -14),# units:Unit Size Right  index:128    from 15 To 1
        SetMemory(0x661C44, Add, 5),# units:Unit Size Right  index:143    from 23 To 28
        SetMemory(0x661C4C, Add, 5),# units:Unit Size Right  index:144    from 23 To 28
        SetMemory(0x661C5C, Add, 5),# units:Unit Size Right  index:146    from 23 To 28
        SetMemory(0x661D84, Add, -14),# units:Unit Size Right  index:183    from 15 To 1
        SetMemory(0x661D8C, Add, -30),# units:Unit Size Right  index:184    from 31 To 1
        SetMemory(0x661D94, Add, -14),# units:Unit Size Right  index:185    from 15 To 1
        SetMemory(0x661DC4, Add, -46),# units:Unit Size Right  index:191    from 47 To 1
        SetMemory(0x661E2C, Add, -126),# units:Unit Size Right  index:204    from 127 To 1
        SetMemory(0x661E34, Add, -43),# units:Unit Size Right  index:205    from 44 To 1
        SetMemory(0x661E3C, Add, -24),# units:Unit Size Right  index:206    from 25 To 1
        SetMemory(0x661E44, Add, -27),# units:Unit Size Right  index:207    from 28 To 1
        SetMemory(0x661E7C, Add, -47),# units:Unit Size Right  index:214    from 48 To 1
        SetMemory(0x661E84, Add, -14),# units:Unit Size Right  index:215    from 15 To 1
        SetMemory(0x661EAC, Add, -14),# units:Unit Size Right  index:220    from 15 To 1
        SetMemory(0x661824, Add, -1114112),# units:Unit Size Down  index:11    from 20 To 3
        SetMemory(0x6618CC, Add, -262144),# units:Unit Size Down  index:32    from 14 To 10
        SetMemory(0x6618D4, Add, -1048576),# units:Unit Size Down  index:33    from 17 To 1
        SetMemory(0x6618F4, Add, -458752),# units:Unit Size Down  index:37    from 11 To 4
        SetMemory(0x6618FC, Add, -393216),# units:Unit Size Down  index:38    from 12 To 6
        SetMemory(0x661904, Add, -327680),# units:Unit Size Down  index:39    from 15 To 10
        SetMemory(0x66190C, Add, -196608),# units:Unit Size Down  index:40    from 9 To 6
        SetMemory(0x66194C, Add, -327680),# units:Unit Size Down  index:48    from 15 To 10
        SetMemory(0x661954, Add, -1441792),# units:Unit Size Down  index:49    from 23 To 1
        SetMemory(0x661974, Add, -393216),# units:Unit Size Down  index:53    from 12 To 6
        SetMemory(0x66197C, Add, -458752),# units:Unit Size Down  index:54    from 11 To 4
        SetMemory(0x6619CC, Add, -655360),# units:Unit Size Down  index:64    from 11 To 1
        SetMemory(0x6619F4, Add, -786432),# units:Unit Size Down  index:69    from 15 To 3
        SetMemory(0x661A6C, Add, -917504),# units:Unit Size Down  index:84    from 15 To 1
        SetMemory(0x661ABC, Add, -917504),# units:Unit Size Down  index:94    from 15 To 1
        SetMemory(0x661AC4, Add, -917504),# units:Unit Size Down  index:95    from 15 To 1
        SetMemory(0x661B6C, Add, -2424832),# units:Unit Size Down  index:116    from 38 To 1
        SetMemory(0x661B74, Add, -1376256),# units:Unit Size Down  index:117    from 22 To 1
        SetMemory(0x661B7C, Add, -393216),# units:Unit Size Down  index:118    from 22 To 16
        SetMemory(0x661BCC, Add, -917504),# units:Unit Size Down  index:128    from 15 To 1
        SetMemory(0x661C44, Add, 327680),# units:Unit Size Down  index:143    from 23 To 28
        SetMemory(0x661C4C, Add, 327680),# units:Unit Size Down  index:144    from 23 To 28
        SetMemory(0x661C5C, Add, 327680),# units:Unit Size Down  index:146    from 23 To 28
        SetMemory(0x661D84, Add, -917504),# units:Unit Size Down  index:183    from 15 To 1
        SetMemory(0x661D8C, Add, -1966080),# units:Unit Size Down  index:184    from 31 To 1
        SetMemory(0x661D94, Add, -917504),# units:Unit Size Down  index:185    from 15 To 1
        SetMemory(0x661DC4, Add, -1966080),# units:Unit Size Down  index:191    from 31 To 1
        SetMemory(0x661E2C, Add, -4063232),# units:Unit Size Down  index:204    from 63 To 1
        SetMemory(0x661E34, Add, -1245184),# units:Unit Size Down  index:205    from 20 To 1
        SetMemory(0x661E3C, Add, -1245184),# units:Unit Size Down  index:206    from 20 To 1
        SetMemory(0x661E44, Add, -1245184),# units:Unit Size Down  index:207    from 20 To 1
        SetMemory(0x661E7C, Add, -2031616),# units:Unit Size Down  index:214    from 32 To 1
        SetMemory(0x661E84, Add, -917504),# units:Unit Size Down  index:215    from 15 To 1
        SetMemory(0x661EAC, Add, -917504),# units:Unit Size Down  index:220    from 15 To 1
        SetMemory(0x662FC8, Add, -2),# units:Portrait  index:32    from 2 To 0
        SetMemory(0x663044, Add, -54),# units:Portrait  index:94    from 102 To 48
        SetMemory(0x663070, Add, 57),# units:Portrait  index:116    from 17 To 74
        SetMemory(0x663070, Add, 3735552),# units:Portrait  index:117    from 17 To 74
        SetMemory(0x663074, Add, 43),# units:Portrait  index:118    from 17 To 60
        SetMemory(0x663104, Add, 3866624),# units:Portrait  index:191    from 38 To 97
        SetMemory(0x663134, Add, 4289527808),# units:Portrait  index:215    from 82 To 65535
        SetMemory(0x663140, Add, 65457),# units:Portrait  index:220    from 78 To 65535
        SetMemory(0x663894, Add, 29491200),# units:Mineral Cost  index:7    from 50 To 500
        SetMemory(0x663960, Add, 58982400),# units:Mineral Cost  index:109    from 100 To 1000
        SetMemory(0x663970, Add, -99),# units:Mineral Cost  index:116    from 100 To 1
        SetMemory(0x663970, Add, -3211264),# units:Mineral Cost  index:117    from 50 To 1
        SetMemory(0x663974, Add, 100),# units:Mineral Cost  index:118    from 50 To 150
        SetMemory(0x663980, Add, 255590400),# units:Mineral Cost  index:125    from 100 To 4000
        SetMemory(0x663A04, Add, -6553600),# units:Mineral Cost  index:191    from 250 To 150
        SetMemory(0x663A34, Add, -65536),# units:Mineral Cost  index:215    from 1 To 0
        SetMemory(0x65FDE8, Add, -149),# units:Vespene Cost  index:116    from 150 To 1
        SetMemory(0x65FDE8, Add, -3211264),# units:Vespene Cost  index:117    from 50 To 1
        SetMemory(0x65FDEC, Add, -50),# units:Vespene Cost  index:118    from 50 To 0
        SetMemory(0x65FE7C, Add, 3276800),# units:Vespene Cost  index:191    from 0 To 50
        SetMemory(0x65FEAC, Add, -65536),# units:Vespene Cost  index:215    from 1 To 0
        SetMemory(0x660434, Add, -19660800),# units:Build Time  index:7    from 300 To 0
        SetMemory(0x660500, Add, -36044800),# units:Build Time  index:109    from 600 To 50
        SetMemory(0x660510, Add, -899),# units:Build Time  index:116    from 900 To 1
        SetMemory(0x660510, Add, -39256064),# units:Build Time  index:117    from 600 To 1
        SetMemory(0x660514, Add, 150),# units:Build Time  index:118    from 600 To 750
        SetMemory(0x660520, Add, -26214400),# units:Build Time  index:125    from 450 To 50
        SetMemory(0x6605A4, Add, 39256064),# units:Build Time  index:191    from 1 To 600
        SetMemory(0x6605D4, Add, -65536),# units:Build Time  index:215    from 1 To 0
        SetMemory(0x6637CC, Add, 0),# units:Staredit Group Flags  index:46    from 9 To 9
        SetMemory(0x6637FC, Add, -8257536),# units:Staredit Group Flags  index:94    from 136 To 10
        SetMemory(0x663814, Add, -8),# units:Staredit Group Flags  index:116    from 18 To 10
        SetMemory(0x663814, Add, -2048),# units:Staredit Group Flags  index:117    from 18 To 10
        SetMemory(0x663814, Add, -524288),# units:Staredit Group Flags  index:118    from 18 To 10
        SetMemory(0x663854, Add, 805306368),# units:Staredit Group Flags  index:183    from 80 To 128
        SetMemory(0x663858, Add, -70),# units:Staredit Group Flags  index:184    from 80 To 10
        SetMemory(0x663858, Add, -34304),# units:Staredit Group Flags  index:185    from 144 To 10
        SetMemory(0x66385C, Add, 134217728),# units:Staredit Group Flags  index:191    from 1 To 9
        SetMemory(0x664734, Add, -4096),# units:Supply Provided  index:109    from 16 To 0
        SetMemory(0x663D08, Add, -2),# units:Supply Required  index:32    from 2 To 0
        SetMemory(0x663D3C, Add, -2),# units:Supply Required  index:84    from 2 To 0
        SetMemory(0x663DA4, Add, 67108864),# units:Supply Required  index:191    from 0 To 4
        SetMemory(0x6609C0, Add, -2048),# units:Space Provided  index:57    from 8 To 0
        SetMemory(0x660A04, Add, 1024),# units:Space Provided  index:125    from 4 To 8
        SetMemory(0x6634F0, Add, -265),# units:Build Score  index:116    from 275 To 10
        SetMemory(0x6634F0, Add, -4259840),# units:Build Score  index:117    from 75 To 10
        SetMemory(0x6634F4, Add, 25),# units:Build Score  index:118    from 75 To 100
        SetMemory(0x663584, Add, 36044800),# units:Build Score  index:191    from 0 To 550
        SetMemory(0x663EBC, Add, 190054400),# units:Destroy Score  index:3    from 400 To 3300
        SetMemory(0x663EC8, Add, 2800),# units:Destroy Score  index:8    from 800 To 3600
        SetMemory(0x663ECC, Add, 2100),# units:Destroy Score  index:10    from 400 To 2500
        SetMemory(0x663ECC, Add, 170393600),# units:Destroy Score  index:11    from 600 To 3200
        SetMemory(0x663ED0, Add, -2400),# units:Destroy Score  index:12    from 2400 To 0
        SetMemory(0x663ED0, Add, -1638400),# units:Destroy Score  index:13    from 25 To 0
        SetMemory(0x663ED4, Add, 64880640),# units:Destroy Score  index:15    from 10 To 1000
        SetMemory(0x663ED8, Add, 45875200),# units:Destroy Score  index:17    from 800 To 1500
        SetMemory(0x663EDC, Add, 176947200),# units:Destroy Score  index:19    from 300 To 3000
        SetMemory(0x663EE4, Add, 2005401600),# units:Destroy Score  index:23    from 1400 To 32000
        SetMemory(0x663EF0, Add, -2000),# units:Destroy Score  index:28    from 4800 To 2800
        SetMemory(0x663EF4, Add, 27300),# units:Destroy Score  index:30    from 700 To 28000
        SetMemory(0x663F18, Add, -104857600),# units:Destroy Score  index:49    from 1600 To 0
        SetMemory(0x663F20, Add, 2700),# units:Destroy Score  index:52    from 900 To 3600
        SetMemory(0x663F30, Add, 64800),# units:Destroy Score  index:60    from 700 To 65500
        SetMemory(0x663F30, Add, 2578841600),# units:Destroy Score  index:61    from 650 To 40000
        SetMemory(0x663F38, Add, -100),# units:Destroy Score  index:64    from 100 To 0
        SetMemory(0x663F38, Add, 163840000),# units:Destroy Score  index:65    from 200 To 2700
        SetMemory(0x663F3C, Add, 2500),# units:Destroy Score  index:66    from 500 To 3000
        SetMemory(0x663F3C, Add, 1723596800),# units:Destroy Score  index:67    from 700 To 27000
        SetMemory(0x663F40, Add, 64100),# units:Destroy Score  index:68    from 1400 To 65500
        SetMemory(0x663F40, Add, 157286400),# units:Destroy Score  index:69    from 400 To 2800
        SetMemory(0x663F44, Add, 4700),# units:Destroy Score  index:70    from 1300 To 6000
        SetMemory(0x663F4C, Add, 52428800),# units:Destroy Score  index:75    from 800 To 1600
        SetMemory(0x663F50, Add, 58982400),# units:Destroy Score  index:77    from 400 To 1300
        SetMemory(0x663F54, Add, 600),# units:Destroy Score  index:78    from 1000 To 1600
        SetMemory(0x663F54, Add, 91750400),# units:Destroy Score  index:79    from 1400 To 2800
        SetMemory(0x663F58, Add, 2385510400),# units:Destroy Score  index:81    from 1600 To 38000
        SetMemory(0x663F7C, Add, 2000),# units:Destroy Score  index:98    from 1300 To 3300
        SetMemory(0x663F80, Add, 6300),# units:Destroy Score  index:100    from 700 To 7000
        SetMemory(0x663F84, Add, 12000),# units:Destroy Score  index:102    from 4800 To 16800
        SetMemory(0x663FA0, Add, -815),# units:Destroy Score  index:116    from 825 To 10
        SetMemory(0x663FA0, Add, -14090240),# units:Destroy Score  index:117    from 225 To 10
        SetMemory(0x663FA4, Add, 6775),# units:Destroy Score  index:118    from 225 To 7000
        SetMemory(0x663FE4, Add, 60500),# units:Destroy Score  index:150    from 5000 To 65500
        SetMemory(0x663FFC, Add, 6700),# units:Destroy Score  index:162    from 300 To 7000
        SetMemory(0x664034, Add, 72089600),# units:Destroy Score  index:191    from 0 To 1100
        SetMemory(0x664070, Add, 10),# units:Destroy Score  index:220    from 0 To 10
        SetMemory(0x660794, Add, 16777216),# units:Broodwar Unit Flag  index:191    from 0 To 1
        SetMemory(0x661600, Add, -8),# units:Staredit Availability Flags  index:116    from 463 To 455
        SetMemory(0x661600, Add, -524288),# units:Staredit Availability Flags  index:117    from 463 To 455
        SetMemory(0x661684, Add, 29818880),# units:Staredit Availability Flags  index:183    from 0 To 455
        SetMemory(0x661688, Add, 455),# units:Staredit Availability Flags  index:184    from 0 To 455
        SetMemory(0x661688, Add, 29818880),# units:Staredit Availability Flags  index:185    from 0 To 455
        SetMemory(0x661694, Add, 63897600),# units:Staredit Availability Flags  index:191    from 0 To 975
        SetMemory(0x6616C4, Add, -21364736),# units:Staredit Availability Flags  index:215    from 343 To 17
        SetMemory(0x6616D0, Add, 32),# units:Staredit Availability Flags  index:220    from 0 To 32
        SetMemory(0x6572E8, Add, 1185),# weapons:Label  index:4    from 233 To 1418
        SetMemory(0x6572F4, Add, 77201408),# weapons:Label  index:11    from 239 To 1417
        SetMemory(0x657370, Add, -2),# weapons:Label  index:72    from 292 To 290
        SetMemory(0x65738C, Add, 1132),# weapons:Label  index:86    from 284 To 1416
        SetMemory(0x65738C, Add, -720896),# weapons:Label  index:87    from 303 To 292
        SetMemory(0x657390, Add, 1233),# weapons:Label  index:88    from 304 To 1537
        SetMemory(0x657390, Add, 0),# weapons:Label  index:89    from 305 To 305
        SetMemory(0x657394, Add, 1232),# weapons:Label  index:90    from 306 To 1538
        SetMemory(0x65739C, Add, 60882944),# weapons:Label  index:95    from 308 To 1237
        SetMemory(0x6573A4, Add, 70975488),# weapons:Label  index:99    from 310 To 1393
        SetMemory(0x6573D0, Add, 1900544),# weapons:Label  index:121    from 229 To 258
        SetMemory(0x6573D4, Add, 81068032),# weapons:Label  index:123    from 229 To 1466
        SetMemory(0x6573D8, Add, 1186),# weapons:Label  index:124    from 229 To 1415
        SetMemory(0x6573D8, Add, 42991616),# weapons:Label  index:125    from 229 To 885
        SetMemory(0x656DA0, Add, 3),# weapons:Graphics  index:62    from 153 To 156
        SetMemory(0x656DC8, Add, 4),# weapons:Graphics  index:72    from 152 To 156
        SetMemory(0x656E04, Add, 58),# weapons:Graphics  index:87    from 146 To 204
        SetMemory(0x656E08, Add, 40),# weapons:Graphics  index:88    from 143 To 183
        SetMemory(0x656E0C, Add, -2),# weapons:Graphics  index:89    from 144 To 142
        SetMemory(0x656E10, Add, 23),# weapons:Graphics  index:90    from 146 To 169
        SetMemory(0x656E14, Add, -4),# weapons:Graphics  index:91    from 152 To 148
        SetMemory(0x656E20, Add, -1),# weapons:Graphics  index:94    from 152 To 151
        SetMemory(0x656E24, Add, 57),# weapons:Graphics  index:95    from 145 To 202
        SetMemory(0x656E34, Add, 5),# weapons:Graphics  index:99    from 146 To 151
        SetMemory(0x656E8C, Add, -36),# weapons:Graphics  index:121    from 142 To 106
        SetMemory(0x656E90, Add, 13),# weapons:Graphics  index:122    from 142 To 155
        SetMemory(0x656E94, Add, 6),# weapons:Graphics  index:123    from 142 To 148
        SetMemory(0x656E98, Add, 1),# weapons:Graphics  index:124    from 142 To 143
        SetMemory(0x656E9C, Add, 13),# weapons:Graphics  index:125    from 142 To 155
        SetMemory(0x656EA0, Add, 31),# weapons:Graphics  index:126    from 142 To 173
        SetMemory(0x656EA4, Add, 32),# weapons:Graphics  index:127    from 142 To 174
        SetMemory(0x656EAC, Add, -9),# weapons:Graphics  index:129    from 142 To 133
        SetMemory(0x6579A0, Add, 1),# weapons:Target Flags  index:4    from 2 To 3
        SetMemory(0x6579A8, Add, 2),# weapons:Target Flags  index:8    from 1 To 3
        SetMemory(0x6579B4, Add, 131072),# weapons:Target Flags  index:15    from 1 To 3
        SetMemory(0x6579C0, Add, 2),# weapons:Target Flags  index:20    from 1 To 3
        SetMemory(0x6579D0, Add, 131072),# weapons:Target Flags  index:29    from 1 To 3
        SetMemory(0x657A14, Add, 1),# weapons:Target Flags  index:62    from 2 To 3
        SetMemory(0x657A28, Add, 2),# weapons:Target Flags  index:72    from 1 To 3
        SetMemory(0x657A2C, Add, 2),# weapons:Target Flags  index:74    from 1 To 3
        SetMemory(0x657A44, Add, 131072),# weapons:Target Flags  index:87    from 1 To 3
        SetMemory(0x657A48, Add, 131072),# weapons:Target Flags  index:89    from 1 To 3
        SetMemory(0x657A4C, Add, 131072),# weapons:Target Flags  index:91    from 1 To 3
        SetMemory(0x657A5C, Add, 65536),# weapons:Target Flags  index:99    from 2 To 3
        SetMemory(0x657A60, Add, 2),# weapons:Target Flags  index:100    from 1 To 3
        SetMemory(0x657A68, Add, 2),# weapons:Target Flags  index:104    from 1 To 3
        SetMemory(0x657A80, Add, 0),# weapons:Target Flags  index:117    from 3 To 3
        SetMemory(0x657A84, Add, 0),# weapons:Target Flags  index:118    from 3 To 3
        SetMemory(0x657A84, Add, 0),# weapons:Target Flags  index:119    from 3 To 3
        SetMemory(0x657A88, Add, 0),# weapons:Target Flags  index:120    from 3 To 3
        SetMemory(0x657A90, Add, -1),# weapons:Target Flags  index:124    from 3 To 2
        SetMemory(0x657A94, Add, 80),# weapons:Target Flags  index:126    from 3 To 83
        SetMemory(0x657A98, Add, 2097152),# weapons:Target Flags  index:129    from 3 To 35
        SetMemory(0x656A84, Add, -64),# weapons:Minimum Range  index:27    from 64 To 0
        SetMemory(0x656A88, Add, -64),# weapons:Minimum Range  index:28    from 64 To 0
        SetMemory(0x657470, Add, 36),# weapons:Maximum Range  index:0    from 128 To 164
        SetMemory(0x657474, Add, 32),# weapons:Maximum Range  index:1    from 160 To 192
        SetMemory(0x657480, Add, 64),# weapons:Maximum Range  index:4    from 160 To 224
        SetMemory(0x657484, Add, 32),# weapons:Maximum Range  index:5    from 160 To 192
        SetMemory(0x657490, Add, 64),# weapons:Maximum Range  index:8    from 160 To 224
        SetMemory(0x657494, Add, 32),# weapons:Maximum Range  index:9    from 160 To 192
        SetMemory(0x6574AC, Add, 36),# weapons:Maximum Range  index:15    from 160 To 196
        SetMemory(0x6574B8, Add, 32),# weapons:Maximum Range  index:18    from 160 To 192
        SetMemory(0x65753C, Add, 96),# weapons:Maximum Range  index:51    from 128 To 224
        SetMemory(0x657568, Add, 160),# weapons:Maximum Range  index:62    from 32 To 192
        SetMemory(0x657590, Add, 96),# weapons:Maximum Range  index:72    from 32 To 128
        SetMemory(0x657598, Add, 96),# weapons:Maximum Range  index:74    from 128 To 224
        SetMemory(0x6575A8, Add, 64),# weapons:Maximum Range  index:78    from 160 To 224
        SetMemory(0x6575C8, Add, 177),# weapons:Maximum Range  index:86    from 15 To 192
        SetMemory(0x6575CC, Add, 64),# weapons:Maximum Range  index:87    from 128 To 192
        SetMemory(0x6575D0, Add, 64),# weapons:Maximum Range  index:88    from 128 To 192
        SetMemory(0x6575D8, Add, 64),# weapons:Maximum Range  index:90    from 128 To 192
        SetMemory(0x6575DC, Add, -32),# weapons:Maximum Range  index:91    from 224 To 192
        SetMemory(0x657638, Add, 36),# weapons:Maximum Range  index:114    from 128 To 164
        SetMemory(0x657640, Add, 32),# weapons:Maximum Range  index:116    from 192 To 224
        SetMemory(0x657644, Add, 96),# weapons:Maximum Range  index:117    from 128 To 224
        SetMemory(0x657648, Add, 96),# weapons:Maximum Range  index:118    from 128 To 224
        SetMemory(0x65764C, Add, 96),# weapons:Maximum Range  index:119    from 128 To 224
        SetMemory(0x657650, Add, 96),# weapons:Maximum Range  index:120    from 128 To 224
        SetMemory(0x657654, Add, 96),# weapons:Maximum Range  index:121    from 128 To 224
        SetMemory(0x65765C, Add, 256),# weapons:Maximum Range  index:123    from 128 To 384
        SetMemory(0x657660, Add, 64),# weapons:Maximum Range  index:124    from 128 To 192
        SetMemory(0x657664, Add, -88),# weapons:Maximum Range  index:125    from 128 To 40
        SetMemory(0x65766C, Add, 872),# weapons:Maximum Range  index:127    from 128 To 1000
        SetMemory(0x6571EC, Add, -13568),# weapons:Damage Upgrade  index:29    from 60 To 7
        SetMemory(0x657228, Add, -256),# weapons:Damage Upgrade  index:89    from 60 To 59
        SetMemory(0x657230, Add, -16777216),# weapons:Damage Upgrade  index:99    from 8 To 7
        SetMemory(0x657248, Add, 3473408),# weapons:Damage Upgrade  index:122    from 7 To 60
        SetMemory(0x65724C, Add, 6),# weapons:Damage Upgrade  index:124    from 7 To 13
        SetMemory(0x6572D0, Add, -768),# weapons:Weapon Type  index:121    from 3 To 0
        SetMemory(0x6572D4, Add, -768),# weapons:Weapon Type  index:125    from 3 To 0
        SetMemory(0x65668C, Add, 589824),# weapons:Weapon Behavior  index:30    from 0 To 9
        SetMemory(0x6566C4, Add, 0),# weapons:Weapon Behavior  index:86    from 5 To 5
        SetMemory(0x6566C4, Add, 33554432),# weapons:Weapon Behavior  index:87    from 0 To 2
        SetMemory(0x6566C8, Add, -1),# weapons:Weapon Behavior  index:88    from 2 To 1
        SetMemory(0x6566C8, Add, 256),# weapons:Weapon Behavior  index:89    from 1 To 2
        SetMemory(0x6566C8, Add, 65536),# weapons:Weapon Behavior  index:90    from 0 To 1
        SetMemory(0x6566C8, Add, -16777216),# weapons:Weapon Behavior  index:91    from 2 To 1
        SetMemory(0x6566CC, Add, 1),# weapons:Weapon Behavior  index:92    from 0 To 1
        SetMemory(0x6566CC, Add, 256),# weapons:Weapon Behavior  index:93    from 0 To 1
        SetMemory(0x6566CC, Add, -65536),# weapons:Weapon Behavior  index:94    from 2 To 1
        SetMemory(0x6566CC, Add, 50331648),# weapons:Weapon Behavior  index:95    from 0 To 3
        SetMemory(0x6566E8, Add, -65536),# weapons:Weapon Behavior  index:122    from 2 To 1
        SetMemory(0x6566E8, Add, -16777216),# weapons:Weapon Behavior  index:123    from 2 To 1
        SetMemory(0x6566EC, Add, 1024),# weapons:Weapon Behavior  index:125    from 2 To 6
        SetMemory(0x6566EC, Add, 458752),# weapons:Weapon Behavior  index:126    from 2 To 9
        SetMemory(0x6566EC, Add, 117440512),# weapons:Weapon Behavior  index:127    from 2 To 9
        SetMemory(0x6566F0, Add, 1792),# weapons:Weapon Behavior  index:129    from 2 To 9
        SetMemory(0x6566FC, Add, 2),# weapons:Explosion Type  index:4    from 1 To 3
        SetMemory(0x6566FC, Add, 65536),# weapons:Explosion Type  index:6    from 2 To 3
        SetMemory(0x656700, Add, 33554432),# weapons:Explosion Type  index:11    from 1 To 3
        SetMemory(0x656704, Add, 2),# weapons:Explosion Type  index:12    from 1 To 3
        SetMemory(0x656714, Add, 1),# weapons:Explosion Type  index:28    from 2 To 3
        SetMemory(0x656714, Add, -786432),# weapons:Explosion Type  index:30    from 15 To 3
        SetMemory(0x656714, Add, -33554432),# weapons:Explosion Type  index:31    from 5 To 3
        SetMemory(0x656740, Add, 2),# weapons:Explosion Type  index:72    from 1 To 3
        SetMemory(0x65674C, Add, 1),# weapons:Explosion Type  index:84    from 2 To 3
        SetMemory(0x65674C, Add, 131072),# weapons:Explosion Type  index:86    from 1 To 3
        SetMemory(0x65674C, Add, 0),# weapons:Explosion Type  index:87    from 1 To 1
        SetMemory(0x656754, Add, 131072),# weapons:Explosion Type  index:94    from 1 To 3
        SetMemory(0x656754, Add, 33554432),# weapons:Explosion Type  index:95    from 1 To 3
        SetMemory(0x656758, Add, 33554432),# weapons:Explosion Type  index:99    from 1 To 3
        SetMemory(0x65675C, Add, -21),# weapons:Explosion Type  index:100    from 24 To 3
        SetMemory(0x656770, Add, 512),# weapons:Explosion Type  index:121    from 1 To 3
        SetMemory(0x656774, Add, 2),# weapons:Explosion Type  index:124    from 1 To 3
        SetMemory(0x656774, Add, 0),# weapons:Explosion Type  index:125    from 1 To 1
        SetMemory(0x656774, Add, 131072),# weapons:Explosion Type  index:126    from 1 To 3
        SetMemory(0x656778, Add, 512),# weapons:Explosion Type  index:129    from 1 To 3
        SetMemory(0x656890, Add, 32),# weapons:Inner Splash Range  index:4    from 0 To 32
        SetMemory(0x656894, Add, 100),# weapons:Inner Splash Range  index:6    from 50 To 150
        SetMemory(0x65689C, Add, 4194304),# weapons:Inner Splash Range  index:11    from 0 To 64
        SetMemory(0x6568A0, Add, 5),# weapons:Inner Splash Range  index:12    from 0 To 5
        SetMemory(0x6568C4, Add, 8),# weapons:Inner Splash Range  index:30    from 0 To 8
        SetMemory(0x656904, Add, 32),# weapons:Inner Splash Range  index:62    from 0 To 32
        SetMemory(0x656918, Add, 10),# weapons:Inner Splash Range  index:72    from 0 To 10
        SetMemory(0x656934, Add, 64),# weapons:Inner Splash Range  index:86    from 0 To 64
        SetMemory(0x656944, Add, 75),# weapons:Inner Splash Range  index:94    from 0 To 75
        SetMemory(0x656944, Add, 196608),# weapons:Inner Splash Range  index:95    from 0 To 3
        SetMemory(0x65694C, Add, 4194304),# weapons:Inner Splash Range  index:99    from 0 To 64
        SetMemory(0x656978, Add, 4194304),# weapons:Inner Splash Range  index:121    from 0 To 64
        SetMemory(0x656980, Add, 64),# weapons:Inner Splash Range  index:124    from 0 To 64
        SetMemory(0x656984, Add, 10),# weapons:Inner Splash Range  index:126    from 0 To 10
        SetMemory(0x6570D0, Add, 64),# weapons:Medium Splash Range  index:4    from 0 To 64
        SetMemory(0x6570D4, Add, 75),# weapons:Medium Splash Range  index:6    from 75 To 150
        SetMemory(0x6570DC, Add, 8388608),# weapons:Medium Splash Range  index:11    from 0 To 128
        SetMemory(0x6570E0, Add, 15),# weapons:Medium Splash Range  index:12    from 0 To 15
        SetMemory(0x657104, Add, 8),# weapons:Medium Splash Range  index:30    from 0 To 8
        SetMemory(0x657144, Add, 64),# weapons:Medium Splash Range  index:62    from 0 To 64
        SetMemory(0x657158, Add, 15),# weapons:Medium Splash Range  index:72    from 0 To 15
        SetMemory(0x657174, Add, 64),# weapons:Medium Splash Range  index:86    from 0 To 64
        SetMemory(0x657184, Add, 75),# weapons:Medium Splash Range  index:94    from 0 To 75
        SetMemory(0x657184, Add, 655360),# weapons:Medium Splash Range  index:95    from 0 To 10
        SetMemory(0x65718C, Add, 4194304),# weapons:Medium Splash Range  index:99    from 0 To 64
        SetMemory(0x657190, Add, -40),# weapons:Medium Splash Range  index:100    from 50 To 10
        SetMemory(0x6571B8, Add, 8388608),# weapons:Medium Splash Range  index:121    from 0 To 128
        SetMemory(0x6571C0, Add, 64),# weapons:Medium Splash Range  index:124    from 0 To 64
        SetMemory(0x6571C4, Add, 15),# weapons:Medium Splash Range  index:126    from 0 To 15
        SetMemory(0x657788, Add, 128),# weapons:Outer Splash Range  index:4    from 0 To 128
        SetMemory(0x65778C, Add, 50),# weapons:Outer Splash Range  index:6    from 100 To 150
        SetMemory(0x657794, Add, 16777216),# weapons:Outer Splash Range  index:11    from 0 To 256
        SetMemory(0x657798, Add, 75),# weapons:Outer Splash Range  index:12    from 0 To 75
        SetMemory(0x6577BC, Add, 8),# weapons:Outer Splash Range  index:30    from 0 To 8
        SetMemory(0x6577FC, Add, 128),# weapons:Outer Splash Range  index:62    from 0 To 128
        SetMemory(0x657810, Add, 25),# weapons:Outer Splash Range  index:72    from 0 To 25
        SetMemory(0x65782C, Add, 64),# weapons:Outer Splash Range  index:86    from 0 To 64
        SetMemory(0x65783C, Add, 100),# weapons:Outer Splash Range  index:94    from 0 To 100
        SetMemory(0x65783C, Add, 1310720),# weapons:Outer Splash Range  index:95    from 0 To 20
        SetMemory(0x657844, Add, 4194304),# weapons:Outer Splash Range  index:99    from 0 To 64
        SetMemory(0x657848, Add, -50),# weapons:Outer Splash Range  index:100    from 100 To 50
        SetMemory(0x657870, Add, 12582912),# weapons:Outer Splash Range  index:121    from 0 To 192
        SetMemory(0x657878, Add, 64),# weapons:Outer Splash Range  index:124    from 0 To 64
        SetMemory(0x65787C, Add, 20),# weapons:Outer Splash Range  index:126    from 0 To 20
        SetMemory(0x656EB0, Add, 9),# weapons:Damage Amount  index:0    from 6 To 15
        SetMemory(0x656EB0, Add, 2097152),# weapons:Damage Amount  index:1    from 18 To 50
        SetMemory(0x656EB8, Add, 300),# weapons:Damage Amount  index:4    from 20 To 320
        SetMemory(0x656EB8, Add, 122552320),# weapons:Damage Amount  index:5    from 30 To 1900
        SetMemory(0x656EBC, Add, 475),# weapons:Damage Amount  index:6    from 125 To 600
        SetMemory(0x656EC0, Add, 100),# weapons:Damage Amount  index:8    from 10 To 110
        SetMemory(0x656EC0, Add, 14811136),# weapons:Damage Amount  index:9    from 24 To 250
        SetMemory(0x656EC4, Add, 63504384),# weapons:Damage Amount  index:11    from 30 To 999
        SetMemory(0x656EC8, Add, 80),# weapons:Damage Amount  index:12    from 70 To 150
        SetMemory(0x656ECC, Add, 7864320),# weapons:Damage Amount  index:15    from 20 To 140
        SetMemory(0x656ED4, Add, 334),# weapons:Damage Amount  index:18    from 16 To 350
        SetMemory(0x656ED8, Add, 752),# weapons:Damage Amount  index:20    from 25 To 777
        SetMemory(0x656ED8, Add, 26214400),# weapons:Damage Amount  index:21    from 50 To 450
        SetMemory(0x656EDC, Add, 200),# weapons:Damage Amount  index:22    from 50 To 250
        SetMemory(0x656EDC, Add, 47185920),# weapons:Damage Amount  index:23    from 30 To 750
        SetMemory(0x656EE4, Add, 34),# weapons:Damage Amount  index:26    from 16 To 50
        SetMemory(0x656EE4, Add, 58327040),# weapons:Damage Amount  index:27    from 70 To 960
        SetMemory(0x656EE8, Add, 650),# weapons:Damage Amount  index:28    from 150 To 800
        SetMemory(0x656EE8, Add, 1966080),# weapons:Damage Amount  index:29    from 20 To 50
        SetMemory(0x656EEC, Add, 59740),# weapons:Damage Amount  index:30    from 260 To 60000
        SetMemory(0x656EEC, Add, 550502400),# weapons:Damage Amount  index:31    from 600 To 9000
        SetMemory(0x656EF4, Add, 983040),# weapons:Damage Amount  index:35    from 5 To 20
        SetMemory(0x656EF8, Add, 20),# weapons:Damage Amount  index:36    from 10 To 30
        SetMemory(0x656EF8, Add, 6553600),# weapons:Damage Amount  index:37    from 50 To 150
        SetMemory(0x656EFC, Add, 2),# weapons:Damage Amount  index:38    from 10 To 12
        SetMemory(0x656EFC, Add, 65536),# weapons:Damage Amount  index:39    from 20 To 21
        SetMemory(0x656F00, Add, 30),# weapons:Damage Amount  index:40    from 20 To 50
        SetMemory(0x656F00, Add, 2949120),# weapons:Damage Amount  index:41    from 50 To 95
        SetMemory(0x656F04, Add, 6),# weapons:Damage Amount  index:42    from 4 To 10
        SetMemory(0x656F04, Add, 2949120),# weapons:Damage Amount  index:43    from 5 To 50
        SetMemory(0x656F0C, Add, 10),# weapons:Damage Amount  index:46    from 20 To 30
        SetMemory(0x656F0C, Add, 1966080),# weapons:Damage Amount  index:47    from 40 To 70
        SetMemory(0x656F10, Add, 11),# weapons:Damage Amount  index:48    from 9 To 20
        SetMemory(0x656F10, Add, 1179648),# weapons:Damage Amount  index:49    from 18 To 36
        SetMemory(0x656F14, Add, 117309440),# weapons:Damage Amount  index:51    from 10 To 1800
        SetMemory(0x656F18, Add, 2293760),# weapons:Damage Amount  index:53    from 40 To 75
        SetMemory(0x656F2C, Add, 328),# weapons:Damage Amount  index:62    from 5 To 333
        SetMemory(0x656F30, Add, 172),# weapons:Damage Amount  index:64    from 8 To 180
        SetMemory(0x656F30, Add, 44564480),# weapons:Damage Amount  index:65    from 20 To 700
        SetMemory(0x656F34, Add, 330),# weapons:Damage Amount  index:66    from 20 To 350
        SetMemory(0x656F34, Add, 52756480),# weapons:Damage Amount  index:67    from 45 To 850
        SetMemory(0x656F38, Add, 445),# weapons:Damage Amount  index:68    from 5 To 450
        SetMemory(0x656F38, Add, 90439680),# weapons:Damage Amount  index:69    from 20 To 1400
        SetMemory(0x656F3C, Add, 870),# weapons:Damage Amount  index:70    from 30 To 900
        SetMemory(0x656F3C, Add, 40632320),# weapons:Damage Amount  index:71    from 60 To 680
        SetMemory(0x656F40, Add, 106),# weapons:Damage Amount  index:72    from 4 To 110
        SetMemory(0x656F44, Add, 156),# weapons:Damage Amount  index:74    from 14 To 170
        SetMemory(0x656F44, Add, 28180480),# weapons:Damage Amount  index:75    from 20 To 450
        SetMemory(0x656F48, Add, 14417920),# weapons:Damage Amount  index:77    from 10 To 230
        SetMemory(0x656F4C, Add, 880),# weapons:Damage Amount  index:78    from 20 To 900
        SetMemory(0x656F50, Add, 180),# weapons:Damage Amount  index:80    from 20 To 200
        SetMemory(0x656F58, Add, 256),# weapons:Damage Amount  index:84    from 14 To 270
        SetMemory(0x656F58, Add, 42598400),# weapons:Damage Amount  index:85    from 100 To 750
        SetMemory(0x656F5C, Add, 288),# weapons:Damage Amount  index:86    from 45 To 333
        SetMemory(0x656F5C, Add, 11337728),# weapons:Damage Amount  index:87    from 7 To 180
        SetMemory(0x656F60, Add, 193),# weapons:Damage Amount  index:88    from 7 To 200
        SetMemory(0x656F60, Add, 10027008),# weapons:Damage Amount  index:89    from 7 To 160
        SetMemory(0x656F64, Add, 268),# weapons:Damage Amount  index:90    from 7 To 275
        SetMemory(0x656F64, Add, 4784128),# weapons:Damage Amount  index:91    from 7 To 80
        SetMemory(0x656F6C, Add, 196),# weapons:Damage Amount  index:94    from 4 To 200
        SetMemory(0x656F6C, Add, 327680),# weapons:Damage Amount  index:95    from 30 To 35
        SetMemory(0x656F74, Add, 2621440),# weapons:Damage Amount  index:99    from 10 To 50
        SetMemory(0x656F78, Add, 55),# weapons:Damage Amount  index:100    from 5 To 60
        SetMemory(0x656F80, Add, 135),# weapons:Damage Amount  index:104    from 25 To 160
        SetMemory(0x656F8C, Add, 26476544),# weapons:Damage Amount  index:111    from 40 To 444
        SetMemory(0x656F94, Add, 630),# weapons:Damage Amount  index:114    from 20 To 650
        SetMemory(0x656F98, Add, 220),# weapons:Damage Amount  index:116    from 30 To 250
        SetMemory(0x656FA0, Add, 196214784),# weapons:Damage Amount  index:121    from 6 To 3000
        SetMemory(0x656FA4, Add, 20),# weapons:Damage Amount  index:122    from 6 To 26
        SetMemory(0x656FA4, Add, 1245184),# weapons:Damage Amount  index:123    from 6 To 25
        SetMemory(0x656FA8, Add, 660),# weapons:Damage Amount  index:124    from 6 To 666
        SetMemory(0x656FA8, Add, 2621046784),# weapons:Damage Amount  index:125    from 6 To 40000
        SetMemory(0x656FAC, Add, 344),# weapons:Damage Amount  index:126    from 6 To 350
        SetMemory(0x656FAC, Add, -393216),# weapons:Damage Amount  index:127    from 6 To 0
        SetMemory(0x656FB0, Add, -393216),# weapons:Damage Amount  index:129    from 6 To 0
        SetMemory(0x657678, Add, 0),# weapons:Damage Bonus  index:0    from 1 To 1
        SetMemory(0x657678, Add, 131072),# weapons:Damage Bonus  index:1    from 1 To 3
        SetMemory(0x657680, Add, -2),# weapons:Damage Bonus  index:4    from 2 To 0
        SetMemory(0x657680, Add, -131072),# weapons:Damage Bonus  index:5    from 2 To 0
        SetMemory(0x657688, Add, -2),# weapons:Damage Bonus  index:8    from 2 To 0
        SetMemory(0x657688, Add, -65536),# weapons:Damage Bonus  index:9    from 1 To 0
        SetMemory(0x65768C, Add, -196608),# weapons:Damage Bonus  index:11    from 3 To 0
        SetMemory(0x657690, Add, -3),# weapons:Damage Bonus  index:12    from 3 To 0
        SetMemory(0x657694, Add, -131072),# weapons:Damage Bonus  index:15    from 2 To 0
        SetMemory(0x6576A0, Add, -3),# weapons:Damage Bonus  index:20    from 3 To 0
        SetMemory(0x6576A0, Add, -196608),# weapons:Damage Bonus  index:21    from 3 To 0
        SetMemory(0x6576A4, Add, -3),# weapons:Damage Bonus  index:22    from 3 To 0
        SetMemory(0x6576A4, Add, -196608),# weapons:Damage Bonus  index:23    from 3 To 0
        SetMemory(0x6576AC, Add, -1),# weapons:Damage Bonus  index:26    from 1 To 0
        SetMemory(0x6576AC, Add, -327680),# weapons:Damage Bonus  index:27    from 5 To 0
        SetMemory(0x6576B0, Add, -5),# weapons:Damage Bonus  index:28    from 5 To 0
        SetMemory(0x6576B0, Add, 1638400),# weapons:Damage Bonus  index:29    from 0 To 25
        SetMemory(0x6576C0, Add, -65536),# weapons:Damage Bonus  index:37    from 1 To 0
        SetMemory(0x6576DC, Add, -65536),# weapons:Damage Bonus  index:51    from 1 To 0
        SetMemory(0x6576F8, Add, -1),# weapons:Damage Bonus  index:64    from 1 To 0
        SetMemory(0x6576F8, Add, -65536),# weapons:Damage Bonus  index:65    from 1 To 0
        SetMemory(0x6576FC, Add, -2),# weapons:Damage Bonus  index:66    from 2 To 0
        SetMemory(0x6576FC, Add, -131072),# weapons:Damage Bonus  index:67    from 2 To 0
        SetMemory(0x657700, Add, -1),# weapons:Damage Bonus  index:68    from 1 To 0
        SetMemory(0x657700, Add, -65536),# weapons:Damage Bonus  index:69    from 1 To 0
        SetMemory(0x657704, Add, -3),# weapons:Damage Bonus  index:70    from 3 To 0
        SetMemory(0x657704, Add, -196608),# weapons:Damage Bonus  index:71    from 3 To 0
        SetMemory(0x65770C, Add, -1),# weapons:Damage Bonus  index:74    from 1 To 0
        SetMemory(0x65770C, Add, -65536),# weapons:Damage Bonus  index:75    from 1 To 0
        SetMemory(0x657710, Add, -65536),# weapons:Damage Bonus  index:77    from 1 To 0
        SetMemory(0x657714, Add, -1),# weapons:Damage Bonus  index:78    from 1 To 0
        SetMemory(0x657720, Add, -1),# weapons:Damage Bonus  index:84    from 1 To 0
        SetMemory(0x657720, Add, -65536),# weapons:Damage Bonus  index:85    from 1 To 0
        SetMemory(0x657724, Add, -1),# weapons:Damage Bonus  index:86    from 1 To 0
        SetMemory(0x657724, Add, -65536),# weapons:Damage Bonus  index:87    from 1 To 0
        SetMemory(0x657728, Add, -1),# weapons:Damage Bonus  index:88    from 1 To 0
        SetMemory(0x657728, Add, -65536),# weapons:Damage Bonus  index:89    from 1 To 0
        SetMemory(0x65772C, Add, -1),# weapons:Damage Bonus  index:90    from 1 To 0
        SetMemory(0x65772C, Add, -65536),# weapons:Damage Bonus  index:91    from 1 To 0
        SetMemory(0x657734, Add, -1),# weapons:Damage Bonus  index:94    from 1 To 0
        SetMemory(0x657734, Add, -65536),# weapons:Damage Bonus  index:95    from 1 To 0
        SetMemory(0x65773C, Add, 589824),# weapons:Damage Bonus  index:99    from 1 To 10
        SetMemory(0x657740, Add, -1),# weapons:Damage Bonus  index:100    from 1 To 0
        SetMemory(0x657754, Add, -196608),# weapons:Damage Bonus  index:111    from 3 To 0
        SetMemory(0x65775C, Add, -1),# weapons:Damage Bonus  index:114    from 1 To 0
        SetMemory(0x657760, Add, -1),# weapons:Damage Bonus  index:116    from 1 To 0
        SetMemory(0x65776C, Add, -1),# weapons:Damage Bonus  index:122    from 1 To 0
        SetMemory(0x65776C, Add, 196608),# weapons:Damage Bonus  index:123    from 1 To 4
        SetMemory(0x657770, Add, -1),# weapons:Damage Bonus  index:124    from 1 To 0
        SetMemory(0x657770, Add, -65536),# weapons:Damage Bonus  index:125    from 1 To 0
        SetMemory(0x657774, Add, -1),# weapons:Damage Bonus  index:126    from 1 To 0
        SetMemory(0x657774, Add, -65536),# weapons:Damage Bonus  index:127    from 1 To 0
        SetMemory(0x657778, Add, -65536),# weapons:Damage Bonus  index:129    from 1 To 0
        SetMemory(0x656FC0, Add, -21),# weapons:Weapon Cooldown  index:8    from 22 To 1
        SetMemory(0x656FC0, Add, -5376),# weapons:Weapon Cooldown  index:9    from 22 To 1
        SetMemory(0x656FC0, Add, -603979776),# weapons:Weapon Cooldown  index:11    from 37 To 1
        SetMemory(0x656FC4, Add, 29),# weapons:Weapon Cooldown  index:12    from 37 To 66
        SetMemory(0x656FC4, Add, -83886080),# weapons:Weapon Cooldown  index:15    from 22 To 17
        SetMemory(0x656FCC, Add, -117440512),# weapons:Weapon Cooldown  index:23    from 22 To 15
        SetMemory(0x656FD4, Add, -917504),# weapons:Weapon Cooldown  index:30    from 15 To 1
        SetMemory(0x656FF4, Add, -458752),# weapons:Weapon Cooldown  index:62    from 22 To 15
        SetMemory(0x65700C, Add, -1900544),# weapons:Weapon Cooldown  index:86    from 30 To 1
        SetMemory(0x65700C, Add, -83886080),# weapons:Weapon Cooldown  index:87    from 22 To 17
        SetMemory(0x657014, Add, 268435456),# weapons:Weapon Cooldown  index:95    from 22 To 38
        SetMemory(0x657018, Add, -117440512),# weapons:Weapon Cooldown  index:99    from 22 To 15
        SetMemory(0x657030, Add, 5120),# weapons:Weapon Cooldown  index:121    from 15 To 35
        SetMemory(0x657034, Add, -14),# weapons:Weapon Cooldown  index:124    from 15 To 1
        SetMemory(0x6564E0, Add, 1),# weapons:Damage Factor  index:0    from 1 To 2
        SetMemory(0x656528, Add, -65536),# weapons:Damage Factor  index:74    from 2 To 1
        SetMemory(0x6569EC, Add, -536870912),# weapons:Attack Angle  index:95    from 64 To 32
        SetMemory(0x656A08, Add, 4009754624),# weapons:Attack Angle  index:123    from 16 To 255
        SetMemory(0x657900, Add, 0),# weapons:Launch Spin  index:123    from 0 To 0
        SetMemory(0x657904, Add, 32768),# weapons:Launch Spin  index:125    from 0 To 128
        SetMemory(0x657988, Add, 0),# weapons:Forward Offset  index:123    from 0 To 0
        SetMemory(0x656C28, Add, 0),# weapons:Upward Offset  index:8    from 0 To 0
        SetMemory(0x6567FC, Add, 5),# weapons:Icon  index:62    from 351 To 356
        SetMemory(0x65682C, Add, -8323072),# weapons:Icon  index:87    from 363 To 236
        SetMemory(0x656830, Add, 214),# weapons:Icon  index:88    from 0 To 214
        SetMemory(0x656834, Add, 173),# weapons:Icon  index:90    from 0 To 173
        SetMemory(0x656870, Add, -786432),# weapons:Icon  index:121    from 323 To 311
        SetMemory(0x656878, Add, 32),# weapons:Icon  index:124    from 323 To 355
        SetMemory(0x656878, Add, -5701632),# weapons:Icon  index:125    from 323 To 236
        SetMemory(0x6CA3EC, Add, 18),# flingy:Sprite  index:106    from 249 To 267
        SetMemory(0x6CA480, Add, 0),# flingy:Sprite  index:181    from 305 To 305
        SetMemory(0x6C9F2C, Add, -907),# flingy:Speed  index:13    from 1707 To 800
        SetMemory(0x6CA10C, Add, 1),# flingy:Speed  index:133    from 0 To 1
        SetMemory(0x6CA180, Add, 8135),# flingy:Speed  index:162    from 8533 To 16668
        SetMemory(0x6CA19C, Add, 2400),# flingy:Speed  index:169    from 0 To 2400
        SetMemory(0x6CA1B0, Add, 1707),# flingy:Speed  index:174    from 0 To 1707
        SetMemory(0x6CA1BC, Add, 1),# flingy:Speed  index:177    from 0 To 1
        SetMemory(0x6CA1CC, Add, 1680),# flingy:Speed  index:181    from 0 To 1680
        SetMemory(0x6CA1D0, Add, 3200),# flingy:Speed  index:182    from 0 To 3200
        SetMemory(0x6CA1D4, Add, 2400),# flingy:Speed  index:183    from 0 To 2400
        SetMemory(0x6CA234, Add, 853),# flingy:Speed  index:207    from 0 To 853
        SetMemory(0x6C9CD0, Add, 1116),# flingy:Acceleration  index:44    from 17 To 1133
        SetMemory(0x6C9D08, Add, 1383),# flingy:Acceleration  index:72    from 17 To 1400
        SetMemory(0x6C9D80, Add, 65536),# flingy:Acceleration  index:133    from 0 To 1
        SetMemory(0x6C9DBC, Add, 7333),# flingy:Acceleration  index:162    from 667 To 8000
        SetMemory(0x6C9DC8, Add, 78643200),# flingy:Acceleration  index:169    from 0 To 1200
        SetMemory(0x6C9DD4, Add, 1707),# flingy:Acceleration  index:174    from 0 To 1707
        SetMemory(0x6C9DD8, Add, 65536),# flingy:Acceleration  index:177    from 0 To 1
        SetMemory(0x6C9DE0, Add, 3145728),# flingy:Acceleration  index:181    from 0 To 48
        SetMemory(0x6C9DE4, Add, 128),# flingy:Acceleration  index:182    from 0 To 128
        SetMemory(0x6C9DE4, Add, 78643200),# flingy:Acceleration  index:183    from 0 To 1200
        SetMemory(0x6C9E14, Add, 1769472),# flingy:Acceleration  index:207    from 0 To 27
        SetMemory(0x6C99E0, Add, -37756),# flingy:Halt Distance  index:44    from 37756 To 0
        SetMemory(0x6C9A50, Add, -37756),# flingy:Halt Distance  index:72    from 37756 To 0
        SetMemory(0x6C9B44, Add, 1),# flingy:Halt Distance  index:133    from 0 To 1
        SetMemory(0x6C9BE8, Add, 0),# flingy:Halt Distance  index:174    from 0 To 0
        SetMemory(0x6C9C04, Add, 17067),# flingy:Halt Distance  index:181    from 0 To 17067
        SetMemory(0x6C9C08, Add, 17067),# flingy:Halt Distance  index:182    from 0 To 17067
        SetMemory(0x6C9C0C, Add, 3412),# flingy:Halt Distance  index:183    from 0 To 3412
        SetMemory(0x6C9C6C, Add, 13474),# flingy:Halt Distance  index:207    from 0 To 13474
        SetMemory(0x6C9E68, Add, 107),# flingy:Turn Radius  index:72    from 20 To 127
        SetMemory(0x6C9EA4, Add, 32512),# flingy:Turn Radius  index:133    from 0 To 127
        SetMemory(0x6C9EC0, Add, 5701632),# flingy:Turn Radius  index:162    from 40 To 127
        SetMemory(0x6C9EC8, Add, 32512),# flingy:Turn Radius  index:169    from 0 To 127
        SetMemory(0x6C9ECC, Add, 8323072),# flingy:Turn Radius  index:174    from 0 To 127
        SetMemory(0x6C9ED0, Add, 20480),# flingy:Turn Radius  index:177    from 0 To 80
        SetMemory(0x6C9ED4, Add, 17920),# flingy:Turn Radius  index:181    from 0 To 70
        SetMemory(0x6C9ED4, Add, 4587520),# flingy:Turn Radius  index:182    from 0 To 70
        SetMemory(0x6C9ED4, Add, 2130706432),# flingy:Turn Radius  index:183    from 0 To 127
        SetMemory(0x6C9EEC, Add, 335544320),# flingy:Turn Radius  index:207    from 0 To 20
        SetMemory(0x6C98DC, Add, -512),# flingy:Movement Control  index:133    from 2 To 0
        SetMemory(0x6C9900, Add, -512),# flingy:Movement Control  index:169    from 2 To 0
        SetMemory(0x6C9904, Add, -512),# flingy:Movement Control  index:173    from 2 To 0
        SetMemory(0x6C9904, Add, -131072),# flingy:Movement Control  index:174    from 2 To 0
        SetMemory(0x6C9908, Add, -512),# flingy:Movement Control  index:177    from 2 To 0
        SetMemory(0x6C990C, Add, -512),# flingy:Movement Control  index:181    from 2 To 0
        SetMemory(0x6C990C, Add, -131072),# flingy:Movement Control  index:182    from 2 To 0
        SetMemory(0x6C990C, Add, -33554432),# flingy:Movement Control  index:183    from 2 To 0
        SetMemory(0x6C9924, Add, -33554432),# flingy:Movement Control  index:207    from 2 To 0
        SetMemory(0x6663AC, Add, -189),# sprites:Image File  index:294    from 399 To 210
        SetMemory(0x6663C0, Add, 12910592),# sprites:Image File  index:305    from 739 To 936
        SetMemory(0x6663C4, Add, 15335424),# sprites:Image File  index:307    from 741 To 975
        SetMemory(0x666458, Add, -24444928),# sprites:Image File  index:381    from 742 To 369
        SetMemory(0x66645C, Add, -210),# sprites:Image File  index:382    from 743 To 533
        SetMemory(0x665E48, Add, 0),# sprites:Is Visible  index:515    from 1 To 1
        SetMemory(0x66C50C, Add, -65536),# images:Clickable  index:958    from 1 To 0
        SetMemory(0x669E9C, Add, -512),# images:Draw Function  index:117    from 10 To 8
        SetMemory(0x669EBC, Add, 1792),# images:Draw Function  index:149    from 10 To 17
        SetMemory(0x669EF8, Add, 524288),# images:Draw Function  index:210    from 0 To 8
        SetMemory(0x669FB4, Add, 655360),# images:Draw Function  index:398    from 0 To 10
        SetMemory(0x66A020, Add, 285212672),# images:Draw Function  index:507    from 0 To 17
        SetMemory(0x66A034, Add, 268435456),# images:Draw Function  index:527    from 0 To 16
        SetMemory(0x66A03C, Add, 2048),# images:Draw Function  index:533    from 9 To 17
        SetMemory(0x66A044, Add, 2560),# images:Draw Function  index:541    from 0 To 10
        SetMemory(0x66A1C4, Add, 2560),# images:Draw Function  index:925    from 0 To 10
        SetMemory(0x66A1FC, Add, 458752),# images:Draw Function  index:982    from 9 To 16
        SetMemory(0x66A1FC, Add, 117440512),# images:Draw Function  index:983    from 9 To 16
        SetMemory(0x66A200, Add, 7),# images:Draw Function  index:984    from 9 To 16
        SetMemory(0x66EC48, Add, 155),# images:Iscript ID  index:0    from 0 To 155
        SetMemory(0x66EE20, Add, 4),# images:Iscript ID  index:118    from 157 To 161
        SetMemory(0x66EF90, Add, 49),# images:Iscript ID  index:210    from 193 To 242
        SetMemory(0x66EFC4, Add, 14),# images:Iscript ID  index:223    from 68 To 82
        SetMemory(0x66F140, Add, 113),# images:Iscript ID  index:318    from 133 To 246
        SetMemory(0x66F20C, Add, 86),# images:Iscript ID  index:369    from 309 To 395
        SetMemory(0x66F45C, Add, -63),# images:Iscript ID  index:517    from 298 To 235
        SetMemory(0x66F4BC, Add, 148),# images:Iscript ID  index:541    from 247 To 395
        SetMemory(0x66F578, Add, -244),# images:Iscript ID  index:588    from 335 To 91
        SetMemory(0x66FABC, Add, 0),# images:Iscript ID  index:925    from 365 To 365
        SetMemory(0x66FAF4, Add, -280),# images:Iscript ID  index:939    from 362 To 82
        SetMemory(0x66FB40, Add, -88),# images:Iscript ID  index:958    from 219 To 131
        SetMemory(0x66FB84, Add, -155),# images:Iscript ID  index:975    from 390 To 235
        SetMemory(0x655740, Add, -100),# upgrades:Mineral Cost Base  index:0    from 100 To 0
        SetMemory(0x65574C, Add, -6553600),# upgrades:Mineral Cost Base  index:7    from 100 To 0
        SetMemory(0x6559C0, Add, -60),# upgrades:Mineral Cost Factor  index:0    from 75 To 15
        SetMemory(0x6559CC, Add, -4259840),# upgrades:Mineral Cost Factor  index:7    from 75 To 10
        SetMemory(0x655840, Add, -100),# upgrades:Vespene Cost Base  index:0    from 100 To 0
        SetMemory(0x65584C, Add, -6553600),# upgrades:Vespene Cost Base  index:7    from 100 To 0
        SetMemory(0x6557C0, Add, -75),# upgrades:Vespene Cost Factor  index:0    from 75 To 0
        SetMemory(0x6557CC, Add, -4915200),# upgrades:Vespene Cost Factor  index:7    from 75 To 0
        SetMemory(0x655B80, Add, -4000),# upgrades:Research Time Base  index:0    from 4000 To 0
        SetMemory(0x655B8C, Add, -262144000),# upgrades:Research Time Base  index:7    from 4000 To 0
        SetMemory(0x655940, Add, -480),# upgrades:Research Time Factor  index:0    from 480 To 0
        SetMemory(0x65594C, Add, -31457280),# upgrades:Research Time Factor  index:7    from 480 To 0
        SetMemory(0x655700, Add, 247),# upgrades:Max. Repeats  index:0    from 3 To 250
        SetMemory(0x655704, Add, 4143972352),# upgrades:Max. Repeats  index:7    from 3 To 250
        SetMemory(0x65639C, Add, 0),# techdata:Energy Required  index:14    from 200 To 200
    ])

