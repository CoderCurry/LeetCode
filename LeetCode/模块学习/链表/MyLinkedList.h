//
//  MyLinkedList.h
//  LeetCode
//
//  Created by curryZ on 2021/1/6.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyLinkedList : NSObject

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) ListNode *head;

- (NSInteger)getValueIndex:(NSInteger)index;

- (void)addAtIndex:(NSInteger)index value:(NSInteger)value;

- (void)addHeadNode:(NSInteger)value;

- (void)addTailNode:(NSInteger)value;

- (void)deleteAtIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END

