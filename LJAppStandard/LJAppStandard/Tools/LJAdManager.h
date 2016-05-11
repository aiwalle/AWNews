//
//  LJAdManager.h
//  LJAppStandard
//
//  Created by liang on 16/4/28.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJAdManager : NSObject


/** 如果存在广告图片，则展示*/
+ (BOOL)isShouldDisplayAdvertisement;
/** 获取广告图片*/
+ (UIImage *)getAdvertisementImage;
/** 更新广告*/
+ (void)loadLastestAdvertisementImage;
@end
