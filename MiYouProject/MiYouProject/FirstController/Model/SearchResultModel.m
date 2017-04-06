
//
//  SearchResultModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/24.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"id":@"id",
             @"name":@"name",
             @"vip":@"vip"
             };
}
@end
