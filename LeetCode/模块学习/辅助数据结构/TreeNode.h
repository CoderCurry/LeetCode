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



#pragma mark - extra
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
+ (TreeNode *)getNormalHead;






@end

NS_ASSUME_NONNULL_END
