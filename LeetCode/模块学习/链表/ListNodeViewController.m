//
//  ListNodeViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/6.
//

#import "ListNodeViewController.h"
#import "ListNode.h"

@interface ListNodeViewController ()

@end

@implementation ListNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configRowTitles:@[@"移除链表元素", @"链表设计"]];
}

- (void)didSelectRowAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self action0];
            break;
            
        default:
            break;
    }
}

- (void)action0
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
    ListNode *node3 = [ListNode nodeValue:3 next:node4];
    ListNode *node2 = [ListNode nodeValue:6 next:node3];
    ListNode *node1 = [ListNode nodeValue:2 next:node2];
    ListNode *head = [ListNode nodeValue:1 next:node1];
    
    [self deleteListNode:head target:6];
    NSLog(@"%@", head);
}

- (void)deleteListNode:(ListNode *)head target:(NSInteger)target
{
    // 先确保头结点安全
    while (head.value == target) {
        head = head.next;
    }
    
    ListNode *cur = head;
    while (cur) {
        // 如果next命中 就指向next.next
        // 如果next没命中 cur后移
        if (cur.next.value == target) {
            cur.next = cur.next.next;
        } else {
            cur = cur.next;
        }
    }
}

- (void)action1
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
    
    ListNode *listNode = [ListNode nodeValue:88 next:nil];
    
}

- (void)listNode:(ListNode *)head getIndex:(NSInteger)index
{
    
}

- (void)listNode:(ListNode *)head addHead:(NSInteger)val
{
    ListNode *newHead = [ListNode nodeValue:val next:head];
    
}

- (void)listNode:(ListNode *)head addTail:(NSInteger)val
{
    
}

- (void)listNode:(ListNode *)head addAtIndex:(NSInteger)index value:(NSInteger)value
{
    
}

- (void)listNode:(ListNode *)head deleteAtIndex:(NSInteger)index
{
    
}

@end
