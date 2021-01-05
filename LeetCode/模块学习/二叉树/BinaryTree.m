//
//  BinaryTree.m
//  BaseProjectFramework
//
//  Created by curry on 2020/12/29.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import "BinaryTree.h"

@implementation BinaryTree
/*
+ (BinaryTreeNode *)createTreeWithValues:(NSArray <NSString *>*)values
{
    if (values.count == 0) {
        return nil;
    }
    
    NSMutableArray *nodeArray = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < values.count; i++) {
        BinaryTreeNode *treeNode = [BinaryTreeNode new];
        [nodeArray addObject:treeNode];
    }
    
    for (int i = 0; i < nodeArray.count; i++) {
        BinaryTreeNode *curNode = nodeArray[i];
        curNode.value = values[i];
        
        NSInteger leftIndex = 2 * i + 1;
        if (leftIndex < values.count && values[leftIndex].length > 0) {
            BinaryTreeNode *leftNode = nodeArray[leftIndex];
            leftNode.value = values[leftIndex];
            curNode.leftNode = leftNode;
        }
        
        NSInteger rightIndex = 2 * i + 2;
        if (rightIndex < values.count && values[rightIndex].length > 0) {
            BinaryTreeNode *rightNode = nodeArray[rightIndex];
            rightNode.value = values[rightIndex];
            curNode.rightNode = rightNode;
        }
        
    }
    return nodeArray.firstObject;
}*/

+ (BinaryTreeNode *)createTreeWithValues:(NSArray <NSString *>*)values
{
    if (values.count == 0) {
        return nil;
    }
    
    BinaryTreeNode *rootNode = nil;
    BinaryTreeNode *curNode = nil;
    NSMutableArray *nodeArray = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < values.count; i++) {
        
        if (i == 0) {
            curNode = [BinaryTreeNode new];
            curNode.value = values[i];
            rootNode = curNode;
            [nodeArray addObject:curNode];
        }

        curNode = nodeArray[i];
        
        NSInteger leftIndex = 2 * i + 1;
        BinaryTreeNode *leftNode = [BinaryTreeNode new];
        if (leftIndex < values.count && values[leftIndex].length > 0) {
            leftNode.value = values[leftIndex];
            curNode.leftNode = leftNode;
        }
        [nodeArray addObject:leftNode];
        
        NSInteger rightIndex = 2 * i + 2;
        BinaryTreeNode *rightNode = [BinaryTreeNode new];
        if (rightIndex < values.count && values[rightIndex].length > 0) {
            rightNode.value = values[rightIndex];
            curNode.rightNode = rightNode;
        }
        [nodeArray addObject:rightNode];
    }
    
    return rootNode;
}


// 前序遍历
+ (void)preorderNode:(BinaryTreeNode *)root
{
    if (!root) {
        return;
    }
    NSLog(@"%@", root.value);
    [self preorderNode:root.leftNode];
    [self preorderNode:root.rightNode];
}
// 中序遍历
+ (void)inorderNode:(BinaryTreeNode *)root
{
    if (!root) {
        return;
    }
    [self inorderNode:root.leftNode];
    NSLog(@"%@", root.value);
    [self inorderNode:root.rightNode];
}
// 后序遍历
+ (void)postorderNode:(BinaryTreeNode *)root
{
    if (!root) {
        return;
    }
    [self postorderNode:root.leftNode];
    [self postorderNode:root.rightNode];
    NSLog(@"%@", root.value);
}

// 层次遍历
+ (void)levelNode:(BinaryTreeNode *)root
{
    NSMutableArray *nodeArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    if (root.value.length != 0) {
        [nodeArray addObject:root];
    }
    
    while (nodeArray.count != 0) {
        NSInteger size = nodeArray.count;
        NSMutableArray *subResult = [NSMutableArray arrayWithCapacity:0];
        
        for (int i = 0; i < size; i++) {
            BinaryTreeNode *node = nodeArray.firstObject;
            [nodeArray removeObjectAtIndex:0];
            [subResult addObject:node.value];
            
            if (node.leftNode) {
                [nodeArray addObject:node.leftNode];
            }
            
            if (node.rightNode) {
                [nodeArray addObject:node.rightNode];
            }
        }
        [result addObject:subResult];
        NSLog(@"%@", result);
    }
}

// 前序遍历 - 迭代
+ (void)preorderTraversal:(BinaryTreeNode *)root
{

}
// 中序遍历
+ (void)inorderTraversal:(BinaryTreeNode *)root
{
    
}
// 后序遍历
+ (void)postorderTraversal:(BinaryTreeNode *)root
{
    
}

@end
