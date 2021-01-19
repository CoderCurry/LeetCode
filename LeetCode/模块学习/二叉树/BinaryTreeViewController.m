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
     层次 [[5], [4,6], [1,2,7,8]]
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

/*
 满二叉树: 如果一棵二叉树只有度为0的结点和度为2的结点，并且度为0的结点在同一层上，则这棵二叉树为满二叉树
 叶子节点: 是指没有子节点的节点
 */

/*
 二叉树主要有两种遍历方式：
- 深度优先遍历：先往深走，遇到叶子节点再往回走。包括 前序 中序 后序 这里前中后，其实指的就是中间节点的遍历顺序
- 广度优先遍历：一层一层的去遍历。 包括 层侧
 
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
    
    [self configRowTitles:@[@"二叉树前序遍历-深度搜索",
                            @"二叉树中序遍历-深度搜索",
                            @"二叉树后序遍历-深度搜索",
                            @"层次遍历-广度搜索",
                            @"翻转二叉树",
                            @"对称二叉树",
                            @"二叉树的最大深度",
                            @"二叉树的最小深度",
                            @"完全二叉树的节点个数",
                            @"平衡二叉树",
                            @"二叉树的所有路径",
                            @"左叶子之和",
                            @"找树左下角的值",
                            @"路径总和",
                            @"从中序与后序遍历序列构造二叉树"
                            
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
        case 11:
            [self action11];
            break;
        case 12:
            [self action12];
            break;
        case 13:
            [self action13];
            break;
        case 14:
            [self action14];
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
    // 每一层的节点数
    NSMutableArray *nodeArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    if (root.value != 0) {
        [nodeArray addObject:root];
    }
    // 这一层还有节点
    while (nodeArray.count != 0) {
        // 获取当层的节点数 将节点值将入集合 并且将此节点的子节点推入队列中
        NSInteger size = nodeArray.count;
        // 每一层节点的值
        NSMutableArray *subResult = [NSMutableArray arrayWithCapacity:0];
        // 当前层的节点加入队列 并且当前节点的子节点进队
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
    }
    NSLog(@"%@", result);
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
    TreeNode *node4 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:15 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:20 left:node3 right:node4];
    TreeNode *node1 = [TreeNode nodeValue:9 left:nil right:nil];
    TreeNode *head = [TreeNode nodeValue:3 left:node1 right:node2];
    NSInteger depth = [self deepTreeNode:head];
    NSLog(@"%ld", depth);
}

- (NSInteger)deepTreeNode:(TreeNode *)node
{
    if (node.value == 0) {
        return 0;
    }
    NSInteger leftDepth = [self deepTreeNode:node.left];
    NSInteger rightDepth = [self deepTreeNode:node.right];
    NSInteger nodeDepth = MAX(leftDepth, rightDepth) + 1;
    // 加1 是当前node的高度 leftDeep只是从 node.left 开始计算
    return nodeDepth;
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
    TreeNode *node4 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:15 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:20 left:node3 right:node4];
    TreeNode *node1 = [TreeNode nodeValue:9 left:nil right:nil];
    TreeNode *head = [TreeNode nodeValue:3 left:node1 right:node2];
    NSInteger depth = [self minTreeNode:head];
    NSLog(@"%ld", depth);
}

- (NSInteger)minTreeNode:(TreeNode *)node
{
    if (node.value == 0) {
        return 0;
    }
    
    NSInteger leftDepth = [self deepTreeNode:node.left];
    NSInteger rightDepth = [self deepTreeNode:node.right];
    if (node.left == 0 && node.right > 0) {
        return 1 + rightDepth;
    }
    
    if (node.right == 0 && node.left > 0) {
        return 1 + leftDepth;
    }
    
    NSInteger nodeDepth = MIN(leftDepth, rightDepth) + 1;
    return nodeDepth;
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
    TreeNode *node5 = [TreeNode nodeValue:6 left:nil right:nil];
    TreeNode *node4 = [TreeNode nodeValue:5 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:3 left:node5 right:nil];
    TreeNode *node1 = [TreeNode nodeValue:2 left:node3 right:node4];
    TreeNode *head = [TreeNode nodeValue:1 left:node1 right:node2];
    NSInteger count = [self countTreeNode:head];
    NSLog(@"- %ld", count);
}
// 第一种直接层次遍历
// 第二种 不讲武德
- (NSInteger)countTreeNode:(TreeNode *)node
{
    if (node.value == 0) {
        return 0;
    }
    return [self countTreeNode:node.left] + [self countTreeNode:node.right] + 1;
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
    
    
    TreeNode *node3 = [TreeNode nodeValue:5 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:3 left:nil right:nil];
    TreeNode *node1 = [TreeNode nodeValue:2 left:nil right:node3];
    TreeNode *head = [TreeNode nodeValue:1 left:node1 right:node2];
    
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    [self traversal:head path:path pathArray:result];
    NSLog(@"%@", result);
}

- (void)traversal:(TreeNode *)cur path:(NSMutableArray *)path pathArray:(NSMutableArray *)result
{
    [path addObject:@(cur.value)];
    // 找到叶子节点
    if (!cur.left && !cur.right) {
        // 终止
        NSString *sPath = @"";
        for (int i = 0; i < path.count; i++) {
            sPath = [path componentsJoinedByString:@"->"];
        }
        [result addObject:sPath];
//        [result addObject:path.copy];
        return;
    }
    
    if (cur.left) {
        [self traversal:cur.left path:path pathArray:result];
        [path removeLastObject];
    }
    
    if (cur.right) {
        [self traversal:cur.right path:path pathArray:result];
        [path removeLastObject];
    }
}

/*
 1. 确定递归参数及返回值
 - (void)traversal:(TreeNode *)cur path:(NSMutableArray *)path pathArray:(NSMutableArray *)result
 2. 确定终止条件
 // 找到叶子节点 记录路径
 if (!cur.left && !cur.right) {
     // 终止
     [result addObject:path.copy];
     return;
 }
 3. 确定单层递归逻辑 回溯要和递归放在一起
 if (cur.left) {
     [self traversal:cur.left path:path pathArray:result];
     [path removeLastObject];
 }
 
 if (cur.right) {
     [self traversal:cur.right path:path pathArray:result];
     [path removeLastObject];
 }
 */

- (void)action11
{
    // 404. 左叶子之和
    // 计算给定二叉树的所有左叶子之和。
    // 左叶子: 如果左节点不为空，且左节点没有左右孩子，那么这个节点就是左叶子
    /*
            3
           / \
          9   20
             /  \
            15   7
     返回 24
     */
    TreeNode *node4 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:15 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:20 left:node3 right:node4];
    TreeNode *node1 = [TreeNode nodeValue:9 left:nil right:nil];
    TreeNode *head = [TreeNode nodeValue:3 left:node1 right:node2];
    NSInteger sum = [self leftSum:head];
    NSLog(@"sum %ld", sum);
}

- (NSInteger)leftSum:(TreeNode *)node
{
    NSInteger sum = 0;
    // 节点的左存在 并且左节点没有左右孩子 成为左节点
    if (node.left) {
        sum = [self isLeafNode:node.left] ? node.left.value : [self leftSum:node.left];
    }
    
    if (node.right && ![self isLeafNode:node.right]) {
        sum += [self leftSum:node.right];
    }
    return sum;
}

- (BOOL)isLeafNode:(TreeNode *)node
{
    return !node.left && !node.right;
}

- (void)action12
{
    // 513. 找树左下角的值
    /*
            1
           / \
          2   3
         /   / \
        4   5   6
           /
          7
     返回 7
     */
    TreeNode *node6 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node5 = [TreeNode nodeValue:6 left:nil right:nil];
    TreeNode *node4 = [TreeNode nodeValue:5 left:node6 right:nil];
    TreeNode *node3 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:3 left:node4 right:node5];
    TreeNode *node1 = [TreeNode nodeValue:2 left:node3 right:nil];
    TreeNode *head = [TreeNode nodeValue:1 left:node1 right:node2];
    NSInteger value = [self lastLeftNodeValue:head];
    NSLog(@"%ld", value);
}

- (NSInteger)lastLeftNodeValue:(TreeNode *)head
{
    NSMutableArray *nodeQueue = [NSMutableArray array];
    NSInteger result = head.value;
    [nodeQueue addObject:head];
    
    while (nodeQueue.count > 0) {
        NSInteger size = nodeQueue.count;
        for (int i = 0; i < size; i++) {
            TreeNode *node = nodeQueue.firstObject;
            [nodeQueue removeObject:node];
            if (i == 0) {
                result = node.value;
            }
            if (node.left) {
                [nodeQueue addObject:node.left];
            }
            if (node.right) {
                [nodeQueue addObject:node.right];
            }
        }
    }
    return result;
}

- (void)action13
{
    // 112 路径总和
    // 给定一个二叉树和一个目标和，判断该树中是否存在根节点到叶子节点的路径，这条路径上所有节点值相加等于目标和。
    /*
            5
           / \
          4   8
         /   / \
        11  13  4
       / \       \
      7   2       1
     返回 7
     */
    TreeNode *node8 = [TreeNode nodeValue:1 left:nil right:nil];
    TreeNode *node7 = [TreeNode nodeValue:2 left:nil right:nil];
    TreeNode *node6 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node5 = [TreeNode nodeValue:4 left:nil right:node8];
    TreeNode *node4 = [TreeNode nodeValue:13 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:11 left:node6 right:node7];
    TreeNode *node2 = [TreeNode nodeValue:8 left:node4 right:node5];
    TreeNode *node1 = [TreeNode nodeValue:4 left:node3 right:nil];
    TreeNode *head = [TreeNode nodeValue:5 left:node1 right:node2];
    
    NSMutableArray *path = [NSMutableArray array];
    BOOL result = [self traversal1:head path:path target:22];
    NSLog(@"%@", result ? @"yes" : @"no");
}

- (BOOL)traversal1:(TreeNode *)cur path:(NSMutableArray *)path target:(NSInteger)target
{
    [path addObject:@(cur.value)];
    
    if (!cur.left && !cur.right) {
        NSInteger count = 0;
        for (int i = 0; i < path.count; i++) {
            count += [path[i] integerValue];
        }
        if (count == target) {
            NSLog(@"%@", path);
            return YES;
        }
        return NO;
    }
    
    if (cur.left) {
        if ([self traversal1:cur.left path:path target:target]) {
            return YES;
        } else {
            [self traversal1:cur.left path:path target:target];
        }
        
        [path removeObject:@(cur.left.value)];
    }
    
    if (cur.right) {
        if ([self traversal1:cur.right path:path target:target]) {
            return YES;
        } else {
            [self traversal1:cur.right path:path target:target];
        }
    }
    return NO;
}

- (void)action14
{
    // 106 从中序与后序遍历序列构造二叉树
    // 根据一棵树的中序遍历与后序遍历构造二叉树。
    // 注意: 你可以假设树中没有重复的元素。
    /*
            1
           / \
          2   3
         / \ / \
        4  5 6  7
          / \ \
         8   9 10
     返回 7
     */
    // 三种遍历方式构造二叉树
    NSArray *inorder = @[@(4), @(2), @(8), @(5), @(9), @(1), @(6), @(10), @(3), @(7)];
    NSArray *postorder = @[@(4), @(8), @(9), @(5), @(2), @(10), @(6), @(7), @(3), @(1)];
    
}



@end
