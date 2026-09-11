"""Wave-function-collapse over the learned ISOM tuple set.

Variables are the 'sides' of the ISOM cell grid:
    V[iy][ix]  vertical   sides, ix in 0..iw   (cell.left = V[iy][ix], cell.right = V[iy][ix+1])
    H[iy][ix]  horizontal sides, iy in 0..ih   (cell.top  = H[iy][ix], cell.bottom = H[iy+1][ix])
Each cell (ix,iy) constrains (left, top, right, bottom) to be a tuple observed in real
maps for that cell's (ix+iy) parity.
"""
import sys, os, random, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


class TupleSet:
    """Indexed set of valid 4-tuples for one parity, with bitmask lookups."""

    def __init__(self, tuples, weights=None):
        self.tuples = list(tuples)
        self.n = len(self.tuples)
        self.weight = [1] * self.n
        if weights:
            for i, t in enumerate(self.tuples):
                self.weight[i] = weights.get(t, 1)
        self.pos_val_mask = [collections.defaultdict(int) for _ in range(4)]
        self.values = [set() for _ in range(4)]
        for i, t in enumerate(self.tuples):
            for p in range(4):
                self.pos_val_mask[p][t[p]] |= (1 << i)
                self.values[p].add(t[p])
        self.all_mask = (1 << self.n) - 1

    def mask_for(self, pos, domain):
        m = 0
        pv = self.pos_val_mask[pos]
        for v in domain:
            m |= pv.get(v, 0)
        return m

    def project(self, pos, mask):
        out = set()
        pv = self.pos_val_mask[pos]
        for v, m in pv.items():
            if m & mask:
                out.add(v)
        return out


class Field:
    def __init__(self, iw, ih, tset):
        self.fail_cell = None
        self.restrict = {}      # {(ix,iy): tuple bitmask} extra per-cell limits
        self.iw, self.ih = iw, ih
        self.tset = tset            # {parity: TupleSet}
        allvals = set()
        for ts in tset.values():
            for p in range(4):
                allvals |= ts.values[p]
        self.allvals = allvals
        self.V = [[set(allvals) for _ in range(iw + 1)] for _ in range(ih)]
        self.H = [[set(allvals) for _ in range(iw)] for _ in range(ih + 1)]

    # --- variable access -------------------------------------------------
    def cell_vars(self, ix, iy):
        return (("V", iy, ix), ("H", iy, ix), ("V", iy, ix + 1), ("H", iy + 1, ix))

    def dom(self, var):
        k, a, b = var
        return self.V[a][b] if k == "V" else self.H[a][b]

    def setdom(self, var, d):
        k, a, b = var
        if k == "V":
            self.V[a][b] = d
        else:
            self.H[a][b] = d

    def cells_of(self, var):
        k, a, b = var
        out = []
        if k == "V":            # V[a][b] is left of cell (b,a) and right of cell (b-1,a)
            if b < self.iw:
                out.append((b, a))
            if b - 1 >= 0:
                out.append((b - 1, a))
        else:                   # H[a][b] is top of cell (b,a) and bottom of cell (b,a-1)
            if a < self.ih:
                out.append((b, a))
            if a - 1 >= 0:
                out.append((b, a - 1))
        return out

    # --- propagation -----------------------------------------------------
    def revise_cell(self, ix, iy, queue):
        ts = self.tset[(ix + iy) % 2]
        vs = self.cell_vars(ix, iy)
        masks = []
        for p in range(4):
            masks.append(ts.mask_for(p, self.dom(vs[p])))
        allowed = masks[0] & masks[1] & masks[2] & masks[3]
        r = self.restrict.get((ix, iy))
        if r is not None:
            allowed &= r
        if allowed == 0:
            return False
        for p in range(4):
            proj = ts.project(p, allowed)
            cur = self.dom(vs[p])
            if not proj:
                return False
            if len(proj) < len(cur):
                self.setdom(vs[p], proj)
                for c in self.cells_of(vs[p]):
                    if c != (ix, iy):
                        queue.append(c)
        return True

    def propagate(self, seeds=None):
        q = collections.deque()
        if seeds is None:
            for iy in range(self.ih):
                for ix in range(self.iw):
                    q.append((ix, iy))
        else:
            q.extend(seeds)
        inq = set(q)
        while q:
            ix, iy = q.popleft()
            inq.discard((ix, iy))
            nq = []
            if not self.revise_cell(ix, iy, nq):
                self.fail_cell = (ix, iy)
                return False
            for c in nq:
                if c not in inq:
                    inq.add(c)
                    q.append(c)
        return True

    # --- pinning / solving ----------------------------------------------
    def pin(self, var, value):
        self.setdom(var, {value})

    def entropy_var(self):
        best = None
        bestn = 1 << 30
        for iy in range(self.ih):
            row = self.V[iy]
            for ix in range(self.iw + 1):
                n = len(row[ix])
                if 1 < n < bestn:
                    bestn = n
                    best = ("V", iy, ix)
        for iy in range(self.ih + 1):
            row = self.H[iy]
            for ix in range(self.iw):
                n = len(row[ix])
                if 1 < n < bestn:
                    bestn = n
                    best = ("H", iy, ix)
        return best

    def snapshot(self):
        return ([[set(s) for s in row] for row in self.V],
                [[set(s) for s in row] for row in self.H])

    def restore(self, snap):
        self.V, self.H = snap

    def solve(self, rng, weights=None, max_restarts=40, log=None):
        if not self.propagate():
            return False
        for attempt in range(max_restarts):
            snap = self.snapshot()
            ok = True
            steps = 0
            while True:
                var = self.entropy_var()
                if var is None:
                    break
                d = sorted(self.dom(var))
                if weights:
                    w = [weights.get(v, 1) for v in d]
                    val = rng.choices(d, weights=w, k=1)[0]
                else:
                    val = rng.choice(d)
                self.setdom(var, {val})
                seeds = self.cells_of(var)
                if not self.propagate(seeds):
                    ok = False
                    break
                steps += 1
                if log and steps % 500 == 0:
                    log("  collapse step %d" % steps)
            if ok:
                return True
            self.restore(snap)
            if log:
                log("  restart %d" % (attempt + 1))
        return False

    def result(self):
        V = [[next(iter(s)) if len(s) == 1 else 0 for s in row] for row in self.V]
        H = [[next(iter(s)) if len(s) == 1 else 0 for s in row] for row in self.H]
        return V, H
