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
    // Here we need to pass a full frame
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    //[alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close1", @"Close2", @"Close3", nil]];
    [alertView setButtonTitles:nil];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:NO];
    //self.navigationItem.title = @"KSMainView";
    //self.navigationController.navigationBar.topItem.title=@"测试二";
     self.tabBarController.navigationItem.title = @"正解";
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
//    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 225, 125)];
//    demoView.backgroundColor = [UIColor whiteColor];
//    UILabel * label = [[UILabel alloc]init];
//    label.text = @"观看会员视频需要开通VIP";
//    label.textColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
//    [demoView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(demoView);
//        make.centerY.mas_equalTo(demoView.mas_centerY).offset(-20.0f);
//    }];
//    UIView * spView = [[UIView alloc]init];
//    spView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
//    [demoView addSubview:spView];
//    [spView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(demoView);
//        make.height.equalTo(@1.0);
//        make.centerY.mas_equalTo(demoView.mas_centerY).offset(10.0f);
//    }];
//    
//    
//    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [demoView addSubview:cancelButton];
//
//    
//    UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [okButton setTitle:@"马上开通" forState:UIControlStateNormal];
//    [okButton addTarget:self action:@selector(OKButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [demoView addSubview:okButton];
//    
//    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(okButton);
//        make.height.equalTo(okButton);
//    }];
//    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(cancelButton);
//        make.height.equalTo(cancelButton);
//    }];
//    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
////    [imageView setImage:[UIImage imageNamed:@"demo"]];
////    [demoView addSubview:imageView];
    
    UIAlertViewZL * demoView = (UIAlertViewZL *)[[NSBundle mainBundle]loadNibNamed:@"UIAlertVIewZL" owner:self options:nil][0];
    
    return demoView;
}
- (void)cancelButtonAction:(UIButton *)sender{
    NSLog(@"点击了取消按钮");
}
- (void)OKButtonAction:(UIButton *)sender{
    NSLog(@"点击了确定按钮");
}


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
