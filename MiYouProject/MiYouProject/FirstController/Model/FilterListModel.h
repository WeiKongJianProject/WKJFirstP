//
//  FilterListModel.h
//  MiYouProject
//
//  Created by wkj on 2017/3/24.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FilterListModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSString * key;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSDictionary * list;

@end
