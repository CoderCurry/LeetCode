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

+ (TreeNode *)getNormalHead
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

+ (TreeNode *)createTreeWithValues:(NSArray <NSNumber *>*)values
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
