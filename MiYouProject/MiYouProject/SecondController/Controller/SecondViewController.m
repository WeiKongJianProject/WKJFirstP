//
//  SecondViewController.m
//  SecondProject
//
//  Created by wkj on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"继续测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //[self videoBoFang];
    //[self videlXiaZai];
    //[MBManager showLoading];
    //[MBManager showPermanentAlert:@"请稍等..."];
    //[MBManager showBriefAlert:@"加载中..."];
    //[MBManager showLoadingInView:self.view];
//    [MBManager hideAlert];
    //[UIView addMJNotifierWithText:@"请先登录" dismissAutomatically:YES];
//    [self.view toast:@"测试"];
//    [self.view toastMid:@"测试02"];
    //[self.view startLoadingWithTxtUser:@"测试"];
    //[self.view showBadgeValue:@"测试"];
    //[self.view configBlankPage:EaseBlankPageTypeLiuLan hasData:NO];
    
}
/*
//视频播放
- (void)videoBoFang{
    //视频播放  功能
    HcdCacheVideoPlayer *play = [HcdCacheVideoPlayer sharedInstance];
    UIView *videoView = [[UIView alloc] init];
    videoView.frame = CGRectMake(0, 64, SIZE_WIDTH, SIZE_WIDTH * 0.5625);
    [self.view addSubview:videoView];
    
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"test.mp4"];
    NSLog(@"文件的路径为：%@",fullPath);
    NSURL *url = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14564977406580.mp4"];//您要播放的url地址
    NSURL * url2 = [NSURL fileURLWithPath:fullPath];
    // /Users/wkj/Library/Developer/CoreSimulator/Devices/F9E33A67-3C43-4C6C-B8E7-4CB258372E96/data/Containers/Data/Application/0327319C-C49D-4C27-A03D-95F768A51854/Documents/test.mp4
    [play playWithUrl:url
             showView:videoView
         andSuperView:self.view
            withCache:YES];
    double  tt = [HcdCacheVideoPlayer allVideoCacheSize];
    NSLog(@"缓存视频的大小:%lf",tt);

}
*/
//视频下载
- (void)videlXiaZai{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"沙盒路径：%@",documentsDirectory);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"test.mp4"];
    NSURL *url = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14564977406580.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task =
    [manager downloadTaskWithRequest:request
                            progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                return [NSURL fileURLWithPath:fullPath];
                            }
                   completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                       
                   }];
    [task resume];
}

- (void)btnAction:(UIButton *)sender{

    AlertViewCustomZL * alertView = [[AlertViewCustomZL alloc]init];
    [alertView showCustomAlertView];
    [alertView cancelBlockAction:^(BOOL success) {
        [alertView hideCustomeAlertView];
    }];
    [alertView okButtonBlockAction:^(BOOL success) {
        [alertView hideCustomeAlertView];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:NO];
    //self.navigationItem.title = @"KSMainView";
    //self.navigationController.navigationBar.topItem.title=@"测试二";
     self.tabBarController.navigationItem.title = @"正解";
}
#pragma mark 自定义AlertController 代理方法


#pragma end mark

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
