//
//  VideoListMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/22.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VideoListMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber * duration;
@property (strong, nonatomic) NSString * pic;
@property (strong, nonatomic) NSNumber * vip;
@property (strong, nonatomic) NSString * subname;
@end
