//
//  MLAnimationViewController.h
//  Matro
//
//  Created by lang on 16/7/20.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "YYAnimationIndicator.h"
#import "CommonHeader.h"

typedef void(^AnimationMLBlock)(BOOL success);


@interface MLAnimationViewController : ZLBaseViewController


@property (copy, nonatomic) AnimationMLBlock block;


- (void)animationBlockAction:(AnimationMLBlock)block;

@end
