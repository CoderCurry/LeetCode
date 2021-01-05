//
//  BinaryTreeViewController.m
//  BaseProjectFramework
//
//  Created by curry on 2020/12/29.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import "BinaryTreeViewController.h"
#import "BinaryTree.h"

@interface BinaryTreeViewController ()

@end

@implementation BinaryTreeViewController

/*
  ** 递归方法论 **

 1. 确定递归函数的参数和返回值：确定哪些参数是递归的过程中需要处理的，那么就在递归函数里加上这个参数， 并且还要明确每次递归的返回值是什么进而确定递归函数的返回类型。

 2. 确定终止条件：写完了递归算法, 运行的时候，经常会遇到栈溢出的错误，就是没写终止条件或者终止条件写的不对，操作系统也是用一个栈的结构来保存每一层递归的信息，如果递归没有终止，操作系统的内存栈必然就会溢出。

 3. 确定单层递归的逻辑：确定每一层递归需要处理的信息。在这里也就会重复调用自己来实现递归的过程。
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /*
            5
           / \
          4   6
         / \ / \
        1  2 7  8
     
     前 5412678
     中 1425768
     后 1247865
    */
    NSArray *arr = @[@"5", @"4", @"6", @"1", @"2", @"7", @"8"];
    
    BinaryTreeNode *rootNode = [BinaryTree createTreeWithValues:arr];
    NSLog(@"--pre");
    [BinaryTree preorderNode:rootNode];
    NSLog(@"--in");
    [BinaryTree inorderNode:rootNode];
    NSLog(@"--post");
    [BinaryTree postorderNode:rootNode];
    NSLog(@"--level");
    [BinaryTree levelNode:rootNode];
}


@end
