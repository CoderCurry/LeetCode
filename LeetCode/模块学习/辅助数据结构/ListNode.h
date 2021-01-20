//
//  ListNode.h
//  BaseProjectFramework
//
//  Created by curryZ on 2021/1/1.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 单链表
@interface ListNode : NSObject

// 值
@property (nonatomic, assign) NSInteger value;
// 链表指向
@property (nonatomic, strong) ListNode * _Nullable next;

+ (instancetype)nodeValue:(NSInteger)value next:(ListNode * _Nullable)next;

@end

NS_ASSUME_NONNULL_END
