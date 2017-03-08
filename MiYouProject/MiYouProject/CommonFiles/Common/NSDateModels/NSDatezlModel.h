//
//  NSDatezlModel.h
//  Matro
//
//  Created by lang on 16/6/21.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDatezlModel : NSObject

@property (strong, nonatomic) NSDate * firstDate;
@property (strong, nonatomic) NSString * fuWutimeVerString;
@property (strong, nonatomic) NSDate * nowDate;
@property (assign, nonatomic) NSTimeInterval timeInterval;


- (NSTimeInterval )currentTimeDate;
+(NSDatezlModel *)shareDate;
+ (instancetype)sharedInstance;

@end
