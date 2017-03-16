//
//  HuanCunZLTableViewCell.h
//  MiYouProject
//
//  Created by wkj on 2017/3/16.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLButtons.h"
@interface HuanCunZLTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *videoSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *shengYuLabel;

@property (strong, nonatomic) ZLButtons * leftButton02;

@end
