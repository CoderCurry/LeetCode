//
//  MyLinkedList.m
//  LeetCode
//
//  Created by curryZ on 2021/1/6.
//

#import "MyLinkedList.h"

@implementation MyLinkedList

- (instancetype)init
{
    self = [super init];
    self.size = 0;
    self.head = [ListNode nodeValue:0 next:nil];
    return self;
}

- (NSInteger)getValueIndex:(NSInteger)index
{
    ListNode *cur = self.head;
    for (int i = 0; i < index + 1; i++) {
        cur = cur.next;
    }
    return cur.value;
}

- (void)addAtIndex:(NSInteger)index value:(NSInteger)value
{
    if (index > self.size) {
        return;
    }
    
    if (index < 0) {
        index = 0;
    }
    
    ListNode *pre = self.head;
    for (int i = 0; i < index; i++) {
        pre = pre.next;
    }
    
    ListNode *insertNode  = [ListNode nodeValue:value next:nil];
    insertNode.next = pre.next;
    pre.next = insertNode;
    
    self.size += 1;
}

- (void)addHeadNode:(NSInteger)value
{
    [self addAtIndex:0 value:value];
}

- (void)addTailNode:(NSInteger)value
{
    [self addAtIndex:self.size value:value];
}

- (void)deleteAtIndex:(NSInteger)index
{
    ListNode *pre = self.head;
    for (int i = 0; i < index; i++) {
        pre = pre.next;
    }
    
    pre.next = pre.next.next;
    
    self.size -= 1;
}

@end
