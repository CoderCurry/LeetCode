//
//  LeetCodeTopViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/20.
//

#import "LeetCodeTopViewController.h"

@interface LeetCodeTopViewController ()

@end

@implementation LeetCodeTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configRowTitles:@[
        @"200.岛屿数量",
        @"463.岛屿的周长",
        @"695.岛屿的最大面积",
        @"827.最大人工岛"
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
        case 2:
            [self action2];
            break;
        case 3:
            [self action3];
            break;
            
        default:
            break;
    }
}

- (void)action0
{
    // 200.岛屿数量
    /*
    给你一个由 '1'（陆地）和 '0'（水）组成的的二维网格，请你计算网格中岛屿的数量。

    岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。

    此外，你可以假设该网格的四条边均被水包围。
     
     输入：grid = [
       ["1","1","1","1","0"],
       ["1","1","0","1","0"],
       ["1","1","0","0","0"],
       ["0","0","0","0","0"]
     ]
     输出：1

     输入：grid = [
       ["1","1","0","0","0"],
       ["1","1","0","0","0"],
       ["0","0","1","0","0"],
       ["0","0","0","1","1"]
     ]
     输出：3
     */
    
    NSMutableArray *grid0 = @[
        @[@(1), @(1), @(1), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(0), @(0), @(0)].mutableCopy,
    ].mutableCopy;
    
    NSMutableArray *grid1 = @[
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(1), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(0), @(1), @(1)].mutableCopy,
    ].mutableCopy;
    
    NSArray *grids = @[grid0, grid1];
    for (NSInteger i = 0; i < grids.count; i++) {
        NSInteger num = [self action0NumOfGrid:grids[i]];
        NSLog(@"%ld", num);
    }
    
}

// 岛屿问题通解
// https://leetcode-cn.com/problems/number-of-islands/solution/dao-yu-lei-wen-ti-de-tong-yong-jie-fa-dfs-bian-li-/
- (NSInteger)action0NumOfGrid:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
{
    NSInteger num = 0;
    for (NSInteger row = 0; row < grid.count; row++) {
        for (NSInteger col = 0; col < grid.firstObject.count; col++) {
            if([grid[row][col] isEqual:@(1)]) {
                num++;
                [self action0Dfs:grid row:row col:col];
            }
        }
    }
    return num;
}

- (void)action0Dfs:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
               row:(NSInteger)row
               col:(NSInteger)col
{
    //判断 base case
    //如果坐标（r,c）超出了网格范围，直接返回
    if(![self action0IsArea:grid row:row col:col]) return;
    
    //如果这个格子不是岛屿，直接返回
    if (![grid[row][col] isEqual:@(1)]) return;
    
    grid[row][col] = @(2); //将格子标记为【已遍历过】
    
    //访问上、下、左、右四个相邻结点
    [self action0Dfs:grid row:row-1 col:col];
    [self action0Dfs:grid row:row+1 col:col];
    [self action0Dfs:grid row:row col:col-1];
    [self action0Dfs:grid row:row col:col+1];
}

//判断坐标（r,c）是否在网格中
- (BOOL)action0IsArea:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
                  row:(NSInteger)row
                  col:(NSInteger)col
{
    return (0 <= row && row < grid.count && 0 <= col && col < grid[0].count);
}

- (void)action1
{
    // 463 岛屿的周长
    NSMutableArray *grid = @[
        @[@(1), @(1), @(1), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(0), @(0), @(0)].mutableCopy,
    ].mutableCopy;
    NSInteger max = [self action1MaxPerOfGrid:grid];
    NSLog(@"%ld", max);
}

- (NSInteger)action1MaxPerOfGrid:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
{
    for (NSInteger row = 0; row < grid.count; row++) {
        for (NSInteger col = 0; col < grid.firstObject.count; col++) {
            if([grid[row][col] isEqual:@(1)]) {
                return [self action1Pre:grid row:row col:col];
            }
        }
    }
    return 0;
}

- (NSInteger)action1Pre:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
                    row:(NSInteger)row
                    col:(NSInteger)col
{
    //判断 base case
    //如果坐标（r,c）超出了网格范围，直接返回
    if(![self action0IsArea:grid row:row col:col]) return 1;
    
    //函数因为「当前格子是海洋格子」返回，对应一条蓝色的边
    if ([grid[row][col] isEqual:@(0)]) return 1;
    
    //如果这个格子不是岛屿，直接返回
    if (![grid[row][col] isEqual:@(1)]) return 0;
    
    grid[row][col] = @(2); //将格子标记为【已遍历过】
    
    //访问上、下、左、右四个相邻结点
    return [self action2Area:grid row:row-1 col:col] +
    [self action2Area:grid row:row+1 col:col] +
    [self action2Area:grid row:row col:col-1] +
    [self action2Area:grid row:row col:col+1];
}

- (void)action2
{
    // 695 岛屿的最大面积
    
    NSMutableArray *grid = @[
        @[@(1), @(1), @(1), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(1), @(0)].mutableCopy,
        @[@(1), @(1), @(0), @(0), @(0)].mutableCopy,
        @[@(0), @(0), @(0), @(0), @(0)].mutableCopy,
    ].mutableCopy;
    NSInteger max = [self action2MaxAreaOfGrid:grid];
    NSLog(@"%ld", max);
}

- (NSInteger)action2MaxAreaOfGrid:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
{
    NSInteger maxArea = 0;
    for (NSInteger row = 0; row < grid.count; row++) {
        for (NSInteger col = 0; col < grid.firstObject.count; col++) {
            if([grid[row][col] isEqual:@(1)]) {
                NSInteger area = [self action2Area:grid row:row col:col];
                maxArea = MAX(area, maxArea);
            }
        }
    }
    return maxArea;
}

- (NSInteger)action2Area:(NSMutableArray <NSMutableArray <NSNumber *>*>*)grid
                     row:(NSInteger)row
                     col:(NSInteger)col
{
    //判断 base case
    //如果坐标（r,c）超出了网格范围，直接返回
    if(![self action0IsArea:grid row:row col:col]) return 0;
    
    //如果这个格子不是岛屿，直接返回
    if (![grid[row][col] isEqual:@(1)]) return 0;
    
    grid[row][col] = @(2); //将格子标记为【已遍历过】
    
    //访问上、下、左、右四个相邻结点
    return 1 +
    [self action2Area:grid row:row-1 col:col] +
    [self action2Area:grid row:row+1 col:col] +
    [self action2Area:grid row:row col:col-1] +
    [self action2Area:grid row:row col:col+1];
}

- (void)action3
{
    // 827 填海造陆问题
    
}

@end
