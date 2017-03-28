//
//  MyYuEViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "MyYuEViewController.h"

@interface MyYuEViewController ()

@end

@implementation MyYuEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.yuELabel.text = [NSString stringWithFormat:@"%d",[self.userModel.points intValue]];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"我的余额";
    [self.navigationController setNavigationBarHidden:NO];
}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     [self.navigationController setNavigationBarHidden:YES];
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
