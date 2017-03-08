//
//  CustomeColorObject.h
//  JinTangLangJia
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 jtljia.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomeColorObject : NSObject
+ (UIColor *)makeColorWithHue:(float)hue withSaturation:(float)saturation withbrightness:(float) brightness withAlpha:(float)alpha;

@end
