//
//  UserInfoMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/28.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserInfoMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSNumber * vip;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * password;
@property (strong, nonatomic) NSString * sex;
@property (strong, nonatomic) NSString * nickname;
@property (strong, nonatomic) NSString * loginip;
@property (strong, nonatomic) NSString * vipName;
@property (strong, nonatomic) NSNumber * points;
@end
