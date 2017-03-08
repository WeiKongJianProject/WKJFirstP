//
//  NSDatezlModel.m
//  Matro
//
//  Created by lang on 16/6/21.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import "NSDatezlModel.h"

@implementation NSDatezlModel
static NSDatezlModel * shareDateObj =nil;



+(NSDatezlModel *)shareDate{
    if (!shareDateObj) {
        shareDateObj=[[super allocWithZone:NULL]init];
    }
    return shareDateObj;
}


//
+(id)copyWithZone:(struct _NSZone *)zone{
    return [self shareDate];
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}



+ (instancetype)sharedInstance
{
    static NSDatezlModel *sharedFoodObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFoodObj =[[super allocWithZone:NULL]init];
    });
    
    return sharedFoodObj;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}
//以上是单例方法


//返回时间戳
- (NSTimeInterval )currentTimeDate{
    NSDate * nowDate = [NSDate date];
    NSTimeInterval timeIntervals = [nowDate timeIntervalSinceDate:self.firstDate];
    NSTimeInterval zong = timeIntervals+self.timeInterval;
    return zong;
   // NSLog(@"总的时间戳：%lf",zong);
}


@end
