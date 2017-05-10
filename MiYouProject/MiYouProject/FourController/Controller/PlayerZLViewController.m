
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
static int _isKuaiJinAction = 0;
static int _currentPage;
@implementation PlayerZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    if (self.isBenDi == YES) {
        //本地视频
        [self settingPlayer];
    }else{
        //网络视频
        //NSString * userMID = [[NSUserDefaults standardUserDefaults] objectForKey:IS_MEMBER_VIP];
        [self startAFNetworkingWithID:self.id];
    }
    
    
    [self settingTableView];
    [self.tiJiaoButton addTarget:self action:@selector(tiJiaoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.xiaZaiButton addTarget:self action:@selector(alertXiaZaiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self) weakSelf = self;
    
    [self xw_addNotificationForName:@"KUAIJINNOTIFICATION" block:^(NSNotification * _Nonnull notification) {
        NSLog(@"执行了快进按钮");
        NSString * isVIP = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_VIP_LEVEL];
        if ([isVIP isEqualToString:@"1"]) {
            
            
        }else{
            if ( _isKuaiJinAction == 0) {
                [weakSelf alertViewShow];
                _isKuaiJinAction++;
            }
        }
        
        
    }];
    
    [self startPingLunAFNetworkingWithID:self.id withPage:_currentPage];
}

- (void)alertXiaZaiButtonAction:(UIButton *)sender{
    if (self.playModel.video != nil) {
        [self zf_playerDownload:self.playModel.trial];
    }
}

//播放页 请求评论
- (void)startPingLunAFNetworkingWithID:(NSString *)keyID withPage:(int)page{
    //[MBManager showLoadingInView:self.view];
    
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults]objectForKey:MEMBER_INFO_DIC];
    NSString * userID = userInfoDic[@"id"];
    __weak typeof(self) weakSelf = self;
    //play
    NSString * urlstr = [NSString stringWithFormat:@"%@&action=comment&id=%@&page=%d",URL_Common_ios,keyID,page];
    NSLog(@"评论的链接为：%@",urlstr);
    [[ZLSecondAFNetworking sharedInstance]getWithURLString:urlstr parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //[MTLJSONAdapter modelOfClass:[PlayVideoMTLModel class] fromJSONDictionary:dic error:nil];
        if ([dic[@"result"] isEqualToString:@"success"]) {
            NSArray * arr01 = dic[@"list"];
            if (!zlArrayIsEmpty(arr01)) {
                [self.tableViewARR addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[PingLunMTLModel class] fromJSONArray:dic[@"list"] error:nil]];
                [weakSelf.tableView reloadData];
            }
            [MBManager hideAlert];
        }
        else{
            [MBManager showBriefMessage:@"评论数据加载失败" InView:self.view];
        }
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"评论请求失败"];
    }];
    
}
//播放页 视频 信息
- (void)startAFNetworkingWithID:(NSString *)keyID{
    [MBManager showLoadingInView:self.view];
    
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults]objectForKey:MEMBER_INFO_DIC];
    NSString * userID = userInfoDic[@"id"];
    __weak typeof(self) weakSelf = self;
    NSString * urlstr = [NSString stringWithFormat:@"%@&action=play&id=%@&mid=%@",URL_Common_ios,keyID,userID];
    NSLog(@"播放页请求的链接为：%@",urlstr);
    [[ZLSecondAFNetworking sharedInstance]getWithURLString:urlstr parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //[MTLJSONAdapter modelOfClass:[PlayVideoMTLModel class] fromJSONDictionary:dic error:nil];
        if ([dic[@"result"] isEqualToString:@"success"]) {
            weakSelf.playModel = (PlayVideoMTLModel *)[MTLJSONAdapter modelOfClass:[PlayVideoMTLModel class] fromJSONDictionary:dic[@"video"] error:nil];
            weakSelf.playMemberModel = [MTLJSONAdapter modelOfClass:[PlayMemberMTLModel class] fromJSONDictionary:dic[@"member"] error:nil];
            //NSString * str = [dic objectForKey:@"actor"];
            //NSLog(@"播放页请求的结果为：%@++++全部结果为：%@",weakSelf.playModel.pic,dic);
            weakSelf.videoTitleLabel.text = weakSelf.playModel.name;
            weakSelf.boFangNumLabel.text = [NSString stringWithFormat:@"%d",[weakSelf.playModel.hit intValue]];
            [weakSelf settingPlayer];//加载播放器
            [MBManager hideAlert];
            [weakSelf.tableView reloadData];
        }
        else{
            [MBManager showBriefMessage:@"数据加载失败" InView:self.view];
        }
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"请求失败"];
    }];
}

- (void)alertViewShow{
    AlertViewCustomZL  * alert = [[AlertViewCustomZL alloc]init];
    
    alert.titleName = @"需要开通VIP";
    alert.cancelBtnTitle = @"取消";
    alert.okBtnTitle = @"支付";
    [alert showCustomAlertView];
    [alert cancelBlockAction:^(BOOL success) {
        _isKuaiJinAction = 0;
        [alert hideCustomeAlertView];
    }];
    [alert okButtonBlockAction:^(BOOL success) {
        _isKuaiJinAction = 0;
    }];
    [self.view addSubview:alert];
}


- (void)tiJiaoButtonAction:(UIButton *)sender{
    if (![self.textField.text isEqualToString:@""] && self.textField.text != nil) {
        [self.textField resignFirstResponder];
        self.textField.text = @"";
        [MBManager showBriefAlert:@"评论提交成功,审核中"];
    }else{
        [self.textField resignFirstResponder];
        [MBManager showBriefAlert:@"评论不能为空！"];
    }
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
    if (self.isBenDi == YES) {
        playerModel.videoURL = self.url;
        playerModel.title = self.name;
    }
    else{
        playerModel.videoURL = [NSURL URLWithString:self.playModel.video];
        //[NSURL URLWithString:@"http://www.w3cschool.cc/try/demo_source/mov_bbb.mp4"];
        playerModel.title = self.playModel.name;
    }
    
    //从xx秒开始播放
    //playerModel.seekTime = 10;
    //占位图
    playerModel.placeholderImage = [UIImage imageNamed:@"icon_default"];
    //网络占位图
    // 网络图片
    playerModel.placeholderImageURLString = self.playModel.pic;
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
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerShuaXin)];
}

- (void)footerShuaXin{
    _currentPage++;
    [self startPingLunAFNetworkingWithID:self.id withPage:_currentPage];
}

#pragma mark TableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewARR.count;
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
    
    return 75.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     switch (indexPath.row) {
     case 0:{
     static NSString * cellID = @"PlayTableviewCellID";
     PlayVideoTableViewCell * cell0 = [tableView dequeueReusableCellWithIdentifier:cellID];
     if (!cell0) {
     cell0 = (PlayVideoTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"PlayVideoTableViewCell" owner:self options:nil][0];
     //[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
     }
     [cell0.smallImageView sd_setImageWithURL:[NSURL URLWithString:self.playModel.pic] placeholderImage:PLACEHOLDER_IMAGE];
     cell0.videoName.text = self.playModel.name;
     cell0.typeLabel.text = self.playModel.type;
     cell0.zhuYanLabel.text = self.playModel.actor;
     cell0.jianJieLabel.text = self.playModel.content;
     
     
     
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
     */
    //UITableViewCell * cell = nil;
    
    static NSString * cellID = @"PingLunTableVIewCellID";
    
    PingLunTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PingLunTableViewCell" owner:self options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PingLunMTLModel * model = self.tableViewARR[indexPath.row];
    [cell.headImageVIew sd_setImageWithURL:[NSURL URLWithString:model.avator] placeholderImage:PLACEHOLDER_IMAGE];
    cell.nameLabel.text = model.member;
    cell.contentLabel.text = model.content;
    
    //时间 时间戳设置
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    //NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[confromTimesp timeIntervalSince1970]];
    //NSDate *date = [NSDate date];
    //创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //按照什么样的格式来格式化时间
    //formatter.dateFormat = @"yyyy年MM月dd日 HH时mm分ss秒 Z";
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    //formatter.dateFormat = @"MM-dd-yyyy HH-mm-ss";
    NSString *res = [formatter stringFromDate:confromTimesp];
    cell.timeLabel.text = res;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma end mark TableViewDelegate

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
    //NSString *name = [url lastPathComponent];
    NSString *name = self.playModel.name;
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


//- (void)tiJiaoButtonAction:(UIButton *)sender{
//
//    AlertViewCustomZL  * alert = [[AlertViewCustomZL alloc]init];
//
//    alert.titleName = @"观看完整版才可以评论";
//    alert.cancelBtnTitle = @"取消";
//    alert.okBtnTitle = @"确定";
//    [alert showCustomAlertView];
//    [alert cancelBlockAction:^(BOOL success) {
//        //_isKuaiJinAction = 0;
//        [alert hideCustomeAlertView];
//    }];
//    [alert okButtonBlockAction:^(BOOL success) {
//        //_isKuaiJinAction = 0;
//        [alert hideCustomeAlertView];
//        //        [weakSelf.navigationController popViewControllerAnimated:NO];
//        //        [weakSelf xw_postNotificationWithName:KAITONG_VIP_NOTIFICATION userInfo:nil];
//        [self.textField resignFirstResponder];
//    }];
//    [self.view addSubview:alert];
//
//}


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


- (NSMutableArray *)tableViewARR{
    if (!_tableViewARR) {
        _tableViewARR = [[NSMutableArray alloc]init];
    }
    return _tableViewARR;
}
//升级VIP
- (IBAction)shengJiVIPButtonAction:(UIButton *)sender {
    ChongZhiViewController * vc = [[ChongZhiViewController alloc]init];
    vc.UB_or_VIP = VIP_ChongZhi;
    [self.navigationController pushViewController:vc animated:YES];
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
