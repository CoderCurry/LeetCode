//
//  LeetCodeModel.h
//  BaseProjectFramework
//
//  Created by curry on 2020/9/27.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LeetCodeType) {
    LeetCodeTypeEasy,
    LeetCodeTypeNormal,
    LeetCodeTypeHard,
};

@interface LeetCodeModel : NSObject

@property (nonatomic, copy) NSString *title;// 标题
@property (nonatomic, assign) NSInteger num;// 题号
@property (nonatomic, assign) LeetCodeType type;

+ (instancetype)modelWithTitle:(NSString *)title num:(NSInteger)num type:(LeetCodeType)type;

@end

NS_ASSUME_NONNULL_END
