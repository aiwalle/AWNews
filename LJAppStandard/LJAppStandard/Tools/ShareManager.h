//
//  ShareManager.h
//  LJAppStandard
//
//  Created by liang on 16/4/22.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
@interface ShareManager : NSObject
/**
 *  无UI分享
 *
 *  @param text         内容
 *  @param images       图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
 *  @param url          网页路径/应用路径
 *  @param title        标题
 *  @param type         分享类型
 *  @param platformType 平台类型
 */
+ (void)noUIShareWithText:(NSString *)text images:(id)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type platformType:(SSDKPlatformType)platformType;

/**
 *  自定义分享菜单栏样式
 *
 *  @param text         内容
 *  @param images       图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
 *  @param url          网页路径/应用路径
 *  @param title        标题
 *  @param type         分享类型
 *  @param platformType 平台类型
 */
+ (void)customShareWithText:(NSString *)text images:(id)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type platformType:(SSDKPlatformType)platformType;

/**
 *  跳过分享的编辑界面（在这个方法里可自由设定分享的内容是否需要编辑）
 *
 *  @param text         内容
 *  @param images       图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
 *  @param url          网页路径/应用路径
 *  @param title        标题
 *  @param type         分享类型
 *  @param platformType 平台类型
 */
+ (void)jumpoverEditUIShareWithText:(NSString *)text images:(id)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type platformType:(SSDKPlatformType)platformType;
@end
