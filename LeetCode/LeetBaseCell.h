//
//  LeetBaseCell.h
//  LeetCode
//
//  Created by curryZ on 2021/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeetBaseCell : UITableViewCell

+ (CGFloat)heightWithSource:(NSString *)text;

- (void)configWithSource:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
