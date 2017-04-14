//
//  VIPPriceMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/4/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VIPPriceMTLModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSNumber * id;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber * price;
@property (strong, nonatomic) NSNumber * day;

@end
