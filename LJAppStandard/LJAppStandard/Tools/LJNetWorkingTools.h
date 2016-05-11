//
//  LJNetWorkingTools.h
//  LJAppStandard
//
//  Created by liang on 16/4/20.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;
typedef NS_ENUM(NSUInteger, NetWorkingRequestType) {
    NetWorkingRequestTypeGET = 0,
    NetWorkingRequestTypePOST,
};

@interface LJNetWorkingTools : NSObject
/** 检查网络状态*/
+ (void)checkNetWorkStatus;
/** 添加通知实时检测网络（如果不需要实时检测可以不添加该代码）*/
+ (void)addNetWorkChangeEveryTime;
/** 停止检测网络状态*/
+ (void)stopCheckNetWorkStatus;
/**
 *  GET请求
 *
 *  @param URLString URL路径
 *  @param params    请求参数
 *  @param success   成功的回调
 *  @param failure   失败的回调
 *
 *  @return
 */
+ (NSURLSessionTask *)GET:(NSString *)URLString params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 *  POST请求
 *
 *  @param URLString URL路径
 *  @param params    请求参数
 *  @param success   成功的回调
 *  @param failure   失败的回调
 *
 *  @return 
 */
+ (NSURLSessionTask *)POST:(NSString *)URLString params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/** 取消网络请求*/
+ (void)cancelAllRequest;
@end
