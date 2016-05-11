//
//  UIColor+Common.h
//  HZ
//
//  Created by huazi on 14-8-5.
//  Copyright (c) 2014年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Common)
/** 转换16进制的颜色*/
+ (UIColor *)colorWithHexString:(NSString *)color;
@end
