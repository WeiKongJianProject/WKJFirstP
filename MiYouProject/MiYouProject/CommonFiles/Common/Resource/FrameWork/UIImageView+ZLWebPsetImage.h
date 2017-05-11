//
//  UIImageView+ZLWebPsetImage.h
//  Matro
//
//  Created by lang on 16/8/8.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDwebImage/UIimage+MultiFormat.h>


@interface UIImageView (ZLWebPsetImage)


- (void)setZLWebPImageWithURLStr:(NSString *)urlStr withPlaceHolderImage:(UIImage *)placeImage;

@end
