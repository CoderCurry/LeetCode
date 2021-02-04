//
//  LeetCodeTopViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/20.
//

#import "LeetCodeTopViewController.h"
#import "ListNode.h"
#import "TreeNode.h"
#import "LRUCache.h"

#pragma - LRUObj


@interface LeetCodeTopViewController ()

@end

@implementation LeetCodeTopViewController

#pragma mark - 题目
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configRowTitles:@[
        @"200.岛屿数量(中等)",
        @"463.岛屿的周长(简单)",
        @"695.岛屿的最大面积(中等)",
        
        @"53.最大子序和(简单)",
        @"25.K个一组翻转链表(困难)",
        @"5.最长回文子串(中等)",
        @"32.最长有效括号",
        @"443.压缩字符串",
        @"120.三角形最小路径和 - 动态规划的反向用法",
        @"146.LRU缓存机制",
        @"165.比较版本号",
        @"82.删除排序链表中的重复元素 II",
        @"438.找到字符串中所有字母异位词",
        @"739.每日温度",
        @"2.两数相加",
        @"71.简化路径",
        @"162.寻找峰值",
        @"7.整数反转",
        @"160.相交链表",
        @"3.无重复字符的最长子串",
        @"445.两数相加 II",
        @"1233.删除子文件夹",
        @"1.两数之和",
        @"20.有效的括号",
        @"189.旋转数组",
        @"767.重构字符串-未解题",
        @"48.旋转图像",
        @"101.对称二叉树",
        @"151.翻转字符串里的单词",
        @"33.搜索旋转排序数组",
        @"86.分隔链表",
        @"236.二叉树的最近公共祖先",
        @"23.合并K个升序链表"
    ]];
}

- (void)action200
{
    // 200.岛屿数量
    /*
    给你一个由 '1'（陆地）和 '0'（水）组成的的二维网格，请你计算网格中岛屿的数量。

    岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。

    此外，你可以假设该网格的四条边均被水包围。
     
     输入：grid = [
       ["1","1","1","1","0"],
       ["1","1","0","1","0"],
       ["1","1","0","0","0"],
       ["0","0","0","0","0"]
     ]
     输出：1

     输入：grid = [
       ["1","1","0","0","0"],
       ["1","1","0","0","0"],
       ["0","0","1","0","0"],
       ["0","0","0","1","1"]
     ]
     输出：3
     */
    
    NSMutableArray *grid0 = @[
        @[@(1), @(1), @(1), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(0), @(0), @(0)].mutableCopy,
    ].mutableCopy;
    
    NSMutableArray *grid1 = @[
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(1), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(0), @(1), @(1)].mutableCopy,
    ].mutableCopy;
    
    NSArray *grids = @[grid0, grid1];
    for (NSInteger i = 0; i < grids.count; i++) {
        NSInteger num = [self action0NumOfGrid:grids[i]];
        NSLog(@"%ld", num);
    }
    
}

// 岛屿问题通解
// https://leetcode-cn.com/problems/number-of-islands/solution/dao-yu-lei-wen-ti-de-tong-yong-jie-fa-dfs-bian-li-/
- (NSInteger)action0NumOfGrid:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
{
    NSInteger num = 0;
    for (NSInteger row = 0; row < grid.count; row++) {
        for (NSInteger col = 0; col < grid.firstObject.count; col++) {
            if([grid[row][col] isEqual:@(1)]) {
                num++;
                [self action0Dfs:grid row:row col:col];
            }
        }
    }
    return num;
}

- (void)action0Dfs:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
               row:(NSInteger)row
               col:(NSInteger)col
{
    //判断 base case
    //如果坐标（r,c）超出了网格范围，直接返回
    if(![self action0IsArea:grid row:row col:col]) return;
    
    //如果这个格子不是岛屿/已经遍历过，直接返回
    if (![grid[row][col] isEqual:@(1)]) return;
    
    grid[row][col] = @(2); //将格子标记为【已遍历过】
    
    //访问上、下、左、右四个相邻结点
    [self action0Dfs:grid row:row-1 col:col];
    [self action0Dfs:grid row:row+1 col:col];
    [self action0Dfs:grid row:row col:col-1];
    [self action0Dfs:grid row:row col:col+1];
}

//判断坐标（r,c）是否在网格中
- (BOOL)action0IsArea:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
                  row:(NSInteger)row
                  col:(NSInteger)col
{
    return (0 <= row && row < grid.count && 0 <= col && col < grid[0].count);
}

- (void)action463
{
    // 463 岛屿的周长
    NSMutableArray *grid = @[
        @[@(1), @(1), @(1), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(0), @(0), @(0)].mutableCopy,
    ].mutableCopy;
    NSInteger max = [self action1MaxPerOfGrid:grid];
    NSLog(@"%ld", max);
}

- (NSInteger)action1MaxPerOfGrid:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
{
    for (NSInteger row = 0; row < grid.count; row++) {
        for (NSInteger col = 0; col < grid.firstObject.count; col++) {
            if([grid[row][col] isEqual:@(1)]) {
                return [self action1Pre:grid row:row col:col];
            }
        }
    }
    return 0;
}

- (NSInteger)action1Pre:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
                    row:(NSInteger)row
                    col:(NSInteger)col
{
    //判断 base case
    //如果坐标（r,c）超出了网格范围，直接返回
    if(![self action0IsArea:grid row:row col:col]) return 1;
    
    //函数因为「当前格子是海洋格子」返回，对应一条蓝色的边
    if ([grid[row][col] isEqual:@(0)]) return 1;
    
    //如果这个格子不是岛屿，直接返回
    if (![grid[row][col] isEqual:@(1)]) return 0;
    
    grid[row][col] = @(2); //将格子标记为【已遍历过】
    
    //访问上、下、左、右四个相邻结点
    return [self action2Area:grid row:row-1 col:col] +
    [self action2Area:grid row:row+1 col:col] +
    [self action2Area:grid row:row col:col-1] +
    [self action2Area:grid row:row col:col+1];
}

- (void)action695
{
    // 695 岛屿的最大面积
    NSMutableArray *grid = @[
        @[@(1), @(1), @(1), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(0), @(0), @(0)].mutableCopy,
    ].mutableCopy;
    NSInteger max = [self action2MaxAreaOfGrid:grid];
    NSLog(@"%ld", max);
}

- (NSInteger)action2MaxAreaOfGrid:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
{
    NSInteger maxArea = 0;
    for (NSInteger row = 0; row < grid.count; row++) {
        for (NSInteger col = 0; col < grid.firstObject.count; col++) {
            if([grid[row][col] isEqual:@(1)]) {
                NSInteger area = [self action2Area:grid row:row col:col];
                maxArea = MAX(area, maxArea);
            }
        }
    }
    return maxArea;
}

- (NSInteger)action2Area:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
                     row:(NSInteger)row
                     col:(NSInteger)col
{
    //判断 base case
    //如果坐标（r,c）超出了网格范围，直接返回
    if(![self action0IsArea:grid row:row col:col]) return 0;
    
    //如果这个格子不是岛屿，直接返回
    if (![grid[row][col] isEqual:@(1)]) return 0;
    
    grid[row][col] = @(2); //将格子标记为【已遍历过】
    
    //访问上、下、左、右四个相邻结点
    return 1 +
    [self action2Area:grid row:row-1 col:col] +
    [self action2Area:grid row:row+1 col:col] +
    [self action2Area:grid row:row col:col-1] +
    [self action2Area:grid row:row col:col+1];
}

- (void)action53
{
    // 53. 最大子序和
    /*
     给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

     示例:

     输入: [-2,1,-3,4,-1,2,1,-5,4]
     输出: 6
     解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
     */
    NSArray <NSNumber *>*nums = @[@(-2),@(1),@(-3),@(4),@(-1),@(2),@(1),@(-5),@(4)];
    [self actiond4Nums:nums];
    
}

- (void)actiond4Nums:(NSArray <NSNumber *>*)nums
{
    NSInteger sum = 0;
    NSInteger temp = 0;
    for (NSInteger i = 0; i < nums.count; i++) {
        temp += nums[i].integerValue;
        if (temp <= 0 ) {
            temp = 0;
        } else {
            sum = MAX(sum, temp);
        }
    }
    NSLog(@"sum %ld", sum);
}

- (void)action25
{
    // 25. K 个一组翻转链表
    /*
     给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。
     k 是一个正整数，它的值小于或等于链表的长度。
     如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
      
     示例：
     给你这个链表：1->2->3->4->5
     当 k = 2 时，应当返回: 2->1->4->3->5
     当 k = 3 时，应当返回: 3->2->1->4->5

     说明：
     你的算法只能使用常数的额外空间。
     你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。
     */
    NSInteger k = 2;
//    NSInteger k = 3;
    ListNode *node4 = [ListNode nodeValue:5 next:nil];
    ListNode *node3 = [ListNode nodeValue:4 next:node4];
    ListNode *node2 = [ListNode nodeValue:3 next:node3];
    ListNode *node1 = [ListNode nodeValue:2 next:node2];
    ListNode *node0 = [ListNode nodeValue:1 next:node1];
    ListNode *head = [self action5reverseKGroup:node0 k:k];
    NSLog(@"%@", head);
}
// https://leetcode-cn.com/problems/reverse-nodes-in-k-group/solution/tu-jie-kge-yi-zu-fan-zhuan-lian-biao-by-user7208t/
- (ListNode *)action5reverseKGroup:(ListNode *)head k:(NSInteger)k
{
    // 头结点
    ListNode *dummy = [ListNode nodeValue:0 next:head];
    //待翻转链表的前驱
    ListNode *pre = dummy;
    //待翻转链表的末尾
    ListNode *end = dummy;
    
    while (end.next != nil) {
        // 循环k次，找到需要翻转的链表的结尾
        for (int i = 0; i < k; i++)
        {
            end = end.next;
        }
        // end == nil 说明剩余部分不足k 不用翻转
        if (end == nil) break;
        // 获取待翻转链表头
        ListNode *start = pre.next;
        // 获取待翻转链表后驱
        ListNode *next = end.next;
        // 将待翻转链表尾部置nil 准备翻转
        end.next = nil;
        // 将前驱与翻转后链表头连接
        pre.next = [self action5Reverse:start];
        // 将后驱与翻转后链表尾连接
        start.next = next;
        // 重置前驱尾翻转后链表尾部 也就是start
        pre = start;
        // 重置新的链表尾部为前驱 pre end 还原成充实状态 重新进入循环
        end = pre;
    }
    return dummy.next;
}

- (ListNode *)action5Reverse:(ListNode *)head
{
    ListNode *pre = nil;
    ListNode *cur = head;
    while (cur != nil) {
        ListNode *next = cur.next;
        cur.next = pre;
        pre = cur;
        cur = next;
    }
    return pre;
}

- (void)action5
{
    // 5. 最长回文子串
    /*
     给你一个字符串 s，找到 s 中最长的回文子串。
     示例 1：

     输入：s = "babad"
     输出："bab"
     解释："aba" 同样是符合题意的答案。
     示例 2：

     输入：s = "cbbd"
     输出："bb"
     示例 3：

     输入：s = "a"
     输出："a"
     示例 4：

     输入：s = "ac"
     输出："a"
     */
    NSArray *array =@[@"babad", @"cbbd", @"a", @"ac"];
    for (NSInteger i = 0; i < array.count; i++) {
        NSString *s = array[i];
        NSString *sub = [self action6LongestPalindrome:s];
        NSLog(@"%@", sub);
    }
//    NSInteger len1 = [self action6ExpandAroundCenter:@"babad" left:3 right:3];
    
}

// 中心扩散法 遍历子串 每一个点都像外扩散 找到每一个点的最长子串 然后比较
- (NSString *)action6LongestPalindrome:(NSString *)s
{
    if (s.length < 1) {
        return @"";
    }
    NSString *res = @"";
    NSInteger maxLength = 1;
    // 最后一个位置违法向右延伸 所以不用枚举
    for (NSInteger i = 0; i < s.length - 1; i++) {
        NSString *str1 = [self action6ExpandAroundCenter:s left:i right:i];
        NSString *str2 = [self action6ExpandAroundCenter:s left:i right:i+1];
        NSString *maxStr = str1.length > str2.length ? str1 : str2;
        if (maxStr.length > maxLength) {
            maxLength = maxStr.length;
            res = maxStr;
        }
    }
    return res;
}

/// 回文串长度 以奇数/偶数中心点扩散 得到的最长回文串
/// @param s 字符串
/// @param left 起始左
/// @param right 起始右
- (NSString *)action6ExpandAroundCenter:(NSString *)s left:(NSInteger)left right:(NSInteger)right
{
    NSInteger i = left;
    NSInteger j = right;
    NSInteger maxLength = s.length;
    while (i >= 0 && j < maxLength) {
        if ([self action6CharAtIndex:i s:s] == [self action6CharAtIndex:j s:s]) {
            i--;
            j++;
        } else {
            break;
        }
    }
    // 此时跳出 i j 是不符合条件的下标 要回退
    // j - 1 -( i + 1) + 1
    return [s substringWithRange:NSMakeRange(i + 1, j - 1 -( i + 1) + 1)];;
}

- (NSString *)action6CharAtIndex:(NSInteger)index s:(NSString *)s
{
    return [s substringWithRange:NSMakeRange(index, 1)];
}

- (void)action32
{
    // 32. 最长有效括号
    // 给你一个只包含 '(' 和 ')' 的字符串，找出最长有效（格式正确且连续）括号子串的长度。
    /*
     输入：s = "(()"
     输出：2
     解释：最长有效括号子串是 "()"

     输入：s = "()((()())"
     输出：6
     解释：最长有效括号子串是 "(()())"

     输入：s = "()(()())"
     输出：8
     */
    
    NSArray *arr = @[
    @[@"(", @"(", @")"],
    @[@"(", @")", @"(", @"(", @"(", @")", @"(", @")", @")"],
    @[@"(", @")", @"(", @"(", @")", @"(", @")", @")"]
    ];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSArray *s = arr[i];
        NSInteger result = [self action7Arr:s];
        NSLog(@"%ld", result);
    }
    
}

// 利用堆栈 每遇( index进栈 遇到) 如果栈顶是( 正好与(前一个算差值 如果是) 更新(的index 就堆栈pop 然后算差值
- (NSInteger)action7Arr:(NSArray <NSString *>*)s
{
    NSInteger maxLength = 0;
    NSMutableArray <NSNumber *>*stack = [NSMutableArray array];
    [stack addObject:@(-1)];
    for (int i = 0; i < s.count; i++) {
        if ([s[i] isEqualToString: @"("]) {
            [stack addObject:@(i)];
        } else {
            [stack removeLastObject];
            if (stack.count == 0) {
                [stack addObject:@(i)];
            } else {
                maxLength = MAX(maxLength, i - stack.lastObject.integerValue);
            }
        }
    }
    return maxLength;
}

- (void)action443
{
    // 443. 压缩字符串
    /*
     输入：
     ["a","a","b","b","c","c","c"]

     输出：
     返回 6 ，输入数组的前 6 个字符应该是：["a","2","b","2","c","3"]
     
     输入：
     ["a"]

     输出：
     返回 1 ，输入数组的前 1 个字符应该是：["a"]
     
     输入：
     ["a","b","b","b","b","b","b","b","b","b","b","b","b"]

     输出：
     返回 4 ，输入数组的前4个字符应该是：["a","b","1","2"]。

     解释：
     由于字符 "a" 不重复，所以不会被压缩。"bbbbbbbbbbbb" 被 “b12” 替代。
     注意每个数字在数组中都有它自己的位置。
     */
    NSArray <NSMutableArray <NSString *>*>*arr = @[
    @[@"a",@"a",@"b",@"b",@"c",@"c",@"c"].mutableCopy,
    @[@"a"].mutableCopy,
    @[@"a",@"b",@"b",@"b",@"b",@"b",@"b",@"b",@"b",@"b",@"b",@"b",@"b"].mutableCopy,
    ];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSMutableArray <NSString *>*s = arr[i];
        NSInteger result = [self action8LengthCompress:s];
        NSLog(@"%ld", result);
    }
}


/*
 anchor 指向当前读到连续字符串的起始位置
 write 当前写入位置
 read 当前读的位置
 当读到最后一个字符，或者下一个字符与当前不同时，则到达连续区块的结尾
 当我们到达连续区块的结尾时，就从 write 写入压缩的结果。chars[anchor] 为字符，read - anchor + 1 （若大于 1）为长度。

 */
- (NSInteger)action8LengthCompress:(NSMutableArray <NSString *>*)chars
{
    NSInteger anchor = 0, write = 0;
    for (int read = 0; read < chars.count; read++) {
        // read + 1 == chars.count : 最后一个数 开始压缩
        // chars[read + 1] != chars[read] : 当前值 != 下一个值 开始压缩前一段
        if (read + 1 == chars.count || chars[read + 1] != chars[read]) {
            chars[write++] = chars[anchor];
            if (read > anchor) {
                NSInteger count = read - anchor + 1;
                NSString *countStr = @(count).stringValue;
                
                for (NSInteger i = 0; i < countStr.length; i++) {
                    NSString *sub = [countStr substringWithRange:NSMakeRange(i, 1)];
                    chars[write++] = sub;
                }
            }
            anchor = read + 1;
        }
    }
    // 最后有一个write++ 所以write就是长度 而不是write-1
    return write;
}

- (void)action120
{
    // 120. 三角形最小路径和
    /*
     给定一个三角形 triangle ，找出自顶向下的最小路径和。
     每一步只能移动到下一行中相邻的结点上。相邻的结点 在这里指的是 下标 与 上一层结点下标 相同或者等于 上一层结点下标 + 1 的两个结点。也就是说，如果正位于当前行的下标 i ，那么下一步可以移动到下一行的下标 i 或 i + 1 。
     输入：triangle = [[2],[3,4],[6,5,7],[4,1,8,3]]
     输出：11
     解释：如下面简图所示：
        2
       3 4
      6 5 7
     4 1 8 3
     自顶向下的最小路径和为 11（即，2 + 3 + 5 + 1 = 11）。
     */
    
    NSArray <NSArray <NSNumber *>*>*t = @[
    @[@(2)],
    @[@(3), @(4)],
    @[@(6), @(5), @(7)],
    @[@(4), @(1), @(8), @(3)]];
    
    NSInteger result = [self action9Triangle1:t];
    NSLog(@"%ld", result);
}

- (NSInteger)action9Triangle:(NSArray <NSArray <NSNumber *>*>*)t
{
    NSMutableArray <NSMutableArray <NSNumber *>*>*dp = [NSMutableArray array];
    for (NSInteger i = 0; i <= t.count; i++) {
        NSMutableArray <NSNumber *>* row = [NSMutableArray array];
        NSInteger col = (i >= t.count)? t[i-1].count + 1 : t[i].count;
        for (NSInteger j = 0; j < col; j++) {
            [row addObject: @(0)];
        }
        [dp addObject:row];
    }
    
    for (NSInteger i = t.count - 1; i >= 0; i--) {
        for (NSInteger j = 0; j < t[i].count; j++) {
            dp[i][j] = @(MIN(dp[i+1][j].integerValue, dp[i+1][j+1].integerValue) + t[i][j].integerValue);
        }
    }
    return dp[0][0].integerValue;
}

// 空间优化版本
- (NSInteger)action9Triangle1:(NSArray <NSArray <NSNumber *>*>*)t
{
    NSMutableArray <NSNumber *>*dp = [NSMutableArray array];
    for (NSInteger i = 0; i <= t.lastObject.count; i++) {
        [dp addObject:@(0)];
    }
    
    for (NSInteger i = t.count - 1; i >= 0; i--) {
        for (NSInteger j = 0; j < t[i].count; j++) {
            dp[j] = @(MIN(dp[j].integerValue, dp[j+1].integerValue) + t[i][j].integerValue);
        }
    }
    return dp[0].integerValue;
}


- (void)action146
{
    // 146. LRU缓存机制
    /*
     运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制 。
     实现 LRUCache 类：

     LRUCache(int capacity) 以正整数作为容量 capacity 初始化 LRU 缓存
     int get(int key)
     如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
     void put(int key, int value)
     如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字-值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。

     输入
     ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
     [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
     输出
     [null, null, null, 1, null, -1, null, -1, 3, 4]

     解释
     LRUCache lRUCache = new LRUCache(2);
     lRUCache.put(1, 1); // 缓存是 {1=1}
     lRUCache.put(2, 2); // 缓存是 {1=1, 2=2}
     lRUCache.get(1);    // 返回 1
     lRUCache.put(3, 3); // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
     lRUCache.get(2);    // 返回 -1 (未找到)
     lRUCache.put(4, 4); // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
     lRUCache.get(1);    // 返回 -1 (未找到)
     lRUCache.get(3);    // 返回 3
     lRUCache.get(4);    // 返回 4
     */
    
    LRUCache *cache = [[LRUCache alloc] initWithCapacity:2];
    [cache putKey:@"1" value:1];
    [cache putKey:@"2" value:2];
    NSInteger value0 = [cache getKey:@"1"];
    [cache putKey:@"3" value:3];
    NSInteger value1 = [cache getKey:@"2"];
    [cache putKey:@"4" value:4];
    NSInteger value2 = [cache getKey:@"1"];
    NSInteger value3 = [cache getKey:@"3"];
    NSInteger value4 = [cache getKey:@"4"];
    NSLog(@"\nvalue0:%ld\nvalue1:%ld\nvalue2:%ld\nvalue3:%ld\nvalue4:%ld", value0, value1, value2, value3, value4);
    
}

- (void)action165
{
    // 165. 比较版本号
    /*
     给你两个版本号 version1 和 version2 ，请你比较它们。

     版本号由一个或多个修订号组成，各修订号由一个 '.' 连接。每个修订号由 多位数字 组成，可能包含 前导零 。每个版本号至少包含一个字符。修订号从左到右编号，下标从 0 开始，最左边的修订号下标为 0 ，下一个修订号下标为 1 ，以此类推。例如，2.5.33 和 0.1 都是有效的版本号。

     比较版本号时，请按从左到右的顺序依次比较它们的修订号。比较修订号时，只需比较 忽略任何前导零后的整数值 。也就是说，修订号 1 和修订号 001 相等 。如果版本号没有指定某个下标处的修订号，则该修订号视为 0 。例如，版本 1.0 小于版本 1.1 ，因为它们下标为 0 的修订号相同，而下标为 1 的修订号分别为 0 和 1 ，0 < 1 。

     返回规则如下：

     如果 version1 > version2 返回 1，
     如果 version1 < version2 返回 -1，
     除此之外返回 0。
     
     输入：version1 = "1.01", version2 = "1.001"
     输出：0
     解释：忽略前导零，"01" 和 "001" 都表示相同的整数 "1"

     输入：version1 = "1.0", version2 = "1.0.0"
     输出：0
     解释：version1 没有指定下标为 2 的修订号，即视为 "0"

     输入：version1 = "0.1", version2 = "1.1"
     输出：-1
     解释：version1 中下标为 0 的修订号是 "0"，version2 中下标为 0 的修订号是 "1" 。0 < 1，所以 version1 < version2

     输入：version1 = "1.0.1", version2 = "1"
     输出：1

     输入：version1 = "7.5.2.4", version2 = "7.5.3"
     输出：-1
     */
    
    NSArray <NSArray <NSString *>*>*array = @[
    @[@"1.01", @"1.001"],
    @[@"1.0", @"1.0.0"],
    @[@"0.1", @"1.1"],
    @[@"1.0.1", @"1"],
    @[@"7.5.2.4", @"7.5.3"]
    ];
    
    for (NSInteger i = 0; i < array.count; i++) {
        NSArray <NSString *>*versions = array[i];
        NSInteger result = [self action11CompareVersion1:versions[0] version2:versions[1]];
        NSLog(@"\n%ld", result);
    }
}

- (NSInteger)action11CompareVersion1:(NSString *)version1 version2:(NSString *)version2
{
    NSArray *nums1 = [version1 componentsSeparatedByString:@"."];
    NSArray *nums2 = [version2 componentsSeparatedByString:@"."];
    
    int i = 0, j = 0;
        while (i < nums1.count || j < nums2.count) {
            //这个技巧经常用到，当一个已经遍历结束的话，我们将其赋值为 0
            NSString *num1 = i < nums1.count ? nums1[i] : @"0";
            NSString *num2 = j < nums2.count ? nums2[j] : @"0";
            NSInteger res = [self action11Compare:num1 num2:num2];
            if (res == 0) {
                i++;
                j++;
            } else {
                return res;
            }
        }
        return 0;

}

- (NSInteger)action11Compare:(NSString *)num1 num2:(NSString *)num2
{
    NSInteger n1 = num1.integerValue;
    NSInteger n2 = num2.integerValue;
    if (n1 > n2) {
        return 1;
    } else if (n1 < n2) {
        return -1;
    } else {
        return 0;
    }
}

- (void)action82
{
    // 82. 删除排序链表中的重复元素 II
    /*
     给定一个排序链表，删除所有含有重复数字的节点，只保留原始链表中 没有重复出现 的数字。
     输入: 1->2->3->3->4->4->5
     输出: 1->2->5

     输入: 1->1->1->2->3
     输出: 2->3
     */
    
    ListNode *node6 = [ListNode nodeValue:5 next:nil];
    ListNode *node5 = [ListNode nodeValue:4 next:node6];
    ListNode *node4 = [ListNode nodeValue:4 next:node5];
    ListNode *node3 = [ListNode nodeValue:3 next:node4];
    ListNode *node2 = [ListNode nodeValue:3 next:node3];
    ListNode *node1 = [ListNode nodeValue:2 next:node2];
    ListNode *node0 = [ListNode nodeValue:1 next:node1];
    
    ListNode *head = [self action12DeleteDuplicatesNode:node0];
    NSLog(@"%@", head);
}

- (ListNode *)action12DeleteDuplicatesNode:(ListNode *)head
{
    // 判断参数安全 是好的习惯 其实不加也行
    if (head == nil || head.next == nil) {
        return head;
    }
    
    if (head.value == head.next.value) {
        while (head != nil && head.next != nil && head.value == head.next.value) {
            head = head.next;
        }
        return [self action12DeleteDuplicatesNode:head.next];
    } else {
        head.next = [self action12DeleteDuplicatesNode:head.next];
        return head;
    }
}

- (void)action438
{
    // 438. 找到字符串中所有字母异位词
    /*
     给定一个字符串 s 和一个非空字符串 p，找到 s 中所有是 p 的字母异位词的子串，返回这些子串的起始索引
     字符串只包含小写英文字母，并且字符串 s 和 p 的长度都不超过 20100。
     
     说明：
     字母异位词指字母相同，但排列不同的字符串。
     不考虑答案输出的顺序。

     s: "cbaebabacd" p: "abc"
     输出: [0, 6]
     解释:
     起始索引等于 0 的子串是 "cba", 它是 "abc" 的字母异位词。
     起始索引等于 6 的子串是 "bac", 它是 "abc" 的字母异位词。
     
     s: "abab" p: "ab"
     输出: [0, 1, 2]

     解释:
     起始索引等于 0 的子串是 "ab", 它是 "ab" 的字母异位词。
     起始索引等于 1 的子串是 "ba", 它是 "ab" 的字母异位词。
     起始索引等于 2 的子串是 "ab", 它是 "ab" 的字母异位词。

     */
    
    NSArray *result = [self action13FindAnagrams:@"cbaebabacd" p:@"abc"];
    NSLog(@"%@", result);
    NSArray *result1 = [self action13FindAnagrams:@"abab" p:@"ab"];
    NSLog(@"%@", result1);
}

- (NSArray <NSNumber *>*)action13FindAnagrams:(NSString *)s p:(NSString *)p
{
    NSArray <NSString *>*(^toCharArray)(NSString *) = ^(NSString *str) {
        NSMutableArray *result = @[].mutableCopy;
        for (NSInteger i = 0; i < str.length; i++) {
            NSString *sub = [str substringWithRange:NSMakeRange(i, 1)];
            [result addObject:sub];
        }
        return result.copy;
    };
    
    NSArray <NSString *>*arrS = toCharArray(s);
    NSArray <NSString *>*arrP = toCharArray(p);
    NSMutableArray *result = [NSMutableArray array];
    NSMutableDictionary <NSString *, NSNumber *>*window = [NSMutableDictionary dictionary];
    NSMutableDictionary <NSString *, NSNumber *>*needs = [NSMutableDictionary dictionary];
    
    for (NSInteger i = 0; i < arrP.count; i++) {
        NSString *key = arrP[i];
        needs[key] = @(needs[key].integerValue + 1);
    }
    NSInteger left = 0, right = 0;
    
    while (right < arrS.count) {
        NSString *rightChar = arrS[right];
        right++;
        window[rightChar] = @(window[rightChar].integerValue + 1);
        
        while (window[rightChar].integerValue > needs[rightChar].integerValue) {
            NSString *leftChar = arrS[left];
            left++;
            window[leftChar] = @(window[leftChar].integerValue - 1);
        }
        
        // 这里将所有符合要求的左窗口索引放入到了接收结果的 List 中
        if (right - left == arrP.count) {
            [result addObject:@(left)];
        }
    }
    return result;
}

- (void)action739
{
    // 739. 每日温度
    /*
     请根据每日气温列表，重新生成一个列表。对应位置的输出为：要想观测到更高的气温，至少需要等待的天数。如果气温在这之后都不会升高，请在该位置用 0 来代替。
     例如，给定一个列表 temperatures = [73, 74, 75, 71, 69, 72, 76, 73]，你的输出应该是 [1, 1, 4, 2, 1, 1, 0, 0]。
     提示：气温 列表长度的范围是 [1, 30000]。每个气温的值的均为华氏度，都是在 [30, 100] 范围内的整数。

     */
    NSArray *result = [self action14dayTemperatures:@[@(73), @(74), @(75), @(71), @(69), @(72), @(76), @(73)]];
    NSLog(@"%@", result);
}

- (NSArray *)action14dayTemperatures:(NSArray <NSNumber *>*)days
{
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < days.count; i++) {
        [result addObject:@(0)];
        NSInteger cur = days[i].integerValue;
        for (NSInteger j = i + 1; j < days.count; j++) {
            if (days[j].integerValue > cur) {
                result[i] = @(j - i);
                break;
            }
        }
    }
    return result;
}

- (void)action2
{
    // 2. 两数相加
    /*
     给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
     请你将两个数相加，并以相同形式返回一个表示和的链表。
     你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

     l1 = [2,4,3], l2 = [5,6,4]
     输出：[7,0,8]
     解释：342 + 465 = 807.
     示例 2：

     输入：l1 = [0], l2 = [0]
     输出：[0]
     示例 3：

     输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
     输出：[8,9,9,9,0,0,0,1]
     */
    ListNode *l3 = [ListNode nodeValue:3 next:nil];
    ListNode *l2 = [ListNode nodeValue:4 next:l3];
    ListNode *l1 = [ListNode nodeValue:2 next:l2];
    
    ListNode *r3 = [ListNode nodeValue:4 next:nil];
    ListNode *r2 = [ListNode nodeValue:6 next:r3];
    ListNode *r1 = [ListNode nodeValue:5 next:r2];
    
    ListNode *head = [self action15ListAdd:l1 node1:r1];
    NSLog(@"%@", head);
}

- (ListNode *)action15ListAdd:(ListNode *)l1 node1:(ListNode *)l2
{
    ListNode *pre = [ListNode nodeValue:0 next:nil];
    ListNode *cur = pre;
    NSInteger carry = 0;
    while(l1 != nil || l2 != nil) {
        NSInteger x = l1 == nil ? 0 : l1.value;
        NSInteger y = l2 == nil ? 0 : l2.value;
        NSInteger sum = x + y + carry;
        
        carry = sum / 10;
        sum = sum % 10;
        cur.next = [ListNode nodeValue:sum next:nil];
        
        cur = cur.next;
        if(l1 != nil)
            l1 = l1.next;
        if(l2 != nil)
            l2 = l2.next;
    }
    if(carry == 1) {
        cur.next = [ListNode nodeValue:carry next:nil];
    }
    return pre.next;
}

- (void)action71
{
    // 71. 简化路径
    /*
     以 Unix 风格给出一个文件的绝对路径，你需要简化它。或者换句话说，将其转换为规范路径。

     输入："/home/"
     输出："/home"
     解释：注意，最后一个目录名后面没有斜杠。

     输入："/../"
     输出："/"
     解释：从根目录向上一级是不可行的，因为根是你可以到达的最高级。

     输入："/home//foo/"
     输出："/home/foo"
     解释：在规范路径中，多个连续斜杠需要用一个斜杠替换。

     输入："/a/./b/../../c/"
     输出："/c"

     输入："/a/../../b/../c//.//"
     输出："/c"

     输入："/a//b////c/d//././/.."
     输出："/a/b/c"

     */
    NSArray *arr = @[@"/home/", @"/../", @"/home//foo/", @"/a/./b/../../c/", @"/a/../../b/../c//.//", @"/a//b////c/d//././/.."];
    
    for (NSString *path in arr) {
        NSString *result = [self action16SimplifyPath:path];
        NSLog(@"%@", result);
    }
}

- (NSString *)action16SimplifyPath:(NSString *)path
{
    NSMutableArray <NSString *>*pathArray = [path componentsSeparatedByString:@"/"].mutableCopy;
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSInteger i = 0; i < pathArray.count; i++) {
        
        NSString *node = pathArray[i];
        if (node.length == 0 || [node isEqualToString:@"."]) {
            continue;
        }
        
        if ([node isEqualToString:@".."]) {
            if (result.count != 0) {
                [result removeLastObject];
            }
        } else {
            [result addObject:node];
        }
    }
    
    NSString *resultString = @"";
    for (NSString *node in result) {
        resultString = [NSString stringWithFormat:@"%@/%@", resultString, node];
    }
    return resultString.length == 0 ? @"/" : resultString;
}

- (void)action162
{
    // 162. 寻找峰值
    /*
     峰值元素是指其值大于左右相邻值的元素。
     给你一个输入数组 nums，找到峰值元素并返回其索引。数组可能包含多个峰值，在这种情况下，返回 任何一个峰值 所在位置即可。
     你可以假设 nums[-1] = nums[n] = -∞ 。

     输入：nums = [1,2,3,1]
     输出：2
     解释：3 是峰值元素，你的函数应该返回其索引 2。

     输入：nums = [1,2,1,3,5,6,4]
     输出：1 或 5
     解释：你的函数可以返回索引 1，其峰值元素为 2；
          或者返回索引 5， 其峰值元素为 6。
     */
    NSArray *arr = @[@[@(1), @(2), @(3), @(1)], @[@(1), @(2), @(1), @(3), @(5)]];
    
    for (NSArray *nums in arr) {
        NSInteger index = [self action17Find:nums];
        NSLog(@"%ld", index);
    }

}

// 首先要注意题目条件，在题目描述中出现了 nums[-1] = nums[n] = -∞，这就代表着 2个边界是负无穷 所以从第一个值开始 只要大于右边的值 既是峰值

- (NSInteger)action17Find:(NSArray <NSNumber *>*)nums
{
    for (int i = 0; i < nums.count - 1; i++) {
        if (nums[i].integerValue > nums[i + 1].integerValue)
            return i;
    }
    // 单独判断下最后一个值
    return nums.count - 1;
}

- (void)action7
{
    //7. 整数反转
    /*
     给你一个 32 位的有符号整数 x ，返回 x 中每位上的数字反转后的结果。
     如果反转后整数超过 32 位的有符号整数的范围 [−231,  231 − 1] ，就返回 0。
     假设环境不允许存储 64 位整数（有符号或无符号）。
     
     */
    NSArray *arr = @[@(123), @(-123), @(120), @(0)];
    
    for (NSNumber *num in arr) {
        int rnum = [self action18Reverse:num.intValue];
        NSLog(@"%d", rnum);
    }
    // 321 -321 21 0
}

// https://leetcode-cn.com/problems/reverse-integer/solution/tu-jie-7-zheng-shu-fan-zhuan-by-wang_ni_ma/
- (int)action18Reverse:(int)x
{
    int res = 0;
    while(x!=0) {
        //每次取末尾数字
        int tmp = x%10;
        //判断是否 大于 最大32位整数
        if (res>INT_MAX/10 || (res==INT_MAX/10 && tmp>7)) {
            return 0;
        }
        //判断是否 小于 最小32位整数
        if (res<-INT_MAX/10 || (res==-INT_MAX/10 && tmp<-8)) {
            return 0;
        }
        res = res*10 + tmp;
        x /= 10;
    }
    return res;
}

- (void)action160
{
    // 160. 相交链表
    /*
     指针 pA 指向 A 链表，指针 pB 指向 B 链表，依次往后遍历
     如果 pA 到了末尾，则 pA = headB 继续遍历
     如果 pB 到了末尾，则 pB = headA 继续遍历
     比较长的链表指针指向较短链表head时，长度差就消除了
     如此，只需要将最短链表遍历两次即可找到位置
     */
}

- (ListNode*)action19GetIntersectionNode:(ListNode *)headA node:(ListNode *)headB
{
    if (headA == nil || headB == nil) return nil;
    ListNode *pA = headA, *pB = headB;
    while (pA != pB) {
        pA = pA == nil ? headB : pA.next;
        pB = pB == nil ? headA : pB.next;
    }
    return pA;
}

- (void)action3
{
    // 3. 无重复字符的最长子串
    /*
     给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
     */
    
    NSArray *arr = @[@"abcabcbb", @"bbbbb", @"pwwkew"];
    
    for (NSString *num in arr) {
        int rnum = [self action20minString:num];
        NSLog(@"%d", rnum);
    }
}

- (int)action20minString:(NSString *)s
{
    if (s.length == 0) return 0;
    NSMutableDictionary <NSString*, NSNumber*>*map = [NSMutableDictionary dictionary];
    int max = 0;
    int left = 0;
    for(int i = 0; i < s.length; i ++){
        NSString *c = [s substringWithRange:NSMakeRange(i, 1)];
        if([map.allKeys containsObject:c]){
            left = (int)MAX(left,map[c].integerValue + 1);
        }
        map[c] = @(i);
        max = (int)MAX(max, i-left+1);
    }
    return max;

}

- (void)action445
{
    // 445. 两数相加 II
    /*
     给你两个 非空 链表来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储一位数字。将这两数相加会返回一个新的链表。
     如果输入链表不能修改该如何处理？换句话说，你不能对列表中的节点进行翻转。

     输入：(7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
     输出：7 -> 8 -> 0 -> 7
     */
    ListNode *node04 = [ListNode nodeValue:3 next:nil];
    ListNode *node03 = [ListNode nodeValue:4 next:node04];
    ListNode *node02 = [ListNode nodeValue:2 next:node03];
    ListNode *node01 = [ListNode nodeValue:7 next:node02];
    
    ListNode *node13 = [ListNode nodeValue:4 next:nil];
    ListNode *node12 = [ListNode nodeValue:6 next:node13];
    ListNode *node11 = [ListNode nodeValue:5 next:node12];
    
    ListNode *result = [self action21Sum:node01 node:node11];
    NSLog(@"%ld", result.value);
}

- (ListNode *)action21Sum:(ListNode *)node0 node:(ListNode *)node1
{
    // 利用栈的思路
    NSMutableArray <NSNumber *>*stack0 = [NSMutableArray array];
    NSMutableArray <NSNumber *>*stack1 = [NSMutableArray array];
    
    ListNode *cur0 = node0;
    while (cur0) {
        [stack0 addObject:@(cur0.value)];
        cur0 = cur0.next;
    }
    
    ListNode *cur1 = node1;
    while (cur1) {
        [stack1 addObject:@(cur1.value)];
        cur1 = cur1.next;
    }
    
    NSInteger maxLength = MAX(stack0.count, stack1.count);
    NSMutableArray <NSNumber *>*stack2 = [NSMutableArray array];
    // 进位
    BOOL carry = NO;
    for (NSInteger i = 0; i < maxLength; i++) {
        NSInteger num0 = 0;
        if (stack0.count != 0) {
            num0 = stack0.lastObject.integerValue;
            [stack0 removeLastObject];
        }
        
        NSInteger num1 = 0;
        if (stack1.count != 0) {
            num1 = stack1.lastObject.integerValue;
            [stack1 removeLastObject];
        }
        
        NSInteger num2 = num0 + num1 + (carry?1:0);
        carry = NO;
        
        if (num2 > 9) {
            num2 %= 10;
            carry = YES;
        }
        
        [stack2 addObject:@(num2)];
    }
    
    if (carry) {
        [stack2 addObject:@(1)];
    }
    
    //
    ListNode *cur = [ListNode nodeValue:0 next:nil];;
    for (NSInteger i = 0; i < stack2.count; i++) {
        ListNode *temp = [ListNode nodeValue:stack2[i].integerValue next:nil];
        temp.next = cur;
        cur = temp;
    }
    return cur;
}

- (void)action1233
{
    // 1233. 删除子文件夹
    /*
     你是一位系统管理员，手里有一份文件夹列表 folder，你的任务是要删除该列表中的所有 子文件夹，并以 任意顺序 返回剩下的文件夹。
     我们这样定义「子文件夹」：
     如果文件夹 folder[i] 位于另一个文件夹 folder[j] 下，那么 folder[i] 就是 folder[j] 的子文件夹。
     文件夹的「路径」是由一个或多个按以下格式串联形成的字符串：
     / 后跟一个或者多个小写英文字母。
     例如，/leetcode 和 /leetcode/problems 都是有效的路径，而空字符串和 / 不是。
     
     输入：folder = ["/a","/a/b","/c/d","/c/d/e","/c/f"]
     输出：["/a","/c/d","/c/f"]
     解释："/a/b/" 是 "/a" 的子文件夹，而 "/c/d/e" 是 "/c/d" 的子文件夹。

     输入：folder = ["/a","/a/b/c","/a/b/d"]
     输出：["/a"]
     解释：文件夹 "/a/b/c" 和 "/a/b/d/" 都会被删除，因为它们都是 "/a" 的子文件夹。

     输入：folder = ["/a/b/c","/a/b/d","/a/b/ca"]
     输出：["/a/b/c","/a/b/ca","/a/b/d"]
     */
    
    NSArray *folders = @[@[@"/a",@"/a/b",@"/c/d",@"/c/d/e",@"/c/f"], @[@"/a",@"/a/b/c",@"/a/b/d"], @[@"/a/b/c",@"/a/b/d",@"/a/b/ca"]];
    for (NSInteger i = 0; i < folders.count; i++) {
        NSArray *result = [self action1233Nums:folders[i]];
        NSLog(@"%@", result);
    }
}

- (NSArray <NSString *>*)action1233Nums:(NSArray <NSString *>*)folders
{
    if (folders.count <= 1) {
        return folders;
    }
    
    NSMutableArray *sortFolders = [folders sortedArrayUsingSelector:@selector(compare:)].mutableCopy;
    NSMutableArray *stack = [NSMutableArray array];
    [stack addObject:sortFolders.firstObject];
    
    for (NSInteger i = 1; i < sortFolders.count; i++) {
        
        NSString *pre = [NSString stringWithFormat:@"%@/", stack.lastObject];
        if ([sortFolders[i] hasPrefix:pre]) {
            continue;
        } else {
            [stack addObject:sortFolders[i]];
        }
    }
    return stack.copy;
}

- (void)action1
{
    // 1. 两数之和
    /*
     请你在该数组中找出 和为目标值 的那 两个 整数，并返回它们的数组下标。你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。
     
     输入：nums = [2,7,11,15], target = 9
     输出：[0,1]
     解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。

     输入：nums = [3,2,4], target = 6
     输出：[1,2]

     输入：nums = [3,3], target = 6
     输出：[0,1]
     */
    NSArray *nums = @[
    @[@(2),@(7),@(11),@(15)],
    @[@(3),@(2),@(4)],
    @[@(3),@(3)]
    ];
    NSArray <NSNumber *>*targets = @[@(9),@(6),@(6)];
    for (NSInteger i = 0; i < nums.count; i++) {
        NSArray *result = [self action1Nums:nums[i] target:targets[i].integerValue];
        NSLog(@"%@", result);
    }
}

- (NSArray <NSNumber *>*)action1Nums:(NSArray <NSNumber *>*)nums target:(NSInteger)target
{
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < nums.count; i++) {
        NSInteger key = target - nums[i].integerValue;
        if ([map.allKeys containsObject:@(key).stringValue]) {
            return @[map[@(key).stringValue], @(i)];
        } else {
            [map setValue:@(i) forKey:nums[i].stringValue];
        }
    }
    return nil;
}

- (void)action20
{
    // 20. 有效的括号
    /*
     给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。
     有效字符串需满足：

     左括号必须用相同类型的右括号闭合。
     左括号必须以正确的顺序闭合。
     */
    NSArray *arr = @[@"()", @"()[]{}", @"(]", @"([)]", @"{[]}"];
    
    for (NSString *s in arr) {
        BOOL result = [self action20:s];
        NSLog(@"%d", result);
    }
    NSLog(@"答案 true true false false ture");
}

- (BOOL)action20:(NSString *)s
{
    if (s.length == 0) {
        return NO;
    }
    
    NSString *sub = [s substringWithRange:NSMakeRange(0, 1)];
    if ([@[@")", @"}", @"]"] containsObject:sub]) {
        return NO;
    }
    
    // get arr
    NSMutableArray *sArray = [NSMutableArray array];
    for (NSInteger i = 0; i < s.length; i++) {
        NSString *sub = [s substringWithRange:NSMakeRange(i, 1)];
        [sArray addObject:sub];
    }
        
    NSMutableArray *stack = [NSMutableArray array];
    for (NSInteger i = 0; i < sArray.count; i++) {
        NSString *sub = sArray[i];
        if ([sub isEqualToString:@"("]) {
            [stack addObject:@")"];
        } else if ([sub isEqualToString:@"["]) {
            [stack addObject:@"]"];
        } else if ([sub isEqualToString:@"{"]) {
            [stack addObject:@"}"];
        } else if (stack.count == 0) {
            return NO;
        } else {
            if ([sub isEqualToString:stack.lastObject]) {
                [stack removeLastObject];
            } else {
                return NO;
            }
        }
    }
    return !stack.count;
}


- (void)action189
{
    // 189. 旋转数组
    /*
     给定一个数组，将数组中的元素向右移动 k
     输入: nums = [1,2,3,4,5,6,7], k = 3
     输出: [5,6,7,1,2,3,4]位置，其中 k 是非负数。
     */
    NSArray *nums = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7)];
    NSArray *result = [self action189:nums targrt:3];
    NSLog(@"%@", result);
}

- (NSArray <NSNumber *>*)action189:(NSArray <NSNumber *>*)nums targrt:(NSInteger)k
{
    NSMutableArray *mnums = nums.mutableCopy;
    for (NSInteger i = 0; i < k; i++) {
        NSNumber *temp = mnums.lastObject;
        for (NSInteger j = mnums.count - 1; j > 0; j--) {
            mnums[j] = mnums[j-1];
        }
        mnums[0] = temp;
    }
    return mnums;
}

- (void)action48
{
    // 48. 旋转图像
    /*
     给定一个 n × n 的二维矩阵 matrix 表示一个图像。请你将图像顺时针旋转 90 度。
     你必须在 原地 旋转图像，这意味着你需要直接修改输入的二维矩阵。请不要 使用另一个矩阵来旋转图像。
     
     matrix = [[1,2,3],[4,5,6],[7,8,9]]
     输出：[[7,4,1],[8,5,2],[9,6,3]]
     */
    NSArray <NSMutableArray <NSNumber *>*>*matrix = @[@[@(1),@(2),@(3)].mutableCopy,
                                                             @[@(4),@(5),@(6)].mutableCopy,
                                                             @[@(7),@(8),@(9)].mutableCopy
    ];
    [self action48Rotate:matrix];
    NSLog(@"%@", matrix);
}

// 先以对角线（左上<—>右下）为轴进行翻转，再对每行左右翻转即可
// https://leetcode-cn.com/problems/rotate-image/solution/ji-qiao-ti-zai-zeng-song-yi-wei-xing-shi-377z/
- (void)action48Rotate:(NSArray <NSMutableArray <NSNumber *>*>*)matrix
{
    NSInteger n = matrix.count;
    // 先以对角线（左上-右下）为轴进行翻转
    for (int i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            NSInteger tmp = matrix[i][j].integerValue;
            matrix[i][j] = matrix[j][i];
            matrix[j][i] = @(tmp);
        }
    }
    
    // 再对每一行以中点进行翻转
    NSInteger mid = n >> 1;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < mid; j++) {
            NSInteger tmp = matrix[i][j].integerValue;
            matrix[i][j] = matrix[i][n - 1 - j];
            matrix[i][n - 1 - j] = @(tmp);
        }
    }
}

- (void)action101
{
    // 101. 对称二叉树
    /*
     给定一个二叉树，检查它是否是镜像对称的。
     例如，二叉树 [1,2,2,3,4,4,3] 是对称的。
         1
        / \
       2   2
      / \ / \
     3  4 4  3
     但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:

         1
        / \
       2   2
        \   \
        3    3
     */
    TreeNode *node6 = [TreeNode nodeValue:3 left:nil right:nil];
    TreeNode *node5 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node4 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:3 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:2 left:node5 right:node6];
    TreeNode *node1 = [TreeNode nodeValue:2 left:node3 right:node4];
    TreeNode *head = [TreeNode nodeValue:1 left:node1 right:node2];
    BOOL isCom = [self action101Node:head.left node:head.right];
    NSLog(@"isCom %@", isCom ? @"yes" : @"no");
}

- (BOOL)action101Node:(TreeNode *)left node:(TreeNode *)right
{
    // 2边都为空 相等
    if (!left && !right) {
        return YES;
    }
    
    // 2遍不等 返回NO
    if (left.value != right.value) {
        return NO;
    }
    
    // 比较子树
    BOOL same0 = [self action101Node:left.left node:right.right];
    BOOL same1 = [self action101Node:left.right node:right.left];
    return same0 && same1;
}

- (void)action151
{
    //151.翻转字符串里的单词
    /*
     给定一个字符串，逐个翻转字符串中的每个单词。

     说明：
     无空格字符构成一个 单词 。
     输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
     如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
     输入："the sky is blue"
     输出："blue is sky the"

     输入："  hello world!  "
     输出："world! hello"
     解释：输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。

     输入："a good   example"
     输出："example good a"
     解释：如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。

     输入：s = "  Bob    Loves  Alice   "
     输出："Alice Loves Bob"

     输入：s = "Alice does not even like bob"
     输出："bob like even not does Alice"
     */
    
    NSArray *arr = @[@"the sky is blue",
                     @"  hello world!  ",
                     @"a good   example",
                     @"  Bob    Loves  Alice   ",
                     @"Alice does not even like bob"];
    for (NSString *s in arr) {
        NSString *result = [self action151ReverseWords:s];
        NSLog(@"%@", result);
    }
}

- (NSString *)action151ReverseWords:(NSString *)s
{
    s = [s stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet]; // 删除首尾空格
    NSInteger j = s.length - 1, i = j;
    NSString *res = @"";
    while(i >= 0) {
        while(i >= 0 && ![[s substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "])
        {
            i--; // 搜索首个空格
        }
        // 从空格后一个 开始截取字符串
        NSString *sub = [s substringWithRange:NSMakeRange(i+1, j-(i+1)+1)];
        if (res.length == 0) {
            res = sub;
        } else {
            res = [NSString stringWithFormat:@"%@ %@", res, sub];
        }
        // 跳过单词间空格
        while(i >= 0 && [[s substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "])
        {
            i--;
        }
        j = i; // j 指向下个单词的尾字符
    }
    return res; // 转化为字符串并返回
}

- (void)action33
{
    // 33. 搜索旋转排序数组
    /*
     升序排列的整数数组 nums 在预先未知的某个点上进行了旋转（例如， [0,1,2,4,5,6,7] 经旋转后可能变为 [4,5,6,7,0,1,2] ）。
     请你在数组中搜索 target ，如果数组中存在这个目标值，则返回它的索引，否则返回 -1 。

     输入：nums = [4,5,6,7,0,1,2], target = 0
     输出：4

     输入：nums = [4,5,6,7,0,1,2], target = 3
     输出：-1

     输入：nums = [1], target = 0
     输出：-1
     */
    
    NSInteger result = [self action33Nums:@[@(4), @(5), @(6), @(7), @(0), @(1), @(2)] target:0];
    NSLog(@"%ld", result);
}

- (NSInteger)action33Nums:(NSArray <NSNumber *>*)nums target:(NSInteger)target
{
    NSInteger n = nums.count;
    if (n == 0) {
        return -1;
    }
    if (n == 1) {
        return nums[0].integerValue == target ? 0 : -1;
    }
    
    NSInteger left = 0;
    NSInteger right = n - 1;
    while (left <= right) {
        NSInteger mid = (right - left + 1) >> 1;
        
        if (nums[mid].integerValue == target) return mid;
        
        // 找有序数组 用有序数组来判断区间
        if (nums[0].integerValue <= nums[mid].integerValue) {
            // 0 - mid 是有序的
            if (nums[0].integerValue <= target && target < nums[mid].integerValue) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        } else {
            // mid - n-1 是有序的
            if (nums[mid].integerValue < target && target <= nums[n - 1].integerValue) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
    }
    return -1;

}

- (void)action86
{
    // 86. 分隔链表
    /*
     给你一个链表和一个特定值 x ，请你对链表进行分隔，使得所有小于 x 的节点都出现在大于或等于 x 的节点之前。
     你应当保留两个分区中每个节点的初始相对位置。

     输入：head = 1->4->3->2->5->2, x = 3
     输出：1->2->2->4->3->5
     */
    ListNode *node5 = [ListNode nodeValue:2 next:nil];
    ListNode *node4 = [ListNode nodeValue:5 next:node5];
    ListNode *node3 = [ListNode nodeValue:2 next:node4];
    ListNode *node2 = [ListNode nodeValue:3 next:node3];
    ListNode *node1 = [ListNode nodeValue:4 next:node2];
    ListNode *node = [ListNode nodeValue:1 next:node1];
    
    ListNode *result = [self action86:node target:3];
    NSLog(@"%@", result);
}

- (ListNode *)action86:(ListNode *)head target:(NSInteger)x
{
    ListNode* small = [ListNode nodeValue:0 next:nil];
    ListNode* smallHead = small;
    ListNode* large = [ListNode nodeValue:0 next:nil];
    ListNode* largeHead = large;
    while (head != nil) {
        if (head.value < x) {
            small.next = head;
            small = small.next;
        } else {
            large.next = head;
            large = large.next;
        }
        head = head.next;
    }
    large.next = nil;
    small.next = largeHead.next;
    return smallHead.next;
}

- (void)action236
{
    // 236. 二叉树的最近公共祖先
    /*
     给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。
     输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
     输出: 3
     解释: 节点 5 和节点 1 的最近公共祖先是节点 3。

     输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
     输出: 5
     */
    
    TreeNode *node8 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node7 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node6 = [TreeNode nodeValue:8 left:nil right:nil];
    TreeNode *node5 = [TreeNode nodeValue:0 left:nil right:nil];
    TreeNode *node4 = [TreeNode nodeValue:2 left:node7 right:node8];
    TreeNode *node3 = [TreeNode nodeValue:6 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:1 left:node5 right:node6];
    TreeNode *node1 = [TreeNode nodeValue:5 left:node3 right:node4];
    TreeNode *node = [TreeNode nodeValue:3 left:node1 right:node2];
    
    TreeNode *common = [self action236TreeNode:node p:node1 q:node8];
    NSLog(@"%ld", common.value);
}

- (TreeNode *)action236TreeNode:(TreeNode *)root p:(TreeNode *)p q:(TreeNode *)q
{
    if (root == nil || root == q || root == p) return root;
    
    TreeNode *left = [self action236TreeNode:root.left p:p q:q];
    TreeNode *right = [self action236TreeNode:root.right p:p q:q];
    // 说明左右子树 都不含pq 返回 nil
    if(left == nil && right == nil) return nil;
    // pq都在右子树中 返回right即可
    if(left == nil) return right;
    // pq都在左子树中 返回left即可
    if(right == nil) return left;
    // 左右都不为空 说明pq在两侧 直接返回root
    return root;
}

- (void)action23
{
    // 23.合并K个升序链表
    /*
     请你将所有链表合并到一个升序链表中，返回合并后的链表。
     输入：lists = [[1,4,5],[1,3,4],[2,6]]
     输出：[1,1,2,3,4,4,5,6]
     
     */
    
    ListNode *node02 = [ListNode nodeValue:5 next:nil];
    ListNode *node01 = [ListNode nodeValue:4 next:node02];
    ListNode *node00 = [ListNode nodeValue:1 next:node01];
    
    ListNode *node12 = [ListNode nodeValue:4 next:nil];
    ListNode *node11 = [ListNode nodeValue:3 next:node12];
    ListNode *node10 = [ListNode nodeValue:1 next:node11];
    
    ListNode *node21 = [ListNode nodeValue:6 next:nil];
    ListNode *node20 = [ListNode nodeValue:2 next:node21];

    NSArray *nodeArray = @[node00, node10, node20];
    ListNode *result = [self action23MergeKLists:nodeArray];
    NSLog(@"%@", result);
}

- (ListNode *)action23MergeKLists:(NSArray *)lists
{
    if (lists == nil || lists.count == 0) return nil;
    return [self action23Merge:lists left:0 right:lists.count - 1];
}

- (ListNode *)action23Merge:(NSArray *)lists left:(NSInteger)left right:(NSInteger)right
{
    if (left == right) {
        return lists[left];
    }
    
    NSInteger mid = left + (right - left) / 2;
    ListNode *l1 = [self action23Merge:lists left:left right:mid];
    ListNode *l2 = [self action23Merge:lists left:mid + 1 right:right];
    return [self action23MergeTwo:l1 node:l2];
}
// 合并2个链表
- (ListNode *)action23MergeTwo:(ListNode *)l1 node:(ListNode *)l2
{
    if (l1 == nil) return l2;
    if (l2 == nil) return l1;
    if (l1.value < l2.value) {
        l1.next = [self action23MergeTwo:l1.next node:l2];
        return l1;
    } else {
        l2.next = [self action23MergeTwo:l1 node:l2.next];
        return l2;
    }
}

@end
