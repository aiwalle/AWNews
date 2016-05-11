//
//  LJNetWorkingTools.m
//  LJAppStandard
//
//  Created by liang on 16/4/20.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "LJNetWorkingTools.h"
#import "AFNetworking.h"

#define BaseURL @"http://c.m.163.com/"

// 该对象只基于AFNetWorking，不与其他文件产生耦合
#ifdef DEBUG
#define AppNetLog(s, ... ) NSLog( @"[%@：in line: %d]-->%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define AppNetLog(s, ... )
#endif
@implementation LJNetWorkingTools
#pragma mark - **************** 检查网络状态
/** 检查网络状态*/
+ (void)checkNetWorkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                AppNetLog(@"当前为未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                AppNetLog(@"当前为无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                AppNetLog(@"当前为有线网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                AppNetLog(@"当前为WIFI网络");
                break;
            default:
                break;
        }
    }];
}

/** 添加通知实时检测网络（如果不需要实时检测可以不添加该代码）*/
+ (void)addNetWorkChangeEveryTime {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

/** 当网络变化时调用*/
+ (void)reachabilityChanged:(NSNotification *)note {
    NSDictionary *userinfo = note.userInfo;
    AFNetworkReachabilityStatus status = (AFNetworkReachabilityStatus)userinfo[AFNetworkingReachabilityNotificationStatusItem];
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            AppNetLog(@"未知网络");
            break;
        case AFNetworkReachabilityStatusNotReachable:
            AppNetLog(@"无网络");
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            AppNetLog(@"有线网络");
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            AppNetLog(@"WIFI网络");
            break;
        default:
            break;
    }
    
}

/** 停止检测网络状态*/
+ (void)stopCheckNetWorkStatus {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

#pragma mark - **************** GET & POST
+ (NSURLSessionTask *)GET:(NSString *)URLString params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self requestWithUrl:URLString httpMethod:NetWorkingRequestTypeGET params:params success:success failure:failure];
}

+ (NSURLSessionTask *)POST:(NSString *)URLString params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self requestWithUrl:URLString httpMethod:NetWorkingRequestTypePOST params:params success:success failure:failure];
}

#pragma mark - **************** Private
/** 生成AFHTTPSessionManager单例对象（私有方法）*/
+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager;
    if (BaseURL.length > 0) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    }else {
        manager = [AFHTTPSessionManager manager];
    }
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    return manager;
}

/** 请求网络数据*/
+ (NSURLSessionTask *)requestWithUrl:(NSString *)url httpMethod:(NetWorkingRequestType)httpMethod params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    AFHTTPSessionManager *manager = [self manager];
    
    NSURLSessionTask *task = nil;
    if (httpMethod == NetWorkingRequestTypeGET) {
        task = [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error;
                id JSONObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                if (error != nil) {
                    AppNetLog(@"errorMessage = %@", error);
                }
                responseObject = JSONObject;
            }
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failure(task, error);
        }];
    }else if (httpMethod == NetWorkingRequestTypePOST) {
        task = [manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error;
                id JSONObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                if (error != nil) {
                    AppNetLog(@"errorMessage = %@", error);
                }
                responseObject = JSONObject;
            }
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failure(task, error);
        }];
    }
    return task;
}

/** 取消网络请求*/
+ (void)cancelAllRequest {
    [[[self manager] operationQueue] cancelAllOperations];
}

@end
