//
//  BacktrackingController.m
//  BaseProjectFramework
//
//  Created by curryZ on 2021/1/2.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "BacktrackingController.h"

@interface BacktrackingController ()

@end

@implementation BacktrackingController

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
 
 for 负责横向 如果每次都从0开始  则i = 0 如果每次进1 则i = start
 递归里面 start 用来给 下一层for 选择集合 

 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configRowTitles:@[@"组合问题-所给集合求k个数的组合",
                            @"组合总和III-集合不含重复元素, 元素不可重复使用",
                            @"电话号码的字母组合",
                            @"组合总和-集合不含重复元素, 元素可重复使用, 解集不能包含重复组合",
                            @"组合总和II-集合有重复元素, 解集不能包含重复组合",
                            @"分割回文串",
                            @"复原IP地址",
                            @"子集-集合不含重复元素, 解集不能包含重复子集",
                            @"子集II-集合有重复元素, 解集不能包含重复子集",
                            @"递增子序列",
                            @"全排列-不含重复元素",
                            @"全排列II-包含重复",
                            @"重新安排行程",
                            @"N皇后",
                            @"解数独"
                            
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
        case 9:
            [self action9];
            break;
        case 10:
            [self action10];
            break;
        case 11:
            [self action11];
            break;
        case 12:
            [self action12];
            break;
        case 13:
            [self action13];
            break;
        case 14:
            [self action14];
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
    NSInteger n = 4;
    NSInteger k = 2;
    [self action1N:n
                 k:k
             start:1
              path:path
            result:result];
    NSLog(@"result:%@", result);
}

- (void)action1N:(NSInteger)n
               k:(NSInteger)k
           start:(NSInteger)start
            path:(NSMutableArray *)path
         result:(NSMutableArray *)result
{
    if (path.count == k) {
        [result addObject:path.copy];
        return;
    }
    // for 循环是横向遍历 递归是纵向遍历
    // 剪枝:如果for循环选择的起始位置之后的元素个数 已经不足 我们需要的元素个数了，那么就没有必要搜索了
    /*
     1. 已选择元素: path.count
     2. 还剩的长度: n - i + 1
     3. 需要的长度: k - path.count
     需要的长度 <= 还剩的长度
     k - path.count <= n - i + 1
     i <= n - (k - path.count) + 1
     */

    for (NSInteger i = start; i <= n - (k - path.count) + 1; i++) {
        [path addObject:@(i)];
        // 递归纵向遍历
        [self action1N:n
                     k:k
                 start:i+1
                  path:path
                result:result];
        // 回溯
        [path removeLastObject];
    }
}

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
    NSInteger sum = 0;
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
//    NSInteger n = 7;
//    NSInteger k = 3;
    NSInteger n = 9;
    NSInteger k = 3;
    NSInteger start = 1;
    [self action1Sum:sum n:n k:k start:start path:path result:result];
    NSLog(@"result:%@", result);
}

- (void)action1Sum:(NSInteger)sum
                 n:(NSInteger)n
                 k:(NSInteger)k
             start:(NSInteger)start
              path:(NSMutableArray *)path
            result:(NSMutableArray *)result
{
    if (sum > n) {
        return;
    }
    
    if (path.count == k) {
        if (sum == n) {
            [result addObject:path.copy];
        }
        return;
    }
    
    for (NSInteger i = start; i <= 9; i++) {
        sum+=i;
        [path addObject:@(i)];
        [self action1Sum:sum n:n k:k start:i+1 path:path result:result];
        sum-=i;
        [path removeLastObject];
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
    
    NSString *string = @"23";
    NSMutableArray *result = [NSMutableArray array];
    [self action2NumsString:string result:result];
    NSLog(@"result %@", result);
}

- (void)action2NumsString:(NSString *)numsString result:(NSMutableArray *)result
{
    NSMutableArray *nums = [NSMutableArray array];
    for (NSInteger i = 0; i < numsString.length; i++) {
        NSString *sub = [numsString substringWithRange:NSMakeRange(i, 1)];
        [nums addObject:sub];
    }
    
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
    
    NSMutableArray *path = [NSMutableArray array];
    
    [self action2Nums:nums
                  map:map
           startIndex:0
               result:result
                 path:path];
}

- (void)action2Nums:(NSArray *)nums
                map:(NSDictionary *)map
         startIndex:(NSInteger)startIndex
             result:(NSMutableArray *)result
               path:(NSMutableArray *)path
{
    if (path.count == nums.count) {
        [result addObject:path.copy];
        return;
    }
    
    NSString *key = nums[startIndex];
    NSArray *array = map[key];
    
    for (NSInteger i = 0; i < array.count; i++) {
        [path addObject:array[i]];
        [self action2Nums:nums
                      map:map
               startIndex:startIndex + 1
                   result:result
                     path:path];
        [path removeLastObject];
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
    NSInteger sum = 0;
//    NSArray *nums = @[@(2), @(3), @(6), @(7)];
//    NSInteger target = 7;
    NSArray *nums = @[@(2), @(3), @(5)];
    NSInteger target = 8;
    
    [self action3Sum:sum
              target:target
                nums:nums
          startIndex:0
              result:result
                path:path];
    NSLog(@"result %@", result);
}

- (void)action3Sum:(NSInteger)sum
            target:(NSInteger)target
              nums:(NSArray <NSNumber *>*)nums
        startIndex:(NSInteger)startIndex
            result:(NSMutableArray *)result
              path:(NSMutableArray <NSNumber *>*)path
{
    if (sum > target) {
        return;
    }
    
    if (sum == target) {
        [result addObject:path.copy];
        return;
    }
    
    for (NSInteger i = startIndex; i < nums.count; i++) {
        sum += nums[i].integerValue;
        [path addObject:nums[i]];
        // 树枝中数字重复选取 i 不用+1
        [self action3Sum:sum
                  target:target
                    nums:nums
              startIndex:i
                  result:result
                    path:path];
        sum -= nums[i].integerValue;
        [path removeLastObject];
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
    NSArray *nums = @[@(10), @(1), @(2), @(7), @(6), @(1), @(5)];
    NSInteger target = 8;
//    NSArray *nums = @[@(2), @(3), @(5)];
//    NSInteger target = 8;
    
    [self action4Nums:nums target:target result:result];
    NSLog(@"result %@", result);
}

- (void)action4Nums:(NSArray <NSNumber *>*)nums
             target:(NSInteger)target
             result:(NSMutableArray *)result
{
    NSArray *numsSort = [nums sortedArrayUsingSelector:@selector(compare:)];
    NSInteger sum = 0;
    NSMutableArray *path = [NSMutableArray array];
    NSMutableArray *used = [NSMutableArray array];
    for (int i = 0; i < nums.count; i++) {
        [used addObject:@(NO)];
    }
    
    [self action4Nums:numsSort
                  sum:sum
               target:target
           startIndex:0
                 used:used
               result:result
                 path:path];
}

- (void)action4Nums:(NSArray <NSNumber *>*)nums
                sum:(NSInteger)sum
             target:(NSInteger)target
         startIndex:(NSInteger)startIndex
               used:(NSMutableArray <NSNumber *>*)used
             result:(NSMutableArray *)result
               path:(NSMutableArray <NSNumber *>*)path
{
    if (sum > target) {
        return;
    }
    
    if (sum == target) {
        [result addObject:path.copy];
        return;
    }
    
    for (NSInteger i = startIndex; i < nums.count; i++) {
        // https://mp.weixin.qq.com/s/_1zPYk70NvHsdY8UWVGXmQ
        // 因为nums是排序的 所以直接对比i 和 i - 1 这两个重复值
        // used[i - 1] == true，说明同一树支candidates[i - 1]使用过
        // used[i - 1] == false，说明前一个树枝使用过 也就是同一树层candidates[i - 1]使用过
        
        if (i > 0 && nums[i] == nums[i - 1] && used[i - 1].boolValue == NO) {
            continue;
        }
        
        sum += nums[i].integerValue;
        [path addObject:nums[i]];
        used[i] = @(YES);
        [self action4Nums:nums
                      sum:sum
                   target:target
               startIndex:i + 1
                     used:used
                   result:result
                     path:path];
        used[i] = @(NO);
        sum -= nums[i].integerValue;
        [path removeLastObject];
    }
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
    [self action5S:s
        startIndex:0
            result:result
              path:path];
    NSLog(@"--%@", result);
    
}

- (void)action5S:(NSString *)s
      startIndex:(NSInteger)startIndex
          result:(NSMutableArray  *)result
            path:(NSMutableArray <NSString *>*)path
{
    if (startIndex >= s.length) {
        [result addObject:path.copy];
        return;
    }
    
    for (NSInteger i = startIndex; i < s.length; i++) {
        
        if ([self isPalindrome:s start:startIndex end:i]) {
            NSString *subs = [s substringWithRange:NSMakeRange(startIndex, i - startIndex + 1)];
            [path addObject:subs];
        } else {
            continue;
        }
        [self action5S:s
            startIndex:i + 1
                result:result
                  path:path];
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
    
    NSString *s0 = @"25525511135";
    NSString *s1 = @"0000";
    NSString *s2 = @"1111";
    NSString *s3 = @"010010";
    NSString *s4 = @"101023";
    NSArray *arr = @[s0, s1, s2, s3, s4];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *s = arr[i];
        NSMutableArray *result = [NSMutableArray array];
        NSMutableArray *path = [NSMutableArray array];
        
        [self action6S:s res:result path:path startIndex:0];
        NSLog(@"%@", result);
    }
}

- (void)action6S:(NSString *)s res:(NSMutableArray <NSString *>*)res path:(NSMutableArray <NSString *>*)path startIndex:(NSInteger)startIndex
{
    if (startIndex >= s.length) {
        return;
    }
    // 当已经截取三个的时候 第四个必须是合法的才算ip地址 且截取点要小于s长度
    if (path.count == 3) {
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
    NSInteger commitInt = commit.integerValue;
    // 0开头 多于一位
    if (commit.length > 1 && [commit hasPrefix:@"0"]) {
        return NO;
    }
    
    if (commitInt > 255) {
        return NO;
    }
    return YES;
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
    [self action7nums:nums startIndex:0 result:result path:path];
    NSLog(@"%@", result);
}

- (void)action7nums:(NSArray <NSNumber *>*)nums
         startIndex:(NSInteger)startIndex
             result:(NSMutableArray <NSNumber *>*)result
               path:(NSMutableArray <NSNumber *>*)path
         
{
    [result addObject:path.copy];
    if (startIndex >= nums.count) {
        return;
    }
    
    for (NSInteger i = startIndex; i < nums.count; i++) {
        [path addObject:nums[i]];
        [self action7nums:nums startIndex:i + 1 result:result path:path];
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
    NSMutableArray <NSNumber *>*result = [NSMutableArray array];
    NSArray *nums = @[@(1),@(2),@(2)];
    [self action8nums:nums result:result];
    NSLog(@"result %@", result);
}

- (void)action8nums:(NSArray <NSNumber *>*)nums result:(NSMutableArray <NSNumber *>*)result
{
    NSArray <NSNumber *>*sortNums = [nums sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray <NSNumber *>*path = [NSMutableArray array];
    NSMutableArray <NSNumber *>*used = [NSMutableArray array];
    for (NSInteger i = 0; i < sortNums.count; i++) {
        [used addObject:@(NO)];
    }
    
    [self action8nums:sortNums startIndex:0 used:used result:result path:path];
}

- (void)action8nums:(NSArray <NSNumber *>*)sortNums
         startIndex:(NSInteger)startIndex
               used:(NSMutableArray <NSNumber *>*)used
             result:(NSMutableArray <NSNumber *>*)result
               path:(NSMutableArray <NSNumber *>*)path
         
{
    [result addObject:path.copy];
    if (startIndex >= sortNums.count) {
        return;
    }
    
    for (NSInteger i = startIndex; i < sortNums.count; i++) {
        
        if (i > 0 && sortNums[i] == sortNums[i - 1] && used[i - 1].boolValue == NO) {
            continue;
        }

        [path addObject:sortNums[i]];
        used[i] = @(YES);
        [self action8nums:sortNums startIndex:i + 1 used:used result:result path:path];
        [path removeLastObject];
        used[i] = @(NO);
    }
}

- (void)action9
{
    // 491 递增子序列
    // 给定一个整型数组, 你的任务是找到所有该数组的递增子序列，递增子序列的长度至少是2。
    /*
     示例:

     输入: [4, 6, 7, 7] 输出: [[4, 6], [4, 7], [4, 6, 7], [4, 6, 7, 7], [6, 7], [6, 7, 7], [7,7], [4,7,7]]

     说明:

     给定数组的长度不会超过15。
     数组中的整数范围是 [-100,100]。
     给定数组中可能包含重复数字，相等的数字应该被视为递增的一种情况。
     */
    NSMutableArray *result = [NSMutableArray array];
    NSArray *nums = @[@(4),@(6),@(7),@(7)];
    [self action9Nums:nums result:result];
    NSLog(@"result %@", result);
}

- (void)action9Nums:(NSArray <NSNumber *>*)nums result:(NSMutableArray <NSNumber *>*)result
{
    NSArray <NSNumber *>*sortNums = [nums sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *path = [NSMutableArray array];
    NSMutableArray <NSNumber *>*used = [NSMutableArray array];
    for (NSInteger i = 0; i < sortNums.count; i++) {
        [used addObject:@(NO)];
    }
    
    [self action9Nums:sortNums startIndex:0 used:used result:result path:path];
}

- (void)action9Nums:(NSArray <NSNumber *>*)sortNums
         startIndex:(NSInteger)startIndex
               used:(NSMutableArray <NSNumber *>*)used
             result:(NSMutableArray <NSNumber *>*)result
               path:(NSMutableArray <NSNumber *>*)path
{
    if (path.count >= 2) {
        [result addObject:path.copy];
    }

    if (startIndex >= sortNums.count) {
        return;
    }
    
    for (NSInteger i = startIndex; i < sortNums.count; i++) {
        
        if (i > 0 && sortNums[i] == sortNums[i-1] && used[i-1].boolValue == NO) {
            continue;
        }
        
        [path addObject:sortNums[i]];
        used[i] = @(YES);
        [self action9Nums:sortNums startIndex:i + 1 used:used result:result path:path];
        used[i] = @(NO);
        [path removeLastObject];
    }
}

- (void)action10
{
    // 46 全排列
    // 排列问题就不用使用startIndex了, 但排列问题需要一个used数组，标记已经选择的元素
    /*
     给定一个 没有重复 数字的序列，返回其所有可能的全排列。
     示例:
     输入: [1,2,3]
     输出:
     [
     [1,2,3],
     [1,3,2],
     [2,1,3],
     [2,3,1],
     [3,1,2],
     [3,2,1]
     ]
     */
    
    NSMutableArray *result = [NSMutableArray array];
    NSArray *nums = @[@(1),@(2),@(3)];
    [self action10Nums:nums result:result];
    NSLog(@"result %@", result);
}

- (void)action10Nums:(NSArray <NSNumber *>*)nums result:(NSMutableArray <NSNumber *>*)result
{
    NSMutableArray *path = [NSMutableArray array];
    NSMutableArray <NSNumber *>*used = [NSMutableArray array];
    for (NSInteger i = 0; i < nums.count; i++) {
        [used addObject:@(NO)];
    }
    
    [self action10Nums:nums used:used result:result path:path];
}

- (void)action10Nums:(NSArray <NSNumber *>*)nums
                used:(NSMutableArray <NSNumber *>*)used
              result:(NSMutableArray <NSNumber *>*)result
                path:(NSMutableArray <NSNumber *>*)path
{
    if (path.count == nums.count) {
        [result addObject:path.copy];
        return;
    }
    
    for (NSInteger i = 0; i < nums.count; i++) {
        if (used[i].boolValue) {
            continue;
        }
        used[i] = @(YES);
        [path addObject:nums[i]];
        [self action10Nums:nums used:used result:result path:path];
        used[i] = @(NO);
        [path removeLastObject];
    }
}
- (void)action11
{
    // 47.全排列 II
    // 给定一个可包含重复数字的序列 nums ，按任意顺序 返回所有不重复的全排列。
    /*
     示例 1：
     输入：nums = [1,1,2]
     输出：
     [[1,1,2],
     [1,2,1],
     [2,1,1]]
     
     示例 2：
     输入：nums = [1,2,3]
     输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
     
     提示：
     
     1 <= nums.length <= 8
     -10 <= nums[i] <= 10
     */
 
    NSArray *nums0 = @[@(1),@(1),@(2)];
    NSArray *nums1 = @[@(1),@(2),@(3)];
    NSArray *array = @[nums0, nums1];
    for (NSArray *nums in array) {
        NSMutableArray *result = [NSMutableArray array];
        [self action11Nums:nums result:result];
        NSLog(@"result %@", result);
    }
}

- (void)action11Nums:(NSArray <NSNumber *>*)nums result:(NSMutableArray <NSNumber *>*)result
{
    NSMutableArray *path = [NSMutableArray array];
    NSMutableArray <NSNumber *>*used = [NSMutableArray array];
    for (NSInteger i = 0; i < nums.count; i++) {
        [used addObject:@(NO)];
    }
    
    [self action11Nums:nums used:used result:result path:path];
}

- (void)action11Nums:(NSArray <NSNumber *>*)nums
                used:(NSMutableArray <NSNumber *>*)used
              result:(NSMutableArray <NSNumber *>*)result
                path:(NSMutableArray <NSNumber *>*)path
{
    if (path.count == nums.count) {
        [result addObject:path.copy];
        return;
    }
    
    for (NSInteger i = 0; i < nums.count; i++) {
        if (i > 0 && nums[i] == nums[i - 1] && used[i - 1].boolValue == NO) {
            continue;
        }
        
        if (used[i].boolValue == NO) {
            used[i] = @(YES);
            [path addObject:nums[i]];
            [self action11Nums:nums used:used result:result path:path];
            used[i] = @(NO);
            [path removeLastObject];
        }
    }
}

- (void)action12
{
    // 332.重新安排行程
    /*
     给定一个机票的字符串二维数组 [from, to]，子数组中的两个成员分别表示飞机出发和降落的机场地点，对该行程进行重新规划排序。所有这些机票都属于一个从 JFK（肯尼迪国际机场）出发的先生，所以该行程必须从 JFK 开始。

     提示：

     如果存在多种有效的行程，请你按字符自然排序返回最小的行程组合。例如，行程 ["JFK", "LGA"] 与 ["JFK", "LGB"] 相比就更小，排序更靠前
     所有的机场都用三个大写字母表示（机场代码）。
     假定所有机票至少存在一种合理的行程。
     所有的机票必须都用一次 且 只能用一次。
     示例 1：
     输入：[["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
     输出：["JFK", "MUC", "LHR", "SFO", "SJC"]

     示例 2：
     输入：[["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
     输出：["JFK","ATL","JFK","SFO","ATL","SFO"]
     解释：另一种有效的行程是 ["JFK","SFO","ATL","JFK","ATL","SFO"]。但是它自然排序更大更靠后。
     */
}

- (void)action13
{
    // 第51题. N皇后
    // n 皇后问题研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。
    /*
     给定一个整数 n，返回所有不同的 n 皇后问题的解决方案。
     每一种解法包含一个明确的 n 皇后问题的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。

     示例: 输入: 4
     输出: [
     [".Q..",  // 解法 1
     "...Q",
     "Q...",
     "..Q."],

     ["..Q.",  // 解法 2
     "Q...",
     "...Q",
     ".Q.."]
     ]
     解释: 4 皇后问题存在两个不同的解法。

     提示：
     皇后们的约束条件：
     不能同行
     不能同列
     不能同斜线
     */
    
    NSInteger n = 4;
    [self action13N:n];
}

- (void)action13N:(NSInteger)n
{
    NSMutableArray <NSMutableArray <NSString *>*>*chessboard = [NSMutableArray array];
    for (NSInteger row = 0; row < n; row++) {
        NSMutableArray <NSString *>* rowArray = [NSMutableArray array];
        for (NSInteger col = 0; col < n; col++) {
            [rowArray addObject:@"."];
        }
        [chessboard addObject:rowArray];
    }
    [self action13N:n row:0 chessboard:chessboard];
}

/// @param n 棋盘大小
/// @param row 当前递归到棋牌的第几行了
/// @param chessboard 棋盘
- (void)action13N:(NSInteger)n
              row:(NSInteger)row
       chessboard:(NSMutableArray <NSMutableArray <NSString *>*>*)chessboard
{
    if (row == n) {
        NSLog(@"result\n%@", chessboard);
        return;
    }
    
    for (NSInteger col = 0; col < n; col++) {
        BOOL isValid = [self action13IsValid:n row:row col:col chessboard:chessboard];
        if (isValid) { // 验证合法就可以放
            chessboard[row][col] = @"Q"; // 放置皇后
            [self action13N:n row:row + 1 chessboard:chessboard];
            chessboard[row][col] = @"."; // 回溯，撤销皇后
        }
    }
}

- (BOOL)action13IsValid:(NSInteger)n
                    row:(NSInteger)row
                    col:(NSInteger)col
             chessboard:(NSMutableArray <NSMutableArray <NSString *>*>*)chessboard
{
    // 检查列
    for (NSInteger i = 0; i < row; i++) {
        if ([chessboard[i][col] isEqualToString:@"Q"]) {
            return NO;
        }
    }
    
    //判断当前坐标的右上角有没有皇后 135度
    for (NSInteger i = row - 1, j = col + 1; i >= 0 && j < n; i--, j++) {
        if ([chessboard[i][j] isEqualToString:@"Q"]) {
            return NO;
        }
    }
    
    //判断当前坐标的左上角有没有皇后 45度
    for (NSInteger i = row - 1, j = col - 1; i >= 0 && j >= 0; i--, j--) {
        if ([chessboard[i][j] isEqualToString:@"Q"]) {
            return NO;
        }
    }
    return YES;
}


- (void)action14
{
    // 37. 解数独
    /*
     编写一个程序，通过填充空格来解决数独问题。

     一个数独的解法需遵循如下规则：
     数字 1-9 在每一行只能出现一次。
     数字 1-9 在每一列只能出现一次。
     数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。
     空白格用 '.' 表示。
     */
}

@end
