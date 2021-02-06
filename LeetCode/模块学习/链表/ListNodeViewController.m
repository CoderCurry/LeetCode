//
//  ListNodeViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/6.
//

#import "ListNodeViewController.h"
#import "ListNode.h"
#import "MyLinkedList.h"

@interface ListNodeViewController ()

@end

@implementation ListNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configRowTitles:@[@"203.移除链表元素(简单)",
                            @"707.链表设计(中等)",
                            @"反转链表",
                            @"环形链表II",
                            @"25.(剑指)合并两个排序链表(简单)"
    ]];
}

- (void)action203
{
    // 第203题：移除链表元素
    // 删除链表中等于给定值 val 的所有节点
    /*
     输入: 1->2->6->3->4->5->6, val = 6
     输出: 1->2->3->4->5
     */
    ListNode *node6 = [ListNode nodeValue:6 next:nil];
    ListNode *node5 = [ListNode nodeValue:5 next:node6];
    ListNode *node4 = [ListNode nodeValue:4 next:node5];
    ListNode *node3 = [ListNode nodeValue:1 next:node4];
    ListNode *node2 = [ListNode nodeValue:6 next:node3];
    ListNode *node1 = [ListNode nodeValue:1 next:node2];
    ListNode *head = [ListNode nodeValue:1 next:node1];
    
    ListNode *res = [self deleteListNode:head target:1];
    NSLog(@"%@", [res getListValue]);
}

- (ListNode *)deleteListNode:(ListNode *)head target:(NSInteger)target
{
    ListNode *dummy = [ListNode nodeValue:0 next:head];
    ListNode *pre = dummy;
    ListNode *cur = head;
    
    while (cur) {
        if (cur.value == target) {
            pre.next = cur.next;
        } else {
            pre = cur;
        }
        cur = cur.next;
    }
    return dummy.next;
}

- (void)action707
{
    // 707. 设计链表
    /*
     在链表类中实现这些功能：
     get(index)：获取链表中第 index 个节点的值。如果索引无效，则返回-1。
     addAtHead(val)：在链表的第一个元素之前添加一个值为 val 的节点。插入后，新节点将成为链表的第一个节点。
     addAtTail(val)：将值为 val 的节点追加到链表的最后一个元素。
     addAtIndex(index,val)：在链表中的第 index 个节点之前添加值为 val  的节点。如果 index 等于链表的长度，则该节点将附加到链表的末尾。如果 index 大于链表长度，则不会插入节点。如果index小于0，则在头部插入节点。
     deleteAtIndex(index)：如果索引 index 有效，则删除链表中的第 index 个节点。
     */
    
    MyLinkedList *linkedList = [[MyLinkedList alloc] init];
    [linkedList addHeadNode:1];
    [linkedList addTailNode:3];
    [linkedList addAtIndex:1 value:2];
    [linkedList getValueIndex:1];
    [linkedList deleteAtIndex:1];
    [linkedList getValueIndex:1];
}

- (void)action2
{
    NSLog(@"在数组章节中");
}

- (void)action3
{
    NSLog(@"在数组章节中");
}

- (void)action25
{
    // 剑指 Offer 25. 合并两个排序的链表
    /*
     输入两个递增排序的链表，合并这两个链表并使新链表中的节点仍然是递增排序的。
     输入：1->2->4, 1->3->4
     输出：1->1->2->3->4->4
     */
    ListNode *node2 = [ListNode nodeValue:4 next:nil];
    ListNode *node1 = [ListNode nodeValue:2 next:node2];
    ListNode *node0 = [ListNode nodeValue:1 next:node1];
    
    ListNode *node5 = [ListNode nodeValue:4 next:nil];
    ListNode *node4 = [ListNode nodeValue:3 next:node5];
    ListNode *node3 = [ListNode nodeValue:1 next:node4];
    
    ListNode *res = [self action25MergeNode:node0 node1:node3];
    NSLog(@"%@", [res getListValue]);
}

- (ListNode *)action25MergeNode:(ListNode *)node0 node1:(ListNode *)node1
{
    if (node0 == nil) {
        return node1;
    }
    if (node1 == nil) {
        return node0;
    }
    
    if (node0.value < node1.value) {
        node0.next = [self action25MergeNode:node0.next node1:node1];
        return node0;
    } else {
        node1.next = [self action25MergeNode:node0 node1:node1.next];
        return node1;
    }
}

@end
