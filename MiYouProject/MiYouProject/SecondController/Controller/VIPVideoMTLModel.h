//
//  VIPVideoMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VIPVideoMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber * duration;
@property (strong, nonatomic) NSString * pic;
@property (strong, nonatomic) NSNumber * vip;

@end
