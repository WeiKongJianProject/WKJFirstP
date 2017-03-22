//
//  MemberMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/22.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MemberMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSNumber * id;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * nickname;
@property (strong, nonatomic) NSString * password;
@property (strong, nonatomic) NSNumber * group;
@property (strong, nonatomic) NSString * sex;

@end
