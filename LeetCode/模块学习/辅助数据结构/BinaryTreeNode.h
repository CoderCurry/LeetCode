//
//  BinaryTreeNode.h
//  BaseProjectFramework
//
//  Created by curryZ on 2021/1/1.
//  Copyright © 2021 CNLive_张建军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 二叉树
@interface BinaryTreeNode : NSObject
// 值
@property (nonatomic, copy) NSString *value;
// 左节点
@property (nonatomic, strong) BinaryTreeNode *leftNode;
// 右节点
@property (nonatomic, strong) BinaryTreeNode *rightNode;


@end

NS_ASSUME_NONNULL_END
