//
//  UIImage+Extension.m
//  LJAppStandard
//
//  Created by liang on 16/4/20.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithNamed:(NSString *)name{
    UIImage *image = [[self imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
@end
