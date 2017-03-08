//
//  ZLAFNetworking.m
//  SecondProject
//
//  Created by wkj on 2017/3/6.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "ZLAFNetworking.h"

@implementation ZLAFNetworking

+ (void)postWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)successBock failure:(FailureBlock)failureBlock{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;//延迟时间
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBock) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];

}

+ (void)getWithURLString:(NSString *)urlString parameters:(id)paremeters success:(SuccessBlock)successBlock failure:(FailureBlock)failereBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager GET:urlString parameters:paremeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failereBlock) {
            failereBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];

}










@end
