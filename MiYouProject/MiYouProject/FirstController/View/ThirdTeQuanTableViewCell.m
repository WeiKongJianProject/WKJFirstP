//
//  ThirdTeQuanTableViewCell.m
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ThirdTeQuanTableViewCell.h"

@implementation ThirdTeQuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.VIPButtonARR addObjectsFromArray:@[self.youKuButton,self.souHuButton,self.tuDouButton,self.mangGuoButton,self.leShiButton,self.aiQiYiButton]];
}
- (NSMutableArray *)VIPButtonARR{
    if (!_VIPButtonARR) {
        _VIPButtonARR = [[NSMutableArray alloc]init];
    }
    return _VIPButtonARR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
