//
//  PersonHederTableViewCell.m
//  MiYouProject
//
//  Created by wkj on 2017/3/13.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PersonHederTableViewCell.h"

@implementation PersonHederTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"执行了awakeFromNib");
    //设置圆角
    self.headerImageVIew.layer.cornerRadius = self.headerImageVIew.frame.size.width / 2;
    //将多余的部分切掉
    self.headerImageVIew.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
