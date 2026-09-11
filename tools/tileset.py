"""StarCraft tileset (CV5 / VF4 / VX4 / VR4 / WPE) reader."""
import struct, os

TILESET_NAMES = {0:"badlands",1:"platform",2:"install",3:"AshWorld",4:"Jungle",
                 5:"Desert",6:"Ice",7:"Twilight"}
DEFAULT_DIR = r"C:\Users\USER\Downloads\Release\Data\TileSet"

class CV5Group:
    __slots__=("index","buildability","ground_height","left","top","right","bottom",
               "u1","u2","u3","u4","megatiles")
    def __init__(self, b, o):
        (self.index, self.buildability, self.ground_height, self.left, self.top,
         self.right, self.bottom, self.u1, self.u2, self.u3, self.u4) = \
            struct.unpack_from("<HBBHHHHHHHH", b, o)
        self.megatiles = list(struct.unpack_from("<16H", b, o+20))

class Tileset:
    def __init__(self, era, dirpath=None):
        d = dirpath or DEFAULT_DIR
        nm = TILESET_NAMES[era]
        self.era = era; self.name = nm
        cv5 = open(os.path.join(d, nm + ".cv5"), "rb").read()
        self.groups = [CV5Group(cv5, i*52) for i in range(len(cv5)//52)]
        vf4 = open(os.path.join(d, nm + ".vf4"), "rb").read()
        self.vf4 = vf4                      # 32 bytes per megatile: 16 u16
        self.nmega = len(vf4)//32
    def megatile(self, tile):
        g, s = tile >> 4, tile & 0xF
        if g >= len(self.groups): return None
        return self.groups[g].megatiles[s]
    def minitile_flags(self, tile):
        mt = self.megatile(tile)
        if mt is None or mt >= self.nmega: return [0]*16
        return list(struct.unpack_from("<16H", self.vf4, mt*32))
    def height(self, tile):
        g = tile >> 4
        return self.groups[g].ground_height if g < len(self.groups) else 0
    def buildable(self, tile):
        g = tile >> 4
        return self.groups[g].buildability if g < len(self.groups) else 0

# vf4 minitile flag bits
WALKABLE   = 0x0001
MID_GROUND = 0x0002
HIGH_GROUND= 0x0004
BLOCKS_VIEW= 0x0008
RAMP       = 0x0010
