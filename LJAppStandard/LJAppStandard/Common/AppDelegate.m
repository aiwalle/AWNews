//
//  AppDelegate.m
//  LJAppStandard
//
//  Created by liang on 16/4/10.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "AppDelegate.h"
#import "LJTabBarController.h"
#import "LJNetWorkingTools.h"
#import "LJAdManager.h"

#import "JPUSHService.h"
#import "MobClick.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"
static NSString *appKey = @"3d02c654219bbf8de2849a22";
static NSString *channel = @"Publish channel";
static NSString *UMengAppKey = @"571878fee0f55aaed30017f2";
static NSString *ShareSDKKey = @"11f03685d720c";

@interface AppDelegate () {
    UIView *_bgView;
    UIImageView *_adImageView;
    UIButton *_adButton;
    
}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[LJTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self checkNetWork];
    
    [self setupJPushWithOptions:launchOptions];
    [self umengTrack];
    [self setupShareSDK];
    
    [self setupAdvertisement];
    return YES;
}

#pragma mark - **************** 加载广告页面（TODO:这里写的不好，点击应该跳转webview）
- (void)setupAdvertisement {
    [LJAdManager loadLastestAdvertisementImage];
    if ([LJAdManager isShouldDisplayAdvertisement]) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.frame = DeviceRect;
        _bgView = bgView;
        [self.window addSubview:bgView];
        
        UIImageView *adIV = [[UIImageView alloc] initWithImage:[LJAdManager getAdvertisementImage]];
        adIV.userInteractionEnabled = YES;
        _adImageView = adIV;
        adIV.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight * 0.7);
        adIV.backgroundColor = [UIColor redColor];
        [bgView addSubview:adIV];
        
        UIButton *adBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _adButton = adBtn;
        adBtn.frame = CGRectMake(DeviceWidth - 40, 10, 30, 30);
        adBtn.backgroundColor = [UIColor lightGrayColor];
        adBtn.layer.cornerRadius = 15;
        [adBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [adBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [adBtn addTarget:self action:@selector(adBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [self.window addSubview:adBtn];
        
        adIV.alpha = 0.99;
        [UIView animateWithDuration:5.0 animations:^{
            adIV.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [UIView animateWithDuration:0.5 animations:^{
                adIV.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [adBtn removeFromSuperview];
                [bgView removeFromSuperview];
            }];
        }];
        
    }else{
        return;
    }
}

/** 点击跳过，移除广告*/
- (void)adBtnclick {
    [_adImageView removeFromSuperview];
    [_adButton removeFromSuperview];
}

#pragma mark - **************** 检测网络状态
- (void)checkNetWork{
    [LJNetWorkingTools checkNetWorkStatus];
    [LJNetWorkingTools addNetWorkChangeEveryTime];
}

#pragma mark - **************** 极光推送相关
- (void)setupJPushWithOptions:(NSDictionary *)launchOptions{
    // 注册
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories iOS8 新特性，例如快速回复
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:NO // 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
            advertisingIdentifier:nil];// 广告 不用设置为nil
    
    [JPUSHService resetBadge];
    //极光推送打印调试信息
//    [JPUSHService setDebugMode];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //注册
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidLoginNotification object:nil];
}

//通知方法
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    //调用接口
    NSLog(@"\n\n极光推送注册成功\n\n");
    [JPUSHService setTags:nil alias:@"test" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
    }];
    //通知后台registrationID
//    xxxxx
    NSString *registrationID = [JPUSHService registrationID];
    NSLog(@"registrationID==%@", registrationID);
    
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kJPFNetworkDidLoginNotification object:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    completionHandler(UIBackgroundFetchResultNewData);
    // 收到通知就触发
    [JPUSHService handleRemoteNotification:userInfo];
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        //        [self.window.rootViewController.view addSubview:[UISwitch new]];
    }
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // error 处理
    NSLog(@"DeviceToken 获取失败，原因：%@", error);
}

#pragma mark - **************** 友盟统计
- (void)umengTrack{
    // 捕捉异常
    [MobClick setCrashReportEnabled:YES];
#ifdef DEBUG
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setLogEnabled:YES];
#endif
    //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick setAppVersion:kVersion];
    [MobClick startWithAppkey:UMengAppKey reportPolicy:(ReportPolicy) REALTIME channelId:@"App Store"];
    ///   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    ///   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    ///设置是否对日志信息进行加密, 默认NO(不加密).
    [MobClick setEncryptEnabled:NO];
    ///设置是否开启background模式,
    [MobClick setBackgroundTaskEnabled:YES];
    
}

#pragma mark - **************** ShareSDK
- (void)setupShareSDK{
    [ShareSDK registerApp:ShareSDKKey activePlatforms:@[
                                                        @(SSDKPlatformTypeSinaWeibo),
                                                        @(SSDKPlatformTypeSMS),
                                                        // 不要使用微信总平台进行初始化(会有微信收藏)
                                                        //@(SSDKPlatformTypeWechat),
                                                        // 使用微信子平台进行初始化，即可
                                                        @(SSDKPlatformSubTypeWechatSession),
                                                        @(SSDKPlatformSubTypeWechatTimeline)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeSinaWeibo:
                             //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"175030390"
                                                       appSecret:@"736923729877074d453b01a3a9517c3d"
                                                     redirectUri:@"http://www.sharesdk.cn"
                                                        authType:SSDKAuthTypeBoth];
                             break;
                         case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:@"wx226513383806d03d"
                                                   appSecret:@"34613e97b739adc2a8f677830331b036"];
                             break;
                         default:
                             break;
                     }
                 }];
}

@end
