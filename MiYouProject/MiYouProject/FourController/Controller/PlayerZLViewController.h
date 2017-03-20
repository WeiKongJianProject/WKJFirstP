//
//  PlayerZLViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer.h>
#import "DownloadModel.h"
#import "WHCNetWorkKit.h"
#import "UIView+WHC_Toast.h"
@interface PlayerZLViewController : UIViewController<ZFPlayerDelegate,ZFPlayerControlViewDelagate>

@property (assign, nonatomic) BOOL isBenDi;
@property (strong, nonatomic) IBOutlet ZFPlayerView *playerView;
@property (strong, nonatomic) NSURL * url;
@property (strong, nonatomic) NSString * name;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
@end
