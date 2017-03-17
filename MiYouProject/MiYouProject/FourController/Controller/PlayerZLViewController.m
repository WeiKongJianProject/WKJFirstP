
//
//  PlayerZLViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PlayerZLViewController.h"

@interface PlayerZLViewController ()

@end

@implementation PlayerZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)settingPlayer{

    // 初始化控制层view(可自定义)
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    // 初始化播放模型
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    // playerView的父视图
    playerModel.fatherView = self.view;
    playerModel.videoURL = [NSURL URLWithString:@""];
    playerModel.title = @"你好";

    [self.playerView playerControlView:controlView playerModel:playerModel];
    // 设置代理
    self.playerView.delegate = self;
    // 自动播放
    [self.playerView autoPlayTheVideo];
    
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
