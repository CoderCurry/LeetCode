//
//  BinaryTree.h
//  BaseProjectFramework
//
//  Created by curry on 2020/12/29.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTree : NSObject

/// 创建二叉树
/// @param values 数据源
+ (BinaryTreeNode *)createTreeWithValues:(NSArray <NSString *>*)values;

// 前序遍历 - 递归
+ (void)preorderNode:(BinaryTreeNode *)root;
// 中序遍历
+ (void)inorderNode:(BinaryTreeNode *)root;
// 后序遍历
+ (void)postorderNode:(BinaryTreeNode *)root;
// 层次遍历
+ (void)levelNode:(BinaryTreeNode *)root;

// 前序遍历 - 迭代
+ (void)preorderTraversal:(BinaryTreeNode *)root;
// 中序遍历
+ (void)inorderTraversal:(BinaryTreeNode *)root;
// 后序遍历
+ (void)postorderTraversal:(BinaryTreeNode *)root;

@end

NS_ASSUME_NONNULL_END
