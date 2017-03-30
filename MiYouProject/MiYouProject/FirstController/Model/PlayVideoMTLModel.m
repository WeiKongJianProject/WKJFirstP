//
//  PlayVideoMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/27.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PlayVideoMTLModel.h"

@implementation PlayVideoMTLModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"id":@"id",
             @"name":@"name",
             @"subname":@"subname",
             @"pic":@"pic",
             @"actor":@"actor",
             @"tag":@"tag",
             @"remarks":@"remarks",
             @"area":@"area",
             @"lang":@"lang",
             @"year":@"year",
             @"type":@"type",
             @"story":@"story",
             @"duration":@"duration",
             @"hit":@"hit",
             @"score":@"score",
             @"video":@"video",
             @"trial":@"trial",
             @"usergroup":@"usergroup",
             @"content":@"content"
             };
}
@end
