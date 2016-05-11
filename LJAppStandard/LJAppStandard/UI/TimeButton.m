//
//  TimeButton.m
//  LJAppStandard
//
//  Created by liang on 16/4/15.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "TimeButton.h"

@implementation TimeButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}

- (void)timerWithSecond:(int)seconds
{
    //获取验证码倒计时
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = seconds - 1; i > -1; i--) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"重新发送(%ds)",i] forState:UIControlStateNormal];
                self.enabled = NO;
            });
            if (i == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    self.enabled = YES;
                });
            }
            sleep(1);
        }
    });
}


@end
