//
//  LeetCodeEasyViewController.h
//  BaseProjectFramework
//
//  Created by curry on 2020/9/27.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeetCodeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LeetCodeListViewController : UIViewController

@property (nonatomic, assign) NSInteger questionId;

@property (nonatomic, strong) NSArray <LeetCodeModel *>*array;

@end

NS_ASSUME_NONNULL_END
