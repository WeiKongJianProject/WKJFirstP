//
//  MyYuEViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "UserMessageMTLModel.h"

@interface MyYuEViewController : ZLBaseViewController
@property (strong, nonatomic) IBOutlet UILabel *yuELabel;
@property (strong, nonatomic) UserMessageMTLModel * userModel;
@end
