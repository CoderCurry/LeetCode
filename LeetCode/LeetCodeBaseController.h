//
//  LeetCodeBaseController.h
//  BaseProjectFramework
//
//  Created by curry on 2021/1/4.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeetCodeBaseController : UIViewController

- (void)didSelectRowAtIndex:(NSInteger)index;

- (void)configRowTitles:(NSArray <NSString *>*)titles;

- (void)action;

@end

NS_ASSUME_NONNULL_END
