//
//  LeetCodeTopViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/20.
//

#import "LeetCodeTopViewController.h"
#import "ListNode.h"

@interface LeetCodeTopViewController ()

@end

@implementation LeetCodeTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configRowTitles:@[
        @"200.岛屿数量",
        @"463.岛屿的周长",
        @"695.岛屿的最大面积",
        @"827.最大人工岛",
        
        @"53. 最大子序和",
        @"25. K个一组翻转链表",
        @"5. 最长回文子串",
        @"32. 最长有效括号",
    ]];
}


- (void)didSelectRowAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self action0];
            break;
        case 1:
            [self action1];
            break;
        case 2:
            [self action2];
            break;
        case 3:
            [self action3];
            break;
        case 4:
            [self action4];
            break;
        case 5:
            [self action5];
            break;
        case 6:
            [self action6];
            break;
        case 7:
            [self action7];
            break;
            
        default:
            break;
    }
}

- (void)action0
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
    
    //如果这个格子不是岛屿，直接返回
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

- (void)action1
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

- (void)action2
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

- (void)action3
{
    // 827 填海造陆问题
    
}

- (void)action4
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

- (void)action5
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

- (void)action6
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

// 中心扩散法
- (NSString *)action6LongestPalindrome:(NSString *)s
{
    if (s.length < 1) {
        return @"";
    }
    
    NSInteger maxLength = 1;
    NSInteger begin = 0;
    // 最后一个位置违法向右延伸 所以不用枚举
    for (NSInteger i = 0; i < s.length - 1; i++) {
        NSInteger len1 = [self action6ExpandAroundCenter:s left:i right:i];
        NSInteger len2 = [self action6ExpandAroundCenter:s left:i right:i+1];
        NSInteger curMaxLength = MAX(len1, len2);
        if (curMaxLength > maxLength) {
            maxLength = curMaxLength;
            begin = i - (maxLength - 1) / 2;
        }
    }
    return [s substringWithRange:NSMakeRange(begin, maxLength)];
}

/// 回文串长度
/// @param s 字符串
/// @param left 起始左
/// @param right 起始右
- (NSInteger)action6ExpandAroundCenter:(NSString *)s left:(NSInteger)left right:(NSInteger)right
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
    // j - 1 -( i + 1) + 1
    return j - i - 1;
}

- (NSString *)action6CharAtIndex:(NSInteger)index s:(NSString *)s
{
    return [s substringWithRange:NSMakeRange(index, 1)];
}

- (void)action7
{
    // 32. 最长有效括号
    // 给你一个只包含 '(' 和 ')' 的字符串，找出最长有效（格式正确且连续）括号子串的长度。
    /*
     输入：s = "(()"
     输出：2
     解释：最长有效括号子串是 "()"

     输入：s = ")()())"
     输出：4
     解释：最长有效括号子串是 "()()"

     输入：s = ""
     输出：0

     */
}

@end
