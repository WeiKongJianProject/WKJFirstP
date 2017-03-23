//
//  HOmeBannerMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/22.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "HOmeBannerMTLModel.h"

@implementation HOmeBannerMTLModel
/*
 @property (strong, nonatomic) NSNumber * id;
 @property (strong, nonatomic) NSString * name;
 @property (strong, nonatomic) NSString * subname;
 @property (strong, nonatomic) NSString * pic;
 @property (strong, nonatomic) NSString * video;
 @property (strong, nonatomic) NSString * trial;
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"id":@"id",
             @"name":@"name",
             @"subname":@"subname",
             @"pic":@"pic",
             @"vip":@"vip"
             };
}

@end
