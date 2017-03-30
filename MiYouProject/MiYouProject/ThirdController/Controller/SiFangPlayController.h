//
//  SiFangPlayController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/30.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import <ZFPlayer.h>
#import "DownloadModel.h"
#import "WHCNetWorkKit.h"
#import "UIView+WHC_Toast.h"
#import "PlayVideoTableViewCell.h"
#import "ZLSecondAFNetworking.h"
#import "PlayVideoMTLModel.h"
#import "PlayMemberMTLModel.h"
@interface SiFangPlayController : ZLBaseViewController<ZFPlayerDelegate,ZFPlayerControlViewDelagate>

@property (weak, nonatomic) IBOutlet ZFPlayerView *playerView;
@property (assign,  nonatomic) BOOL isBenDi;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
@property (weak, nonatomic) IBOutlet UIView *backgroundPlayView;

@property (strong, nonatomic) NSURL * benDiUrl;
@property (strong, nonatomic) NSString * benDiName;
@property (strong, nonatomic) NSURL * zaiXianUrl;
@property (strong, nonatomic) NSString * zaiXianName;

@end
