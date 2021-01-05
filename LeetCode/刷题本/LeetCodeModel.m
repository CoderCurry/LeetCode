//
//  LeetCodeModel.m
//  BaseProjectFramework
//
//  Created by curry on 2020/9/27.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import "LeetCodeModel.h"

@implementation LeetCodeModel

+ (instancetype)modelWithTitle:(NSString *)title num:(NSInteger)num type:(LeetCodeType)type
{
    LeetCodeModel *model = [[LeetCodeModel alloc] init];
    model.title = title;
    model.num = num;
    model.type = (NSInteger)type;
    return model;
}

@end
