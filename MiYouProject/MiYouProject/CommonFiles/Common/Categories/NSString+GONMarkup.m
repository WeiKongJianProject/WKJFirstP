//
//  NSString+GONMarkup.m
//  HotelProject
//
//  Created by huangYuHua on 15/8/13.
//  Copyright (c) 2015年 Mr.huang. All rights reserved.
//

#import "NSString+GONMarkup.h"

@implementation NSString (GONMarkup)

- (NSString *)addColorMark:(NSString *)mark
{
    if (self.length <= 0) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"<color value=\"%@\">%@</>", mark, self];
}



- (NSString *)addFontMark:(NSString *)fontName AndSize:(CGFloat)fontSize
{
    if (self.length <= 0)
    {
        return nil;
    }
    
    return [NSString stringWithFormat:@"<font  name=\"%@\" size=\"%f\">%@   </>",fontName,fontSize,self];
    
}

- (NSString *)addFontNAmeMark:(NSString *)fontName
{
    if (self.length <= 0)
    {
        return nil;
    }
    
    return [NSString stringWithFormat:@"<font name=\"%@\">%@</>",fontName,self];
}

- (NSString *)addFontSizeMark:(CGFloat)fontSize
{
    if (self.length <= 0)
    {
        return nil;
    }
    
    return [NSString stringWithFormat:@"<font size=\"%f\">%@</>",fontSize,self];
    
}

- (NSAttributedString *)createAttributedString
{
    return [[GONMarkupParserManager sharedParser] attributedStringFromString:self
                                                                       error:nil];
}


@end
