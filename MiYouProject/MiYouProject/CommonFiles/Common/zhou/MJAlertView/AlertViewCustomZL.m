//
//  AlertViewCustomZL.m
//  MiYouProject
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "AlertViewCustomZL.h"

@implementation AlertViewCustomZL

- (void)showCustomAlertView{
    
    
    self.alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [self.alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    //[self.alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close1", @"Close2", @"Close3", nil]];
    [self.alertView setButtonTitles:nil];
    [self.alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [self.alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [self.alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [self.alertView show];
    
}

- (void)hideCustomeAlertView{
    [self.alertView close];
    
}

#pragma mark 自定义AlertController 代理方法
//自定义弹出框
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

- (UIView *)createDemoView
{
    UIAlertViewZL * demoView = (UIAlertViewZL *)[[NSBundle mainBundle]loadNibNamed:@"UIAlertVIewZL" owner:self options:nil][0];
    [demoView.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [demoView.okButton addTarget:self action:@selector(OKButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.titleName != nil && ![self.titleName isEqualToString:@""]) {
        demoView.titleLabel.text = self.titleName;
    }
    if (self.cancelBtnTitle != nil && ![self.cancelBtnTitle isEqualToString:@""]) {
        [demoView.cancelButton setTitle:self.cancelBtnTitle forState:UIControlStateNormal];
    }
    if (self.okBtnTitle != nil && ![self.okBtnTitle isEqualToString:@""]) {
        [demoView.okButton setTitle:self.okBtnTitle forState:UIControlStateNormal];
    }
    
    
    return demoView;
}
- (void)cancelButtonAction:(UIButton *)sender{
    NSLog(@"点击了取消按钮");
    self.cancelBlock(YES);
}
- (void)OKButtonAction:(UIButton *)sender{
    NSLog(@"点击了确定按钮");
    self.okButtonBlock(YES);
}
- (void)cancelBlockAction:(CancelBlock)block{
    self.cancelBlock = block;
}
- (void)okButtonBlockAction:(OKButtonBlock)block{
    self.okButtonBlock = block;
}

#pragma end mark
@end
