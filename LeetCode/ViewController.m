//
//  ViewController.m
//  LeetCode
//
//  Created by curry on 2021/1/5.
//

#import "ViewController.h"

// 模块学习
#import "BinaryTreeViewController.h"
#import "TwoPointerViewController.h"
#import "BacktrackingController.h"
#import "ArrayViewController.h"
#import "CTestViewController.h"
#import "ListNodeViewController.h"
#import "HashViewController.h"
#import "TanxinViewController.h"

// LeetCodeTop
#import "LeetCodeTopViewController.h"

#define kLeetCodeModule @"leetCode模块复习"
#define kLeetCodeModuleArray @"数组"
#define kLeetCodeModuleListNode @"链表"
#define kLeetCodeModuleHash @"哈希表"
#define kLeetCodeModulePointer @"双指针"
#define kLeetCodeModuleTree @"二叉树"
#define kLeetCodeModuleBackTracking @"回溯算法"
#define kLeetCodeModuleTanxin @"贪心算法"


#define kLeetCodeTopModule @"LeetCodeTop"

#define kLeetCodeMM @"leetCodeC++代码"

#define kBack @"返回"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *homeConfig;
@property (nonatomic, strong) NSDictionary *jumpConfig;

@end

@implementation ViewController

#warning OC 算法的注意点 当递归遇到 array add subArray时 subArray 一定要copy

/*
 常用api
 - 排序:
 NSArray *nums = @[@(-1), @(0), @(1), @(2), @(-1), @(-4)];
 // 升序
 nums = [nums sortedArrayUsingSelector:@selector(compare:)];
 // 降序
 nums = [[nums reverseObjectEnumerator] allObjects];
 
 - 数组/字符串 互转
 string = [array componentsJoinedByString:@"->"];
 array = [string componentsSeparatedByString:@"->"];
 
 // 字符串 按字符 转 数组
 NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
 for (int i = 0; i < str.length; i++) {
     NSString *sub = [str substringWithRange:NSMakeRange(i, 1)];
     if (![arr containsObject:sub]) {
         [arr addObject:sub];
     }
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"LeetCode";

    self.homeConfig = @{
        kLeetCodeModule:@[
                kLeetCodeModuleArray,
                kLeetCodeModuleListNode,
                kLeetCodeModuleHash,
                kLeetCodeModulePointer,
                kLeetCodeModuleTree,
                kLeetCodeModuleBackTracking,
                kLeetCodeModuleTanxin,
                kBack],
        kBack:@[
                kLeetCodeModule,
                kLeetCodeTopModule,
                kLeetCodeMM]
    };
    
    self.jumpConfig = @{
        kLeetCodeMM:NSStringFromClass(CTestViewController.class),
        kLeetCodeModuleArray:NSStringFromClass(ArrayViewController.class),
        kLeetCodeModuleListNode:NSStringFromClass(ListNodeViewController.class),
        kLeetCodeModuleHash:NSStringFromClass(HashViewController.class),
        kLeetCodeModuleTree:NSStringFromClass(BinaryTreeViewController.class),
        kLeetCodeModulePointer:NSStringFromClass(TwoPointerViewController.class),
        kLeetCodeModuleBackTracking:NSStringFromClass(BacktrackingController.class),
        kLeetCodeModuleTanxin:NSStringFromClass(TanxinViewController.class),
        kLeetCodeTopModule:NSStringFromClass(LeetCodeTopViewController.class),
    };
    
    self.dataArray = self.homeConfig[kBack];
    [self.view addSubview:self.tableView];    
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
    NSString *key = self.dataArray[indexPath.row];
    
    if ([self.homeConfig.allKeys containsObject:key]) {
        self.dataArray = self.homeConfig[key];
        [self.tableView reloadData];
    } else if ([self.jumpConfig.allKeys containsObject:key]) {
        Class cls = NSClassFromString(self.jumpConfig[key]);
        UIViewController *vc = [[cls alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
