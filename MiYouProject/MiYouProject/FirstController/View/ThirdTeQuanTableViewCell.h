//
//  ThirdTeQuanTableViewCell.h
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdTeQuanTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *aiQiYiButton;
@property (strong, nonatomic) IBOutlet UIButton *leShiButton;
@property (strong, nonatomic) IBOutlet UIButton *mangGuoButton;
@property (strong, nonatomic) IBOutlet UIButton *tuDouButton;
@property (strong, nonatomic) IBOutlet UIButton *souHuButton;
@property (strong, nonatomic) IBOutlet UIButton *youKuButton;

@property (strong, nonatomic) NSMutableArray *VIPButtonARR;

@end
