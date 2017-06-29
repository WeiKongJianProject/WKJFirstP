//
//  HuanCunCenterViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/16.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuanCunZLTableViewCell.h"
#import "ZLButtons.h"
#import "HuanCunFooterView.h"
#import "VideoModelZL.h"
#import "PlayerZLViewController.h"
#import "SiFangPlayController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@interface HuanCunCenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray * videoARR;
@property (strong, nonatomic) NSMutableArray * selectButtonARR;
@property (strong, nonatomic) NSMutableArray * buttonsZongARR;
@property (strong, nonatomic) UITableView * tableview;
@property (strong, nonatomic) HuanCunFooterView * footView;
@property (strong, nonatomic) UIBarButtonItem * rightButton;

@end
