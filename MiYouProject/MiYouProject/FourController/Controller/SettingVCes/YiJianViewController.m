//
//  YiJianViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/28.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "YiJianViewController.h"

@interface YiJianViewController ()

@end

@implementation YiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
//    self.textVIew.textContainer.lineFragmentPadding = 0;
//    self.textVIew.textContainerInset = UIEdgeInsetsZero;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)tiJiaoButton:(id)sender {
    self.textVIew.text = @"";
    [self.textVIew resignFirstResponder];
    [MBManager showBriefAlert:@"提交成功"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
