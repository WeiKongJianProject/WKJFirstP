//
//  UIColor+ColorZL.h
//  MiYouProject
//
//  Created by wkj on 2017/3/9.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorZL)
+(UIColor *) colorWithhex16stringToColor: (NSString *) stringToConvert;
+(UIColor *)colorWithhex16stringToColor:(NSString *)hexString alpha:(CGFloat)alpha;
@end
