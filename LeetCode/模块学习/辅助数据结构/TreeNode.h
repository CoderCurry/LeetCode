//
//  TreeNode.h
//  LeetCode
//
//  Created by curry on 2021/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : NSObject

// 值
@property (nonatomic, assign) NSInteger value;
// 左节点
@property (nonatomic, strong) TreeNode *left;
// 右节点
@property (nonatomic, strong) TreeNode *right;

+ (instancetype)nodeValue:(NSInteger)value
                     left:(TreeNode * _Nullable)left
                    right:(TreeNode * _Nullable)right;
@end

NS_ASSUME_NONNULL_END
