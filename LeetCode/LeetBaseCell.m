//
//  LeetBaseCell.m
//  LeetCode
//
//  Created by curryZ on 2021/1/13.
//

#import "LeetBaseCell.h"

@interface LeetBaseCell ()

@property (nonatomic, strong) UILabel *leetTitle;
@property (nonatomic, strong) UILabel *leetSubTitle;

@end

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation LeetBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leetTitle = [[UILabel alloc] init];
        self.leetTitle.textColor = [UIColor blackColor];
        self.leetTitle.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:self.leetTitle];
        
        self.leetSubTitle = [[UILabel alloc] init];
        self.leetSubTitle.textColor = [UIColor brownColor];
        self.leetSubTitle.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.leetSubTitle];
    }
    return self;
}

- (void)configWithSource:(NSString *)text
{
    NSArray *array = [text componentsSeparatedByString:@"-"];
    if (array.count == 1) {
        self.leetTitle.text = array[0];
        self.leetTitle.frame = CGRectMake(20, 0, KScreenWidth - 40, [LeetBaseCell heightWithSource:text]);
    } else if (array.count == 2) {
        self.leetTitle.text = array[0];
        self.leetSubTitle.text = array[1];
        
        self.leetTitle.frame = CGRectMake(20, 0, KScreenWidth - 40, [LeetBaseCell heightWithSource:text] / 2.0);
        self.leetSubTitle.frame = CGRectMake(20, self.leetTitle.frame.origin.y + self.leetTitle.frame.size.height, KScreenWidth - 40, [LeetBaseCell heightWithSource:text] / 2.0);
    }
}

+ (CGFloat)heightWithSource:(NSString *)text
{
    NSArray *array = [text componentsSeparatedByString:@"-"];
    if (array.count == 1) {
        return 44.f;
    } else {
        return 66.f;
    }
}



@end
