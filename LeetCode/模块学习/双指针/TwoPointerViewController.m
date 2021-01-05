//
//  TwoPointerViewController.m
//  BaseProjectFramework
//
//  Created by curryZ on 2021/1/1.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "TwoPointerViewController.h"
#import "ListNode.h"

@interface TwoPointerViewController ()

@end

@implementation TwoPointerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 双指针法
}


- (IBAction)action0:(id)sender {
    // 要知道数组的元素在内存地址中是连续的，不能单独删除数组中的某个元素，所以删除操作的实质是覆盖
    // 27. 移除元素
    // 移除所有元素 并返回新数组的长度
    
    NSMutableArray <NSString *>*nums = @[@"2", @"1", @"2", @"2", @"3", @"0", @"4", @"2"].mutableCopy;
    int val = 2;
    {
        int slowIndex = 0;
        for (int fastIndex = 0; fastIndex < nums.count; fastIndex++)
        {
            // nums[fastIndex] 等于val时 fastIndex 跳过该元素 不等的时候 将该元素赋值给slowIndex 并且同时递增2个索引
            if (val != nums[fastIndex].intValue) {
                nums[slowIndex] = nums[fastIndex];
                slowIndex++;
            }
        }
        // slowIndex 代表着新数组的长度
        NSLog(@"index %d", slowIndex);
        NSLog(@"array %@", [nums subarrayWithRange:NSMakeRange(0, slowIndex)]);
    }
}

- (IBAction)action1:(id)sender {
    // 15. 三数之和
    // 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组
    // bf算法 就是2层for循环 用双指针的话 虽然也是n2 但是效率要高
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray <NSString *>*nums = @[@(-1), @(0), @(1), @(2), @(-1), @(-4)].mutableCopy;
    nums = [nums sortedArrayUsingSelector:@selector(compare:)].mutableCopy;
    
    // 找出a + b + c = 0
    // a = nums[i], b = nums[left], c = nums[right]
    for (int i = 0; i < nums.count; i++) {
        // 排序之后如果第一个元素已经大于零，那么无论如何组合都不可能凑成三元组，直接返回结果就可以了
        if (nums[i].intValue > 0) {
            break;
        }
        // 错误去重方法，将会漏掉-1,-1,2 这种情况
        /*
        if (nums[i] == nums[i + 1]) {
            continue;
        }
        */
        // 正确去重方法
        if (i > 0 && nums[i] == nums[i - 1]) {
            continue;
        }
        int left = i + 1;
        int right = (int)nums.count - 1;
        while (right > left) {
            // 去重复逻辑如果放在这里，0，0，0 的情况，可能直接导致 right<=left 了，从而漏掉了 0,0,0 这种三元组
            /*
            while (right > left && nums[right] == nums[right - 1]) right--;
            while (right > left && nums[left] == nums[left + 1]) left++;
            */
            if (nums[i].intValue + nums[left].intValue + nums[right].intValue > 0) {
                right--;
            } else if (nums[i].intValue + nums[left].intValue + nums[right].intValue < 0) {
                left++;
            } else {
                [result addObject:@[nums[i], nums[left], nums[right]]];
                // 去重逻辑应该放在找到一个三元组之后
                while (right > left && nums[right] == nums[right - 1]) right--;
                while (right > left && nums[left] == nums[left + 1]) left++;

                // 找到答案时，双指针同时收缩
                right--;
                left++;
            }
        }
    }
    NSLog(@"%@", result);
}

- (IBAction)action2:(id)sender {
    // 第206题：反转链表
    // 示例: 输入: 1->2->3->4->5->NULL 输出: 5->4->3->2->1->NULL
    ListNode *node2 = [ListNode nodeValue:@"2" next:nil];
    ListNode *node1 = [ListNode nodeValue:@"1" next:node2];
    ListNode *head = [ListNode nodeValue:@"0" next:node1];
    
    ListNode *newHead = reverseList(head);
}

ListNode* reverseList(ListNode* head) {
    ListNode* temp; // 保存cur的下一个节点
    ListNode* cur = head;
    ListNode* pre = NULL;
    while(cur) {
        temp = cur.next;  // 保存一下 cur的下一个节点，因为接下来要改变cur->next
        cur.next = pre; // 翻转操作
        // 更新pre 和 cur指针
        pre = cur;
        cur = temp;
    }
    return pre;
}

- (IBAction)action3:(id)sender {
    // 142 环形链表II 给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null
    // 给定一个链表 给定一个值表示链表尾部到链表首部连接的环点
    
    /*
     1. 定义快慢指针 fast / slow 快指针走2格 慢指针走一格 如果相遇说明一定有环 遇到null停下 说明没环
     2. 有环的情况下 fast和slow相遇点 通过数学证明 相遇点走一格 head走一格 他们会相遇在环点
     */
    
    ListNode *node4 = [ListNode nodeValue:@"2" next:nil];
    ListNode *node3 = [ListNode nodeValue:@"2" next:node4];
    ListNode *node2 = [ListNode nodeValue:@"2" next:node3];
    ListNode *node1 = [ListNode nodeValue:@"1" next:node2];
    ListNode *head = [ListNode nodeValue:@"0" next:node1];
    
    // node1 是环点
    node4.next = node1;
    
    ListNode *node = detectCycle(head);
    NSLog(@"环点是%@", node.value);
}

ListNode *detectCycle(ListNode *head) {
        ListNode* fast = head;
        ListNode* slow = head;
        while(fast != NULL && fast.next != NULL) {
            slow = slow.next;
            fast = fast.next.next;
            // 快慢指针相遇，此时从head 和 相遇点，同时查找直至相遇
            if (slow == fast) {
                ListNode* index1 = fast;
                ListNode* index2 = head;
                while (index1 != index2) {
                    index1 = index1.next;
                    index2 = index2.next;
                }
                return index2; // 返回环的入口
            }
        }
        return NULL;
    }

@end
