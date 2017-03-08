//
//  UILabel+HeinQi.m
//  FashionShop
//
//  Created by 王闻昊 on 15/8/20.
//  Copyright (c) 2015年 HeinQi. All rights reserved.
//

#import "UILabel+HeinQi.h"

@implementation UILabel (HeinQi)

-(void)alignTop {
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidtth = self.frame.size.width;
    CGSize stringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidtth, finalHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context:nil].size;
    int newLineToPad = (finalHeight - stringSize.height) / fontSize.height;
    for (int i = 0; i < newLineToPad; i++) {
        self.text = [self.text stringByAppendingString:@"\n "];
    }
}

-(void)alignBottom {
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidtth = self.frame.size.width;
    CGSize stringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidtth, finalHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context:nil].size;
    int newLineToPad = (finalHeight - stringSize.height) / fontSize.height;
    for (int i = 0; i < newLineToPad; i++) {
        self.text = [NSString stringWithFormat:@" \n%@", self.text];
    }
}

@end
