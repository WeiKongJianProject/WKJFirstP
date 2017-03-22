//
//  AlertViewCustomZL.h
//  MiYouProject
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAlertViewZL.h"

typedef void(^CancelBlock)(BOOL success);
typedef void(^OKButtonBlock)(BOOL success);

@interface AlertViewCustomZL : UIView<CustomIOSAlertViewDelegate>
@property (strong, nonatomic)CustomIOSAlertView * alertView;

@property (copy, nonatomic) CancelBlock cancelBlock;
@property (copy, nonatomic) OKButtonBlock okButtonBlock;

@property (strong, nonatomic) NSString * titleName;
@property (strong, nonatomic) NSString * cancelBtnTitle;
@property (strong, nonatomic) NSString * okBtnTitle;

- (void)cancelBlockAction:(CancelBlock )block;
- (void)okButtonBlockAction:(OKButtonBlock )block;
- (void)showCustomAlertView;
- (void)hideCustomeAlertView;

@end
