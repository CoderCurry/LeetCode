//
//  TreeNode.m
//  LeetCode
//
//  Created by curry on 2021/1/7.
//

#import "TreeNode.h"

@implementation TreeNode

+ (instancetype)nodeValue:(NSInteger)value
                     left:(TreeNode * _Nullable)left
                    right:(TreeNode * _Nullable)right
{
    TreeNode *node = [[TreeNode alloc] init];
    node.value = value;
    node.left = left;
    node.right = right;
    return node;
}

@end
