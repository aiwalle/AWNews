//
//  UIImage+Extension.h
//  LJAppStandard
//
//  Created by liang on 16/4/20.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/** 返回一张没有渲染过的图*/
+ (UIImage *)imageWithNamed:(NSString *)name;
@end
