//
//  UIColor+HeinQi.h
//  FashionShop
//
//  Created by 王闻昊 on 15/8/13.
//  Copyright (c) 2015年 HeinQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HeinQi)

+(UIColor *)colorWithHexString:(NSString *)hexString;

+(UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

- (CGFloat)red;
- (CGFloat)green;
- (CGFloat)blue;
- (CGFloat)alpha;

- (UIColor *)darkerColor;
- (UIColor *)lighterColor;
- (BOOL)isLighterColor;
- (BOOL)isClearColor;

@end
