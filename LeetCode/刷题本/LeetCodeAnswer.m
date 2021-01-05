//
//  LeetCodeAnswer.m
//  BaseProjectFramework
//
//  Created by curry on 2020/10/10.
//  Copyright © 2020 CNLive_张建军. All rights reserved.
//

#import "LeetCodeAnswer.h"

@implementation LeetCodeAnswer

+ (void)invokeLeetCodeNum:(NSInteger)num
{
    NSString *selName = [NSString stringWithFormat:@"answer_%ld", num];
    NSLog(@"go to %@", selName);
    SEL selector = NSSelectorFromString(selName);
    IMP imp = [self methodForSelector:selector];
    void(*func)(id, SEL, NSDictionary*) = (void *)imp;
    @try {
        func(self, selector, nil);
    } @catch (NSException *exception) {
        NSLog(@"catch %@", exception.reason);
    }
}

#pragma mark - Zhe Answer
+ (void)answer_1 {
    int target = 9;
    NSArray *arr = @[@(2), @(7), @(11), @(15)];
    for (int i = 0; i < arr.count; i++) {
        int f = [arr[i] intValue];
        int s = target - f;
        for (int j = i; j < arr.count; j++) {
            if ([arr[j] intValue] == s) {
                NSLog(@"- %d - %d", i, j);
                break;
            }
        }
    }
}

+ (void)answer_2 {
    NSArray *num0 = @[@"2", @"4", @"3"];
    NSArray *num1 = @[@"5", @"6", @"4"];
    NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:0];
    NSInteger count = 0;
    NSInteger jinzhi = 0;
    if (num0.count >= num1.count) {
        count = num0.count;
    } else {
        count = num1.count;
    }
    
    for (int i = 0; i < count; i++) {
        
        NSInteger int0 = 0, int1 = 0;
        if (num0.count > i) {
            int0 = [num0[i] integerValue];
        }
        
        if (num1.count > i) {
            int1 = [num1[i] integerValue];
        }
        
        NSInteger temp = 0;
        if (int0 + int1 + jinzhi >= 10) {
            temp = int0 + int1 + jinzhi - 10;
            jinzhi = 1;
        } else {
            temp = int0 + int1 + jinzhi;
            jinzhi = 0;
        }
        [newArr addObject:[NSString stringWithFormat:@"%ld", temp]];
    }
    
    if (jinzhi == 1) {
        [newArr addObject:@"1"];
    }
    
    NSLog(@"\n%@", newArr);
}

+ (void)answer_3 {
    NSString *str = @"abcabcbb";
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < str.length; i++) {
        NSString *sub = [str substringWithRange:NSMakeRange(i, 1)];
        if (![arr containsObject:sub]) {
            [arr addObject:sub];
        }
    }
    NSLog(@"\n%@", arr);
}

+ (void)answer_4 {
    // 先冒泡 拿到有序集 再取中位数
    NSArray *num1 = @[@"1", @"2", @"3"];
    NSArray *num2 = @[ @"4", @"5"];

    NSMutableArray *total = [num1 arrayByAddingObjectsFromArray:num2].mutableCopy;
    for (int i = 0; i < total.count; i++) {
        for (int j = i + 1; j < total.count; j++) {
            int a = [[total objectAtIndex:i] intValue];
            int b = [[total objectAtIndex:j] intValue];
            if (a>b) { //从小到大
                [total replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",b]];
                [total replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%d",a]];
            }
        }
    }

    CGFloat result = 0;
    if (total.count % 2 != 0) {
        int index = (int)(total.count / 2);
        result = ([total[index] intValue]+ [total[index + 1] intValue]) / 2.0;
    } else {
        int index = (total.count + 1) / 2.0;
        result = [total[index] intValue];
    }

    NSLog(@"\n%f", result);
}

+ (void)answer_5 {
    //"回文串"是一个正读和反读都一样的字符串，比如“level”或者“noon”等等就是回文串
    
    NSString *str = @"bacadjfoiiolpoooopzaba";
    // 字符串长度
    int len = (int)str.length;
    if (len < 2) {
        return;
    }
    
    int maxLen = 1;
    int begin = 0;
    
    NSMutableArray *arr = @[].mutableCopy;
    for (int i = 0; i < len; i++) {
        NSString *subString = [str substringWithRange:NSMakeRange(i, 1)];
        [arr addObject:subString];
    }
    
    for (int i = 0; i < len; i++) {
        NSLog(@"--起始index %d 起始%@", i, arr[i]);
        for (int j = i + 1; j < len; j++) {
            NSLog(@"结尾index %d 结尾%@", j, arr[j]);
            // 当前 长度大于之前的 回文串长度 并且 当前的串是回文串
            int subLen = j - i + 1;
            if (subLen > maxLen && validPalindromic(arr, i, j)) {
                maxLen = subLen;
                begin = i;
                NSLog(@"符合条件begin %d, maxLen %d", begin, maxLen);
            }
        }
    }
    NSLog(@"-- %@", [str substringWithRange:NSMakeRange(begin, maxLen)]);
}

BOOL validPalindromic(NSArray <NSString *> *arr, int left, int right)
{
    while (left < right) {
        if (![arr[left] isEqualToString:arr[right]]) {
            return NO;
        }
        left++;
        right--;
    }
    return YES;
}

+ (void)answer_6 {
    NSString *str = @"leetcodeishiring";
    NSInteger row = 4;
    NSLog(@"answer_6: %@", [self answer_6_convert:str row:row]);
}

+ (NSString *)answer_6_convert:(NSString *)str row:(NSInteger)row
{
    if (row < 2) {
        return str;
    }
    // 转化成字符串数组
    NSMutableArray *strArr = @[].mutableCopy;
    for (int i = 0; i < str.length; i++) {
        NSString *subString = [str substringWithRange:NSMakeRange(i, 1)];
        [strArr addObject:subString];
    }
    
    // 构建存储容器
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:row];
    for (int i = 0; i < row; i++) {
        [arr addObject:@""];
    }
    // arr 为行数的集合 arr[i] 第i行的所有字符串
    NSInteger i = 0;
    NSInteger flag = -1;
    for (NSString *subString in strArr) {
        arr[i] = [NSString stringWithFormat:@"%@%@", arr[i], subString];
        if (i == 0 || i == row - 1) {
            flag = -flag;
        }
        i += flag;
    }

    // 按照行数重新拼接
    NSString *newStr = @"";
    for (NSString *newSubStr in arr) {
        newStr = [NSString stringWithFormat:@"%@%@", newStr, newSubStr];
    }
    return newStr;
}

+ (void)answer_7 {
    int num = -1230;
    int newNum = [self answer_7_convert:num];
    NSLog(@"answer_7: %@", [NSString stringWithFormat:@"%d", newNum]);
}

+ (int)answer_7_convert:(int)x
{
    // 当前计算结果
    int ans = 0;
    while (x != 0) {
        // 下一位
        int pop = x % 10;
        // 判断溢出情况
        // -2147483648 ~ 2147483647
        if (ans > INT32_MAX / 10 || (ans == INT32_MAX / 10 && pop > 7)) {
            return 0;
        }
        
        if (ans < INT32_MIN / 10 || (ans == INT32_MIN / 10 && pop < -8)) {
            return 0;
        }
        
        ans = ans * 10 + pop;
        x /= 10;
    }
    return ans;
}

@end
