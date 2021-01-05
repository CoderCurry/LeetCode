//
//  HuisuViewController.m
//  BaseProjectFramework
//
//  Created by curryZ on 2021/1/2.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import "HuisuViewController.h"

@interface HuisuViewController ()

@end

@implementation HuisuViewController

/*
 ** 回溯算法 **
 回溯法也可以叫做回溯搜索法，它是一种搜索的方式。穷举每种情况 寻找问题的解，当发现已不满足求解条件时，就“回溯”返回，尝试别的路径;
 
 回溯法，一般可以解决如下几种问题：

 组合问题：N个数里面按一定规则找出k个数的集合
 排列问题：N个数按一定规则全排列，有几种排列方式
 切割问题：一个字符串按一定规则有几种切割方式
 子集问题：一个N个数的集合里有多少符合条件的子集
 棋盘问题：N皇后，解数独等等
 
 回溯算法模板框架如下：
 void backtracking(参数) {
     if (终止条件) {
         存放结果;
         return;
     }

     for (选择：本层集合中元素（树中节点孩子的数量就是集合的大小）) {
         处理节点;
         backtracking(路径，选择列表); // 递归
         回溯，撤销处理结果
     }
 }

 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self action0];
}

- (void)action0 {
    // 77 组合问题
    /*
     给定两个整数 n 和 k，返回 1 ... n 中所有可能的 k 个数的组合。

     示例:
     输入: n = 4, k = 2
     输出:
     [
     [2,4],
     [3,4],
     [2,3],
     [1,2],
     [1,3],
     [1,4],
     ]
     */
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *path = [NSMutableArray arrayWithCapacity:0];
    
    [self backtracking:5 k:3 index:1 resultArray:result pathArray:path];
    NSLog(@"result:%@, path:%@", result, path);
}

- (void)backtracking:(NSInteger)n
                   k:(NSInteger)k
               index:(NSInteger)startIndex
         resultArray:(NSMutableArray *)result
           pathArray:(NSMutableArray *)path
{
    if (path.count == k) {
        [result addObject:path.copy];
        return;
    }
    
    for (NSInteger i = startIndex; i <= n; i++)
    {
        [path addObject:@(i)];// 处理节点
        [self backtracking:n k:k index:i+1 resultArray:result pathArray:path]; // 递归
        [path removeObject:@(i)];// 回溯，撤销处理的节点
    }
}

- (NSInteger)pathSum:(NSArray *)path
{
    __block int sum = 0;
    [path enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += obj.intValue;
    }];
    return sum;
}

@end
