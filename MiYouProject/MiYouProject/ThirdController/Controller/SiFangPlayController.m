//
//  SiFangPlayController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/30.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SiFangPlayController.h"

@interface SiFangPlayController ()

@end

@implementation SiFangPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackgroundGesAction:)];
    [self.view addGestureRecognizer:tap];
   
    
    if (self.isBenDi == YES) {
         [self settingPlayer];
    }
    else{
        [self startWatchPlayWithID:self.id withMID:self.mid];
    }
}

//观看网络请求
- (void)startWatchPlayWithID:(NSString *)ids withMID:(NSString *)mids{
    __weak typeof(self) weakSelf = self;

    NSString * url = [NSString stringWithFormat:@"%@&action=watch&mid=%@&id=%@",URL_Common_ios,mids,ids];
    NSLog(@"私房视频链接为：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"私房请求的数据为：%@",dic);
        if ([dic[@"result"] isEqualToString:@"success"]) {
            
            if (![dic[@"points"] isKindOfClass:[NSNull class]] && !zlObjectIsEmpty(dic[@"points"])) {
                int shengNum = [dic[@"points"] intValue];
                NSNumber * shengNS = [NSNumber numberWithInt:shengNum];
                [[NSUserDefaults standardUserDefaults] setObject:shengNS forKey:MEMBER_POINTS_NUM];
            }
            
            weakSelf.zaiXianName = self.currentSiFangMTLModel.name;
            if (![dic[@"video"] isEqualToString:@""] && dic[@"video"] != nil) {
                
                weakSelf.zaiXianUrl = [NSURL URLWithString:dic[@"video"]];
                //weakSelf.zaiXianUrl = [NSURL URLWithString:@"http://www.runoob.com/try/demo_source/mov_bbb.mp4"];
                [self settingPlayer];
            }
            else{
//                weakSelf.zaiXianUrl = [NSURL URLWithString:@"http://www.runoob.com/try/demo_source/mov_bbb.mp4"];
//                [self settingPlayer];
                [MBManager showBriefAlert:@"视频信息错误"];
                [weakSelf.navigationController popViewControllerAnimated:NO];
            }
            
            }
            else{
               
                [MBManager showBriefAlert:@"视频信息错误"];
                [weakSelf.navigationController popViewControllerAnimated:NO];
            }
            
        

    } failure:^(NSError *error) {
        [MBManager showBriefAlert:@"视频信息错误"];
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];

    

}

- (void)settingPlayer{
    
    // 初始化控制层view(可自定义)
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    
    // 初始化播放模型
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    // playerView的父视图
    playerModel.fatherView = self.backgroundPlayView;
    if (self.isBenDi == YES) {
        playerModel.videoURL = self.benDiUrl;
        //[NSURL URLWithString:@"http://www.runoob.com/try/demo_source/mov_bbb.mp4"];
        playerModel.title = self.benDiName;
    }
    else{
        playerModel.videoURL = self.zaiXianUrl;
        playerModel.title = self.zaiXianName;
    }
    
    //从xx秒开始播放
    //playerModel.seekTime = 10;
    //占位图
    //playerModel.placeholderImage = [UIImage imageNamed:@"icon_default"];
    //网络占位图
    // 网络图片
    //playerModel.placeholderImageURLString = @"";
    if (!zlStringIsEmpty(self.currentSiFangMTLModel.pic)) {
        playerModel.placeholderImageURLString = self.currentSiFangMTLModel.pic;
    }else{
        //占位图
        playerModel.placeholderImage = [UIImage imageNamed:@"icon_default"];
        
    }
    
    [self.playerView playerControlView:controlView playerModel:playerModel];
    // 设置代理
    self.playerView.delegate = self;
    // 自动播放
    [self.playerView autoPlayTheVideo];
    // 设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    //断点下载
    self.playerView.hasDownload = YES;
    
}
#pragma mark ZFPlayerDelegate方法
//返回按钮执行方法  代理
- (void)zf_playerBackAction{
    [self.navigationController popViewControllerAnimated:NO];
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

#pragma end mark

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
        NSLog(@"执行了播放方法");
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        NSLog(@"执行了暂停方法");
        self.isPlaying = YES;
        [self.playerView pause];
    }
}

- (void)tapBackgroundGesAction:(UITapGestureRecognizer *)sender{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark 隐藏状态栏
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)dealloc{
    NSLog(@"什么类释放了：%@",self.class);
    //[self.playerView cancelAutoFadeOutControlBar];
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
