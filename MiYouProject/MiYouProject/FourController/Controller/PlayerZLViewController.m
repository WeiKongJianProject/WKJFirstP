
//
//  PlayerZLViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/17.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PlayerZLViewController.h"
#define Collection_item_Width (SIZE_WIDTH-40)/3.0
#define Collection_item_Height (SIZE_WIDTH-40)/3.0 * 386.0/225.0

@interface PlayerZLViewController (){

    CGFloat  _index_0_height;
    CGFloat _index_0_height_zhanKai;
    CGFloat _index_1_height;
    CGFloat _index_2_height;
    BOOL _isZhanKai;
    
}

@end

@implementation PlayerZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingPlayer];
    [self settingTableView];
    [self.tiJiaoButton addTarget:self action:@selector(tiJiaoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tiJiaoButtonAction:(UIButton *)sender{
    [self.textField resignFirstResponder];
    self.textField.text = @"";
    [MBManager showBriefAlert:@"您的评论需要后台审核"];
    
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
    playerModel.fatherView = self.backGroundView;
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

- (void)settingTableView{
    
    _index_0_height = SIZE_WIDTH*(240.0/375.0);
    _isZhanKai = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
}
#pragma mark TableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.0f;
    if (indexPath.row == 0) {
        
        if (_isZhanKai == NO) {
            height = _index_0_height;
        }
        else{
            //height = _index_0_height
            height = _index_0_height_zhanKai;
        }
    }
    else if (indexPath.row == 1){
            height = 35.0;
    }

    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
    switch (indexPath.row) {
        case 0:{
            static NSString * cellID = @"PlayTableviewCellID";
            PlayVideoTableViewCell * cell0 = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell0) {
                cell0 = (PlayVideoTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"PlayVideoTableViewCell" owner:self options:nil][0];
                //[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            
            [cell0.moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            _index_0_height_zhanKai = [self textHeight:cell0.jianJieLabel.text] - 15 + _index_0_height ;
            if (_isZhanKai == NO) {
                //NSLog(@"行数为：%ld",cell0.jianJieLabel.numberOfLines);
                cell0.jianJieLabel.numberOfLines = 1;
            }
            else{
                cell0.jianJieLabel.numberOfLines = 0;
            }
            
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = cell0;
        }
            break;
        case 1:{
            static NSString * cellID = @"PlayTableviewCellID02";
            UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell1) {
                //cell0 = (PlayVideoTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"PlayVideoTableViewCell" owner:self options:nil][0];
                 cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            cell1.textLabel.text = @"暂时没有评论";
            cell1.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
            cell = cell1;
        }
            break;
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)moreButtonAction:(UIButton *)sender{
    NSLog(@"展开");
    if (_isZhanKai == YES) {
        _isZhanKai = NO;
        [self.tableView reloadData];
    }
    else{
        _isZhanKai = YES;
        [self.tableView reloadData];
    }
    
}
#pragma end mark

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
//自定义Label高度
-(CGFloat)textHeight:(NSString *)string{
    //传字符串返回高度
    CGRect rect =[string boundingRectWithSize:CGSizeMake(SIZE_WIDTH-69, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];//计算字符串所占的矩形区域的大小
    return rect.size.height;//返回高度
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
