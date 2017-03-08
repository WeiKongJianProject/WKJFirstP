//
//  UIColor+KSString.m
//  Navigation
//
//  Created by 史金亮 on 15/12/9.
//  Copyright © 2015年 kamy. All rights reserved.
//

#import "UIColor+KSString.h"

@implementation UIColor (KSString)
#pragma -mark GetColor//解析16进制的颜色
+ (UIColor *)getColor:(NSString *)hexColor {
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}
@end
