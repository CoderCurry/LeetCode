//
//  ListNode.m
//  BaseProjectFramework
//
//  Created by curryZ on 2021/1/1.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "ListNode.h"

@implementation ListNode

+ (instancetype)nodeValue:(NSInteger)value next:(ListNode * _Nullable)next
{
    ListNode *node = [[ListNode alloc] init];
    node.value = value;
    node.next = next;
    return node;
}

- (NSArray *)getListValue
{
    NSMutableArray *arr = [NSMutableArray array];
    ListNode *cur = self;
    while (cur) {
        [arr addObject:@(cur.value)];
        cur = cur.next;
    }
    return arr.copy;
}

@end
