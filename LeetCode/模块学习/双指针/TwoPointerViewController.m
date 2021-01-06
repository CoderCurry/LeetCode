//
//  TwoPointerViewController.m
//  BaseProjectFramework
//
//  Created by curryZ on 2021/1/1.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "TwoPointerViewController.h"
#import "ListNode.h"

@interface TwoPointerViewController ()

@end

@implementation TwoPointerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configRowTitles:@[@"移除元素", @"反转字符串", @"替换空格", @"翻转字符串里的单词", @"反转链表", @"环形链表II", @"三数之和", @"四数之和"]];
}

- (void)didSelectRowAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self action0];
            break;
        case 1:
            [self action1];
            break;
        case 2:
            [self action2];
            break;
        case 3:
            [self action3];
            break;
        case 4:
            [self action4];
            break;
        case 5:
            [self action5];
            break;
        case 6:
            [self action6];
            break;
        case 7:
            [self action7];
            break;
            
        default:
            break;
    }
}

- (void)action0 {
    NSLog(@"在数组章节中");
}

- (void)action1 {
    NSLog(@"在数组章节中");
}

- (void)action2 {
    // 剑指Offer 05.替换空格
}

- (void)action3 {
    // 151.翻转字符串里的单词
}

- (void)action4 {
    NSLog(@"在数组章节中");
}

- (void)action5 {
    NSLog(@"在数组章节中");
}

- (void)action6 {
    NSLog(@"在数组章节中");
}

- (void)action7 {
    NSLog(@"在数组章节中");
}

@end
