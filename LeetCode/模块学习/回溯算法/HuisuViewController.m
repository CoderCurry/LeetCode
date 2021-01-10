//
//  HuisuViewController.m
//  BaseProjectFramework
//
//  Created by curryZ on 2021/1/2.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "HuisuViewController.h"

@interface HuisuViewController ()

@end

@implementation HuisuViewController

/*
 ** 回溯算法 **
 - 如果解决一个问题有多个步骤，每一个步骤有多种方法，题目又要我们找出所有的方法，可以使用回溯算法；
 - 回溯算法是在一棵树上的 深度优先遍历（因为要找所有的解，所以需要遍历）；
 - 组合问题，相对于排列问题而言，不计较一个组合内元素的顺序性（即 [1, 2, 3] 与 [1, 3, 2] 认为是同一个组合），因此很多时候需要按某种顺序展开搜索，这样才能做到不重不漏。

 回溯算法首先需要画出递归树，不同的树决定了不同的代码实现。 横向是for 纵向是递归
 回溯法，一般可以解决如下几种问题：

 组合问题：N个数里面按一定规则找出k个数的集合
 排列问题：N个数按一定规则全排列，有几种排列方式
 切割问题：一个字符串按一定规则有几种切割方式
 子集问题：一个N个数的集合里有多少符合条件的子集
 棋盘问题：N皇后，解数独等等
 
 回溯算法模板框架如下：
 void backtracking(参数) {
     if (终止条件) {
         存放结果;
         return;
     }

     for (选择：本层集合中元素（树中节点孩子的数量就是集合的大小）) {
         处理节点;
         backtracking(路径，选择列表); // 递归
         回溯，撤销处理结果
     }
 }

 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configRowTitles:@[@"组合问题",
                            @"组合总和III",
                            @"电话号码的字母组合",
                            @"组合总和",
                            @"组合总和II"
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
           
        default:
            break;
    }
}

- (void)action0 {
    // 77 组合问题
    /*
     给定两个整数 n 和 k，返回 1 ... n 中所有可能的 k 个数的组合。
     示例:
     输入: n = 4, k = 2
     输出:
     [
     [2,4],
     [3,4],
     [2,3],
     [1,2],
     [1,3],
     [1,4],
     ]
     */
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *path = [NSMutableArray arrayWithCapacity:0];
    
    [self backtrackingn:4 k:2 startIndex:1 resultArray:result pathArray:path];
    NSLog(@"result:%@, path:%@", result, path);
}

- (void)backtrackingn:(NSInteger)n
                    k:(NSInteger)k
           startIndex:(NSInteger)startIndex
          resultArray:(NSMutableArray *)result
            pathArray:(NSMutableArray *)path
{
    if (path.count == k) {
        [result addObject:path.copy];
        return;
    }
    // for 循环是横向遍历 递归是纵向遍历
    // 剪枝处理
    // for (int i = startIndex; i <= n - (k - path.size()) + 1; i++)
    for (NSInteger i = startIndex; i <= n; i++)
    {
        [path addObject:@(i)];// 处理节点
        [self backtrackingn:n
                          k:k
                 startIndex:i+1
                resultArray:result
                  pathArray:path]; // 递归
        [path removeObject:@(i)];// 回溯，撤销处理的节点
    }
}

static NSInteger sum = 0;
- (void)action1
{
    // 216 组合总和III
    // 找出所有相加之和为 n 的 k 个数的组合。组合中只允许含有 1 - 9 的正整数，并且每种组合中不存在重复的数字。
    /*
     示例 1:
     输入: k = 3, n = 7
     输出: [[1,2,4]]

     示例 2:
     输入: k = 3, n = 9
     输出: [[1,2,6], [1,3,5], [2,3,4]]
     */
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    [self result:result path:path target:7 numCount:3 startIndex:1];
    NSLog(@"result:%@", result);
}

- (void)result:(NSMutableArray *)result
          path:(NSMutableArray *)path
        target:(NSInteger)n
      numCount:(NSInteger)k
    startIndex:(NSInteger)startIndex
{
    // 剪纸 当sum已经大于n时不必再进行下去了
    if (sum >= n) {
        return;
    }

    if (path.count == k) {
        if (sum == n) {
            [result addObject:path.copy];
        }
        return;
    }
    for (NSInteger i = startIndex; i <= 9; i++) {
        sum += i;
        [path addObject:@(i)];
        [self result:result path:path target:n numCount:k startIndex:i+1];
        sum -= i;
        [path removeObject:@(i)];
    }
}

- (void)action2
{
    // 17 电话号码的字母组合
    // 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。 给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。
    /*
     示例:
     输入："23"
     输出：["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
     */
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    NSArray *nums = @[@(2), @(3)];
    NSDictionary *map = @{
        @"0": @[],
        @"1": @[],
        @"2": @[@"a", @"b", @"c"],
        @"3": @[@"d", @"e", @"f"],
        @"4": @[@"g", @"h", @"i"],
        @"5": @[@"j", @"k", @"l"],
        @"6": @[@"m", @"n", @"o"],
        @"7": @[@"p", @"q", @"r", @"s"],
        @"8": @[@"t", @"u", @"v"],
        @"9": @[@"w", @"x", @"y", @"z"],
    };
    
    [self result:result nums:nums path:path map:map index:0];
    NSLog(@"result %@", result);
}

- (void)result:(NSMutableArray *)result
          nums:(NSArray *)nums
          path:(NSMutableArray *)path
           map:(NSDictionary *)map
         index:(NSInteger)index
{
    if (index == nums.count) {
        [result addObject:path.copy];
        return;
    }

    NSArray *letters =  map[[nums[index] stringValue]];
    for (int i = 0; i < letters.count; i++) {
        [path addObject:letters[i]];            // 处理
        [self result:result nums:nums path:path map:map index:index+1]; // 递归，注意index+1，一下层要处理下一个数字了
        [path removeLastObject];                       // 回溯
    }
}

- (void)action3
{
    // 39. 组合总和
    // 给定一个无重复元素的数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。 candidates 中的数字可以无限制重复被选取。
    /*
     示例 1：
     输入：candidates = [2,3,6,7], target = 7,
     所求解集为：
     [
     [7],
     [2,2,3]
     ]

     示例 2：
     输入：candidates = [2,3,5], target = 8,
     所求解集为：
     [
       [2,2,2,2],
       [2,3,3],
       [3,5]
     ]
     */
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    NSArray *nums = @[@(2), @(3), @(6), @(7)];
    NSInteger target = 7;
//    NSArray *nums = @[@(2), @(3), @(5)];
//    NSInteger target = 8;
    
    [self action3Result:result path:path nums:nums target:target startIndex:0];
    NSLog(@"result %@", result);
}

- (void)action3Result:(NSMutableArray *)result
                 path:(NSMutableArray <NSNumber *>*)path
                 nums:(NSArray <NSNumber *>*)nums
               target:(NSInteger)target
           startIndex:(NSInteger)startIndex
{
    if (sum > target) {
        return;
    }
    
    if (sum == target) {
        [result addObject:path.copy];
        return;
    }
    
    for (NSInteger i = startIndex; i < nums.count; i++) {
        [path addObject:nums[i]];
        sum += nums[i].integerValue;
        // 可重复使用元素 startIndex 不用+1
        [self action3Result:result path:path nums:nums target:target startIndex:i];
        [path removeLastObject];
        sum -= nums[i].integerValue;
    }
}

- (void)action4
{
    // 40.组合总和II
    /*
     给定一个数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。
     candidates 中的每个数字在每个组合中只能使用一次。

     说明：
     所有数字（包括目标数）都是正整数。
     解集不能包含重复的组合。

     示例 1:
     输入: candidates = [10,1,2,7,6,1,5], target = 8,
     所求解集为:
     [
     [1, 7],
     [1, 2, 5],
     [2, 6],
     [1, 1, 6]
     ]

     示例 2:
     输入: candidates = [2,5,2,1,2], target = 5,
     所求解集为:
     [
       [1,2,2],
       [5]
     ]
     */
    
    
    // 要去重的是“同一树层上的使用过
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    NSMutableArray *used = [NSMutableArray array];
    NSArray *nums = @[@(10), @(1), @(2), @(7), @(6), @(1), @(5)];
    NSInteger target = 8;
//    NSArray *nums = @[@(2), @(3), @(5)];
//    NSInteger target = 8;
    for (int i = 0; i < nums.count; i++) {
        [used addObject:@(NO)];
    }
    [self action4Result:result path:path nums:nums used:used target:target startIndex:0];
    NSLog(@"result %@", result);
}

- (void)action4Result:(NSMutableArray *)result
                 path:(NSMutableArray <NSNumber *>*)path
                 nums:(NSArray <NSNumber *>*)nums
                 used:(NSMutableArray <NSNumber *>*)used
               target:(NSInteger)target
           startIndex:(NSInteger)startIndex
{

}

@end
