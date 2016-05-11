//
//  BaseUIViewController.m
//  LJAppStandard
//
//  Created by liang on 16/4/10.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "BaseUIViewController.h"
#import "EmptyDataView.h"
@interface BaseUIViewController ()<UIScrollViewDelegate>{
    UIScrollView *_dataScrollView;//数据源Scrollview
    UIActivityIndicatorView *_activy;//转场菊花图标
    EmptyDataView *_emptyView;
}

@end

@implementation BaseUIViewController
#pragma mark - **************** UI方面的设定
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTitleData];
    [self setupTitleView];
    [self setupTitleTextAndBarButtonItem];
    [self setupHideKeyboard];
    [self addNotiToObserveUserLogInfomation];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

/** 当滑动的时候是否需要隐藏navigationBar*/
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (!self.isSupportScrollingHideNavigationBar) {
        return;
    }
    if(velocity.y > 0){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
}

/** 隐藏键盘*/
- (void)hideKeyboard{
    [self.view endEditing:YES];
}

/**
 *  设置titleView的样式（这里的titleView默认为一个Label）
 *  self.navigationItem.title = @""; 也可以通过这种来设置标题，只是无法自定义样式
 */
- (void)setupTitleView{
    if (![self.navTitleText isEmpty] && [self.navigationController.viewControllers count] > 1) {
        // push出来的为灰色字体
        [self setupNavTitleWithColorHex:@"#333333"];
    }else if (![self.navTitleText isEmpty] && [self.navigationController.viewControllers count] == 1){
        // 基础的为白色字体
        [self setupNavTitleWithColorHex:@"#ffffff"];
    }
}

/** 设置Label样式*/
- (void)setupNavTitleWithColorHex:(NSString *)hexColor{
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    self.navTitleLabel = lb;
    self.navTitleLabel.text = self.navTitleText;
    self.navTitleLabel.backgroundColor = [UIColor clearColor];
    self.navTitleLabel.font = themeFont17;
    self.navTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navTitleLabel.textColor = [UIColor colorWithHexString:hexColor];
    self.navigationItem.titleView = self.navTitleLabel;
}

/**
 *  设置标题的文字和返回按钮
 */
- (void)setupTitleTextAndBarButtonItem{
    self.title = self.navTitleText;
    
    [self setupCustomBackButtonItem];
    
}

/**
 *  设置隐藏键盘
 */
- (void)setupHideKeyboard{
    if (self.isSupportSingleTapHideKeyboard){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tap.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tap];
    }
}

/**
 *  添加通知来监听用户登录状态的改变
 */
- (void)addNotiToObserveUserLogInfomation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginStatusNoti) name:LoginStatusChangeNoti object:nil];
}

/**
 *  当销毁ViewController的时候，打印名称并移除监听（子类可以重写此方法）
 */
- (void)dealloc{
    NSLog(@"%@dealloc",self.debugDescription);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LoginStatusChangeNoti object:nil];
}

/**
 *  自定义返回按钮
 */
- (void)setupCustomBackButtonItem{
    if (self.navigationController.childViewControllers.count > 1)
    {
        // 左上角的返回
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(backButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }else{
        
    }
}

/**
 *  设置title的数据（子类重写）
 */
- (void)setupTitleData{
    
}


/**
 *  当用户登录注册改变时调用（子类重写此方法）
 */
- (void)changeLoginStatusNoti{
    
}

/**
 *  返回按钮事件（重写改变返回的ViewController）
 */
- (void)backButtonItemClick{
    if ([self.navigationController.viewControllers count] == 1) {
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/** 设置左侧BarButtonItem（子类重写）*/
- (void)setNavLeftItemWith:(NSString *)str andImage:(UIImage *)image{
    if ([self.navigationController.viewControllers count] == 1){
        if ([str isEqualToString:@""]){
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }else{
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
}

/** 设置右侧BarButtonItem（子类重写）*/
- (void)setNavRightItemWith:(NSString *)str andImage:(UIImage *)image{
    if ([str isEqualToString:@""]){
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else{
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

/** 右侧点击事件（子类重写）*/
- (void)rightItemClick:(id)sender{
    
}

/** 左侧点击事件（子类重写）*/
- (void)leftItemClick:(id)sender{
    
}

/** 返回主界面*/
- (void)backToRootViewControllerWithAnimated:(BOOL)animated{
    [self.navigationController popToRootViewControllerAnimated:animated];
}

#pragma mark - **************** 加载动画的设定
/** 转场加载数据，开始动画 */
- (void)startLoading{
    self.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *activy = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activy = activy;
    activy.center = self.view.center;
    [self.view addSubview:activy];
    [activy startAnimating];
}

/** 转场结束动画 */
- (void)endLoading{
    [_activy removeFromSuperview];
    [_activy stopAnimating];
    self.view.userInteractionEnabled = YES;
}

#pragma mark - **************** 上拉刷新与下拉刷新的设定
/**
 *  添加头部刷新控件
 *  修改提示文字  MJRefreshConst.m
 *  @param scroll 需要添加刷新的UIScrollView对象
 */
- (void)addRefreshHeader:(UIScrollView *)scroll{
    _dataScrollView = scroll;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置header
    _dataScrollView.mj_header = header;
}

/**
 *  添加尾部刷新控件
 *  修改提示文字  MJRefreshConst.m
 *  @param scroll 需要添加刷新的UIScrollView对象
 */
- (void)addRefreshFooter:(UIScrollView *)scroll{
    _dataScrollView = scroll;
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _dataScrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

/**
 *  添加头部和尾部刷新控件
 *
 *  @param scroll 需要添加刷新的UIScrollView对象
 */
- (void)addRefreshHeaderAndFooter:(UIScrollView *)scroll{
    [self addRefreshFooter:scroll];
    [self addRefreshHeader:scroll];
}

/** 加载新的数据*/
- (void)loadNewData{
    
}

/** 加载更多数据*/
- (void)loadMoreData{
    
}

/** 开始刷新（当需要进入界面自动刷新时候，添加该方法）*/
- (void)beginRefreshing{
    [_dataScrollView.mj_header beginRefreshing];
}

/** 结束刷新*/
- (void)endRefreshing{
    if(_dataScrollView.mj_header){
        [_dataScrollView.mj_header endRefreshing];
    }
    if(_dataScrollView.mj_footer){
        [_dataScrollView.mj_footer endRefreshing];
    }
}

#pragma mark - **************** 页面空数据的设定
/**
 *  添加空数据视图
 *
 *  @param title 提醒文字
 */
- (void)addEmptyDataViewWithTitle:(NSString *)title{
    EmptyDataView *empty = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EmptyDataView class]) owner:nil options:nil] lastObject];
    if (title) {
        empty.titleLB.text = title;
    }
    empty.frame = DeviceRect;
    _emptyView = empty;
    [self.view addSubview:empty];
}

/**
 *  移除空数据视图
 */
- (void)removeEmptyDataView{
    if (_emptyView) {
        [_emptyView removeFromSuperview];
    }
}

@end
