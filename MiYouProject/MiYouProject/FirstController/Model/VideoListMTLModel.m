//
//  VideoListMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/22.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "VideoListMTLModel.h"

@implementation VideoListMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"id":@"id",
             @"name":@"name",
             @"duration":@"duration",
             @"pic":@"pic",
             @"vip":@"vip",
             @"subname":@"subname"
      };
    
}

+ (NSValueTransformer *)dateJSONTransformer {

   return  [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[value floatValue]];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%f",[value timeIntervalSince1970]];
    }];

//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum)
//            {
//                return [NSDate dateWithTimeIntervalSince1970:dateNum.floatValue]; } reverseBlock:^(NSDate *date)
//            { return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]]; }];
}

@end
