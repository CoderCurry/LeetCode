//
//  ArrayViewController.m
//  BaseProjectFramework
//
//  Created by curry on 2021/1/4.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "ArrayViewController.h"
#import "ListNode.h"
@interface ArrayViewController ()

@end

@implementation ArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configRowTitles:@[@"搜索插入位置",
                            @"移除元素",
                            @"三数之和",
                            @"四数之和",
                            @"反转链表",
                            @"环形链表II",
                            @"长度最小的子数组",
                            @"螺旋矩阵II"]];
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
    // 编号35：搜索插入位置
    // [1,3,5,6], 5
    /*
     给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
     你可以假设数组中无重复元素。
     */
    NSMutableArray *arr = @[@(1),@(3),@(5),@(6)].mutableCopy;
    NSArray *targets = @[@(5),@(2),@(7),@(0)];
    NSLog(@"答案 2 1 4 0");
    for (NSInteger i = 0; i < targets.count; i++) {
        NSInteger target = [targets[i] integerValue];
        NSInteger index = [self action0SearchIndex:arr target:target];
        NSLog(@"结果 %ld", index);
    }
}
// 利用二分法 查找插入index
/*
 创建left right 和mid
 通过比较mid和target 移动 left right
 当midvalue == target 返回mid
 否则left 总会超出 right 而跳出循环 此时left就是应插入的index
 
 视频: https://leetcode-cn.com/problems/search-insert-position/solution/sou-suo-cha-ru-wei-zhi-by-leetcode-solution/
 */
- (NSInteger)action0SearchIndex:(NSMutableArray <NSNumber *>*)sortArray target:(NSInteger)target
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
    
    
    NSMutableArray *nums0 = @[@(3),@(2),@(2),@(3)].mutableCopy;
    NSMutableArray *nums1 = @[@(0),@(1),@(2),@(2),@(3),@(0),@(4),@(2)].mutableCopy;
    NSArray *nums = @[nums0, nums1];
    NSArray *vals = @[@(3), @(2)];
    NSLog(@"答案 2 5");
    for (NSInteger i = 0; i < nums.count; i++) {
        NSInteger index = [self action1Nums:nums[i] val:[vals[i] integerValue]];
        NSLog(@"%ld", index);
    }
}

// 双指针 这里nums已经被修改过 用nums 取前slow个 就是新数组
- (NSInteger)action1Nums:(NSMutableArray <NSNumber *>*)nums val:(NSInteger)val
{
    NSInteger fast = 0;
    NSInteger slow = 0;
    for (NSInteger i = 1; i < nums.count; i++) {
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
    NSArray *result = [self action3Nums:nums];
    NSLog(@"retult :%@", result);
}

- (NSArray *)action3Nums:(NSArray <NSNumber *>*)nums
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
    NSArray *result = [self action3Nums:nums target:0];
    NSLog(@"result :%@", result);

}

// 增加了减枝操作 核心其实就是for 包裹 3数和
- (NSArray *)action3Nums:(NSArray <NSNumber *>*)nums target:(NSInteger)target
{
    NSArray <NSNumber *>*sortNums = [nums sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];

    for (NSInteger i = 0; i < sortNums.count - 3; i++) {
    
        // 保证第一个数是从小到大排序 将第一个数去重
        if (i > 0 && sortNums[i] == sortNums[i - 1]) {
            continue;
        }

        // i下 最小值 > target 就返回
        if (sortNums[i].integerValue + sortNums[i + 1].integerValue + sortNums[i + 2].integerValue + sortNums[i + 3].integerValue > target) {
            break;
        }
        
        // i下 最大值 < target 就提升i
        if (sortNums[i].integerValue + sortNums[sortNums.count - 3].integerValue + sortNums[sortNums.count - 2].integerValue + sortNums[sortNums.count - 1].integerValue < target) {
            continue;
        }


        for (NSInteger j = i + 1; j < sortNums.count - 2; j++) {
            // 去重
            if (j > i + 1 && sortNums[j] == sortNums[j - 1]) {
                continue;
            }
            
            // i j下 最小值 > target 就返回
            if (sortNums[i].integerValue + sortNums[j].integerValue + sortNums[j + 1].integerValue + sortNums[j + 2].integerValue > target) {
                break;
            }
            
            // i j下 最大值 < target 就提升j
            if (sortNums[i].integerValue + sortNums[j].integerValue + sortNums[sortNums.count - 2].integerValue + sortNums[sortNums.count - 1].integerValue < target) {
                continue;
            }

            NSInteger left = j + 1;
            NSInteger right = sortNums.count - 1;
            while (left < right) {
                NSInteger iValue = sortNums[i].integerValue;
                NSInteger jValue = sortNums[j].integerValue;
                NSInteger leftValue = sortNums[left].integerValue;
                NSInteger rightValue = sortNums[right].integerValue;
                if (iValue + jValue + leftValue + rightValue > 0) {
                    right--;
                } else if (iValue + jValue + leftValue + rightValue < 0) {
                    left++;
                } else {
                    [result addObject:@[@(iValue), @(jValue), @(leftValue), @(rightValue)]];
                    // 将第二三个数去重 eg.@[@(-1), @(0), @(1), @(2), @(-1), @(-4), @(1), @(0)];
                    while (right > left && sortNums[right] == sortNums[right - 1]) right--;
                    while (right > left && sortNums[left] == sortNums[left + 1]) left++;
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
    
    ListNode *node5 = [ListNode nodeValue:5 next:nil];
    ListNode *node4 = [ListNode nodeValue:4 next:node5];
    ListNode *node3 = [ListNode nodeValue:3 next:node4];
    ListNode *node2 = [ListNode nodeValue:2 next:node3];
    ListNode *node1 = [ListNode nodeValue:1 next:node2];
    
    ListNode *reverseNode = [self reverseListNode:node1];
    NSLog(@"%@", reverseNode);
}

- (ListNode *)reverseListNode:(ListNode *)root
{
    ListNode *pre = nil;
    ListNode *cur = root;
    
    while (cur != nil) {
        ListNode *temp = cur.next;
        cur.next = pre;
        pre = cur;
        cur = temp;
    };
    return pre;
}

- (void)action5
{
    // 第142题.环形链表II
    // 给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。
    
    ListNode *node3 = [ListNode nodeValue:4 next:nil];
    ListNode *node2 = [ListNode nodeValue:0 next:node3];
    ListNode *node1 = [ListNode nodeValue:2 next:node2];
    ListNode *head = [ListNode nodeValue:3 next:node1];
    node3.next = node1;
    
    ListNode *cycleNode = [self findCycleNode:head];
    NSLog(@"%@", cycleNode);
}

- (ListNode *)findCycleNode:(ListNode *)head
{
    ListNode *fast = head;
    ListNode *slow = head;
    
    while (fast) {
        fast = fast.next.next;
        slow = slow.next;
        
        // 找出相遇点
        if (fast.value == slow.value) {
            // 快慢指针相遇后，此时从head 和 相遇点，同时查找直至相遇 相遇点就是环点
            ListNode* index1 = fast;
            ListNode* index2 = head;
            while (fast.value == head.value) {
                index1 = index1.next;
                index2 = index2.next;
            }
            return index2;
        }
    }
    return nil;
}

- (void)action6
{
    // 209.长度最小的子数组
    // 给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。
    /*
     示例：
     输入：s = 7, nums = [2,3,1,2,4,3]
     输出：2
     解释：子数组 [4,3] 是该条件下的长度最小的子数组。
     */
    NSArray *array = @[@(2), @(3), @(1), @(2), @(4), @(3)];
    NSInteger length = [self minSubArrayLength:array target:7];
    NSLog(@"length %ld", length);
}

// 时间复杂度O(n) 因为begin 和 end最多各移动n次
- (NSInteger)minSubArrayLength:(NSArray <NSNumber *>*)nums target:(NSInteger)target
{
    if (nums.count == 0) {
        return 0;
    }
        
    NSInteger begin = 0;
    NSInteger end = 0;
    NSInteger length = NSIntegerMax;
    NSInteger sum = 0;
    while ((end < nums.count)) {
        sum += nums[end].integerValue;
        // 当sum大于target时 更新length 并减掉begin 移动begin和end
        // 当sum小于target时 移动end
        while (sum >= target) {
            length = MIN(length, end - begin + 1);
            sum -= nums[begin].integerValue;
            begin++;
        }
        end++;
    }
    // 如果没有匹配值 length = NSIntegerMax 返回0
    return (length == NSIntegerMax) ? 0 : length;
}

- (void)action7
{
    // 59.螺旋矩阵II
    // 给定一个正整数 n，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的正方形矩阵。
    /*
     示例: 输入: 3
     输出: [ [ 1, 2, 3 ], [ 8, 9, 4 ], [ 7, 6, 5 ] ]
     */
    
    NSArray *matrix = [self getMattixArray:4];
    NSLog(@"matrix:%@", matrix);
    
}

// https://leetcode-cn.com/problems/spiral-matrix-ii/solution/spiral-matrix-ii-mo-ni-fa-she-ding-bian-jie-qing-x/
- (NSArray *)getMattixArray:(NSInteger)n
{
    NSMutableArray <NSMutableArray <NSNumber *>*>* matrix = [NSMutableArray arrayWithCapacity:0];
    // 构造矩阵
    for (int i = 0; i < n; i++) {
        NSMutableArray *rowArray = [NSMutableArray arrayWithCapacity:0];
        for (int j = 0; j < n; j++) {
            [rowArray addObject:@(0)];
        }
        [matrix addObject:rowArray];
    }
    
    // 上下左右
    NSInteger l = 0, r = n - 1, t = 0, b = n - 1;
    NSInteger num = 1, tar = n * n;
    while(num <= tar){
        for(NSInteger i = l; i <= r; i++)
        {
            matrix[t][i] = @(num++); // left to right.
        }
        t++;
        for(NSInteger i = t; i <= b; i++)
        {
            matrix[i][r] = @(num++); // top to bottom.
        }
        r--;
        for(NSInteger i = r; i >= l; i--)
        {
            matrix[b][i] = @(num++); // right to left.
        }
        b--;
        for(NSInteger i = b; i >= t; i--)
        {
            matrix[i][l] = @(num++); // bottom to top.
        }
        l++;
    }

    return matrix;
}

@end
