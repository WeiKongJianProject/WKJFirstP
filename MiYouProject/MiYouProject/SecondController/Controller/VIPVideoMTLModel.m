//
//  VIPVideoMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "VIPVideoMTLModel.h"

@implementation VIPVideoMTLModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"id":@"id",
             @"name":@"name",
             @"duration":@"duration",
             @"pic":@"pic",
             @"vip":@"vip"
             };
    
}
@end
