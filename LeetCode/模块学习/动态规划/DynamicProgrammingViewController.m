//
//  DynamicProgrammingViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/22.
//

#import "DynamicProgrammingViewController.h"

@interface DynamicProgrammingViewController ()

@end

@implementation DynamicProgrammingViewController

/*
 动态规划，英文：Dynamic Programming，简称DP，如果某一问题有很多重叠子问题，使用动态规划是最有效的
 所以动态规划中每一个状态一定是由上一个状态推导出来的，这一点就区分于贪心，贪心没有状态推导，而是从局部直接选最优的
 
 对于动态规划问题，我将拆解为如下五步曲，这五步都搞清楚了，才能说把动态规划真的掌握了！

- 确定dp数组（dp table）以及下标的含义
- 确定递推公式
- dp数组如何初始化
- 确定遍历顺序
- 举例推导dp数组
 
 通过不了，其实可以自己先思考这三个问题：

 - 这道题目我举例推导状态转移公式了么？
 - 我打印dp数组的日志了么？
 - 打印出来了dp数组和我想的一样么？
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configRowTitles:@[
        @"斐波那契数",
        @"爬楼梯",
        @"使用最小花费爬楼梯",
        @"不同路径 II",
        @"整数拆分",
        @"不同的二叉搜索树"
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
            
        default:
            break;
    }
}

- (void)action0
{
    // 509 斐波那契数
    /*
     斐波那契数，通常用 F(n) 表示，形成的序列称为 斐波那契数列 。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：
     F(0) = 0，F(1) = 1
     F(n) = F(n - 1) + F(n - 2)，其中 n > 1
     给你n ，请计算 F(n) 。
     
     输入：2
     输出：1
     解释：F(2) = F(1) + F(0) = 1 + 0 = 1

     输入：3
     输出：2
     解释：F(3) = F(2) + F(1) = 1 + 1 = 2

     输入：4
     输出：3
     解释：F(4) = F(3) + F(2) = 2 + 1 = 3
     */
    
    NSArray <NSNumber *>*arr = @[@(2), @(3), @(4)];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSInteger result = [self action0Fib:arr[i].integerValue];
        NSLog(@"%ld", result);
    }
}

- (NSInteger)action0Fib:(NSInteger)n
{
    NSMutableArray <NSNumber *>*dp = [NSMutableArray array];
    for (NSInteger i = 0; i < n; i++) {
        [dp addObject:@(0)];
    }
    
    dp[0] = @(0);
    dp[1] = @(1);
    
    for (int i = 2; i <= n; i++) {
        dp[i] = @(dp[i - 1].integerValue + dp[i - 2].integerValue);
    }
    return dp[n].integerValue;
}

- (void)action1
{
    // 70 爬楼梯
    /*
     假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
     每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
     注意：给定 n 是一个正整数。

     输入：2
     输出：2
     解释：有两种方法可以爬到楼顶。
     1 阶 + 1 阶
     2 阶

     输入：3
     输出：3
     解释：有三种方法可以爬到楼顶。
     1 阶 + 1 阶 + 1 阶
     1 阶 + 2 阶
     2 阶 + 1 阶
     */
    NSArray <NSNumber *>*arr = @[@(2), @(3), @(4), @(5)];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSInteger result = [self action1Step:arr[i].integerValue];
        NSLog(@"%ld", result);
    }
}

- (NSInteger)action1Step:(NSInteger)n
{
    NSMutableArray <NSNumber *>*dp = [NSMutableArray array];
    for (NSInteger i = 0; i <= n; i++) {
        [dp addObject:@(0)];
    }
//    0 1 2
    dp[1] = @(1);
    dp[2] = @(2);
    
    for (int i = 3; i <= n; i++) {
        dp[i] = @(dp[i - 1].integerValue + dp[i - 2].integerValue);
    }
    return dp[n].integerValue;
}

- (void)action2
{
    // 746. 使用最小花费爬楼梯
    /*
     数组的每个下标作为一个阶梯，第 i 个阶梯对应着一个非负数的体力花费值 cost[i]（下标从 0 开始）。
     每当你爬上一个阶梯你都要花费对应的体力值，一旦支付了相应的体力值，你就可以选择向上爬一个阶梯或者爬两个阶梯。

     输入：cost = [10, 15, 20]
     输出：15
     解释：最低花费是从 cost[1] 开始，然后走两步即可到阶梯顶，一共花费 15 。

     输入：cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
     输出：6
     解释：最低花费方式是从 cost[0] 开始，逐个经过那些 1 ，跳过 cost[3] ，一共花费 6

     */
    NSArray <NSNumber *>* cost = @[@(1), @(100), @(1), @(1), @(1), @(100), @(1), @(1), @(100), @(1)];
    NSInteger result = [self action2MinStop2:cost];
    NSLog(@"result %ld", result);
}

/*
 1. dp[i]的定义：第i个台阶所花费的最少体力为dp[i]。
 2. 确定递推公式 dp[i] = min(dp[i - 1], dp[i - 2]) + cost[i];
 3. 初始化 dp[0] = cost[0]; dp[1] = cost[1];
 4. 确定遍历顺序 dp[i]由dp[i-1]dp[i-2]推出 前到后遍历cost数组就可以了
 5. 举例推导dp数组
 cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
 dp =   [1, 100, 2, 3, 3, 103, 4, 5, 104, 6]
 打印dp数组打印出来，看看和如上推导的是不是一样的
 */

- (NSInteger)action2MinStop:(NSArray <NSNumber *>*)cost
{
    NSMutableArray <NSNumber *>*dp = [NSMutableArray array];
    for (NSInteger i = 0; i < cost.count; i++) {
        [dp addObject:@(0)];
    }
    
    dp[0] = cost[0];
    dp[1] = cost[1];
    NSLog(@"过程 %ld", dp[0].integerValue);
    NSLog(@"过程 %ld", dp[1].integerValue);
    for (NSInteger i = 2; i < cost.count; i++) {
        dp[i] = @(MIN(dp[i-1].integerValue, dp[i-2].integerValue) + cost[i].integerValue);
        NSLog(@"过程 %ld", dp[i].integerValue);
    }
    // 登顶的那一步 不花费体力 看前两步谁最少
    return MIN(dp[cost.count-1].integerValue, dp[cost.count-2].integerValue);
}
// 还可以优化空间复杂度，因为dp[i]就是由前两位推出来的，那么也不用dp数组了
- (NSInteger)action2MinStop2:(NSArray <NSNumber *>*)cost
{
    NSInteger dp0 = cost[0].integerValue;
    NSInteger dp1 = cost[1].integerValue;
    NSLog(@"过程 %ld", dp0);
    NSLog(@"过程 %ld", dp1);
    for (NSInteger i = 2; i < cost.count; i++) {
        NSInteger dpi = MIN(dp0, dp1) + cost[i].integerValue;
        dp0 = dp1;
        dp1 = dpi;
        NSLog(@"过程 %ld", dpi);
    }
    return MIN(dp0, dp1);
}

- (void)action3
{
    // 63. 不同路径 II
    /*
     一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为“Start” ）。
     机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为“Finish”）。
     现在考虑网格中有障碍物。那么从左上角到右下角将会有多少条不同的路径？

     输入：obstacleGrid = [[0,0,0],[0,1,0],[0,0,0]]
     输出：2
     解释：
     3x3 网格的正中间有一个障碍物。
     从左上角到右下角一共有 2 条不同的路径：
     1. 向右 -> 向右 -> 向下 -> 向下
     2. 向下 -> 向下 -> 向右 -> 向右

     输入：obstacleGrid = [[0,1],[0,0]]
     输出：1
     */
    NSArray <NSArray <NSNumber *>*>*map = @[
        @[@(0),@(0),@(0)],
        @[@(0),@(1),@(0)],
        @[@(0),@(0),@(0)],
    ];
    NSInteger num = [self action3Path:map];
    NSLog(@"%ld", num);
}

- (NSInteger)action3Path:(NSArray <NSArray <NSNumber *>*>*)map
{
    NSMutableArray <NSMutableArray <NSNumber *>*>*dp = [NSMutableArray array];
    for (NSInteger i = 0; i < map.count; i++) {
        NSMutableArray <NSNumber *>*row = [NSMutableArray array];
        for (NSInteger j = 0; j < map.firstObject.count; j++) {
            if (i == 0 || j == 0) {
                [row addObject:@(1)];
            } else {
                [row addObject:@(0)];
            }
        }
        [dp addObject:row];
    }
    
    NSInteger row = map.count;
    NSInteger col = map.firstObject.count;
    
    for (int i = 1; i < row; i++) {
        for (int j = 1; j < col; j++) {
            if ([map[i][j] isEqual:@(1)]) {
                dp[i][j] = @(0);
            } else {
                dp[i][j] = @(dp[i - 1][j].integerValue + dp[i][j - 1].integerValue);
            }
        }
    }
    return dp[row-1][col-1].integerValue;
}

- (void)action4
{
    // 343 整数拆分
    /*
     给定一个正整数 n，将其拆分为至少两个正整数的和，并使这些整数的乘积最大化。返回你可以获得的最大乘积。

     示例 1: 输入: 2
     输出: 1
     解释: 2 = 1 + 1, 1 × 1 = 1。

     示例 2:
     输入: 10
     输出: 36
     解释: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36。
     说明: 你可以假设 n 不小于 2 且不大于 58
     */
    NSInteger result = [self action4Break:10];
    NSLog(@"result %ld", result);
}

- (NSInteger)action4Break:(NSInteger)n
{
    NSMutableArray <NSNumber *>*dp = [NSMutableArray array];
    for (NSInteger i = 0; i <= n; i++) {
        [dp addObject:@(0)];
    }
    dp[2] = @(1);
    for (int i = 3; i <= n ; i++) {
        for (int j = 1; j < i - 1; j++) {
            dp[i] = @(MAX(dp[i].integerValue, MAX((i - j) * j, dp[i - j].integerValue * j)));
        }
    }
    return dp[n].integerValue;
}

- (void)action5
{
    // 96 不同的二叉搜索树
    /*
     给定一个整数 n，求以 1 ... n 为节点组成的二叉搜索树有多少种？

     输入: 3
     输出: 5
     解释:
     给定 n = 3, 一共有 5 种不同结构的二叉搜索树:

        1         3     3      2      1
         \       /     /      / \      \
          3     2     1      1   3      2
         /     /       \                 \
        2     1         2                 3
     */
}

@end
