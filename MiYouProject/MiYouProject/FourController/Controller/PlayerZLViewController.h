//
//  PlayerZLViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer.h>
@interface PlayerZLViewController : UIViewController<ZFPlayerDelegate,ZFPlayerControlViewDelagate>

@property (assign, nonatomic) BOOL isBenDi;
@property (strong, nonatomic) IBOutlet ZFPlayerView *playerView;
@property (strong, nonatomic) NSURL * url;
@end
