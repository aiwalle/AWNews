//
//  BaseUIViewController.h
//  LJAppStandard
//
//  Created by liang on 16/4/10.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
/**
 *  viewController的父类，提供UI
 */
@interface BaseUIViewController : UIViewController
#pragma mark - **************** UI方面的设定
/** 导航条的自定义titleLabel*/
@property (nonatomic, weak) UILabel *navTitleLabel;
/** 导航条的文字*/
@property (nonatomic, copy) NSString *navTitleText;
/** 点击屏幕隐藏键盘*/
@property (nonatomic, assign) BOOL isSupportSingleTapHideKeyboard;
/** 滑动时隐藏NavigationBar*/
@property (nonatomic, assign) BOOL isSupportScrollingHideNavigationBar;
/**
 *  设置title的数据（子类重写)
 */
- (void)setupTitleData;
/**
 *  添加通知来监听用户登录状态的改变(子类重写)
 */
- (void)addNotiToObserveUserLogInfomation;
/**
 *  返回按钮事件（子类重写)
 */
- (void)backButtonItemClick;
/**
 *  设置右侧BarButtonItem（子类重写）
 *
 *  @param str   文字（如果是图片，@""）
 *  @param image 图片
 */
- (void)setNavRightItemWith:(NSString *)str andImage:(UIImage *)image;
/**
 *  设置左侧BarButtonItem（子类重写）
 *
 *  @param str   文字（如果是图片，@""）
 *  @param image 图片
 */
- (void)setNavLeftItemWith:(NSString *)str andImage:(UIImage *)image;
/**
 *  左侧点击事件（子类重写）
 *
 */
- (void)leftItemClick:(id)sender;
/**
 *  右侧点击事件（子类重写）
 *
 */
- (void)rightItemClick:(id)sender;
/**
 *  返回主界面
 *
 *  @param animated 是否需要动画
 */
- (void)backToRootViewControllerWithAnimated:(BOOL)animated;
#pragma mark - **************** 转场动画的设定
/**
 *  转场开始动画
 */
- (void)startLoading;
/**
 *  转场结束动画
 */
- (void)endLoading;
#pragma mark - **************** 上拉刷新与下拉刷新的设定
/**
 *  添加头部刷新控件
 *
 *  @param scroll 需要添加刷新的UIScrollView对象
 */
- (void)addRefreshHeader:(UIScrollView *)scroll;
/**
 *  添加尾部刷新控件
 *
 *  @param scroll 需要添加刷新的UIScrollView对象
 */
- (void)addRefreshFooter:(UIScrollView *)scroll;
/**
 *  同时添加头部和尾部刷新控件
 *
 *  @param scroll 需要添加刷新的UIScrollView对象
 */
- (void)addRefreshHeaderAndFooter:(UIScrollView *)scroll;
/**
 *  加载新的数据(子类重写)
 */
- (void)loadNewData;
/**
 *  加载更多数据(子类重写)
 */
- (void)loadMoreData;
/**
 *  开始刷新（当进入界面需要自动刷新的时候，添加该方法）
 */
- (void)beginRefreshing;
/**
 *  结束刷新（当数据加载完毕后，务必调用该方法）
 */
- (void)endRefreshing;
#pragma mark - **************** 页面空数据的设定
/**
 *  添加空数据视图
 *
 *  @param title 提醒文字
 */
- (void)addEmptyDataViewWithTitle:(NSString *)title;
/**
 *  移除空数据视图
 */
- (void)removeEmptyDataView;
@end
