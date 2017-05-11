//
//  SiFangMTLModel.m
//  MiYouProject
//
//  Created by wkj on 2017/3/30.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SiFangMTLModel.h"

@implementation SiFangMTLModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{

     return @{
      @"id":@"id",
      @"name":@"name",
      @"duration":@"duration",
      @"pic":@"pic",
      @"member":@"member",
      @"avator":@"avator",
      @"time":@"time",
      @"price":@"price",
      @"commentNum":@"commentNum",
      @"isBuy":@"isBuy",
      @"hits":@"hits"
      };

}

+ (NSValueTransformer *)dateJSONTransformer {
    
    return  [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[value floatValue]];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%f",[value timeIntervalSince1970]];
    }];
}
@end
