//
//  SettingViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "SettingTableViewCell.h"

@interface SettingViewController : ZLBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;

@end
