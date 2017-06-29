//
//  SiFangMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/30.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SiFangMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber *duration;
@property (strong, nonatomic) NSString * pic;
@property (strong, nonatomic) NSString * member;
@property (strong, nonatomic) NSString * avator;
@property (strong, nonatomic) NSNumber * time;
@property (strong, nonatomic) NSNumber * price;
@property (strong, nonatomic) NSNumber * commentNum;
@property (strong, nonatomic) NSNumber * isBuy;
@property (strong, nonatomic) NSNumber * hits;



@end
