//
//  SettingViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "SettingTableViewCell.h"

#import "RenZhengViewController.h"
#import "GuanYuUSViewController.h"
#import "AboutUSViewController.h"
#import "YiJianViewController.h"

@interface SettingViewController : ZLBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;

@end
