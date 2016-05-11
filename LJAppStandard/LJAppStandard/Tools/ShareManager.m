//
//  ShareManager.m
//  LJAppStandard
//
//  Created by liang on 16/4/22.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "ShareManager.h"
// 弹出分享菜单需要导入的头文件
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@implementation ShareManager
/** 无UI分享*/
+ (void)noUIShareWithText:(NSString *)text images:(id)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type platformType:(SSDKPlatformType)platformType{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:images //传入要分享的图片
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:type];
    
    [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        //这里添加处理结果的代码
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
}

/** 自定义分享菜单栏样式*/
+ (void)customShareWithText:(NSString *)text images:(id)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type platformType:(SSDKPlatformType)platformType{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:images //传入要分享的图片
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:type];
    
    // 设置分享菜单栏样式（非必要）
    // 设置分享菜单的背景颜色
    [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithRed:249/255.0 green:0/255.0 blue:12/255.0 alpha:0.5]];
    // 设置分享菜单颜色
    [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
    // 设置分享菜单－取消按钮背景颜色
    [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
    // 设置分享菜单－取消按钮的文本颜色
    [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor blackColor]];
    // 设置分享菜单－社交平台文本颜色
    [SSUIShareActionSheetStyle setItemNameColor:[UIColor whiteColor]];
    // 设置分享菜单－社交平台文本字体
    [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
    
    [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
}

/** 跳过分享的编辑界面*/
+ (void)jumpoverEditUIShareWithText:(NSString *)text images:(id)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type platformType:(SSDKPlatformType)platformType{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:images //传入要分享的图片
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:type];
//    (分享菜单)平台顺序自定义(如果SDK中没有添加的功能，将无法调用)
    NSArray *items = @[@(SSDKPlatformTypeSinaWeibo),
                       @(SSDKPlatformTypeSMS),
                       @(SSDKPlatformTypeCopy),
                       @(SSDKPlatformSubTypeWechatSession),
                       @(SSDKPlatformSubTypeWechatTimeline)];
    
    //调用分享的方法
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:nil items:items shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
    
//    /删除和添加平台示例
    [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
//    (默认微信，QQ，QQ空间都是直接跳客户端分享，加了这个方法之后，可以跳分享编辑界面分享)
    
    
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
//    （加了这个方法之后可以不跳分享编辑界面，直接点击分享菜单里的选项，直接分享）
}
@end
