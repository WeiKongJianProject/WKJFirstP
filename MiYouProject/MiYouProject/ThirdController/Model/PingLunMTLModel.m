//
//  PingLunMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PingLunMTLModel.h"

@implementation PingLunMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"member":@"member",
             @"content":@"content",
             @"time":@"time",
             @"avator":@"avator"
             };
    
}

@end
