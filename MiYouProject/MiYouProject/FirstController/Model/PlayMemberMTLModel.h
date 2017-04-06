//
//  PlayMemberMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/29.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PlayMemberMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSNumber * points;
@property (strong, nonatomic) NSMutableArray * viplist;
@property (strong, nonatomic) NSNumber * vip;
@property (strong, nonatomic) NSNumber * messageNum;

@end
