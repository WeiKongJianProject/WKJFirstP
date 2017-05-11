//
//  ThirdViewController.m
//  SecondProject
//
//  Created by wkj on 2017/3/6.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "ThirdViewController.h"


#define Collection_item_Width SIZE_WIDTH
#define Collection_item_Height SIZE_WIDTH * 345.0/375.0
static int _currentPage_NEW;
static int _currentPage_HOT;
static int _is_first;
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage_NEW = 1;
    _currentPage_HOT = 1;
    _is_first = 1;
    [self.menuItems addObjectsFromArray:@[@"更新",@"热门"]];
    //self.navigationController.navigationItem.titleView = self.control;
    //[self.navigationController.navigationItem setTitleView:self.control];
    //self.navigationController.navigationBar.topItem.title=@"BS LZ";
    self.navigationController.navigationBar.topItem.titleView = self.control;
    self.control.selectedSegmentIndex = 0;
    
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"sifangshizianniu"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction:)];
    rightBarButton.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = rightBarButton;
    
    [self setZLCollectionView];
    
    [self startAFNetworkingwithPage:_currentPage_NEW withOrder:@"new"];
    //[self startAFNetworkingwithPage:_currentPage_HOT withOrder:@"hot"];
}

- (void)rightBarButtonAction:(UIBarButtonItem *)sender{
    [MBManager showBriefAlert:@"只有认证用户才能发布视频"];
}

- (void)startAFNetworkingwithPage:(int)page withOrder:(NSString *)order{
    __weak typeof(self) weakSelf = self;
    [MBManager showLoadingInView:self.view];
    NSDictionary * memDic = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    NSString * memID  = memDic[@"id"];
    NSString * url = [NSString stringWithFormat:@"%@&action=sifang&page=%d&order=%@&mid=%@",URL_Common_ios,page,order,memID];
    NSLog(@"私房链接为：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        [MBManager hideAlert];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"私房请求的数据为：%@",dic);
        if ([dic[@"result"] isEqualToString:@"success"]) {
            if ([order isEqualToString:@"new"]) {
                NSArray * arr = dic[@"list"];
                if (arr.count > 0) {
                    [weakSelf.collectionViewARR01 addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[SiFangMTLModel class] fromJSONArray:arr error:nil]];
                    //NSLog(@"私房最新数组个数为：%ld",weakSelf.collectionViewARR01.count);
                }
                if (weakSelf.control.selectedSegmentIndex == 0) {
                    [weakSelf.collectionView reloadData];
                }
                
            }
            else{
                NSArray * arr = dic[@"list"];
                if (arr.count > 0) {
                    [weakSelf.collectionViewARR02 addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[SiFangMTLModel class] fromJSONArray:arr error:nil]];
                }
                if (weakSelf.control.selectedSegmentIndex == 1) {
                    [weakSelf.collectionView reloadData];
                }

            
            }
            
        }
        [self.collectionView reloadData];
        
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    }];
    

}


#pragma mark CollectionViewCellDelegate 代理方法
//设置CollectionView
- (void)setZLCollectionView{
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
    layout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, SIZE_WIDTH, SIZE_HEIGHT-60.0f-49.0f) collectionViewLayout:layout];
    //[self.collectionView setCollectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    //collectionView.scrollEnabled = NO;
    //注册item类型
    
    //[self.backCollectionView registerClass:[DianShiQiangCollectionCell class] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SiFangCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SiFangCollectionCellID"];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(shanglaShuaXin)];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(xiaLaShaXin)];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.control.selectedSegmentIndex == 0) {
        self.collectioinViewARR = [self.collectionViewARR01 mutableCopy];
    }
    else{
        self.collectioinViewARR = [self.collectionViewARR02 mutableCopy];
    }
    NSLog(@"collectioinViewARR的个数为：%ld",self.collectioinViewARR.count);
    return self.collectioinViewARR.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"SiFangCollectionCellID";
    SiFangCollectionViewCell *cell = (SiFangCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (self.control.selectedSegmentIndex == 0) {
        self.collectioinViewARR = [self.collectionViewARR01 mutableCopy];
    }
    else{
        self.collectioinViewARR = [self.collectionViewARR02 mutableCopy];
    }
    
    SiFangMTLModel * model = [self.collectioinViewARR objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.member;
    cell.subNameLabel.text = model.name;
    //[cell.headerImageVIew sd_setImageWithURL:[NSURL URLWithString:model.avator] placeholderImage:PLACEHOLDER_IMAGE];
    //检测缓存中是否已存在图片
    UIImage *myCachedImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.avator];
    /*
     SDWebImageManager *manager = [SDWebImageManager sharedManager];
     // 取消正在下载的操作
     //[manager cancelAll];
     // 清除内存缓存
     [manager.imageCache clearMemory];
     //释放磁盘的缓存
     [manager.imageCache clearDiskOnCompletion:^{
     
     }];
     */
    
    if (myCachedImage) {
        //NSLog(@"缓存中有图片");
        [cell.headerImageVIew sd_setImageWithURL:[NSURL URLWithString:model.avator] placeholderImage:[UIImage imageNamed:@"icon_default"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    else{
        //NSLog(@"缓存中没有图片时执行方法");
        [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:model.avator] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            NSLog(@"处理下载进度");
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
                //NSLog(@"下载有错误");
            }
            if (image) {
                //NSLog(@"下载图片完成");
                dispatch_async(dispatch_get_main_queue(), ^{
                    // switch back to the main thread to update your UI
                    [cell.headerImageVIew setImage:image];
                    //[cell layoutSubviews];
                });
                
                
                [[SDImageCache sharedImageCache] storeImage:image forKey:model.avator toDisk:NO completion:^{
                    //NSLog(@"保存到磁盘中。。。。。。");
                }];
                //图片下载完成  在这里进行相关操作，如加到数组里 或者显示在imageView上
            }
        }];
        
    }

    
    
    //时间 时间戳设置
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.time longValue]];
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
    //[cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"sifang_default"]];
    
    //检测缓存中是否已存在图片
    UIImage *myCachedImage02 = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.pic];
    /*
     SDWebImageManager *manager = [SDWebImageManager sharedManager];
     // 取消正在下载的操作
     //[manager cancelAll];
     // 清除内存缓存
     [manager.imageCache clearMemory];
     //释放磁盘的缓存
     [manager.imageCache clearDiskOnCompletion:^{
     
     }];
     */
    
    if (myCachedImage02) {
        //NSLog(@"缓存中有图片");
        [cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"sifang_default"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    else{
        //NSLog(@"缓存中没有图片时执行方法");
        [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:model.pic] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            //NSLog(@"处理下载进度");
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
               // NSLog(@"下载有错误");
            }
            if (image) {
                //NSLog(@"下载图片完成");
                dispatch_async(dispatch_get_main_queue(), ^{
                    // switch back to the main thread to update your UI
                    [cell.videoImageView setImage:image];
                    //[cell layoutSubviews];
                });
                
                
                [[SDImageCache sharedImageCache] storeImage:image forKey:model.pic toDisk:NO completion:^{
                    //NSLog(@"保存到磁盘中。。。。。。");
                }];
                //图片下载完成  在这里进行相关操作，如加到数组里 或者显示在imageView上
            }
        }];
        
    }

    
    
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%d",[model.hits intValue]];
    cell.pingLunLabel.text = [NSString stringWithFormat:@"%d",[model.commentNum intValue]];
    
    cell.playButton.tag = [model.id intValue];
    cell.playButton.videoID = [model.id intValue];
    cell.playButton.sifangModel = model;
    [cell.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.pingLunButton.tag = [model.id intValue];
    [cell.pingLunButton addTarget:self action:@selector(pingLunButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
    //        [self.delegate firstSubVC:self withType:0 withName:@"电影" withKey:@"关键字"];
    //    }
    NSLog(@"点击了cell");
}
//播放按钮 执行方法
- (void)playButtonAction:(SiFangPlayButton *)sender{
    //NSLog(@"按钮的tag值为：%ld",sender.tag);
    NSDictionary * memDic = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    self.currentMemberMTLModel = [MTLJSONAdapter modelOfClass:[MemberMTLModel class] fromJSONDictionary:memDic error:nil];
    
    if ([sender.sifangModel.isBuy boolValue] == YES) {
        SiFangPlayController * vc = [[SiFangPlayController alloc]init];
        vc.mid = self.currentMemberMTLModel.id;
        vc.id = [NSString stringWithFormat:@"%d",sender.videoID];
        vc.currentSiFangMTLModel = sender.sifangModel;
        [self.navigationController pushViewController:vc animated:NO];

    }else{
        int UBpoitnts = [[[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_POINTS_NUM ] intValue];
        if (UBpoitnts < [sender.sifangModel.price intValue]) {
            __weak typeof(self) weakSelf = self;
            AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
            alertZL.titleName = @"U币余额不足";
            alertZL.cancelBtnTitle = @"取消";
            alertZL.okBtnTitle = @"充值";
            [alertZL cancelBlockAction:^(BOOL success) {
                [alertZL hideCustomeAlertView];
            }];
            [alertZL okButtonBlockAction:^(BOOL success) {
                NSLog(@"点击了去支付按钮");
                [alertZL hideCustomeAlertView];
                ChongZhiViewController * vc = [[ChongZhiViewController alloc]init];
                vc.UB_or_VIP = UB_ChongZhi;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
            [alertZL showCustomAlertView];
        }
        else{
            
            int shengNum = UBpoitnts - [sender.sifangModel.price intValue];
            NSNumber * shengNS = [NSNumber numberWithInt:shengNum];
            [[NSUserDefaults standardUserDefaults] setObject:shengNS forKey:MEMBER_POINTS_NUM];
            SiFangPlayController * vc = [[SiFangPlayController alloc]init];
            vc.mid = self.currentMemberMTLModel.id;
            vc.id = [NSString stringWithFormat:@"%d",sender.videoID];
            vc.currentSiFangMTLModel = sender.sifangModel;
            [self.navigationController pushViewController:vc animated:NO];
        }
    }
    
}
//执行 评论按钮方法
- (void)pingLunButtonAction:(UIButton *)sender{
    
    PingLunViewController * vc = [[PingLunViewController alloc]init];
    vc.id = sender.tag;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma end mark

- (void)shanglaShuaXin{
    
    if (self.control.selectedSegmentIndex == 0) {
        _currentPage_NEW++;
        [self startAFNetworkingwithPage:_currentPage_NEW withOrder:@"new"];
    }
    else{
        _currentPage_HOT++;
        [self startAFNetworkingwithPage:_currentPage_HOT withOrder:@"hot"];
    }
}
- (void)xiaLaShaXin{
    
    if (self.control.selectedSegmentIndex == 0) {
        _currentPage_NEW =1;
        [self.collectionViewARR01 removeAllObjects];
        [self startAFNetworkingwithPage:_currentPage_NEW withOrder:@"new"];
    }
    else{
        _currentPage_HOT = 1;
        [self.collectionViewARR02 removeAllObjects];
        [self startAFNetworkingwithPage:_currentPage_HOT withOrder:@"hot"];
    }
}


#pragma mark 头部 SegmentControl  方法
- (NSMutableArray *)menuItems{
    if (!_menuItems) {
        _menuItems = [[NSMutableArray alloc]init];
    }
    return _menuItems;
}

- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        
        _control.bouncySelectionIndicator = NO;
        _control.height = 44.0f;
        
        //                _control.height = 120.0f;
                        _control.width = 200.0f;
        //                _control.showsGroupingSeparators = YES;
        //                _control.inverseTitles = YES;
        _control.backgroundColor = [UIColor clearColor];
        _control.tintColor = [UIColor whiteColor];
        //                _control.hairlineColor = [UIColor purpleColor];
        _control.showsCount = NO;
        //                _control.autoAdjustSelectionIndicatorWidth = NO;
        //                _control.selectionIndicatorHeight = 4.0;
        //                _control.adjustsFontSizeToFitWidth = YES;
        
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
}

#pragma mark - ViewController Methods
- (void)addSegment:(id)sender
{
    NSUInteger newSegment = self.control.numberOfSegments;
    
    //#if DEBUG_IMAGE
    //    [self.control setImage:[UIImage imageNamed:@"icn_clock"] forSegmentAtIndex:newSegment];
    //#else
    [self.control setTitle:[@"Favorites" uppercaseString] forSegmentAtIndex:newSegment];
    //[self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:newSegment];
    //#endif
}
- (void)refreshSegments:(id)sender
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.menuItems];
    NSUInteger count = [array count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    self.menuItems = array;
    
    [self.control setItems:self.menuItems];
    [self updateControlCounts];
}

- (void)updateControlCounts
{
    //    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:0];
    //    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:1];
    //    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:2];
    
    //#if DEBUG_APPERANCE
    //    [self.control setTitleColor:kHairlineColor forState:UIControlStateNormal];
    //#endif
}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    //[self.collectionView reloadData];
    if (control.selectedSegmentIndex == 0) {
        [self.collectionView reloadData];
    }
    else{
        if (_is_first == 1) {
            [self startAFNetworkingwithPage:_currentPage_HOT withOrder:@"hot"];
            _is_first++;
        }
        else{
            [self.collectionView reloadData];
        }
        
    }
    
}
#pragma mark - DZNSegmentedControlDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}
#pragma end mark

#pragma mark 懒加载
- (NSMutableArray *)collectionViewARR01{
    if (!_collectionViewARR01) {
        _collectionViewARR01 = [[NSMutableArray alloc]init];
    }

    return _collectionViewARR01;
}
- (NSMutableArray *)collectionViewARR02{
    if (!_collectionViewARR02) {
        _collectionViewARR02 = [[NSMutableArray alloc]init];
    }
    
    return _collectionViewARR02;
}

- (NSMutableArray *)collectioinViewARR{
    if (!_collectioinViewARR) {
        _collectioinViewARR = [[NSMutableArray alloc]init];
    }
    return _collectioinViewARR;
}

#pragma end mark


- (void)loadWebView{
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 83, 30);
    leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    //self.navigationItem.leftBarButtonItem = leftBtnItem;
    // Do any additional setup after loading the view.
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    NSURL * url = [NSURL URLWithString:@"http://api4.cn360du.com:88/"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    NSLog(@"网页加载成功");
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];

}

- (void)onTap{
    NSLog(@"点击了导航栏的左侧按钮");
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
