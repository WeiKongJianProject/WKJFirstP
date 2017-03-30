//
//  UserMessageMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/28.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "UserMessageMTLModel.h"

@implementation UserMessageMTLModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"vip":@"vip",
             @"id":@"id",
             @"messageNum":@"messageNum",
             @"points":@"points",
             @"result":@"result",
             @"viplist":@"viplist"
             };
}
@end
