//
//  ZLAFNetworking.h
//  SecondProject
//
//  Created by wkj on 2017/3/6.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void(^SuccessBlock)(NSDictionary * successData);
typedef void(^FailureBlock)(NSError * error);

@interface ZLAFNetworking : NSObject

@property (nonatomic, copy) SuccessBlock successBlock;
@property (copy, nonatomic) FailureBlock failureBlock;

+ (void)postWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBock
                  failure:(FailureBlock)failureBlock;

+ (void)getWithURLString:(NSString *)urlString
              parameters:(id)paremeters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failereBlock;
















@end
