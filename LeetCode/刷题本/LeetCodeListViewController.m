//
//  LeetCodeEasyViewController.m
//  BaseProjectFramework
//
//  Created by curry on 2020/9/27.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import "LeetCodeListViewController.h"
#import "LeetCodeAnswer.h"

@interface LeetCodeListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeetCodeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LeetCodeModel *model = self.array[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@", model.num, model.title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger questionId = self.array[indexPath.row].num;
    [LeetCodeAnswer invokeLeetCodeNum:questionId];
}




@end
