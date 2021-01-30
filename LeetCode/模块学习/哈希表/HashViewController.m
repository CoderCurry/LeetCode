//
//  HashViewController.m
//  LeetCode
//
//  Created by curryZ on 2021/1/6.
//

#import "HashViewController.h"

@interface HashViewController ()

@end

@implementation HashViewController

/*
 常见的三种哈希结构

 当我们想使用哈希法来解决问题的时候，我们一般会选择如下三种数据结构。
 数组
 set(集合)
 map(映射)
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configRowTitles:@[@"有效的字母异位词",
                            @"快乐数",
                            @"两数之和",
                            @"四数相加II",
                            @"赎金信",
                            @"三数之和",
                            @"四数之和"]];
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
            
        default:
            break;
    }
}

- (void)action0
{
    // 242. 有效的字母异位词
    // 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
    // 字母异位词是指由相同的字母按照不同的顺序组成的单词;
    /*
     输入: s = "anagram", t = "nagaram"
     输出: true
     示例 2:

     输入: s = "rat", t = "car"
     输出: false
     */
    
    BOOL isAnagram = [self isAnagram:@"anagram" t:@"nagaram"];
    BOOL isAnagram1 = [self isAnagram:@"rat" t:@"car"];
    NSLog(@"%@ %@", isAnagram?@"yes":@"no", isAnagram1?@"yes":@"no");
}

- (BOOL)isAnagram:(NSString *)s t:(NSString *)t
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (int i = 0; i < s.length; i++) {
        NSString *subString = [s substringWithRange:NSMakeRange(i, 1)];
        NSInteger count = [dic[subString] integerValue];
        count++;
        dic[subString] = @(count);
    }
    
    for (int i = 0; i < t.length; i++) {
        NSString *subString = [t substringWithRange:NSMakeRange(i, 1)];
        NSInteger count = [dic[subString] integerValue];
        count--;
        if (count == 0) {
            [dic removeObjectForKey:subString];
        } else {
            dic[subString] = @(count);
        }
    }
    return dic.allKeys.count == 0 ? YES : NO;
}

- (void)action1
{
    // 202 快乐数
    // 编写一个算法来判断一个数 n 是不是快乐数。
    // 「快乐数」定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，然后重复这个过程直到这个数变为 1，也可能是 无限循环 但始终变不到 1。如果 可以变为  1，那么这个数就是快乐数。
    /*
     「示例：」
     输入：19
     输出：true
     解释：
     12 + 92 = 82
     82 + 22 = 68
     62 + 82 = 100
     12 + 02 + 02 = 1
     */
    
    BOOL isHappy = [self isHappy:19];
    NSLog(@"isHappy %@", isHappy?@"yes":@"no");
}

- (NSInteger)getSum:(NSInteger)n
{
    NSInteger sum = 0;
    while (n) {
        // 对10取余 -> 个位数平凡和
        sum += (n % 10) * (n % 10);
        // 对10取除
        n /= 10;
    }
    return sum;
}

- (BOOL)isHappy:(NSInteger)n
{
    NSMutableSet *set = [NSMutableSet setWithCapacity:0];
    while (1) {
        NSInteger sum = [self getSum:n];
        if (sum == 1) {
            return YES;
        } else {
            if ([set containsObject:@(sum)]) {
                // sum曾经出现过，说明已经陷入了无限循环了
                return NO;
            } else {
                [set addObject:@(sum)];
            }
        }
        // 将平方和再次取平方和
        n = sum;
    }
}

- (void)action2
{
    // 1 两数之和
    // 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 的那 两个 整数，并返回它们的数组下标。 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。

    /*
     输入：nums = [2,7,11,15], target = 9
     输出：[0,1]
     解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。

     输入：nums = [3,2,4], target = 6
     输出：[1,2]

     输入：nums = [3,3], target = 6
     输出：[0,1]
     */
    NSArray *arr = [self getSumIndex:@[@(2),@(7),@(11),@(15)] target:9];
    NSArray *arr1 = [self getSumIndex:@[@(3),@(2),@(4)] target:6];
    NSArray *arr2 = [self getSumIndex:@[@(3),@(3)] target:6];
    NSLog(@"%@\n%@\n%@\n", arr, arr1, arr2);
}

- (NSArray *)getSumIndex:(NSArray <NSNumber *>*)nums target:(NSInteger)target
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];

    for (int i = 0; i < nums.count; i++) {
        
        // 在i下需要的匹配的值
        NSInteger num = target - nums[i].integerValue;
        NSString *key = @(num).stringValue;
        // 如果匹配到就返回 因为只有一组解 查到就返回
        if ([dic.allKeys containsObject:key]) {
            return @[@(i), dic[key]];
        }
        // 没有匹配到就记录i值
        [dic setObject:@(i) forKey:nums[i].stringValue];
    }
    return @[];
}

- (void)action3
{
    // 454 四数相加II
    // 给定四个包含整数的数组列表 A , B , C , D ,计算有多少个元组 (i, j, k, l) ，使得 A[i] + B[j] + C[k] + D[l] = 0。 为了使问题简单化，所有的 A, B, C, D 具有相同的长度 N，且 0 ≤ N ≤ 500 。所有整数的范围在 -2^28 到 2^28 - 1 之间，最终结果不会超过 2^31 - 1 。
    /*
     「例如:」
     输入: A = [ 1, 2] B = [-2,-1] C = [-1, 2] D = [ 0, 2]
     输出: 2
     「解释:」
     两个元组如下:
     (0, 0, 0, 1) -> A[0] + B[0] + C[0] + D[1] = 1 + (-2) + (-1) + 2 = 0
     (1, 1, 0, 0) -> A[1] + B[1] + C[0] + D[0] = 2 + (-1) + (-1) + 0 = 0
     */
    
    NSInteger res = [self fourSumCount:@[@(1), @(2)]
                                     B:@[@(-2), @(-1)]
                                     C:@[@(-1), @(2)]
                                     D:@[@(0), @(2)]];
    NSLog(@"- %ld", res);
    
}

- (NSInteger)fourSumCount:(NSArray <NSNumber *>*)A
                        B:(NSArray <NSNumber *>*)B
                        C:(NSArray <NSNumber *>*)C
                        D:(NSArray <NSNumber *>*)D
{
    NSMutableDictionary *map = [NSMutableDictionary dictionaryWithCapacity:0];
    int res = 0;
    // 现将AB所有和的情况 存入map key:和 value:重复的次数
    for(int i = 0;i<A.count;i++){
        for(int j= 0;j<B.count;j++){
            NSInteger sumAB = A[i].integerValue + B[j].integerValue;
            
            if ([map.allKeys containsObject:@(sumAB).stringValue]) {
                NSNumber *obj = map[@(sumAB).stringValue];
                [map setObject:@(obj.integerValue + 1) forKey:@(sumAB).stringValue];
            } else {
                [map setObject:@(1) forKey:@(sumAB).stringValue];
            }
        }
    }
    
    // 再计算所有CD的和的情况 从map里面取反值 反值的个数 代表情况的个数
    for(int i = 0;i<C.count;i++){
        for(int j = 0;j<D.count;j++){
            NSInteger sumCD = -(C[i].integerValue + D[j].integerValue);
            
            if ([map.allKeys containsObject:@(sumCD).stringValue]) {
                res += [map[@(sumCD).stringValue] integerValue];
            }
        }
    }
    return res;
}

- (void)action4
{
    // 383 救赎信
    // 给定救赎信字符串(ransom)和杂志字符串(magazine)，判断第一个字符串 ransom 能不能由第二个字符串 magazines 里面的字符构成。如果可以构成，返回 true ；否则返回 false。
    BOOL can = [self canTrans:@"ransom" map:@"magazine"];
    BOOL can1 = [self canTrans:@"a" map:@"b"];
    BOOL can2 = [self canTrans:@"aa" map:@"ab"];
    BOOL can3 = [self canTrans:@"aa" map:@"aab"];
    NSLog(@"canTrans: %@ %@ %@ %@", can ?@"yes":@"no", can1 ?@"yes":@"no", can2 ?@"yes":@"no", can3 ?@"yes":@"no");
}

- (BOOL)canTrans:(NSString *)mail map:(NSString *)map
{
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (int i = 0; i < map.length; i++) {
        NSString *key = [map substringWithRange:NSMakeRange(i, 1)];
        NSInteger count = [mapDic[key] integerValue];
        [mapDic setObject:@(++count) forKey:key];
    }
    
    for (int i = 0; i < mail.length; i++) {
        NSString *key = [mail substringWithRange:NSMakeRange(i, 1)];
        NSInteger count = [mapDic[key] integerValue];
        [mapDic setObject:@(--count) forKey:key];
        if (count < 0) {
            return NO;
        }
    }
    return YES;
}

- (void)action5
{
    NSLog(@"在数组章节中");
}

- (void)action6
{
    NSLog(@"在数组章节中");
}
@end
