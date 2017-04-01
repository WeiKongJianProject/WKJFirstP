//
//  SiFangPlayButton.h
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiFangMTLModel.h"
@interface SiFangPlayButton : UIButton

@property (assign, nonatomic) int videoID;
@property (assign, nonatomic) SiFangMTLModel * sifangModel;

@end
