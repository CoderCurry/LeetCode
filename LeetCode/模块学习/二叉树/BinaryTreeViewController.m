//
//  BinaryTreeViewController.m
//  BaseProjectFramework
//
//  Created by curry on 2020/12/29.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import "BinaryTreeViewController.h"
#import "TreeNode.h"

@interface BinaryTreeViewController ()

@end

@implementation BinaryTreeViewController

/*
 满二叉树: 如果一棵二叉树只有度为0的结点和度为2的结点，并且度为0的结点在同一层上，则这棵二叉树为满二叉树
 叶子节点: 是指没有子节点的节点
 */

/*
  ** 递归方法论 **

 1. 确定递归函数的参数和返回值：确定哪些参数是递归的过程中需要处理的，那么就在递归函数里加上这个参数， 并且还要明确每次递归的返回值是什么进而确定递归函数的返回类型。

 2. 确定终止条件：写完了递归算法, 运行的时候，经常会遇到栈溢出的错误，就是没写终止条件或者终止条件写的不对，操作系统也是用一个栈的结构来保存每一层递归的信息，如果递归没有终止，操作系统的内存栈必然就会溢出。

 3. 确定单层递归的逻辑：确定每一层递归需要处理的信息。在这里也就会重复调用自己来实现递归的过程。
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configRowTitles:@[@"二叉树前序遍历",
                            @"二叉树中序遍历",
                            @"二叉树后序遍历",
                            @"层次遍历",
                            @"翻转二叉树",
                            @"对称二叉树",
                            @"二叉树的最大深度",
                            @"完全二叉树的节点个数",
                            @"平衡二叉树",
                            @"二叉树的所有路径",
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
        case 8:
            [self action8];
            break;
        case 9:
            [self action9];
            break;
        case 10:
            [self action10];
            break;
            
        default:
            break;
    }
}

- (void)action0
{
    TreeNode *head = [self getNormalHead];
    [self preorderNode:head];
}

// 前序遍历
- (void)preorderNode:(TreeNode *)root
{
    if (!root) {
        return;
    }
    NSLog(@"%@", @(root.value).stringValue);
    [self preorderNode:root.left];
    [self preorderNode:root.right];
}

- (void)action1
{
    TreeNode *head = [self getNormalHead];
    [self inorderNode:head];
}

// 中序遍历
- (void)inorderNode:(TreeNode *)root
{
    if (!root) {
        return;
    }
    [self inorderNode:root.left];
    NSLog(@"%@", @(root.value).stringValue);
    [self inorderNode:root.right];
}

- (void)action2
{
    TreeNode *head = [self getNormalHead];
    [self postorderNode:head];
}

// 后序遍历
- (void)postorderNode:(TreeNode *)root
{
    if (!root) {
        return;
    }
    [self postorderNode:root.left];
    [self postorderNode:root.right];
    NSLog(@"%@", @(root.value).stringValue);
}

- (void)action3
{
    TreeNode *head = [self getNormalHead];
    [self levelNode:head];
}

// 层次遍历
- (void)levelNode:(TreeNode *)root
{
    NSMutableArray *nodeArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    if (root.value != 0) {
        [nodeArray addObject:root];
    }
    
    while (nodeArray.count != 0) {
        NSInteger size = nodeArray.count;
        NSMutableArray *subResult = [NSMutableArray arrayWithCapacity:0];
        
        for (int i = 0; i < size; i++) {
            TreeNode *node = nodeArray.firstObject;
            [nodeArray removeObjectAtIndex:0];
            [subResult addObject:@(node.value)];
            
            if (node.left) {
                [nodeArray addObject:node.left];
            }
            
            if (node.right) {
                [nodeArray addObject:node.right];
            }
        }
        [result addObject:subResult];
        NSLog(@"%@", result);
    }
}

- (void)action4
{
    // 226.翻转二叉树
    /*
     4
   /   \
  2     7
 / \   / \
1   3 6   9
     
     ->
     4
   /   \
  7     2
 / \   / \
9   6 3   1
     
     */
    TreeNode *node6 = [TreeNode nodeValue:9 left:nil right:nil];
    TreeNode *node5 = [TreeNode nodeValue:6 left:nil right:nil];
    TreeNode *node4 = [TreeNode nodeValue:3 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:1 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:7 left:node5 right:node6];
    TreeNode *node1 = [TreeNode nodeValue:2 left:node3 right:node4];
    TreeNode *head = [TreeNode nodeValue:4 left:node1 right:node2];
    [self transNode:head];
    NSLog(@"-");
}

- (void)transNode:(TreeNode *)node
{
    if (!node.left && !node.right) {
        return;
    }
    
    TreeNode *temp = node.left;
    node.left = node.right;
    node.right = temp;
    
    [self transNode:node.left];
    [self transNode:node.right];
}

- (void)action5
{
    // 101 对称二叉树
    // 给定一个二叉树，检查它是否是镜像对称的
    /*
         1
        / \
       2   2
      / \ / \
     3  4 4  3
     */
    TreeNode *node6 = [TreeNode nodeValue:3 left:nil right:nil];
    TreeNode *node5 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node4 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:3 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:2 left:node5 right:node6];
    TreeNode *node1 = [TreeNode nodeValue:2 left:node3 right:node4];
    TreeNode *head = [TreeNode nodeValue:1 left:node1 right:node2];
    BOOL isCom = [self compareTreeNode:head.left right:head.right];
    NSLog(@"isCom %@", isCom ? @"yes" : @"no");
}

- (BOOL)compareTreeNode:(TreeNode *)left right:(TreeNode *)right
{
    // 左右都没值
    if (!left && !right) {
        return YES;
    }
    // 一边有值
    if (!left || !right) {
        return NO;
    }
    // 左右相等 且 子树对称
    if (left.value == right.value && [self compareTreeNode:left.left right:right.right] && [self compareTreeNode:left.right right:right.left]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)action6
{
    // 104 二叉树的最大深度
    // 给定一个二叉树，找出其最大深度. 二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。
    /*
            3
           / \
          9   20
             /  \
            15   7
     返回 2
     */
}

- (void)action7
{
    // 111 二叉树的最小深度
    // 给定一个二叉树，找出其最小深度. 最小深度是从根节点到最近叶子节点的最短路径上的节点数量
    /*
            3
           / \
          9   20
             /  \
            15   7
     返回 2
     */

}

- (void)action8
{
    // 222 完全二叉树的节点个数
    // 给出一个完全二叉树，求出该树的节点个数
    /*
            1
           / \
          2   3
         / \ /
        4  5 6
     输出6
     */
}

- (void)action9
{
    // 110 平衡二叉树
    // 给定一个二叉树，判断它是否是高度平衡的二叉树。平衡二叉树定义为：一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过1。
    
    /*
            3
           / \
          9   20
             /  \
            15   7
     返回 YES
     
             3
            / \
           2   2
          / \
         3   3
       /  \
      4    4
     返回 NO
     */
}

- (void)action10
{
    // 257 二叉树的所有路径
    // 给定一个二叉树，返回所有从根节点到叶子节点的路径。
    /*
            1
           / \
          2   3
           \
            5
     返回 ["1->2->5", "1->3]
     */
    
}

#pragma mark - tools
- (TreeNode *)getNormalHead
{
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
    NSArray *arr = @[@(5), @(4), @(6), @(1), @(2), @(7), @(8)];
    TreeNode *head = [self createTreeWithValues:arr];
    return head;
}

- (TreeNode *)createTreeWithValues:(NSArray <NSNumber *>*)values
{
    if (values.count == 0) {
        return nil;
    }
    
    TreeNode *rootNode = nil;
    TreeNode *curNode = nil;
    NSMutableArray *nodeArray = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < values.count; i++) {
        
        if (i == 0) {
            curNode = [TreeNode new];
            curNode.value = values[i].integerValue;
            rootNode = curNode;
            [nodeArray addObject:curNode];
        }

        curNode = nodeArray[i];
        
        NSInteger leftIndex = 2 * i + 1;
        TreeNode *left = [TreeNode new];
        if (leftIndex < values.count && values[leftIndex].integerValue > 0) {
            left.value = values[leftIndex].integerValue;
            curNode.left = left;
        }
        [nodeArray addObject:left];
        
        NSInteger rightIndex = 2 * i + 2;
        TreeNode *right = [TreeNode new];
        if (rightIndex < values.count && values[rightIndex].integerValue > 0) {
            right.value = values[rightIndex].integerValue;
            curNode.right = right;
        }
        [nodeArray addObject:right];
    }
    
    return rootNode;
}
@end
