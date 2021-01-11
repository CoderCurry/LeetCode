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
 回文串: 是一个正读和反读都一样的字符串，比如“level”或者“noon”等等就是回文串
 */

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
                            @"组合总和II",
                            @"分割回文串",
                            @"复原IP地址",
                            @"子集",
                            @"子集II"
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
        case 8:
            [self action8];
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

- (void)action5
{
    // 131 分割回文串
    // 给定一个字符串 s，将 s 分割成一些子串，使每个子串都是回文串。
    /*
     示例:
     输入: "aab"
     输出:
     [
     ["aa","b"],
     ["a","a","b"]
     ]
     */
    NSString *s = @"aab";
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    [self action5Result:result path:path s:s startIndex:0];
    NSLog(@"--%@", result);
    
}

- (void)action5Result:(NSMutableArray *)result
                 path:(NSMutableArray <NSString *>*)path
                    s:(NSString *)s
           startIndex:(NSInteger)startIndex
{
    if (startIndex >= s.length) {
        [result addObject:path.copy];
        return;
    }
    
    for (NSInteger i = startIndex; i < s.length ; i++) {
        
        if ([self isPalindrome:s start:startIndex end:i]) {
            NSString *subs = [s substringWithRange:NSMakeRange(startIndex, i - startIndex + 1)];
            [path addObject:subs];
        } else {
            continue;
        }
        
        [self action5Result:result path:path s:s startIndex:i + 1];
        [path removeLastObject];
    }
}

- (BOOL)isPalindrome:(NSString *)str start:(NSInteger)start end:(NSInteger)end
{
    for (NSInteger i = start, j = end; i < j; i++, j--) {
        NSString *left = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *right = [str substringWithRange:NSMakeRange(j, 1)];
        if (left != right) {
            return NO;
        }
    }
    return YES;
}

- (void)action6
{
    // 93 复原IP地址
    /*
     给定一个只包含数字的字符串，复原它并返回所有可能的 IP 地址格式。
     有效的 IP 地址 正好由四个整数（每个整数位于 0 到 255 之间组成，且不能含有前导 0），整数之间用 '.' 分隔。
     例如："0.1.2.201" 和 "192.168.1.1" 是 有效的 IP 地址，但是 "0.011.255.245"、"192.168.1.312" 和 "192.168@1.1" 是 无效的 IP 地址。
     
     示例 1：
     输入：s = "25525511135"
     输出：["255.255.11.135","255.255.111.35"]

     示例 2：
     输入：s = "0000"
     输出：["0.0.0.0"]

     示例 3：输入：s = "1111"
     输出：["1.1.1.1"]

     示例 4：输入：s = "010010"
     输出：["0.10.0.10","0.100.1.0"]

     示例 5：输入：s = "101023"
     输出：["1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3"]

     提示：
     0 <= s.length <= 3000
     s 仅由数字组成
     */
    
//    NSString *s = @"25525511135";
//    NSString *s = @"0000";
//    NSString *s = @"1111";
//    NSString *s = @"010010";
    NSString *s = @"101023";
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    
    [self action6S:s res:result path:path startIndex:0];
    NSLog(@"%@", result);
}

- (void)action6S:(NSString *)s res:(NSMutableArray <NSString *>*)res path:(NSMutableArray <NSString *>*)path startIndex:(NSInteger)startIndex
{
    // 当已经截取三个的时候 第四个必须是合法的才算ip地址 且截取点要小于s长度
    if (path.count == 3 && startIndex < s.length) {
        NSString *last = [s substringWithRange:NSMakeRange(startIndex, s.length - startIndex)];
        
        if ([self legalCommit:last]) {
            [path addObject:last];
            [res addObject:path.copy];
            [path removeLastObject];
        }
        return;
    }
    
    for (NSInteger i = startIndex; i < s.length; i++) {
        NSString *sub = [s substringWithRange:NSMakeRange(startIndex, i - startIndex + 1)];
        NSInteger length = sub.length;
        if ((length == 3 && sub.integerValue > 255) || length > 4) {
            return;
        }
        
        if ([self legalCommit:sub]) {
            [path addObject:sub];
        } else {
            break;
        }
        
        [self action6S:s res:res path:path startIndex:i + 1];
        [path removeLastObject];
    }
}

- (BOOL)legalCommit:(NSString *)commit
{
    if (commit.length > 1 && [commit hasPrefix:@"0"]) {
        return NO;
    }
    NSInteger commitInt = commit.integerValue;
    if (commitInt >= 0 && commitInt <= 255) {
        return YES;
    }
    return NO;
}

- (void)action7
{
    // 78. 子集
    /*
     给定一组不含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。
     说明：解集不能包含重复的子集。
     
     示例: 输入: nums = [1,2,3]
     输出:
     [
       [3],
       [1],
       [2],
       [1,2,3],
       [1,3],
       [2,3],
       [1,2],
       []
     ]
     */
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    NSArray *nums = @[@(1),@(2),@(3)];
    [self action7nums:nums res:result path:path startIndex:0];
    NSLog(@"%@", result);
}

- (void)action7nums:(NSArray <NSNumber *>*)nums
                res:(NSMutableArray <NSNumber *>*)res
               path:(NSMutableArray <NSNumber *>*)path
         startIndex:(NSInteger)startIndex
{
    [res addObject:path.copy];
    if (startIndex == nums.count) {
        return;
    }
    
    for (NSInteger i = startIndex; i < nums.count; i++) {
        [path addObject:nums[i]];
        NSLog(@"%@", path);
        [self action7nums:nums res:res path:path startIndex:i+1];
        [path removeLastObject];
    }
}

- (void)action8
{
    // 90 子集II
    /*
     给定一个可能包含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。
     说明：解集不能包含重复的子集。
     
     示例:
     输入: [1,2,2]
     输出:
     [
     [2],
     [1],
     [1,2,2],
     [2,2],
     [1,2],
     []
     ]
     */
}

@end
