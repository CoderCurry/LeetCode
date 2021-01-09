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
 - 如果解决一个问题有多个步骤，每一个步骤有多种方法，题目又要我们找出所有的方法，可以使用回溯算法；
 - 回溯算法是在一棵树上的 深度优先遍历（因为要找所有的解，所以需要遍历）；
 - 组合问题，相对于排列问题而言，不计较一个组合内元素的顺序性（即 [1, 2, 3] 与 [1, 3, 2] 认为是同一个组合），因此很多时候需要按某种顺序展开搜索，这样才能做到不重不漏。

 回溯算法首先需要画出递归树，不同的树决定了不同的代码实现。
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
    
    [self configRowTitles:@[@"组合问题",
                            @"组合总和III",
    ]];
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

        default:
            break;
    }
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
    
    [self backtrackingn:4 k:2 startIndex:1 resultArray:result pathArray:path];
    NSLog(@"result:%@, path:%@", result, path);
}

- (void)backtrackingn:(NSInteger)n
                    k:(NSInteger)k
           startIndex:(NSInteger)startIndex
          resultArray:(NSMutableArray *)result
            pathArray:(NSMutableArray *)path
{
    if (path.count == k) {
        [result addObject:path.copy];
        return;
    }
    // for 循环是横向遍历 递归是纵向遍历
    // 剪枝处理
    // for (int i = startIndex; i <= n - (k - path.size()) + 1; i++)
    for (NSInteger i = startIndex; i <= n; i++)
    {
        [path addObject:@(i)];// 处理节点
        [self backtrackingn:n
                          k:k
                 startIndex:i+1
                resultArray:result
                  pathArray:path]; // 递归
        [path removeObject:@(i)];// 回溯，撤销处理的节点
    }
}

- (void)action1
{
    // 216 组合总和III
    // 找出所有相加之和为 n 的 k 个数的组合。组合中只允许含有 1 - 9 的正整数，并且每种组合中不存在重复的数字。
    /*
     示例 1:
     输入: k = 3, n = 7
     输出: [[1,2,4]]

     示例 2:
     输入: k = 3, n = 9
     输出: [[1,2,6], [1,3,5], [2,3,4]]
     */
    
}

@end
