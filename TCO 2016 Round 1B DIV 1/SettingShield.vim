Problem Statement
    
Vasa has carefully cultivated n plants. The plants are arranged into a line and they are conveniently numbered from 0 to n-1, inclusive, in the order in which they appear on the line.
Vasa needs to protect his plants from an incoming ice storm. In order to do that, he has installed some shields. There is exactly one special shield and there are h simple shields. The special shield covers all plants. Each simple shield covers some contiguous range of plants: simple shield number i covers plants with numbers from left[i] to right[i], inclusive.
The power of each shield can be set to any nonnegative integer value. Setting any single simple shield to power P costs P coins. Setting the special shield to power P costs (t * P) coins.
For each i, plant i will survive the storm if the total power of all shields that cover it is greater than or equal to protection[i].
You are given the integers n, h, and t. You are also given tuple (integer)s val0, a, b, and m. Below we give pseudocode that uses these to generate the tuple (integer)s protection, left, and right.
Vasa wants to make sure that all his plants survive the storm. Find and return the smallest possible total cost of doing so.
Pseudocode to generate protection, left, and right follows. Watch out for integer overflow.
protection[0] = val0[0]
for i = 1 .. n-1
  protection[i] = (a[0] * protection[i-1] + b[0]) mod m[0]

left[0] = val0[1]
right[0] = val0[2]
for i = 1 .. h-1
  left[i] = min(n-1, (a[1] * left[i-1] + b[1]) mod m[1])
  dist = right[i-1] - left[i-1]
  right[i] = min(n-1, left[i] + (a[2] * dist + b[2]) mod m[2])
Definition
    
Class:
SettingShield
Method:
getOptimalCost
Parameters:
integer, integer, integer, tuple (integer), tuple (integer), tuple (integer), tuple (integer)
Returns:
long integer
Method signature:
def getOptimalCost(self, n, h, t, val0, a, b, m):

Limits
    
Time limit (s):
2.000
Memory limit (MB):
256
Stack limit (MB):
256
Notes
-
The intended solution should work within the given time limit for arbitrary tuple (integer)s protection, left, and right that satisfy the constraints. It does not depend on any special properties of the pseudorandom generator.
Constraints
-
n, h, and t will be between 1 and 10^5, inclusive.
-
val0, a, b, and m each will contain exactly 3 elements.
-
val0[0], and each element of a, and b will be between 0 and 10^7, inclusive.
-
Each element of m will be between 1 and 10^7, inclusive.
-
val0[1] will be between 0 and n-1, inclusive.
-
val0[2] will be between val0[1] and n-1, inclusive.
Examples
0)

    
3
3
10
{4, 0, 1}
{1, 1, 1}
{3, 1, 1}
{6, 10, 10}
Returns: 8
Using the pseudocode we obtain protection = {4, 1, 4}, left = {0, 1, 2}, and right = {1, 2, 2}. Thus, we have one special shield and three simple shields. Simple shield 0 covers the range [0,1], simple shield 1 covers the range [1,2], and simple shield 2 covers the range [2,2].
One optimal solution is to set each of simple shields 0 and 2 to power 4. The special shield and simple shield 1 will remain untouched, with power 0. The total cost of this solution is 4 + 4 = 8.
Another optimal solution is to set the three simple shields to power 4, 1, and 3, respectively.
1)

    
3
1
10
{4, 0, 1}
{1, 1, 1}
{3, 1, 1}
{6, 10, 10}
Returns: 40
The only difference from Example 0 is that now we only have a single simple shield. This shield does not cover plant 2. Hence, we need to set the special shield at least to power 4 to give this plant enough protection. On the other hand, setting the special shield to 4 is clearly enough to protect all three plants. Thus, the optimal cost is 10*4 = 40.
2)

    
6
3
2
{4, 1, 3}
{2, 4, 3}
{3, 2, 2}
{20, 9, 4}
Returns: 22
In this example we have protection = {4, 11, 5, 13, 9, 1}, left = {1, 5, 4}, and right = {3, 5, 5}. An optimal solution: set the special shield to 4, and set the simple shields to 9, 0, and 5, respectively. The total cost of this solution is 4*2 + 9 + 0 + 5 = 22.
3)

    
12
6
4
{4, 3, 7}
{2, 4, 5}
{3, 8, 7}
{40, 23, 13}
Returns: 108

4)

    
50
77
4
{4, 11, 30}
{9, 40, 7}
{33, 8, 12}
{20000, 200, 13}
Returns: 79111

5)

    
555
120
4
{10000000, 301, 520}
{9999999, 9999998, 9999997}
{9995999, 0, 9919999}
{1999999, 9993999, 9299999}
Returns: 40000000
Watch out for integer overflow.
6)

    
501
2
2
{10000000, 500, 500}
{10000000, 10000000, 10000000}
{0, 0, 500}
{1000003, 10000000, 10000000}
Returns: 10000000
There are two simple shields, with left = {500, 0} and right = {500, 500}. Simple shield 0 protects just the plant number 500. Simple shield 1 protects all 501 plants, exactly like the special shield. However, using simple shield 1 is cheaper than using the special shield, so you should do that in the optimal solution.
This problem statement is the exclusive and proprietary property of TopCoder, Inc. Any unauthorized use or reproduction of this information without the prior written consent of TopCoder, Inc. is strictly prohibited. (c)2003, TopCoder, Inc. All rights reserved.



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

