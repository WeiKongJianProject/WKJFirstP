//
//  MemberMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/22.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "MemberMTLModel.h"

@implementation MemberMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"id":@"id",
             @"name":@"name",
             @"nickname":@"nickname",
             @"password":@"password",
             @"group":@"group",
             @"sex":@"sex"
             };
}

@end
