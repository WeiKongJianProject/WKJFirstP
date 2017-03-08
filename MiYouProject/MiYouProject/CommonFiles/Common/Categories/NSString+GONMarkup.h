//
//  NSString+GONMarkup.h
//  HotelProject
//
//  Created by huangYuHua on 15/8/13.
//  Copyright (c) 2015年 Mr.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GONMarkupParser_All.h"

@interface NSString (GONMarkup)

- (NSString *)addColorMark:(NSString *)mark;

- (NSAttributedString *)createAttributedString;

- (NSString *)addFontMark:(NSString *)fontName AndSize:(CGFloat)fontSize;

- (NSString *)addFontNAmeMark:(NSString *)fontName;

- (NSString *)addFontSizeMark:(CGFloat)fontSize;




@end
