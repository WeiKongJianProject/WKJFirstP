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
#import "PlayVideoTableViewCell.h"
#import "ZLSecondAFNetworking.h"
#import "PlayVideoMTLModel.h"
#import "PlayMemberMTLModel.h"
#import "PingLunTableViewCell.h"
#import "PingLunMTLModel.h"
#import "ChongZhiViewController.h"


@interface PlayerZLViewController : UIViewController<ZFPlayerDelegate,ZFPlayerControlViewDelagate,UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) BOOL isBenDi;
@property (assign, nonatomic) BOOL isShiKan;
@property (strong, nonatomic) IBOutlet ZFPlayerView *playerView;
@property (strong, nonatomic) NSURL * url;
@property (assign, nonatomic) int videoId;
@property (strong, nonatomic) NSString * name;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;

@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * tableViewARR;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *tiJiaoButton;

@property (strong, nonatomic) NSString * id;//影片ID
@property (assign, nonatomic) int mid;//用户信息
@property (strong, nonatomic) PlayVideoMTLModel * playModel;
@property (strong, nonatomic) PlayMemberMTLModel * playMemberModel;

@property (strong, nonatomic) IBOutlet UIButton *xiaZaiButton;
@property (strong, nonatomic) IBOutlet UILabel *boFangNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *videoTitleLabel;



@end
