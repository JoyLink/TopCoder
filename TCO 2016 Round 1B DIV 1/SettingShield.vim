class SettingShield(object):

    def solve(self, p, t, n, protection, tolst):
        ans = p * t
        recode = [0 for i in xrange(100100)]
        
        #Treaky part is the var ccnt, when recode[i] is not 0, it means it is out of a range
        ccnt = p
        
        for i in xrange(n):
            ccnt -= recode[i]
            if ccnt < protection[i]:
                diff = protection[i] - ccnt
                ccnt += diff
                ans += diff
                recode[tolst[i]+1] += diff

        return ans
    def getOptimalCost(self, n, h, t, val0, a, b, m):
        protection = [0 for i in xrange(100100)]

        protection[0] = val0[0]
        for i in xrange(1, n):
            protection[i] = (a[0] * protection[i-1] + b[0]) % m[0]
        tolst = [-1 for i in xrange(100100)]
        cleft, cright = val0[1], val0[2]
        
        #tolst[i] denote the right most of range it cover from index i
        tolst[cleft] = max(tolst[cleft], cright)
        for i in xrange(1, h):
            nleft = min(n-1, (a[1] * cleft + b[1]) % m[1])
            dist = cright  - cleft
            nright = min(n-1, nleft  + (a[2] * dist + b[2]) % m[2])
            cleft, cright = nleft, nright
            tolst[cleft] = max(cright, tolst[cleft])

        for i in xrange(1, n):
            tolst[i] = max(tolst[i-1], tolst[i])
        lo = 0
        for  i in xrange(n):
            if tolst[i] < i:
                lo = max(lo, protection[i])
        hi = 1
        for i in xrange(n):
            hi = max(hi, protection[i])
            
        #it is a Parabola, so Ternary will be used to help find the mininum value
        while hi - lo > 5:
            mid = (hi + lo) / 2
            midmid = (mid + hi) / 2
            if self.solve(mid, t, n, protection, tolst) < self.solve(midmid, t, n, protection, tolst):
                hi = midmid
            else:
                lo = mid
        ans = 1e18
        i = lo

        while i <= hi:
            ans = min(ans, self.solve(i, t, n, protection, tolst))
            i += 1

        return ans

