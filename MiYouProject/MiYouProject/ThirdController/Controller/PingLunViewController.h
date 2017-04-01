//
//  PingLunViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "PingLunTableViewCell.h"
#import "PingLunMTLModel.h"
#import "ZLSecondAFNetworking.h"


@interface PingLunViewController : ZLBaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (assign, nonatomic) NSInteger id;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *faSongButton;

@property (strong, nonatomic) NSMutableArray * tableviewARR;

@end
