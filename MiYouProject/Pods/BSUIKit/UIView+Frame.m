//
//  UIView+Frame.m
//  
//
//  Created by Kai on 13-8-6.
//  Copyright (c) 2013年 YY Inc. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (UIViewFrame)

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat) y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
 
}

- (CGFloat)bottom
{
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

- (CGFloat)right
{
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}
@end
