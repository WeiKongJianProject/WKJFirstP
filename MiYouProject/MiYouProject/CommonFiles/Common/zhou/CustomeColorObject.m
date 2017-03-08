//
//  CustomeColorObject.m
//  JinTangLangJia
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 jtljia.com. All rights reserved.
//

#import "CustomeColorObject.h"

@implementation CustomeColorObject


//随机颜色
- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 210 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}


+ (UIColor *)makeColorWithHue:(float)hue withSaturation:(float)saturation withbrightness:(float) brightness withAlpha:(float)alpha{
    float hue1 = hue / 360;
    return [UIColor colorWithHue:hue1 saturation:saturation brightness:brightness alpha:alpha];
}

@end
