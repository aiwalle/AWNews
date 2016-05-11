//
//  LJTabBar.m
//  LJAppStandard
//
//  Created by liang on 16/4/10.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "LJTabBar.h"
//#import "CenterViewController.h"
@interface LJTabBar()
/** 中心按钮*/
@property (nonatomic, weak) UIButton *centerBtn;

@end

@implementation LJTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景图片
//        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        // 添加中心按钮
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        centerBtn.backgroundColor = [UIColor redColor];
        [centerBtn setBackgroundImage:[UIImage imageNamed:@"51"] forState:UIControlStateNormal];
        [centerBtn setBackgroundImage:[UIImage imageNamed:@"52"] forState:UIControlStateHighlighted];
        [centerBtn sizeToFit];
        [centerBtn addTarget:self action:@selector(centerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerBtn];
        self.centerBtn = centerBtn;
    }
    return self;
}

- (void)centerBtnClick{
//    CenterViewController *centerVC = [[CenterViewController alloc] init];
    UIViewController *vc = [[UIViewController alloc] init];
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

/**
 * 布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    self.centerBtn.center = CGPointMake(width * 0.5, height * 0.5);
    
    int index = 0;
    
    CGFloat tabBarButtonW = width / 5;
    CGFloat tabBarButtonH = height;
    CGFloat tabBarButtonY = 0;
    
    for (UIView *tabBarButton in self.subviews) {
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        CGFloat tabBarButtonX = index * tabBarButtonW;
        if (index >= 2) {
            tabBarButtonX += tabBarButtonW;
        }
        
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        
        index++;
    }
}


@end
