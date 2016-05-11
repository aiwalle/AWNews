//
//  CustomCell.m
//  LJAppStandard
//
//  Created by liang on 16/4/20.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnclick:(id)sender {
    NSLog(@"按钮");
//    UINavigationController *nav = [self currentNavigationConntroller];
//    [nav pushViewController:[TestViewController new] animated:YES];
    
//    UIViewController *view = [self currentViewController];
    
//    NSLog(@"%@")
}

@end
