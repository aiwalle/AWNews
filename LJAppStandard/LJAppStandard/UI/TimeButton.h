//
//  TimeButton.h
//  LJAppStandard
//
//  Created by liang on 16/4/15.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeButton : UIButton
/** 该方法添加到按钮的点击事件中*/
- (void)timerWithSecond:(int)seconds;

@end
