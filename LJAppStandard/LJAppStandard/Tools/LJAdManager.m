//
//  LJAdManager.m
//  LJAppStandard
//
//  Created by liang on 16/4/28.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "LJAdManager.h"
/** 当前广告图片(旧的)*/
#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adcurrent.png"])
/** 新的广告图片*/
#define kCachedNewImage     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adnew.png"])
@implementation LJAdManager

/** 如果存在广告图片，则展示*/
+ (BOOL)isShouldDisplayAdvertisement {
    return ([[NSFileManager defaultManager] fileExistsAtPath:kCachedCurrentImage isDirectory:nil] || [[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:nil]);
}

/** 获取广告图片*/
+ (UIImage *)getAdvertisementImage {
    if ([[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:nil]) {
        [[NSFileManager defaultManager] removeItemAtPath:kCachedCurrentImage error:nil];
        [[NSFileManager defaultManager] moveItemAtPath:kCachedNewImage toPath:kCachedCurrentImage error:nil];
    }
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:kCachedCurrentImage]];
}

/**
 *  下载指定地址的广告
 *  @param imageUrl 广告地址
 */
+ (void)downloadAdvertisementImage:(NSString *)imageUrl {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            [data writeToFile:kCachedNewImage atomically:YES];
        }else{
            NSLog(@"advertisement error %@", error);
        }
    }];
    [task resume];
}

+ (void)loadLastestAdvertisementImage {
    NSInteger nowTime = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld", nowTime];
    [LJNetWorkingTools GET:path params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *arr = responseObject[@"ads"];
        NSInteger adsCounts = arr.count;
        NSString *imageUrlOne = arr[0][@"res_url"][0];
        NSString *imageUrlTwo = nil;
        if (arr.count > 1) {
            imageUrlTwo = arr[arc4random() % (adsCounts - 1)][@"res_url"][0];
        }
        BOOL isOne = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOne"];
        if (imageUrlTwo.length > 0) {
            if (isOne) {
                [self downloadAdvertisementImage:imageUrlOne];
                [[NSUserDefaults standardUserDefaults] setBool:isOne forKey:@"isOne"];
            }else {
                [self downloadAdvertisementImage:imageUrlTwo];
                [[NSUserDefaults standardUserDefaults] setBool:isOne forKey:@"isOne"];
            }
        }else {
            [self downloadAdvertisementImage:imageUrlOne];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"advertisement error %@", error);
    }];
    
}

@end
