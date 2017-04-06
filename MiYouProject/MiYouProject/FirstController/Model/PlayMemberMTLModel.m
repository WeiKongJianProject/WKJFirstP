//
//  PlayMemberMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/29.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PlayMemberMTLModel.h"

@implementation PlayMemberMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{
             @"id":@"id",
             @"points":@"points",
             @"viplist":@"viplist",
             @"vip":@"vip",
             @"messageNum":@"messageNum"
             };

}

@end
