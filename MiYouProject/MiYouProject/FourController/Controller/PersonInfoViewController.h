//
//  PersonInfoViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "PersonTableViewCell.h"
@interface PersonInfoViewController : ZLBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView * tableView;
@end