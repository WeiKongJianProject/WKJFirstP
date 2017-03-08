//
//  HFSApplicationContext.m
//  FashionShop
//
//  Created by 王闻昊 on 15/11/18.
//  Copyright © 2015年 HeinQi. All rights reserved.
//

#import "HFSApplicationContext.h"

__strong static HFSApplicationContext *_context = nil;

@implementation HFSApplicationContext

+(instancetype)sharedContext {
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        _context = [[super allocWithZone:NULL] init];
    });
    return _context;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedContext];
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
