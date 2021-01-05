//
//  LeetCodeArrayViewController.m
//  BaseProjectFramework
//
//  Created by curry on 2021/1/4.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "LeetCodeArrayViewController.h"

@interface LeetCodeArrayViewController ()

@end

@implementation LeetCodeArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configRowTitles:@[@"搜索插入位置", @"移除元素", @"三数之和", @"四数之和", @"反转链表", @"环形链表"]];
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
    // 编号35：搜索插入位置
    // [1,3,5,6], 5
    NSMutableArray *arr = @[@(1),@(3),@(5),@(6)].mutableCopy;
    NSInteger target = 5;
    NSInteger index = [self searchIndex:arr target:target];
    NSInteger target1 = 2;
    NSInteger index1 = [self searchIndex:arr target:target1];
    NSInteger target2 = 7;
    NSInteger index2 = [self searchIndex:arr target:target2];
    NSInteger target3 = 0;
    NSInteger index3 = [self searchIndex:arr target:target3];
    NSLog(@"答案 2 1 4 0");
    NSLog(@"结果 %ld %ld %ld %ld", index, index1, index2, index3);
}

// 利用二分法 查找插入index
/*
 创建left right 和mid
 通过比较mid和target 移动 left right
 当midvalue == target 返回mid
 否则left 总会超出 right 而跳出循环 此时left就是应插入的index
 
 视频: https://leetcode-cn.com/problems/search-insert-position/solution/sou-suo-cha-ru-wei-zhi-by-leetcode-solution/
 */
- (NSInteger)searchIndex:(NSMutableArray <NSNumber *>*)sortArray target:(NSInteger)target
{
    NSInteger left = 0;
    NSInteger right = sortArray.count - 1;
    
    while (left <= right) {
        NSInteger mid = (right + left) / 2;
        if (sortArray[mid].integerValue < target) {
            left = mid + 1;
        } else if (sortArray[mid].integerValue > target) {
            right = mid - 1;
        } else {
            return mid;
        }
    }
    return left;
}

- (void)action1
{
    // 27. 移除元素
    // 给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
    // nums = [3,2,2,3], val = 3 -> 2 [2,2]
    // nums = [0,1,2,2,3,0,4,2], val = 2, -> 5 [0,1,3,0,4]
    
    NSMutableArray *nums = @[@(3),@(2),@(2),@(3)].mutableCopy;
    NSInteger val = 3;
    NSMutableArray *nums1 = @[@(0),@(1),@(2),@(2),@(3),@(0),@(4),@(2)].mutableCopy;
    NSInteger val1 = 2;
    
    NSInteger index = [self nums:nums val:val];
    NSInteger index1 = [self nums:nums1 val:val1];
    NSLog(@"- %ld %ld", index, index1);
    
}

// 双指针 这里nums已经被修改过 用nums 取前slow个 就是新数组
- (NSInteger)nums:(NSMutableArray <NSNumber *>*)nums val:(NSInteger)val
{
    NSInteger fast = 0;
    NSInteger slow = 0;
    
    for (int i = 0; i < nums.count; i++) {
        
        if (nums[fast].integerValue == val) {
            fast++;
        } else {
            nums[slow] = nums[fast];
            fast++;
            slow++;
        }
    }
    return slow;
}

- (void)action2
{
    // 15.三数之和
    // 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。
    // nums = [-1, 0, 1, 2, -1, -4] -> [[-1, 0, 1], [-1, -1, 2]]
    // sort [-4, -1, -1, 0, 1, 2]
    
    NSArray *nums = @[@(-1), @(0), @(1), @(2), @(-1), @(-4)];
    NSArray *result = [self nums:nums];
    NSLog(@"arr:%@", result);
}

- (NSArray *)nums:(NSArray <NSNumber *>*)nums
{
    nums = [nums sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < nums.count; i++) {
        
        // 如果第一个数大于0 将不存在三数和为0
        if (nums[i].intValue > 0) {
            break;
        }
        
        // 保证第一个数是从小到大排序 将第一个数去重
        if (i > 0 && nums[i] == nums[i - 1]) {
            continue;
        }
        
        NSInteger left = i + 1;
        NSInteger right = nums.count - 1;
        while (left < right) {
            NSInteger iValue = nums[i].integerValue;
            NSInteger leftValue = nums[left].integerValue;
            NSInteger rightValue = nums[right].integerValue;
            if (iValue + leftValue + rightValue > 0) {
                right--;
            } else if (iValue + leftValue + rightValue < 0) {
                left++;
            } else {
                [result addObject:@[@(iValue), @(leftValue), @(rightValue)]];
                // 将第二三个数去重 eg.@[@(-1), @(0), @(1), @(2), @(-1), @(-4), @(1), @(0)];
                while (right > left && nums[right] == nums[right - 1]) {
                    right--;
                }
                while (right > left && nums[left] == nums[left + 1]) {
                    left++;
                }
                // 找到0后 2边必须收缩才可能再次产生0
                right--;
                left++;
            }
        }
    }
    return result.copy;
}

- (void)action3
{
    // 18. 四数之和
    //
    // [1, 0, -1, 0, -2, 2]  target = 0
    NSArray <NSNumber *>*nums = @[@(1), @(0), @(-1), @(0), @(-2), @(2)];
    nums = [nums sortedArrayUsingSelector:@selector(compare:)];
    
    NSArray *result = [self nums:nums target:0];
    NSLog(@"arr:%@", result);

}

// 增加了减枝操作 核心其实就是for 包裹 3数和
- (NSArray *)nums:(NSArray <NSNumber *>*)nums target:(NSInteger)target
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];

    for (NSInteger i = 0; i < nums.count - 3; i++) {
    
        // 保证第一个数是从小到大排序 将第一个数去重
        if (i > 0 && nums[i] == nums[i - 1]) {
            continue;
        }

        // i下 最小值 > target 就返回
        if (nums[i].integerValue + nums[i + 1].integerValue + nums[i + 2].integerValue + nums[i + 3].integerValue > target) {
            break;
        }
        
        // i下 最大值 < target 就提升i
        if (nums[i].integerValue + nums[nums.count - 3].integerValue + nums[nums.count - 2].integerValue + nums[nums.count - 1].integerValue < target) {
            continue;
        }


        for (NSInteger j = i + 1; j < nums.count - 2; j++) {
            // 去重
            if (j > i + 1 && nums[j] == nums[j - 1]) {
                continue;
            }
            
            // i j下 最小值 > target 就返回
            if (nums[i].integerValue + nums[j].integerValue + nums[j + 1].integerValue + nums[j + 2].integerValue > target) {
                break;
            }
            
            // i j下 最大值 < target 就提升j
            if (nums[i].integerValue + nums[j].integerValue + nums[nums.count - 2].integerValue + nums[nums.count - 1].integerValue < target) {
                continue;
            }

            NSInteger left = j + 1;
            NSInteger right = nums.count - 1;
            while (left < right) {
                NSInteger iValue = nums[i].integerValue;
                NSInteger jValue = nums[j].integerValue;
                NSInteger leftValue = nums[left].integerValue;
                NSInteger rightValue = nums[right].integerValue;
                if (iValue + jValue + leftValue + rightValue > 0) {
                    right--;
                } else if (iValue + jValue + leftValue + rightValue < 0) {
                    left++;
                } else {
                    [result addObject:@[@(iValue), @(jValue), @(leftValue), @(rightValue)]];
                    // 将第二三个数去重 eg.@[@(-1), @(0), @(1), @(2), @(-1), @(-4), @(1), @(0)];
                    while (right > left && nums[right] == nums[right - 1]) right--;
                    while (right > left && nums[left] == nums[left + 1]) left++;
                    // 找到0后 2边必须收缩才可能再次产生0
                    right--;
                    left++;
                }
            }
        }
    }
    return result.copy;
}

- (void)action4
{
    // 第206题：反转链表
    /*
    示例: 输入: 1->2->3->4->5->NULL
    输出: 5->4->3->2->1->NULL
     */
    
}

- (void)action5
{
    
}

@end
