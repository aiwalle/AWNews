//
//  NSString+Common.h
//  LJAppStandard
//
//  Created by liang on 16/4/10.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

/*! 判断文本框是否为空（非正则表达式）*/
- (BOOL)isEmpty;

/*! 判断邮箱是否正确*/
- (BOOL)validateEmail;

/*! 判断验证码是否正确（6位数字验证码）*/
- (BOOL)validateAuthen;

/*! 判断密码格式是否正确*/
- (BOOL)validatePassword;

/*! 判断手机号码是否正确*/
- (BOOL)validatePhoneNumber;

/*! 自己写正则传入进行判断*/
- (BOOL)validateWithRegExp: (NSString *)regExp;

@end
