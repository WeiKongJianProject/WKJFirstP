//
//  PlayVideoTableViewCell.h
//  MiYouProject
//
//  Created by wkj on 2017/3/21.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayVideoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuYanLabel;
@property (weak, nonatomic) IBOutlet UILabel *jianJieLabel;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *shouCangButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *pingLunNumLabel;

@end
