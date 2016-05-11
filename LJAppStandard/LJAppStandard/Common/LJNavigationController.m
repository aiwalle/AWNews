//
//  LJNavigationController.m
//  LJAppStandard
//
//  Created by liang on 16/4/10.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "LJNavigationController.h"
#import "MessagesViewController.h"
@interface LJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LJNavigationController
/**
 *  初始化导航栏
 */
+ (void)initialize{
    /** 设置UINavigationBar */
    UINavigationBar *bar = [UINavigationBar appearance];
    // 设置背景图
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    // 设置标题文字属性
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    barAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:barAttrs];
    
    /** 设置UIBarButtonItem */
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    
//    // UIControlStateNormal
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
//    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//    
//    // UIControlStateDisabled
//    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
//    disabledAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
    
    /** 如果设置了背景色，translucent设置为NO，没有穿透效果*/
//    [bar setTintColor:[UIColor colorWithHexString:KcolorWhite]];
//    [bar setBarTintColor:[UIColor colorWithHexString:knavBJColor]];
//    bar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGlobalSlideGesture];
}

/**
 *  添加全局滑动手势
 */
- (void)addGlobalSlideGesture{
    id target = self.interactivePopGestureRecognizer.delegate;
    NSLog(@"target==%@", target);
    NSLog(@"self.navigationBar = %@", self);
    
//    _UINavigationInteractiveTransition
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法(由于是私有方法，忽略警告)
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    
    self.interactivePopGestureRecognizer.enabled = NO;
}

/**
 * 拦截所有push进来的子控制器
 * @param viewController 每一次push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >= 1) {
        //当跳转的ViewController为MessagesViewController时，直接通过tabbar切换
        if ([viewController isKindOfClass:[MessagesViewController class]]) {
            [self popToRootViewControllerAnimated:NO];
            self.tabBarController.selectedIndex = 2;
            return;
        }
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - <UIGestureRecognizerDelegate>
/**
 * 每当用户触发[返回手势]时都会调用一次这个方法
 * 返回值:返回YES,手势有效; 返回NO,手势失效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

@end
