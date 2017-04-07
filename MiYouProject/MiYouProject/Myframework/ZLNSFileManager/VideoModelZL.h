//
//  VideoModelZL.h
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModelZL : NSObject

@property (strong, nonatomic) NSString * videoName;
@property (strong, nonatomic) NSString * videoSmallImageURL;
@property (strong, nonatomic) NSString * URL;
@property (strong, nonatomic) NSString * cachePath;
@property (assign, nonatomic) float fileSize;
@property (strong, nonatomic) UIImage * image;
@end
