//
//  CateListMTLModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/22.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CateListMTLModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * name;

@end
