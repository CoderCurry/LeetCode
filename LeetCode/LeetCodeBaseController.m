//
//  LeetCodeBaseController.m
//  BaseProjectFramework
//
//  Created by curry on 2021/1/4.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "LeetCodeBaseController.h"

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
    NSLog(@"子类实现");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
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
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}



@end
