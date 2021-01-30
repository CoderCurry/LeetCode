//
//  LeetCodeBaseController.m
//  BaseProjectFramework
//
//  Created by curry on 2021/1/4.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "LeetCodeBaseController.h"
#import "LeetBaseCell.h"
@interface LeetCodeBaseController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation LeetCodeBaseController

/*
 汇总各大互联网公司容易考察的高频leetcode题🔥
 https://leetcode-cn.top/#/home
 Leetcode 基础学习
 https://github.com/youngyangyang04/leetcode-master
 Leetcode 高频考题
 https://github.com/azl397985856/leetcode
 Leetcode 官网
 https://leetcode-cn.com/problemset/all/
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
}

- (void)configRowTitles:(NSArray <NSString *>*)titles
{
    self.dataArray = titles;
    [self.tableView reloadData];
}

- (void)didSelectRowAtIndex:(NSInteger)index
{
    NSString *name = self.dataArray[index];
    NSArray *path = [name componentsSeparatedByString:@"."];
    NSString *num = path.firstObject;
    NSString *selName = [NSString stringWithFormat:@"action%@", num];
    SEL sel = NSSelectorFromString(selName);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL) = (void *)imp;
        func(self, sel);
    } else {
        NSAssert(NO, @"题号错误");
    }
}

- (void)action
{
    NSAssert(NO, @"子类实现");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LeetBaseCell heightWithSource:self.dataArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeetBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LeetBaseCell.class) forIndexPath:indexPath];
    [cell configWithSource:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self didSelectRowAtIndex:indexPath.row];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 44;
        [_tableView registerClass:LeetBaseCell.class forCellReuseIdentifier:NSStringFromClass(LeetBaseCell.class)];
    }
    return _tableView;
}



@end
