//
//  HFSApplicationContext.h
//  FashionShop
//
//  Created by 王闻昊 on 15/11/18.
//  Copyright © 2015年 HeinQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFSApplicationContext : NSObject

+(instancetype)sharedContext;

@property (nonatomic, copy) NSNumber *appFreeFright;
@property (nonatomic, copy) NSNumber *appFright;

@end
