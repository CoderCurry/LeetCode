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
    
    [self configRowTitles:@[@"144.二叉树前序遍历-深度搜索",
                            @"94.二叉树中序遍历-深度搜索",
                            @"145.二叉树后序遍历-深度搜索",
                            @"102.层次遍历-广度搜索",
                            @"226.翻转二叉树",
                            @"101.对称二叉树",
                            @"104.二叉树的最大深度",
                            @"111.二叉树的最小深度",
                            @"222.完全二叉树的节点个数",
                            @"110.平衡二叉树",
                            @"257.二叉树的所有路径",
                            @"404.左叶子之和",
                            @"513.找树左下角的值",
                            @"112.路径总和",
                            @"113.路径总和II",
                            @"106.从中序与后序遍历序列构造二叉树",
                            @"105.从前序与中序遍历序列构造二叉树",
                            @"654.最大二叉树",
                            @"617.合并二叉树",
                            @"98.验证二叉搜索树",
                            @"530.二叉搜索树的最小绝对差",
                            @"236.二叉树的最近公共祖先"
    ]];
    
}

- (void)action144
{
    TreeNode *head = [TreeNode getNormalHead];
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

- (void)action94
{
    TreeNode *head = [TreeNode getNormalHead];
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

- (void)action145
{
    TreeNode *head = [TreeNode getNormalHead];
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

- (void)action102
{
    TreeNode *head = [TreeNode getNormalHead];
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

- (void)action226
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

- (void)action101
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
    if (left.value == right.value &&
        [self compareTreeNode:left.left right:right.right] &&
        [self compareTreeNode:left.right right:right.left]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)action104
{
    // 104 二叉树的最大深度
    // 给定一个二叉树，找出其最大深度. 二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。
    /*
            3
           / \
          9   20
             /  \
            15   7
     返回 3
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

- (void)action111
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
    
    NSInteger leftDepth = [self minTreeNode:node.left];
    NSInteger rightDepth = [self minTreeNode:node.right];
    // 只有当左右节点都是nil的时候 才是最小深度
    // 一边为空 另一边不为空 不是
    // 下面是用来找叶子节点的
    if (node.left == nil && node.right > 0) {
        return 1 + rightDepth;
    }
    
    if (node.right == nil && node.left > 0) {
        return 1 + leftDepth;
    }
    
    NSInteger nodeDepth = MIN(leftDepth, rightDepth) + 1;
    return nodeDepth;
}

- (void)action222
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
    // node nil 返回 0
    if (node.value == 0) {
        return 0;
    }
    // 否则返回1 接着遍历左右节点
    return [self countTreeNode:node.left] + [self countTreeNode:node.right] + 1;
}

- (void)action110
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
    
    TreeNode *node04 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node03 = [TreeNode nodeValue:15 left:nil right:nil];
    TreeNode *node02 = [TreeNode nodeValue:20 left:node03 right:node04];
    TreeNode *node01 = [TreeNode nodeValue:9 left:nil right:nil];
    TreeNode *head0 = [TreeNode nodeValue:3 left:node01 right:node02];
    BOOL isBal = [self action9isBalanced:head0];
    NSLog(@"head0 %@", isBal ? @"yes" : @"no");
    
    TreeNode *node16 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node15 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node14 = [TreeNode nodeValue:3 left:node15 right:node16];
    TreeNode *node13 = [TreeNode nodeValue:3 left:nil right:nil];
    TreeNode *node12 = [TreeNode nodeValue:2 left:nil right:nil];
    TreeNode *node11 = [TreeNode nodeValue:2 left:node13 right:node14];
    TreeNode *head1 = [TreeNode nodeValue:3 left:node11 right:node12];
    BOOL isBal1 = [self action9isBalanced:head1];
    NSLog(@"head1 %@", isBal1 ? @"yes" : @"no");
}
- (BOOL)action9isBalanced:(TreeNode *)node
{
    return [self action9DepNode:node] != -1;
}

// 如果这个节点时平衡的 返回这个节点的深度 用来和兄弟节点比较 如果不是 返回-1
- (NSInteger)action9DepNode:(TreeNode *)node
{
    if (node == nil) return 0;
    NSInteger left = [self action9DepNode:node.left];
    if(left == -1) return -1;
    NSInteger right = [self action9DepNode:node.right];
    if(right == -1) return -1;
    //如果子树平衡(也就是相应的深度之差的绝对值小于2),则返回该子树的深度用于和他的兄弟子树比较深度之差
    return labs(left - right) < 2 ? MAX(left, right) + 1 : -1;
}

- (void)action257
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

- (void)traversal:(TreeNode *)cur
             path:(NSMutableArray *)path
        pathArray:(NSMutableArray *)result
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

- (void)action404
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
    // 节点的左存在 并且左节点是叶子节点 记录值 否则查询左节点下的左节点值
    if (node.left) {
        sum += [self isLeafNode:node.left] ? node.left.value : [self leftSum:node.left];
    }
    // 节点的右存在 并且右节点不是叶子节点 查询右节点下的左节点值
    if (node.right && ![self isLeafNode:node.right]) {
        sum += [self leftSum:node.right];
    }
    return sum;
}

- (BOOL)isLeafNode:(TreeNode *)node
{
    return !node.left && !node.right;
}

- (void)action513
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

// 如果需要搜索整颗二叉树，那么递归函数就不要返回值，如果要搜索其中一条符合条件的路径，递归函数就需要返回值，因为遇到符合条件的路径了就要及时返回
- (void)action112
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
    
    BOOL result =  [self action13Traversa:head sum:22];
    NSLog(@"%@", result ? @"yes" : @"no");
}

- (BOOL)action13Traversa:(TreeNode *)cur sum:(NSInteger)sum
{
    if(!cur){
        return NO;
    }
    
    if(cur.left == nil && cur.right == nil){
        // 当cur为叶子节点时 cur的值 == 剩余值 则路径正好等于目标和
        return cur.value == sum;
    }
    
    // 左节点 接着递归 需要的和是 sum - cur.value
    BOOL left = [self action13Traversa:cur.left sum:sum - cur.value];
    // 右节点 接着递归 需要的和是 sum - cur.value
    BOOL right = [self action13Traversa:cur.right sum:sum - cur.value];
    // 当有一个路径 符合即可
    return left || right;
}

- (void)action113
{
    // 113. 路径总和II
    /*
     给定一个二叉树和一个目标和，找到所有从根节点到叶子节点路径总和等于给定目标和的路径。

     说明: 叶子节点是指没有子节点的节点。

     示例:
     给定如下二叉树，以及目标和 sum = 22，

      5
     / \
    4   8
   /   / \
  11  13  4
 /  \    / \
7    2  5   1

     [
        [5,4,11,2],
        [5,8,4,5]
     ]
     */
    TreeNode *node9 = [TreeNode nodeValue:1 left:nil right:nil];
    TreeNode *node8 = [TreeNode nodeValue:5 left:nil right:nil];
    TreeNode *node7 = [TreeNode nodeValue:2 left:nil right:nil];
    TreeNode *node6 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node5 = [TreeNode nodeValue:4 left:node8 right:node9];
    TreeNode *node4 = [TreeNode nodeValue:13 left:nil right:nil];
    TreeNode *node3 = [TreeNode nodeValue:11 left:node6 right:node7];
    TreeNode *node2 = [TreeNode nodeValue:8 left:node4 right:node5];
    TreeNode *node1 = [TreeNode nodeValue:4 left:node3 right:nil];
    TreeNode *head = [TreeNode nodeValue:5 left:node1 right:node2];
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *path = [NSMutableArray array];
    [path addObject:@(head.value)];
    [self action113AllPath:head sum:22 path:path result:result];
    NSLog(@"%@", result);
}

- (void)action113AllPath:(TreeNode *)node
                     sum:(NSInteger)sum
                    path:(NSMutableArray *)path
                  result:(NSMutableArray *)result
{
    if (node == nil) {
        return;
    }
    
    if (!node.left && !node.right) {
        if (node.value == sum) {
            [result addObject:path.copy];
        }
        return;
    }
    
    if (node.left) {
        [path addObject:@(node.left.value)];
        [self action113AllPath:node.left sum:sum - node.value path:path result:result];
        [path removeLastObject];
    }
    
    if (node.right) {
        [path addObject:@(node.right.value)];
        [self action113AllPath:node.right sum:sum - node.value path:path result:result];
        [path removeLastObject];
    }
}


- (void)action106
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
    TreeNode *result = [self action106inorder:inorder postorder:postorder];
    NSLog(@"%@", result);
}

// https://mp.weixin.qq.com/s/7r66ap2s-shvVvlZxo59xg
- (TreeNode *)action106inorder:(NSArray *)inorder postorder:(NSArray *)postorder
{
    if (inorder.count == 0 || postorder.count == 0) return nil;
//    TreeNode *result =  [self action106Traversal:inorder.mutableCopy postorder:postorder.mutableCopy];
    TreeNode *result = [self action106Traversal:inorder.mutableCopy
                                   inorderBegin:0
                                     inorderEnd:inorder.count - 1
                                      postorder:postorder.mutableCopy
                                 postorderBegin:0
                                   postorderEnd:postorder.count - 1];
    return result;
}

- (TreeNode *)action106Traversal:(NSMutableArray <NSNumber *>*)inorder postorder:(NSMutableArray <NSNumber *>*)postorder
{
    if (postorder.count == 0) return nil;
    
    // 后序遍历数组最后一个元素，就是当前的中间节点
    NSNumber *rootValue = postorder[postorder.count - 1];
    TreeNode *root = [TreeNode nodeValue:rootValue.integerValue left:nil right:nil];
    
    // 叶子节点
    if (postorder.count == 1) return root;
    
    // 找到中序遍历的切割点
    int delimiterIndex;
    for (delimiterIndex = 0; delimiterIndex < inorder.count; delimiterIndex++) {
        if (inorder[delimiterIndex] == rootValue) break;
    }
    
    // 切割中序数组
    // 左闭右开区间：[0, delimiterIndex)
    NSMutableArray *leftInorder = [inorder subarrayWithRange:NSMakeRange(0, delimiterIndex)].mutableCopy;
    // [delimiterIndex + 1, end)
    NSMutableArray *rightInorder = [inorder subarrayWithRange:NSMakeRange(delimiterIndex + 1, (inorder.count - 1) - (delimiterIndex + 1) + 1)].mutableCopy;
    
    // postorder 舍弃末尾元素
    [postorder removeLastObject];
    
    // 切割后序数组
    // 依然左闭右开，注意这里使用了左中序数组大小作为切割点
    // [0, leftInorder.size)
    NSMutableArray *leftPostorder = [postorder subarrayWithRange:NSMakeRange(0, leftInorder.count)].mutableCopy;
    // [leftInorder.size(), end)
    NSMutableArray *rightPostorder = [postorder subarrayWithRange:NSMakeRange(leftPostorder.count, rightInorder.count)].mutableCopy;
    
    root.left = [self action106Traversal:leftInorder postorder:leftPostorder];
    root.right = [self action106Traversal:rightInorder postorder:rightPostorder];
    
    return root;
}
// 进阶版 节省空间 左闭右开的原则
- (TreeNode *)action106Traversal:(NSMutableArray <NSNumber *>*)inorder
                    inorderBegin:(NSInteger)inorderBegin
                      inorderEnd:(NSInteger)inorderEnd
                       postorder:(NSMutableArray <NSNumber *>*)postorder
                  postorderBegin:(NSInteger)postorderBegin
                    postorderEnd:(NSInteger)postorderEnd
{
    if (postorderBegin > postorderEnd) return nil;
    
    NSNumber *rootValue = postorder[postorderEnd];
    TreeNode *root = [TreeNode nodeValue:rootValue.integerValue left:nil right:nil];

    if (postorderEnd - postorderBegin == 0) return root;

    NSInteger delimiterIndex;
    for (delimiterIndex = inorderBegin; delimiterIndex <= inorderEnd; delimiterIndex++) {
        if (inorder[delimiterIndex] == rootValue) break;
    }
    // 切割中序数组
    // 左中序区间，左闭右开[leftInorderBegin, delimiterIndex-1]
    NSInteger leftInorderBegin = inorderBegin;
    NSInteger leftInorderEnd = delimiterIndex-1;
    // 右中序区间，左闭右开[delimiterIndex+1, rightInorderEnd)
    NSInteger rightInorderBegin = delimiterIndex + 1;
    NSInteger rightInorderEnd = inorderEnd;

    // 切割后序数组
    // 左后序区间，左闭右开[postorderBegin, postorderBegin + leftInorder.count - 1]
    NSInteger leftPostorderBegin = postorderBegin;
    NSInteger leftPostorderEnd = postorderBegin + (leftInorderEnd - inorderBegin + 1) - 1;
    // 右后序区间，左闭右开[leftPostorderEnd + 1, postorderEnd - 1)
    NSInteger rightPostorderBegin = leftPostorderEnd + 1;
    NSInteger rightPostorderEnd = postorderEnd - 1; // 排除最后一个元素，后序最后一个元素是用来切割的顶点

    root.left = [self action106Traversal:inorder
                            inorderBegin:leftInorderBegin
                              inorderEnd:leftInorderEnd
                               postorder:postorder
                          postorderBegin:leftPostorderBegin
                            postorderEnd:leftPostorderEnd];
    root.right = [self action106Traversal:inorder
                             inorderBegin:rightInorderBegin
                               inorderEnd:rightInorderEnd
                                postorder:postorder
                           postorderBegin:rightPostorderBegin
                             postorderEnd:rightPostorderEnd];
    
    return root;
}

- (void)action105
{
    // 根据一棵树的前序遍历与中序遍历构造二叉树。
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
    NSArray *preorder = @[@(1), @(2), @(4), @(5), @(8), @(9), @(3), @(6), @(10), @(7)];
    NSArray *inorder = @[@(4), @(2), @(8), @(5), @(9), @(1), @(6), @(10), @(3), @(7)];
    TreeNode *result = [self action105inorder:inorder preorder:preorder];
    NSLog(@"%@", result);
}

- (TreeNode *)action105inorder:(NSArray *)inorder preorder:(NSArray *)preorder
{
    if (inorder.count == 0 || preorder.count == 0) return nil;
//    TreeNode *result = [self action105Traversal:inorder.mutableCopy preorder:preorder.mutableCopy];
    TreeNode *result = [self action105Traversal:inorder.mutableCopy
                                   inorderBegin:0
                                     inorderEnd:inorder.count - 1
                                       preorder:preorder.mutableCopy
                                  preorderBegin:0
                                    preorderEnd:preorder.count - 1];
    return result;
}

- (TreeNode *)action105Traversal:(NSMutableArray <NSNumber *>*)inorder preorder:(NSMutableArray <NSNumber *>*)preorder
{
    if (preorder.count == 0) {
        return nil;
    }
    
    NSNumber *root = preorder.firstObject;
    TreeNode *rootNode = [TreeNode nodeValue:root.integerValue left:nil right:nil];
    
    // 叶子节点
    if (preorder.count == 1) {
        return rootNode;
    }
    
    // 查找中序分割点
    NSInteger rootIndex = 0;
    for (NSInteger i = 0; i < inorder.count; i++) {
        if (inorder[i] == root) {
            rootIndex = i;
            break;
        }
    }
    // 切割中序
    NSMutableArray *leftInorder = [inorder subarrayWithRange:NSMakeRange(0, rootIndex)].mutableCopy;
    NSMutableArray *rightInorder = [inorder subarrayWithRange:NSMakeRange(rootIndex + 1, inorder.count - 1 - (rootIndex + 1) + 1)].mutableCopy;
    
    // 切割前序
    [preorder removeObjectAtIndex:0];
    NSMutableArray *leftPreorder = [preorder subarrayWithRange:NSMakeRange(0, leftInorder.count)].mutableCopy;
    NSMutableArray *rightPreorder = [preorder subarrayWithRange:NSMakeRange(leftPreorder.count, preorder.count - 1 - leftPreorder.count + 1)].mutableCopy;
    
    
    rootNode.left = [self action105Traversal:leftInorder preorder:leftPreorder];
    rootNode.right = [self action105Traversal:rightInorder preorder:rightPreorder];
    return rootNode;
}

- (TreeNode *)action105Traversal:(NSMutableArray <NSNumber *>*)inorder
                    inorderBegin:(NSInteger)inorderBegin
                      inorderEnd:(NSInteger)inorderEnd
                        preorder:(NSMutableArray <NSNumber *>*)preorder
                   preorderBegin:(NSInteger)preorderBegin
                     preorderEnd:(NSInteger)preorderEnd
{
    if (preorderBegin > preorderEnd) {
        return nil;
    }
    
    NSNumber *root = preorder[preorderBegin];
    TreeNode *rootNode = [TreeNode nodeValue:root.integerValue left:nil right:nil];
    
    NSInteger inorderRootIndex = 0;
    for (NSInteger i = inorderBegin; i <= inorderEnd; i++) {
        if (inorder[i] == root) {
            inorderRootIndex = i;
            break;;
        }
    }
    // [inorderBegin, inorderRootIndex-1]
    NSInteger leftInorderBegin = inorderBegin;
    NSInteger leftInorderEnd = inorderRootIndex - 1;
    // [inorderRootIndex + 1, inorderEnd]
    NSInteger rightInorderBegin = inorderRootIndex + 1;
    NSInteger rightInorderEnd = inorderEnd;
    
    // preorderBegin + 1 是因为第一个是root
    // [preorderBegin + 1, leftPreorderBegin + (leftInorderEnd - leftInorderBegin)]
    NSInteger leftPreorderBegin = preorderBegin + 1;
    NSInteger leftPreorderEnd = leftPreorderBegin + (leftInorderEnd - leftInorderBegin);
    // [leftPreorderEnd + 1, preorderEnd]
    NSInteger rightPreorderBegin = leftPreorderEnd + 1;
    NSInteger rightPreorderEnd = preorderEnd;
    
    rootNode.left = [self action105Traversal:inorder
                                inorderBegin:leftInorderBegin
                                  inorderEnd:leftInorderEnd
                                    preorder:preorder
                               preorderBegin:leftPreorderBegin
                                 preorderEnd:leftPreorderEnd];
    rootNode.right = [self action105Traversal:inorder
                                inorderBegin:rightInorderBegin
                                  inorderEnd:rightInorderEnd
                                    preorder:preorder
                               preorderBegin:rightPreorderBegin
                                 preorderEnd:rightPreorderEnd];
    return rootNode;
}

- (void)action654
{
    // 654.最大二叉树
    /*
     二叉树的根是数组 nums 中的最大元素。
     左子树是通过数组中 最大值左边部分 递归构造出的最大二叉树。
     右子树是通过数组中 最大值右边部分 递归构造出的最大二叉树。
     
     输入 [3,2,1,6,0,5]
     输出 [6,3,5,null,2,0,null,null,1]
     */
    
    NSArray *array = @[@(3), @(2), @(1), @(6), @(0), @(5)];
    
}

- (TreeNode *)action654Traversal:(NSMutableArray <NSNumber *>*)nums
{
    if (nums.count == 0) {
        return nil;
    }
    
    TreeNode *node = [TreeNode nodeValue:0 left:nil right:nil];
    if (nums.count == 1) {
        node.value = nums[0].integerValue;
        return node;
    }
    
    // 找到数组中最大的值和对应的下表
    NSInteger maxValue = 0;
    NSInteger maxValueIndex = 0;
    for (int i = 0; i < nums.count; i++) {
        if (nums[i].integerValue > maxValue) {
            maxValue = nums[i].integerValue;
            maxValueIndex = i;
        }
    }
    node.value = maxValue;
    // 最大值所在的下表左区间 构造左子树
//    if (maxValueIndex > 0) {
//        vector<int> newVec(nums.begin(), nums.begin() + maxValueIndex);
//        node.left = constructMaximumBinaryTree(newVec);
//    }
//    // 最大值所在的下表右区间 构造右子树
//    if (maxValueIndex < (nums.size() - 1)) {
//        vector<int> newVec(nums.begin() + maxValueIndex + 1, nums.end());
//        node.right = constructMaximumBinaryTree(newVec);
//    }
    return node;
}

- (void)action617
{
    // 617.合并二叉树
}

- (TreeNode *)action617MergeTrees:(TreeNode *)t1  t2:(TreeNode *)t2
{
    if (t1 == nil) return t2; // 如果t1为空，合并之后就应该是t2
    if (t2 == nil) return t1; // 如果t2为空，合并之后就应该是t1
    // 修改了t1的数值和结构
    t1.value += t2.value;                             // 中
    t1.left = [self action617MergeTrees:t1.left t2:t2.left]; // 左
    t1.right = [self action617MergeTrees:t1.right t2:t2.right];
    return t1;
}

- (void)action98
{
    // 98.验证二叉搜索树
    
    TreeNode *node2 = [TreeNode nodeValue:3 left:nil right:nil];
    TreeNode *node1 = [TreeNode nodeValue:1 left:nil right:nil];
    TreeNode *node = [TreeNode nodeValue:2 left:node1 right:node2];
    BOOL result = [self action98isSearch:node];
    NSLog(@"%@", result?@"yes":@"no");
}

//要知道中序遍历下，输出的二叉搜索树节点的数值是有序序列。
- (BOOL)action98isSearch:(TreeNode *)node
{
//    NSMutableArray <NSNumber *>*result = [NSMutableArray array];
//    [self action98traversal:node reslut:result];
//
//    BOOL isSearch = YES;
//    for (NSInteger i = 0; i < result.count - 1; i++) {
//        if (result[i].integerValue < result[i+1].integerValue) {
//            continue;
//        } else {
//            isSearch = NO;
//            break;
//        }
//    }
//    return isSearch;
//
    TreeNode *pre = nil;
    return [self action98traversal1:node pre:pre];
}

- (void)action98traversal:(TreeNode *)node reslut:(NSMutableArray *)result
{
    if (node == NULL) return;
    [self action98traversal:node.left reslut:result];
    [result addObject:@(node.value)];
    [self action98traversal:node.right reslut:result];
}

- (BOOL)action98traversal1:(TreeNode *)node pre:(TreeNode *)pre
{
    if (node == nil) return true;
    BOOL left = [self action98traversal1:node.left pre:pre];

    if (pre != nil && pre.value >= node.value) return false;
    pre = node; // 记录前一个节点

    BOOL right = [self action98traversal1:node.right pre:pre];
    return left && right;
}

- (void)action530
{
    // 530.二叉搜索树的最小绝对差
    // 在一个有序数组上求两个数最小差值，这是不是就是一道送分题了。」
    // 最直观的想法，就是把二叉搜索树转换成有序数组，然后遍历一遍数组，就统计出来最小差值了。
    TreeNode *node2 = [TreeNode nodeValue:2 left:nil right:nil];
    TreeNode *node1 = [TreeNode nodeValue:3 left:node2 right:nil];
    TreeNode *node = [TreeNode nodeValue:1 left:nil right:node1];
    NSInteger result= [self action530getMinimumDifference:node];
    NSLog(@"%ld", result);
}

- (NSInteger)action530getMinimumDifference:(TreeNode *)node
{
    NSMutableArray <NSNumber *>*result = [NSMutableArray array];
    [self action98traversal:node reslut:result];
    
    NSInteger min = INT_MAX;
    for (int i = 1; i < result.count; i++) { // 统计有序数组的最小差值
        min = MIN(min, result[i].integerValue - result[i-1].integerValue);
    }
    return min;
}

- (void)action236
{
    // 236. 二叉树的最近公共祖先
    /*
     给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。
     输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
     输出: 3
     解释: 节点 5 和节点 1 的最近公共祖先是节点 3。

     输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
     输出: 5
     */
    
    TreeNode *node8 = [TreeNode nodeValue:4 left:nil right:nil];
    TreeNode *node7 = [TreeNode nodeValue:7 left:nil right:nil];
    TreeNode *node6 = [TreeNode nodeValue:8 left:nil right:nil];
    TreeNode *node5 = [TreeNode nodeValue:0 left:nil right:nil];
    TreeNode *node4 = [TreeNode nodeValue:2 left:node7 right:node8];
    TreeNode *node3 = [TreeNode nodeValue:6 left:nil right:nil];
    TreeNode *node2 = [TreeNode nodeValue:1 left:node5 right:node6];
    TreeNode *node1 = [TreeNode nodeValue:5 left:node3 right:node4];
    TreeNode *node = [TreeNode nodeValue:3 left:node1 right:node2];
    
    TreeNode *common = [self action236TreeNode:node p:node1 q:node8];
    NSLog(@"%ld", common.value);
}

- (TreeNode *)action236TreeNode:(TreeNode *)root p:(TreeNode *)p q:(TreeNode *)q
{
    if (root == nil || root == q || root == p) return root;
    
    TreeNode *left = [self action236TreeNode:root.left p:p q:q];
    TreeNode *right = [self action236TreeNode:root.right p:p q:q];
    // 说明左右子树 都不含pq 返回 nil
    if(left == nil && right == nil) return nil;
    // pq都在右子树中 返回right即可
    if(left == nil) return right;
    // pq都在左子树中 返回left即可
    if(right == nil) return left;
    // 左右都不为空 说明pq在两侧 直接返回root
    return root;
}

@end
