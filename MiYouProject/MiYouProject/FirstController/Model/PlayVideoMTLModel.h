//
//  PlayVideoMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/27.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PlayVideoMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * subname;
@property (strong, nonatomic) NSString * pic;
@property (strong, nonatomic) NSString * actor;
@property (strong, nonatomic) NSString * tag;
@property (strong, nonatomic) NSString * remarks;
@property (strong, nonatomic) NSString * area;
@property (strong, nonatomic) NSString * lang;
@property (strong, nonatomic) NSNumber * year;
@property (strong, nonatomic) NSString * type;
@property (strong, nonatomic) NSString * story;
@property (strong, nonatomic) NSNumber * duration;
@property (strong, nonatomic) NSNumber * hit;
@property (strong, nonatomic) NSNumber * score;
@property (strong, nonatomic) NSString * video;
@property (strong, nonatomic) NSString * trial;
@property (strong, nonatomic) NSNumber * usergroup;
@property (strong, nonatomic) NSString * content;


@end
