//
//  UserMessageMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/28.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserMessageMTLModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSNumber * vip;
@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSNumber * messageNum;
@property (strong, nonatomic) NSNumber * points;
@property (strong, nonatomic) NSString * result;
@property (strong, nonatomic) NSArray * viplist;
@end
