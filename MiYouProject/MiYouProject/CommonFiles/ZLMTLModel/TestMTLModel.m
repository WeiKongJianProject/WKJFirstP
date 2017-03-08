//
//  TestMTLModel.m
//  SecondProject
//
//  Created by wkj on 2017/3/7.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "TestMTLModel.h"

@implementation TestMTLModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ @"date": @"dt", //将JSON字典里dt键对应的值，赋值给date属性
              @"locationName": @"name",
              @"humidity": @"main.humidity",
              @"temperature": @"main.temp",
              //这个点是什么意思呢，表示将main键对应的子字典里，
              //temp键对应的值赋给temperature属性。
              //我们不用再写 objectForKey]objectForKey]..这种代码了。
              //注意了：当main键对应的是数组时，main.temp返回的
              //为所有temp键对应值的数组合集
              @"tempHigh": @"main.temp_max",
              @"tempLow": @"main.temp_min",
              @"sunrise": @"sys.sunrise",
              @"sunset": @"sys.sunset",
              @"conditionDescription": @"weather.description",
              @"condition": @"weather.main",
              @"icon": @"weather.icon", 
              @"windBearing": @"wind.deg", 
              @"windSpeed": @"wind.speed", };
}

/*
 
 //转化为NSDate对象
 + (NSValueTransformer *)dateJSONTransformer {
 return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *dateNum)
 {
 return [NSDate dateWithTimeIntervalSince1970:dateNum.floatValue]; } reverseBlock:^(NSDate *date)
 { return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]]; }];
 }
 */

/*
 方法将一个Model实例转回JSON数据。Model对象的存储:由于MTLModel已经帮我们实现了
 NSCoding协议， 要把一个Model对象存储到本地就相当简单了，只需一行代码：
 [NSKeyedArchiver archiveRootObject:model toFile:path];
 解档时同样简单：
 TestDataModel*unachiveModel=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
 */


@end
