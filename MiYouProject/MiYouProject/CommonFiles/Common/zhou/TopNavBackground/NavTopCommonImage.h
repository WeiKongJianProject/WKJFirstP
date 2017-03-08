//
//  NavTopCommonImage.h
//  1PXianProject
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 JiJianNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonHeader.h"
#import "CustomeColorObject.h"


typedef void(^BackBtnBlock)(BOOL succes);

@interface NavTopCommonImage : UIImageView


@property (copy, nonatomic) BackBtnBlock backsBlock;
@property (strong, nonatomic) UILabel * tittleLabel;
@property (strong, nonatomic) UIButton * leftBtn;
@property (strong, nonatomic) UIButton * rightBtn;

- (void)backButtonAction:(BackBtnBlock )blcok;
- (void)loadNavImageWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title;
- (void)loadLeftBackButtonwith:(int)index;

@end
