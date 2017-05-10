//
//  WMPlayZLViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/4/5.
//  Copyright © 2017年 junhong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WMPlayer.h"
#import "ZLSecondAFNetworking.h"
#import "PlayVideoMTLModel.h"
#import "PlayMemberMTLModel.h"
#import "PingLunTableViewCell.h"
#import "PingLunMTLModel.h"
#import "ChongZhiViewController.h"

@interface WMPlayZLViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain)NSString * URLString;

@property (assign, nonatomic) BOOL isNoShiKan;

@property (strong, nonatomic) IBOutlet UIView *topVIew;
@property (strong, nonatomic) WMPlayer * wmPlayer;
@property (strong, nonatomic) IBOutlet UILabel *videoTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *boFangNumLabel;
@property (strong, nonatomic) IBOutlet UIButton *XiaZaiButton;

@property (strong, nonatomic) IBOutlet UITableView *pingLunTableVIew;
@property (strong, nonatomic) IBOutlet UITextField *textFieldView;
@property (strong, nonatomic) IBOutlet UIButton *tiJiaoButton;

@property (strong, nonatomic) NSMutableArray * tableViewARR;

@property (strong, nonatomic) PlayVideoMTLModel * playModel;
@property (strong, nonatomic) PlayMemberMTLModel * playMemberModel;
@property (strong, nonatomic) NSString * id;//影片ID


@end
