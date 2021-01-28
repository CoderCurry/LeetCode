//
//  LRUCache.h
//  LeetCode
//
//  Created by curryZ on 2021/1/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface DLinkedNode : NSObject

@property (nonatomic, copy) NSString *key;

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, strong) DLinkedNode *pre;

@property (nonatomic, strong) DLinkedNode *next;

+ (instancetype)node:(NSString *)key
               value:(NSInteger)value
                 pre:(DLinkedNode *)pre
                next:(DLinkedNode *)next;

@end


@interface LRUCache : NSObject

@property (nonatomic, assign) NSInteger capacity;

@property (nonatomic, strong) NSMutableDictionary *cache;

@property (nonatomic, strong) DLinkedNode *head;

@property (nonatomic, strong) DLinkedNode *tail;

- (instancetype)initWithCapacity:(NSInteger)capacity;

- (NSInteger)getKey:(NSString *)key;

- (void)putKey:(NSString *)key value:(NSInteger)value;
@end

NS_ASSUME_NONNULL_END
