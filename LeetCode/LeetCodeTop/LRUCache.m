//
//  LRUCache.m
//  LeetCode
//
//  Created by curryZ on 2021/1/29.
//

#import "LRUCache.h"

@implementation DLinkedNode

+ (instancetype)node:(NSString *)key
               value:(NSInteger)value
                 pre:(DLinkedNode *)pre
                next:(DLinkedNode *)next
{
    DLinkedNode *node = [DLinkedNode new];
    node.key = key;
    node.value = value;
    node.pre = pre;
    node.next = next;
    return node;
}

@end

@implementation LRUCache


- (instancetype)initWithCapacity:(NSInteger)capacity
{
    self = [super init];
    if (self) {
        _capacity = capacity;
        _cache = [NSMutableDictionary dictionary];
        _head = [DLinkedNode node:@"" value:0 pre:nil next:nil];
        _tail = [DLinkedNode node:@"" value:0 pre:nil next:nil];
        _head.next = _tail;
        _tail.pre = _head;
    }
    return self;
}

- (NSInteger)getKey:(NSString *)key
{
    if (![self.cache.allKeys containsObject:key]) {
        return -1;
    }
    // 如果 key 存在，先通过哈希表定位，再移到头部
    DLinkedNode *node = self.cache[key];
    [self nodeMoveToHead:node];
    return node.value;
}

- (void)putKey:(NSString *)key value:(NSInteger)value
{
    if (![self.cache.allKeys containsObject:key]) {
        // 如果 key 不存在，创建一个新的节点
        DLinkedNode* node = [DLinkedNode node:key value:value pre:nil next:nil];
        // 添加进哈希表
        self.cache[key] = node;
        // 添加至双向链表的头部
        [self nodeAddToHead:node];
        if (self.cache.allKeys.count > self.capacity) {
            // 如果超出容量，删除双向链表的尾部节点
            DLinkedNode *node = [self nodeRemoveLast];
            [self.cache removeObjectForKey:node.key];
        }
    }
    else {
        // 如果 key 存在，先通过哈希表定位，再修改 value，并移到头部
        DLinkedNode *node = self.cache[key];
        node.value = value;
        [self nodeMoveToHead:node];
    }
}

#pragma mark - private

- (void)nodeAddToHead:(DLinkedNode *)node
{
    node.pre = self.head;
    node.next = self.head.next;
    node.next.pre = node;
    self.head.next = node;
}

- (void)nodeRemove:(DLinkedNode *)node
{
    node.pre.next = node.next;
    node.next.pre = node.pre;
}

- (void)nodeMoveToHead:(DLinkedNode *)node
{
    [self nodeRemove:node];
    [self nodeAddToHead:node];
}

- (DLinkedNode *)nodeRemoveLast
{
    DLinkedNode *node = self.tail.pre;
    [self nodeRemove:node];
    return node;
}


@end
