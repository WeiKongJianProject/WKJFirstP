//
//  SanVIPPlayViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/4/7.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SanVIPPlayViewController.h"

@interface SanVIPPlayViewController ()

@end
#define Collection_item_Width (SIZE_WIDTH)/6.0
#define Collection_item_Height (SIZE_WIDTH)/6.0
@implementation SanVIPPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blackColor];
    
    //UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackgroundGesAction:)];
    //[self.view addGestureRecognizer:tap];
    
    
//    if (self.isBenDi == YES) {
//        [self settingPlayer];
//    }
//    else{
//        //[self startWatchPlayWithID:self.id withMID:self.mid];
//    }
//    
    [self settingPlayer];
    [self setZLCollectionView:self.collecctionViews];
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
    self.zfPlayerModel = [[ZFPlayerModel alloc] init];
    // playerView的父视图
    self.zfPlayerModel.fatherView = self.backgroundPlayView;
    if (self.isBenDi == YES) {
        self.zfPlayerModel.videoURL = self.benDiUrl;
        //[NSURL URLWithString:@"http://www.runoob.com/try/demo_source/mov_bbb.mp4"];
        self.zfPlayerModel.title = self.benDiName;
    }
    else{
        self.zfPlayerModel.videoURL = self.zaiXianUrl;
        self.zfPlayerModel.title = self.zaiXianName;
    }
    
    //从xx秒开始播放
    //playerModel.seekTime = 10;
    //占位图
    self.zfPlayerModel.placeholderImage = [UIImage imageNamed:@"icon_default"];
    //网络占位图
    // 网络图片
    //playerModel.placeholderImageURLString = @"";
//    if (!zlStringIsEmpty(self.currentSiFangMTLModel.pic)) {
//        playerModel.placeholderImageURLString = self.currentSiFangMTLModel.pic;
//    }else{
//        //占位图
//        playerModel.placeholderImage = [UIImage imageNamed:@"icon_default"];
//        
//    }
    
    [self.playerView playerControlView:controlView playerModel:self.zfPlayerModel];
    // 设置代理
    self.playerView.delegate = self;
    // 自动播放
    [self.playerView autoPlayTheVideo];
    // 设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    //断点下载
    //self.playerView.hasDownload = YES;
    
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

#pragma mark CollectionViewCellDelegate 代理方法
//设置CollectionView
- (void)setZLCollectionView:(UICollectionView *)collectionView{
    //创建一个Layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为
    layout.itemSize = CGSizeMake(Collection_item_Width, Collection_item_Height);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //item 行与行的距离
    layout.minimumLineSpacing = 0;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 0;
    
    [collectionView setCollectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //collectionView.backgroundColor = [UIColor whiteColor];
    
    //collectionView.scrollEnabled = NO;
    //注册item类型
    //[self.backCollectionView registerClass:[DianShiQiangCollectionCell class] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    [collectionView registerNib:[UINib nibWithNibName:@"XuanJiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XuanJiCellID"];
    //collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(shanglaShuaXin)];
    
}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"self.collectionARR.count的个数为：%ld",self.collectionARR.count);
    return self.collectionARR.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"XuanJiCellID";
    XuanJiCollectionViewCell *cell = (XuanJiCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    
    NSDictionary * dic = (NSDictionary *)[self.collectionARR objectAtIndex:indexPath.row];
    if (!zlDictIsEmpty(dic)) {
        cell.numLabel.text = dic[@"name"];
    }
    
    /*
     UIImage * JHimage = self.dataSourceArray[indexPath.row];
     //    UIImage * JHImage = [UIImage imageNamed:imageNamed];
     cell.myImgView.image = JHimage;
     cell.close.hidden = self.isDelItem;
     cell.delegate = self;
     //    cell.backgroundColor = arcColor;
     */
    
    
    return cell;
    
    
    
}

#pragma end mark
#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //[self startPlayAFNetWorkingwithType:self.type withSource:self.sourceID withVid:nil withIDURL:model.url withName:model.name];
    [self.playerView pause];
   
    
    NSDictionary * dic = self.collectionARR[indexPath.row];
    
    //NSString * vid = [NSString stringWithFormat:@"%@",dic[@"vid"]];
    NSString * urlid = dic[@"url"];
    NSLog(@"选择了第几集：%ld++++%@",indexPath.row,urlid);
    [self startPlayAFNetWorkingwithType:@"2" withSource:self.sourceName withVid:self.vid withIDURL:urlid withName:self.zaiXianName];
}

//请求 VIP 第三方播放页
- (void)startPlayAFNetWorkingwithType:(NSString *)type withSource:(NSString *)source withVid:(NSString *)vid withIDURL:(NSString *)idURL withName:(NSString *)name{
    
    __weak typeof(self) weakSelf = self;
    [MBManager showLoadingInView:weakSelf.view];
    NSString * memID = [[[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC] objectForKey:@"id"];
    //http://api4.cn360du.com:88/index.php?m=api-ios&action=lists&cate=999
    NSString * url = nil;
    if ([type isEqualToString:@"1"]) {
        url = [NSString stringWithFormat:@"%@&action=vipPlay&type=%@&url=%@&mid=%@&source=%@",URL_Common_ios,type,idURL,memID,source];
    }
    else{
        url = [NSString stringWithFormat:@"%@&action=vipPlay&type=%@&url=%@&mid=%@&source=%@&vid=%@",URL_Common_ios,type,idURL,memID,source,vid];
    }
    NSLog(@"VIP播放页请求：%@",url);
    NSString * codeString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//去掉特殊字符
    NSLog(@"VIP播放页请求编码后：%@",codeString);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:codeString parameters:nil success:^(id responseObject) {
        [MBManager hideAlert];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"第三方  电视剧  VIP播放页请求数据：%@",dic);
        if ([dic[@"result"] isEqualToString:@"success"]) {
            if (!zlObjectIsEmpty(dic[@"url"])) {
                weakSelf.zfPlayerModel.videoURL = [NSURL URLWithString:dic[@"url"]];
                 [weakSelf.playerView resetToPlayNewVideo:weakSelf.zfPlayerModel];
                //[weakSelf.playerView play];
            }
        }
        else{
         [MBManager showBriefAlert:@"数据加载失败"];
        }
    } failure:^(NSError *error) {
        //            [self.tableview.mj_header endRefreshing];
        //            [self.tableview.mj_footer endRefreshing];
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"数据加载失败"];
    }];
}


#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma end mark


- (void)dealloc{
    NSLog(@"什么类释放了：%@",self.class);
    //[self.playerView cancelAutoFadeOutControlBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)collectionARR{
    if (!_collectionARR) {
        _collectionARR = [[NSMutableArray alloc]init];
    }
    return _collectionARR;
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
