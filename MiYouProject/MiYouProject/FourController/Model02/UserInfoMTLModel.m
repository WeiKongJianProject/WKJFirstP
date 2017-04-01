//
//  UserInfoMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/28.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "UserInfoMTLModel.h"

@implementation UserInfoMTLModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"id":@"id",
             @"name":@"name",
             @"password":@"password",
             @"vip":@"vip",
             @"sex":@"sex",
             @"nickname":@"nickname",
             @"loginip":@"loginip",
             @"vipName":@"vipName",
             @"points":@"points"
             };
    
}
@end
