//
//  FilterListModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/24.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "FilterListModel.h"

@implementation FilterListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"key":@"key",
             @"name":@"name",
             @"list":@"list"
             };
}
@end
