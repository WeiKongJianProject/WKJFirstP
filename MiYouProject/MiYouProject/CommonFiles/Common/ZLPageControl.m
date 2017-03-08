//
//  ZLPageControl.m
//  Matro
//
//  Created by lang on 16/8/10.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import "ZLPageControl.h"

@implementation ZLPageControl
-(id) initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    
    self.activeImage = [UIImage imageNamed:@"zlpage.png"];
    
    self.inactiveImage = [UIImage imageNamed:@"zlpageA.png"];
    
    self.activeColor = [UIColor whiteColor];
    self.inactiveColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    return self;
    
}


-(void) updateDots

{

    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = (UIImageView *)[self.subviews objectAtIndex:i];
        dot.backgroundColor = [UIColor clearColor];
        CGSize size;
        
        size.height = 3;     //自定义圆点的大小
        
        size.width = 10;      //自定义圆点的大小
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width,  size.height)];
        //NSLog(@"dot.frame.orign.x=%g,dot.frame.origin.y=%g,size.width=%g, size.width=%g",dot.frame.origin.x,dot.frame.origin.y,size.width,size.width);
        //UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, size.width, size.height)];
        //dot = imageView;
        //[dot addSubview:imageView];

        if (i==self.currentPage)dot.backgroundColor=self.activeColor;
        
        else dot.backgroundColor=self.inactiveColor;
    }
    
}

-(void) setCurrentPage:(NSInteger)page

{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}

@end
