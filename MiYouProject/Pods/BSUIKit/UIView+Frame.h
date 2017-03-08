//
//  UIView+Frame.h
//  
//
//  Created by Kai on 13-8-6.
//  Copyright (c) 2013年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewFrame)

@property(assign, nonatomic) CGFloat x;
@property(assign, nonatomic) CGFloat y;

@property(assign, nonatomic) CGFloat width;
@property(assign, nonatomic) CGFloat height;

@property(readonly,nonatomic) CGFloat bottom;
@property(readonly,nonatomic) CGFloat right;

@end