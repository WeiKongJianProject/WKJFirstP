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

@interface PlayerZLViewController : UIViewController<ZFPlayerDelegate,ZFPlayerControlViewDelagate,UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) BOOL isBenDi;
@property (strong, nonatomic) IBOutlet ZFPlayerView *playerView;
@property (strong, nonatomic) NSURL * url;
@property (assign, nonatomic) int videoId;
@property (strong, nonatomic) NSString * name;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;

@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *tiJiaoButton;


@end
