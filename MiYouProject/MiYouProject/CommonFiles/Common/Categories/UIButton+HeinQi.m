//
//  UIButton+HeinQi.m
//  FashionShop
//
//  Created by 王闻昊 on 15/8/13.
//  Copyright (c) 2015年 HeinQi. All rights reserved.
//

#import "UIButton+HeinQi.h"
#import "UIColor+HeinQi.h"
#import "HFSConstants.h"

@implementation UIButton (HeinQi)

//居中
- (void)centerImageAndTitleWithSpace:(float)space {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = imageSize.height + titleSize.height + space;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0, 0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

//左右调换
- (void)changeImageAndTitle {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width, 0, -titleSize.width-10);
    self.titleEdgeInsets = UIEdgeInsetsMake(0 , -imageSize.width , 0 ,imageSize.width);
}


- (void)centerImageAndTitle {
    const int DEFAULT_SPACE = 0.0f;
    [self centerImageAndTitleWithSpace:DEFAULT_SPACE];
}

//登录按钮样式
- (void)loginButtonType{
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    /*
    if(self.enabled == YES){
        
        [self setBackgroundImage:[UIImage imageNamed:@"quguangguang_button"] forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"TM.jpg"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithHexString:@"#AE8E5D"].CGColor;
    }
    */
    if (self.enabled == YES) {
        [self setBackgroundColor:[UIColor colorWithHexString:Main_BackgroundColor]];
    }
    else{
        [self setBackgroundColor:[UIColor colorWithHexString:Main_grayBackgroundColor]];
    }

}

//选择按钮样式
- (void)selButtonType{
    [self setTitleColor:[UIColor colorWithHexString:@"#AE8E5D"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"sel_type_g"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageNamed:@"sel_type_w"] forState:UIControlStateSelected];
}

//发票选择按钮样式
- (void)invoiceselButtonType{
    [self setImage:[UIImage imageNamed:@"icon_weixuanzhong"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"icon_xuanzhong"] forState:UIControlStateSelected];
}

//快递配送
-(void)peisongButtonType{
    [self setTitleColor:[UIColor colorWithHexString:@"#0e0e0e"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"shangmenziti_button"] forState:UIControlStateNormal];
//    [self setBackgroundImage:[UIImage imageNamed:@"sel_type_g"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageNamed:@"kuaidipeisong_button"] forState:UIControlStateSelected];
}


@end
