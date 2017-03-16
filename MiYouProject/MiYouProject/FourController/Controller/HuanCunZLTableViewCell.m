//
//  HuanCunZLTableViewCell.m
//  MiYouProject
//
//  Created by wkj on 2017/3/16.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "HuanCunZLTableViewCell.h"

@implementation HuanCunZLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shengYuLabel.hidden = YES;
    
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"huancunbaise"] forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"huancunhonggou"] forState:UIControlStateSelected];

      [self.leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}
//左侧选择按钮执行方法
- (void)leftButtonAction:(UIButton *)sender{
    NSLog(@"点击了左侧按钮");
    if (sender.isSelected) {
        sender.selected = NO;
    }
    else{
        sender.selected = YES;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
