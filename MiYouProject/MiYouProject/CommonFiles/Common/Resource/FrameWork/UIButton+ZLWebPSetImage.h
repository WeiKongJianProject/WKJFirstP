//
//  UIButton+ZLWebPSetImage.h
//  Matro
//
//  Created by lang on 16/8/22.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDwebImage/UIimage+MultiFormat.h>

#import "UIButton+WebCache.h"
@interface UIButton (ZLWebPSetImage)
- (void)setZLWebPButton_ImageWithURLStr:(NSString *)urlStr withPlaceHolderImage:(UIImage *)placeImage;
- (void)setZLWebPButton_BackgroundImageWithURLStr:(NSString *)urlStr withPlaceHolderImage:(UIImage *)placeImage;
@end
