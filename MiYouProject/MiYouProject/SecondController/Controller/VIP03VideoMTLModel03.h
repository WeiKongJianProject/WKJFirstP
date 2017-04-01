//
//  VIP03VideoMTLModel03.h
//  MiYouProject
//
//  Created by wkj on 2017/4/1.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VIP03VideoMTLModel03 : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * actor;
@property (strong, nonatomic) NSString * pic;
@property (strong, nonatomic) NSString * source;
@end
