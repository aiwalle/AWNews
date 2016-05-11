//
//  LJTabBarController.m
//  LJAppStandard
//
//  Created by liang on 16/4/10.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "LJTabBarController.h"
#import "LJNavigationController.h"
#import "NewsController.h"
#import "ReadController.h"
#import "VideoController.h"
#import "TopicController.h"
#import "MineController.h"
#import "LJTabBar.h"
@interface LJTabBarController ()

@end

@implementation LJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 普通情况下，添加4个控制器
    [self setupTabbarItems];
    [self setupChildVCs];
    
    // 给tabbar添加中间的按钮，如微博（根据情况来使用，新闻客户端不使用）
//    [self setupTabBar];
}

- (void)setupTabBar{
    [self setValue:[[LJTabBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 *  统一设置tabbar按钮的文字样式
 */
- (void)setupTabbarItems{
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 普通状态下按钮文字的颜色
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#858585"];;
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // 选中状态下按钮文字的颜色
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#dd3237"];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 *  添加所有子控制器
 */
- (void)setupChildVCs{
    //dd3237 858585
    [self setupChildVc:[[NewsController alloc] init] title:@"新闻" image:@"tabbar_icon_news_normal" selectedImage:@"tabbar_icon_news_highlight"];
    [self setupChildVc:[[ReadController alloc] init] title:@"阅读" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];
    [self setupChildVc:[[VideoController alloc] init] title:@"视频" image:@"tabbar_icon_media_normal" selectedImage:@"tabbar_icon_media_highlight"];
    [self setupChildVc:[[TopicController alloc] init] title:@"话题" image:@"tabbar_icon_bar_normal" selectedImage:@"tabbar_icon_bar_highlight"];
    [self setupChildVc:[[MineController alloc] init] title:@"我" image:@"tabbar_icon_me_normal" selectedImage:@"tabbar_icon_me_highlight"];
}

/**
 * 添加一个子控制器
 * @param title 文字
 * @param image 图片
 * @param selectedImage 选中时的图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    LJNavigationController *nav = [[LJNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
}

@end
