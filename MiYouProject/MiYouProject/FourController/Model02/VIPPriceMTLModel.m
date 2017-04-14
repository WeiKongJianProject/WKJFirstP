//
//  VIPPriceMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/4/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "VIPPriceMTLModel.h"

@implementation VIPPriceMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"id":@"id",
             @"name":@"name",
             @"price":@"price",
             @"day":@"day"
             };
    

}

@end
