Problem Statement
    
Vasa is a shopkeeper in the small town Deronje. Currently, there are some items for sale in his store. The price of each item is a positive integer. You are given these prices in the tuple (integer) A. Each item has a price tag.
Vasa has just learned that a very rich shopper is going to visit his store. Therefore, Vasa wants to alter some of the price tags to make the items in his store more expensive.
Vasa has a collection of stickers. Each of those stickers contains a single digit between 1 and 9, inclusive. Note that he has no stickers with zeros. You are given the description of Vasa's stickers in the tuple (integer) D. For each i between 1 and 9, inclusive, Vasa has D[i-1] stickers with the digit i.
Vasa can take any sticker and use it to replace any digit on any price tag. However, there is no extra room on the price tags, so he cannot add new digits, he can only replace existing ones.
Compute and return the maximum total cost of items in Vasa's store after he applies some (possibly none, possibly all) of his stickers to the current price tags.
Definition
    
Class:
ReplacingDigit
Method:
getMaximumStockWorth
Parameters:
tuple (integer), tuple (integer)
Returns:
integer
Method signature:
def getMaximumStockWorth(self, A, D):

Limits
    
Time limit (s):
2.000
Memory limit (MB):
256
Stack limit (MB):
256
Constraints
-
A will contain between 1 and 50 elements, inclusive.
-
Each element of A will be between 1 and 10^6, inclusive.
-
D will contain exactly 9 elements.
-
Each element of D will be between 0 and 10^3, inclusive.
Examples
0)

    
{100, 90}
{0, 0, 0, 0, 2, 1, 0, 0, 0}
Returns: 745
Vasa has two digit stickers with digit 5 written on them, and one digit sticker with digit 6 written on it. There are two items in the shop: one with price 100, and the other one with price 90.
Vasa can use one digit sticker with 5 to replace digit 0 of price tag 90 obtaining a new price of 95 of that item. Then, he can use the remaining stickers 5 and 6 to change the price tag of the other item from 100 to 650. In that case, the worth of his stock would be 650 + 95 = 745.
Note that the same stock worth could be obtained by applying all the three digit stickers to 100 in order to obtain a new price of 655. In that case, the price 90 of the other item would remain unchanged.
1)

    
{9}
{1, 1, 1, 1, 1, 1, 1, 1, 0}
Returns: 9
In this example, the maximum stock worth is obtained by leaving the price tag unchanged. Note that Vasa is not required to use all stickers.
2)

    
{123456}
{9, 8, 7, 6, 5, 4, 3, 2, 1}
Returns: 988777

3)

    
{10, 970019, 1976, 10936, 68750, 756309, 37600, 559601, 6750, 76091, 640, 312, 312, 90, 8870}
{11, 2, 8, 10, 7, 6, 3, 1, 3}
Returns: 3297500

4)

    
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
{111, 111, 111, 111, 111, 111, 111, 111, 111}
Returns: 198

This problem statement is the exclusive and proprietary property of TopCoder, Inc. Any unauthorized use or reproduction of this information without the prior written consent of TopCoder, Inc. is strictly prohibited. (c)2003, TopCoder, Inc. All rights reserved.



class ReplacingDigit(object):
    def getMaximumStockWorth(self, A, D):
        dic  = {}
        queue = []
        for a in xrange(len(D)):
            if D[a] == 0:
                queue.append(0)
            else:
                for k in xrange(D[a]):
                    queue.append(a+1)
                    
        #put all the digit into a queue
        queue.sort()
        
        #dic manage all the digit according to their position
        for a in xrange(len(A)):
            t = A[a]
            cnt = 0
            while t>0:
                tmp  = t % 10
                if cnt in dic:
                    dic[cnt].append(tmp)
                else:
                    dic[cnt] = [tmp]
                t /= 10
                cnt+=1

        for a in xrange(len(dic)-1, -1, -1):
            dic[a].sort()
        for a in xrange(len(dic)-1, -1, -1):
            i = 0
            while i < len(dic[a]) and dic[a][i] < queue[-1] and queue:
                dic[a][i] = queue.pop()
                i+=1
            if not queue:
                break
        return self.getSum(dic)

    def getSum(self, s):
        sm = 0
        for a in xrange(len(s)-1, -1, -1):
            for b in xrange(len(s[a])):
                sm += s[a][b] * 10 ** a
        return sm
