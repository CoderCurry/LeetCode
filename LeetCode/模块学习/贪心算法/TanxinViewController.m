//
//  TanxinViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/15.
//

#import "TanxinViewController.h"

@interface TanxinViewController ()

@end

@implementation TanxinViewController

/*
 贪心算法: 贪心的本质是选择每一阶段的局部最优，从而达到全局最优
 贪心算法一般分为如下四步：
 - 将问题分解为若干个子问题
 - 找出适合的贪心策略
 - 求解每一个子问题的最优解
 - 将局部最优解堆叠成全局最优解
 其实这个分的有点细了，真正做题的时候很难分出这么详细的解题步骤，可能就是因为贪心的题目往往还和其他方面的知识混在一起。
 
 贪心没有套路，说白了就是常识性推导加上举反例。
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configRowTitles:@[@"分发饼干", @"摆动序列", @"最大子序和"]];
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
            
        default:
            break;
    }
}

- (void)action0
{
    // 455 分发饼干
    /*
     假设你是一位很棒的家长，想要给你的孩子们一些小饼干。但是，每个孩子最多只能给一块饼干。

     对每个孩子 i，都有一个胃口值 g[i]，这是能让孩子们满足胃口的饼干的最小尺寸；并且每块饼干 j，都有一个尺寸 s[j] 。如果 s[j] >= g[i]，我们可以将这个饼干 j 分配给孩子 i ，这个孩子会得到满足。你的目标是尽可能满足越多数量的孩子，并输出这个最大数值。
     
     示例 1:
     输入: g = [1,2,3], s = [1,1]
     输出: 1
     
     示例 2:
     输入: g = [1,2], s = [1,2,3]
     输出: 2
     */
    NSArray <NSNumber *>*children = @[@(1), @(2)];
    NSArray <NSNumber *>*cookie = @[@(1), @(2), @(3)];
    NSInteger result = [self action0Children:children cookie:cookie];
    NSLog(@"%ld", result);
}

- (NSInteger)action0Children:(NSArray <NSNumber *>*)children cookie:(NSArray <NSNumber *>*)cookie
{
    NSArray <NSNumber *>* childrenSort = [children sortedArrayUsingSelector:@selector(compare:)];
    NSArray <NSNumber *>* cookieSort = [cookie sortedArrayUsingSelector:@selector(compare:)];
    // 饼干数组的下表
    NSInteger cookieIndex = cookie.count - 1;
    NSInteger result = 0;
    for (NSInteger i = childrenSort.count - 1; i >= 0; i--) {
        if (cookieIndex >= 0 && cookieSort[cookieIndex] >= childrenSort[i]) {
            result++;
            cookieIndex--;
        }
    }
    return result;
}

- (void)action1
{
    // 376 摆动序列
    /*
     如果连续数字之间的差严格地在正数和负数之间交替，则数字序列称为摆动序列。第一个差（如果存在的话）可能是正数或负数。少于两个元素的序列也是摆动序列。

     例如， [1,7,4,9,2,5] 是一个摆动序列，因为差值 (6,-3,5,-7,3) 是正负交替出现的。相反, [1,4,7,2,5] 和 [1,7,4,5,5] 不是摆动序列，第一个序列是因为它的前两个差值都是正数，第二个序列是因为它的最后一个差值为零。

     给定一个整数序列，返回作为摆动序列的最长子序列的长度。通过从原始序列中删除一些（也可以不删除）元素来获得子序列，剩下的元素保持其原始顺序。
     
     示例 1:
     输入: [1,7,4,9,2,5]
     输出: 6
     解释: 整个序列均为摆动序列。

     示例 2:
     输入: [1,17,5,10,13,15,10,5,16,8]
     输出: 7
     解释: 这个序列包含几个长度为 7 摆动序列，其中一个可为[1,17,10,13,10,16,8]。

     示例 3:
     输入: [1,2,3,4,5,6,7,8,9]
     输出: 2
     
     */
    
    NSArray <NSNumber *>*num0 = @[@(1), @(7), @(4), @(9), @(2), @(5)];
    NSArray <NSNumber *>*num1 = @[@(1), @(17), @(5), @(10), @(13), @(15), @(10), @(5), @(16), @(8)];
    NSArray <NSNumber *>*num2 = @[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9)];
    
    NSArray *numArray = @[num0, num1, num2];
    [numArray enumerateObjectsUsingBlock:^(NSArray <NSNumber *>* num, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger result = [self action2Nums:num];
        NSLog(@"%ld", result);
    }];
}

- (NSInteger)action2Nums:(NSArray <NSNumber *>*)nums
{
    if (nums.count <= 1) return nums.count;
    
    NSInteger curDiff = 0; // 当前一对差值
    NSInteger preDiff = 0; // 前一对差值
    NSInteger result = 1;  // 记录峰值个数，序列默认序列最右边有一个峰值
    for (int i = 1; i < nums.count; i++) {
        curDiff = nums[i].integerValue - nums[i - 1].integerValue;
        // 出现峰值 因为preDiff默认是0 所以preDiff是闭区间
        if ((curDiff > 0 && preDiff <= 0) || (preDiff >= 0 && curDiff < 0)) {
            result++;
            preDiff = curDiff;
        }
    }
    return result;
}

- (void)action2
{
    // 53 最大子序和
    /*
     给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

     示例:
     输入: [-2,1,-3,4,-1,2,1,-5,4]
     输出: 6
     解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
     */
}

@end
