//
//  ViewController.m
//  LeetCode
//
//  Created by curry on 2021/1/5.
//

#import "ViewController.h"
#import "LeetCodeModel.h"

#import "LeetCodeListViewController.h"
#import "BinaryTreeViewController.h"
#import "TwoPointerViewController.h"
#import "HuisuViewController.h"
#import "LeetCodeArrayViewController.h"
#import "CTestViewController.h"
#import "ListNodeViewController.h"
#import "HashViewController.h"

#define kLeetCodeSet @"leetCode题集"
#define kLeetCodeSetEasy @"easy"
#define kLeetCodeSetMedium @"medium"
#define kLeetCodeSetHard @"hard"
#define kLeetCodeSetAll @"all"

#define kLeetCodeModule @"leetCode模块复习"
#define kLeetCodeModuleTree @"二叉树"
#define kLeetCodeModulePointer @"双指针"
#define kLeetCodeModuleBackTracking @"回溯算法"
#define kLeetCodeModuleArray @"数组"
#define kLeetCodeModuleListNode @"链表"
#define kLeetCodeModuleHash @"哈希表"


#define kLeetCodeMM @"leetCodeC++代码"

#define kBack @"返回"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <LeetCodeModel *>*allArray;
@property (nonatomic, strong) NSMutableArray <LeetCodeModel *>*easyArray;
@property (nonatomic, strong) NSMutableArray <LeetCodeModel *>*mediumArray;
@property (nonatomic, strong) NSMutableArray <LeetCodeModel *>*hardArray;

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
        kLeetCodeSet:@[
                kLeetCodeSetEasy,
                kLeetCodeSetMedium,
                kLeetCodeSetHard,
                kLeetCodeSetAll,
                kBack],
        kLeetCodeModule:@[
                kLeetCodeModuleArray,
                kLeetCodeModuleListNode,
                kLeetCodeModuleHash,
                kLeetCodeModuleTree,
                kLeetCodeModulePointer,
                kLeetCodeModuleBackTracking,
                kBack],
        kBack:@[
//                kLeetCodeSet,
                kLeetCodeModule,
                kLeetCodeMM]
    };
    
    self.jumpConfig = @{
        kLeetCodeMM:NSStringFromClass(CTestViewController.class),
        kLeetCodeModuleArray:NSStringFromClass(LeetCodeArrayViewController.class),
        kLeetCodeModuleListNode:NSStringFromClass(ListNodeViewController.class),
        kLeetCodeModuleHash:NSStringFromClass(HashViewController.class),
        kLeetCodeModuleTree:NSStringFromClass(BinaryTreeViewController.class),
        kLeetCodeModulePointer:NSStringFromClass(TwoPointerViewController.class),
        kLeetCodeModuleBackTracking:NSStringFromClass(HuisuViewController.class),
        kLeetCodeSetEasy:NSStringFromClass(LeetCodeListViewController.class),
        kLeetCodeSetMedium:NSStringFromClass(LeetCodeListViewController.class),
        kLeetCodeSetHard:NSStringFromClass(LeetCodeListViewController.class),
        kLeetCodeSetAll:NSStringFromClass(LeetCodeListViewController.class),
    };
    
    self.dataArray = self.homeConfig[kBack];
    [self.view addSubview:self.tableView];
    
    [self configData];
    
    NSArray *nums = @[@(-1), @(0), @(1), @(2), @(-1), @(-4)];
    nums = [nums sortedArrayUsingSelector:@selector(compare:)];
    nums = [[nums reverseObjectEnumerator] allObjects];
    
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
    
    
//    if ([self.config[key] isKindOfClass:NSArray.class]) {
//        self.dataArray = self.config[key];
//        [self.tableView reloadData];
//    } else {
//        if ([key isEqualToString:kLeetCodeSetEasy]) {
//            [self popToList:@"简单" data:self.easyArray];
//        } else if ([key isEqualToString:kLeetCodeSetMedium]) {
//            [self popToList:@"中等" data:self.mediumArray];
//        } else if ([key isEqualToString:kLeetCodeSetHard]) {
//            [self popToList:@"困难" data:self.hardArray];
//        } else if ([key isEqualToString:kLeetCodeSetAll]) {
//            [self popToList:@"全部" data:self.allArray];
//        } else {
//            Class cls = NSClassFromString(self.config[key]);
//            UIViewController *vc = [[cls alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
}

- (void)popToList:(NSString *)title data:(NSArray <LeetCodeModel *>*)array
{
    LeetCodeListViewController *vc = [[LeetCodeListViewController alloc] init];
    vc.title = title;
    vc.array = array;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)configData
{
    self.allArray = @[
        [LeetCodeModel modelWithTitle:@"两数之和" num:1 type:LeetCodeTypeEasy],
        [LeetCodeModel modelWithTitle:@"两数相加" num:2 type:LeetCodeTypeNormal],
        [LeetCodeModel modelWithTitle:@"无重复字符的最长子串" num:3 type:LeetCodeTypeNormal],
        [LeetCodeModel modelWithTitle:@"寻找两个正序数组的中位数" num:4 type:LeetCodeTypeHard],
        [LeetCodeModel modelWithTitle:@"最长回文子串" num:5 type:LeetCodeTypeNormal],
        [LeetCodeModel modelWithTitle:@"Z字形变换" num:6 type:LeetCodeTypeNormal],
        [LeetCodeModel modelWithTitle:@"整数反转" num:7 type:LeetCodeTypeEasy],
        [LeetCodeModel modelWithTitle:@"字符串转整数(atoi)" num:8 type:LeetCodeTypeNormal],
    ];
    
    [self.allArray enumerateObjectsUsingBlock:^(LeetCodeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == LeetCodeTypeEasy) {
            [self.easyArray addObject:obj];
        } else if (obj.type == LeetCodeTypeNormal) {
            [self.mediumArray addObject:obj];
        } else if (obj.type == LeetCodeTypeHard) {
            [self.hardArray addObject:obj];
        }
    }];
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

- (NSMutableArray<LeetCodeModel *> *)easyArray
{
    if (!_easyArray) {
        _easyArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _easyArray;
}

- (NSMutableArray<LeetCodeModel *> *)mediumArray
{
    if (!_mediumArray) {
        _mediumArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _mediumArray;
}

- (NSMutableArray<LeetCodeModel *> *)hardArray
{
    if (!_hardArray) {
        _hardArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _hardArray;
}
@end
