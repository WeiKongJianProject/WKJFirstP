//
//  ZLPageControl.h
//  Matro
//
//  Created by lang on 16/8/10.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPageControl : UIPageControl
{
    
//    UIImage* activeImage;
//    
//    UIImage* inactiveImage;
    
}
@property (strong, nonatomic) UIImage *activeImage;
@property (strong, nonatomic) UIImage *inactiveImage;
@property (strong, nonatomic) UIColor * activeColor;
@property (strong, nonatomic) UIColor * inactiveColor;


@end
