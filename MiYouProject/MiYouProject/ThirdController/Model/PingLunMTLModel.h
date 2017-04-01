//
//  PingLunMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PingLunMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString * member;
@property (strong, nonatomic) NSString * content;
@property (strong, nonatomic) NSNumber * time;
@property (strong, nonatomic) NSString * avator;
@end
