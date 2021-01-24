//
//  LeetCodeHotViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/25.
//

#import "LeetCodeHotViewController.h"

@interface LeetCodeHotViewController ()

@end

@implementation LeetCodeHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configRowTitles:@[
        @"1.两数之和",
    ]];
}

- (void)didSelectRowAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self action0];
            break;
            
        default:
            break;
    }
}

- (void)action0
{
    
}

@end
