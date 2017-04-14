//
//  HuanCunFooterView.m
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "HuanCunFooterView.h"

@implementation HuanCunFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"HuanCunFooterView执行了awakeFromNib");
}


- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"HuanCunFooterView执行了layoutSubviews");
    [self setFrame:CGRectMake(0, SIZE_HEIGHT-32.0, SIZE_WIDTH, 32.0f)];
}

@end
