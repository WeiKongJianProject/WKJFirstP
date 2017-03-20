
//
//  PlayerZLViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PlayerZLViewController.h"

@interface PlayerZLViewController (){

    
    
}

@end

@implementation PlayerZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingPlayer];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
        //if use Masonry,Please open this annotation
        /*
         [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(20);
         }];
         */
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
        //if use Masonry,Please open this annotation
        /*
         [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(0);
         }];
         */
    }
}

- (void)dealloc{
    NSLog(@"什么类释放了：%@",self.class);
    //[self.playerView cancelAutoFadeOutControlBar];

}
- (void)settingPlayer{
   
    // 初始化控制层view(可自定义)
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    // 初始化播放模型
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    // playerView的父视图
    playerModel.fatherView = self.view;
    playerModel.videoURL = self.url;
    playerModel.title = self.name;
     //从xx秒开始播放
    //playerModel.seekTime = 10;
    //占位图
    playerModel.placeholderImage = [UIImage imageNamed:@"icon_default"];
    //网络占位图
    // 网络图片
    //playerModel.placeholderImageURLString = @"https://xxx.jpg";
    [self.playerView playerControlView:controlView playerModel:playerModel];
    // 设置代理
    self.playerView.delegate = self;
    // 自动播放
    //[self.playerView autoPlayTheVideo];
    // 设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    //断点下载
    self.playerView.hasDownload = YES;

}

#pragma mark ZFPlayerDelegate方法
//返回按钮执行方法  代理
- (void)zf_playerBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)zf_playerDownload:(NSString *)url{
    __weak typeof(self) weakSelf = self;
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSLog(@"下载的链接为：%@",url);
    NSString *name = [url lastPathComponent];
    //开始后台下载
    DownloadModel *downloadModel = [[DownloadModel alloc]init];
    downloadModel.showModelMssage= ^(NSString *message){
        //显示信息
        [weakSelf.view toast:message];
    };
    [downloadModel downLoadWith:url title:name defaultFormat:@".mp4"];
}

#pragma end mark

- (void)viewPlayFeiQi{

    //__weak typeof(self) weakSelf = self;
    
    //if use Masonry,Please open this annotation
    /*
     UIView *topView = [[UIView alloc] init];
     topView.backgroundColor = [UIColor blackColor];
     [self.view addSubview:topView];
     [topView mas_updateConstraints:^(MASConstraintMaker *make) {
     make.top.left.right.equalTo(self.view);
     make.height.mas_offset(20);
     }];
     
     self.playerView = [[ZFPlayerView alloc] init];
     [self.view addSubview:self.playerView];
     [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(self.view).offset(20);
     make.left.right.equalTo(self.view);
     // 注意此处，宽高比16：9优先级比1000低就行，在因为iPhone 4S宽高比不是16：9
     make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
     }];
     */
    /*
     // 设置播放前的占位图（需要在设置视频URL之前设置）
     self.playerView.placeholderImageName = @"icon_default";
     // 设置视频的URL
     self.playerView.videoURL = self.url;
     // 设置标题
     self.playerView.title = self.title;
     //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
     self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
     */
    /*
     // 打开下载功能（默认没有这个功能）
     self.playerView.hasDownload = YES;
     // 下载按钮的回调
     self.playerView.downloadBlock = ^(NSString *urlStr) {
     // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
     NSString *name = [urlStr lastPathComponent];
     //开始后台下载
     DownloadModel *downloadModel = [[DownloadModel alloc]init];
     downloadModel.showModelMssage= ^(NSString *message){
     //显示信息
     [weakSelf.view toast:message];
     };
     [downloadModel downLoadWith:urlStr title:name defaultFormat:@".mp4"];
     };
     */
    // 如果想从xx秒开始播放视频
    // self.playerView.seekTime = 15;
    /*
     // 是否自动播放，默认不自动播放
     [self.playerView autoPlayTheVideo];
     self.playerView.goBackBlock = ^{
     [weakSelf.navigationController popViewControllerAnimated:YES];
     };
     */
    
    //[self settingPlayer];
    // Do any additional setup after loading the view from its nib.

    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    //self prefersStatusBarHidden
    // 调用playerView的layoutSubviews方法
    if (self.playerView) { [self.playerView setNeedsLayout]; }
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }

    [self.navigationController setNavigationBarHidden:YES];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        [self.playerView pause];
    }
}


#pragma mark 隐藏状态栏
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
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
