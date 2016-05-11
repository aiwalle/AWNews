//
//  HeadLineController.m
//  LJAppStandard
//
//  Created by liang on 16/5/6.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "HeadLineController.h"

@interface HeadLineController ()

@end

@implementation HeadLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - **************** UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

static NSString * const CellId = @"HeaderCellId";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

@end
