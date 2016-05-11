//
//  NSString+Common.m
//  LJAppStandard
//
//  Created by liang on 16/4/10.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

- (BOOL)isEmpty {
    return self.length == 0;
}

- (BOOL)validateEmail {
    return [self validateWithRegExp: @"^[a-zA-Z0-9]{4,}@[a-z0-9A-Z]{2,}\\.[a-zA-Z]{2,}$"];
}

- (BOOL)validateAuthen{
    return [self validateWithRegExp: @"^\\d{5,6}$"];
}

- (BOOL)validatePassword{
    NSString * length = @"^\\w{6,18}$"; //长度
    NSString * number = @"^\\w*\\d+\\w*$";//数字
    NSString * lower = @"^\\w*[a-z]+\\w*$";//小写字母
    NSString * upper = @"^\\w*[A-Z]+\\w*$";//大写字母
    return [self validateWithRegExp: length] && [self validateWithRegExp: number] && [self validateWithRegExp: lower] && [self validateWithRegExp: upper];
}

- (BOOL)validatePhoneNumber {
    NSString * reg = @"^1\\d{10}$";
    return [self validateWithRegExp: reg];
}

- (BOOL)validateWithRegExp: (NSString *)regExp {
    NSPredicate * predicate = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", regExp];
    return [predicate evaluateWithObject: self];
}

@end
