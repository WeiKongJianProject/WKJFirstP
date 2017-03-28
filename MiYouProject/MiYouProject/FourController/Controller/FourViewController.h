//
//  FourViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/8.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonHederTableViewCell.h"
#import "ButtonsTableViewCell.h"
#import "ThirdTeQuanTableViewCell.h"
#import "MyYuEViewController.h"
#import "SettingViewController.h"
#import "PersonInfoViewController.h"
#import "XiaoXiViewController.h"
#import "ChongZhiViewController.h"
#import "HuanCunCenterViewController.h"
#import "UserInfoMTLModel.h"
#import "UserMessageMTLModel.h"
#import "UIView+HeinQi.h"

@interface FourViewController : ZLBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UserInfoMTLModel * userInfoModel;
@property (strong, nonatomic) UserMessageMTLModel * userMessageModel;
@property (strong, nonatomic) UIImageView * headImageView;

@end
