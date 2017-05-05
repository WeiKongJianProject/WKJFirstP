//
//  VIPShaiXuanVCViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/4/1.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "VIPShaiXuanVCViewController.h"
#define Collection_item_Width (SIZE_WIDTH-40)/3.0
#define Collection_item_Height (SIZE_WIDTH-40)/3.0 * 386.0/225.0
@interface VIPShaiXuanVCViewController (){

    NSString * _currentType;
    NSString * _currentStory;
    NSString * _currentYear;
    NSString * _currentOrder;
    NSString * _nextPageURL;
    NSString * _currentURL;
}

@end
static int _currentPage;
static int _isFirstOpen;
static BOOL _isHaveNextPage;
static BOOL _isCanPlay;

@implementation VIPShaiXuanVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    _isFirstOpen = 1;
    //_isFirstOpen = 1;
    _currentType = @"全部";
    _currentStory = @"全部";
    _currentOrder = @"new";
    _currentYear = @"全部";
    
    self.topView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    self.collectionARR = [[NSMutableArray alloc]init];
    //[self.collectionARR addObjectsFromArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    self.firstConARR = [[NSMutableArray alloc]init];
    self.secondConARR = [[NSMutableArray alloc]init];
    self.thirdConARR = [[NSMutableArray alloc]init];
    self.fourConARR = [[NSMutableArray alloc]init];
    
    //[self startAFNetworkingWith:self.id withPage:_currentPage withJuQing:@"全部" withYear:@"全部" withType:@"全部" withOrder:@"new"];
    [self startAFNetworkingWith:self.sourceID withURL:_currentURL withType:self.type withIsNexg:NO];
    //[self settingSegmentView];
    [self settingCollectionView];
}
- (void)settingCollectionView{
    //    self.collectionView.delegate = self;
    //    self.collectionView.dataSource = self;
    [self setZLCollectionView:self.collectionView];
}


- (void)startAFNetworkingWith:(NSString *)sourceId withURL:(NSString *)urlID withType:(NSString *)type withIsNexg:(BOOL) isNextPage{
    __weak typeof(self) weakSelf = self;
    [MBManager showLoadingInView:weakSelf.view];
    
    NSString * memID = [[[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC] objectForKey:@"id"];
    //http://api4.cn360du.com:88/index.php?m=api-ios&action=lists&cate=999
    //
    NSString * url = nil;
    if (urlID == nil) {
        url = [NSString stringWithFormat:@"%@&action=vipList&source=%@&type=%@&mid=%@",URL_Common_ios,sourceId,type,memID];
    }
    else{
        url = [NSString stringWithFormat:@"%@&action=vipList&source=%@&url=%@&type=%@&mid=%@",URL_Common_ios,sourceId,urlID,type,memID];
    }
    NSLog(@"VIP筛选列表请求链接：%@",url);
    NSString * codeString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//去掉特殊字符
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:codeString parameters:nil success:^(id responseObject) {
        [MBManager hideAlert];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"第三方VIP筛选列表请求数据：%@",dic);
        NSString * isSuccess = [NSString stringWithFormat:@"%@",[dic objectForKey:@"result"]];
        if ([isSuccess isEqualToString:@"success"]) {
            _isCanPlay = [dic objectForKey:@"access"];
            _isHaveNextPage = [dic objectForKey:@"isNext"];
            NSLog(@"是否有下一页数据：%d",_isHaveNextPage);
            _nextPageURL = [dic objectForKey:@"nextPage"];
            NSArray * arr01 = [MTLJSONAdapter modelsOfClass:[VIP03VideoMTLModel03 class] fromJSONArray:[dic objectForKey:@"list"] error:nil];
            NSLog(@"arr01中个数为：%ld",arr01.count);
            if (arr01.count> 0) {
                if (isNextPage == YES) {
                    //下一页数据
                    [weakSelf.collectionARR addObjectsFromArray:arr01];
                    NSLog(@"加载了下一页数据：%ld",arr01.count);
                }
                else{
                    [weakSelf.collectionARR removeAllObjects];
                    //当前页面数据
                    weakSelf.collectionARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[VIP03VideoMTLModel03 class] fromJSONArray:[dic objectForKey:@"list"] error:nil];
                }
                [weakSelf.collectionView reloadData];
            }
            NSArray  * filterlistARR = dic[@"filterlist"];
            if (!zlArrayIsEmpty(filterlistARR)) {
                NSArray * arr02 = [dic[@"filterlist"] objectForKey:@"area"];
                if (arr02.count > 0) {
                    
                    weakSelf.secondConARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[VIPFilterListMTLModel class] fromJSONArray:arr02 error:nil];
                    
                }
                NSArray * arr03 = [dic[@"filterlist"] objectForKey:@"type"];
                if (arr03.count > 0) {
                    
                    weakSelf.thirdConARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[VIPFilterListMTLModel class] fromJSONArray:arr03 error:nil];
                    
                }
                NSArray * arr04 = [dic[@"filterlist"] objectForKey:@"year"];
                if (arr04.count > 0) {
                    
                    weakSelf.fourConARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[VIPFilterListMTLModel class] fromJSONArray:arr04 error:nil];
                    
                }
                
                if (_isFirstOpen == 1) {
                    NSLog(@"执行了几次 setSegment 方法");
                    
                    [weakSelf settingSegmentView];
                    _isFirstOpen++;
                }
            }
            else{
            
                [MBManager showBriefAlert:@"小编很懒,还没添加数据"];
            }

            
        }
        
        [weakSelf.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        //            [self.tableview.mj_header endRefreshing];
        //            [self.tableview.mj_footer endRefreshing];
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"数据加载失败"];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    
}

- (void)settingSegmentView{
    
    //NSMutableDictionary * firstDic = [[NSMutableDictionary alloc]init];
    NSMutableArray * fourSegmentARR = [[NSMutableArray alloc]init];
    NSMutableArray * secondSegmentARR = [[NSMutableArray alloc]init];
    NSMutableArray * thirdSegmentARR = [[NSMutableArray alloc]init];
    for (int i = 0; i< self.secondConARR.count; i++) {
        VIPFilterListMTLModel * model = self.secondConARR[i];
        [secondSegmentARR addObject:@{VOSegmentText:model.name}];
        NSLog(@"第一个分类的名称为：%@",model.name);
    }
    for (int i = 0; i<self.thirdConARR.count; i++) {
        VIPFilterListMTLModel * model = self.thirdConARR[i];
        [thirdSegmentARR addObject:@{VOSegmentText:model.name}];
    }
    for (int i = 0; i<self.fourConARR.count; i++) {
        //        NSString * str = [NSString stringWithFormat:@"%d",[self.thirdConARR[i] intValue]];
        //        int value = (int)self.thirdConARR[i];
        //        NSLog(@"第三个分类值为：%d",value);
        VIPFilterListMTLModel * model = self.fourConARR[i];
        [fourSegmentARR addObject:@{VOSegmentText:model.name}];
    }
    
    __weak typeof(self) weakSelf = self;
    self.sgControl01 = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"电影"},@{VOSegmentText:@"电视剧"}]];
    self.sgControl01.contentStyle = VOContentStyleTextAlone;
    self.sgControl01.selectedTextColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl01.selectedIndicatorColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl01.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    //self.sgControl01.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sgControl01.backgroundColor = [UIColor whiteColor];
    self.sgControl01.selectedBackgroundColor = self.sgControl01.backgroundColor;
    self.sgControl01.allowNoSelection = NO;
    self.sgControl01.frame = CGRectMake(0, 5, SIZE_WIDTH, 30);
    self.sgControl01.indicatorThickness = 1;
    self.sgControl01.tag = 1;
    [self.topView addSubview:self.sgControl01];
    [self.sgControl01 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        //_currentType = firstSegmentARR[index][VOSegmentText];
        _currentPage = 1;
        //__strong typeof(weakSelf) strongSelf = weakSelf;
        switch (index) {
            case 0:
                weakSelf.type = @"1";
                break;
            case 1:
                weakSelf.type = @"2";
                break;
            default:
                break;
        }
        //[weakSelf.collectionARR removeAllObjects];
        [weakSelf startAFNetworkingWith:weakSelf.sourceID withURL:nil withType:weakSelf.type withIsNexg:NO];
    }];
    [self.sgControl01 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    //第二个
    self.sgControl02 = [[VOSegmentedControl alloc] initWithSegments:secondSegmentARR];
    self.sgControl02.contentStyle = VOContentStyleTextAlone;
    self.sgControl02.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    self.sgControl02.selectedTextColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl02.selectedIndicatorColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    //self.sgControl02.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sgControl02.backgroundColor = [UIColor clearColor];
    self.sgControl02.selectedBackgroundColor = self.sgControl02.backgroundColor;
    self.sgControl02.allowNoSelection = NO;
    self.sgControl02.frame = CGRectMake(10, 40, SIZE_WIDTH-10, 20);
    self.sgControl02.indicatorThickness = 0;
    self.sgControl02.tag = 2;
    [self.sgControl02 setSelectedSegmentIndex:-1];
    [self.topView addSubview:self.sgControl02];
    [self.sgControl02 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        
        VIPFilterListMTLModel * model = weakSelf.secondConARR[index];
        _currentURL = model.id;
        //[weakSelf.collectionARR removeAllObjects];
        [weakSelf startAFNetworkingWith:weakSelf.sourceID withURL:_currentURL withType:weakSelf.type withIsNexg:NO];
    }];
    
    [self.sgControl02 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    
    self.allButton01 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allButton01 setFrame:CGRectMake(10, 40, 40, 20)];
    self.allButton01.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.allButton01 setTitle:@"全部" forState:UIControlStateNormal];
    [self.allButton01 setTitleColor:[UIColor colorWithhex16stringToColor:Main_BackgroundColor] forState:UIControlStateNormal];
    [self.allButton01 addTarget:self action:@selector(allbutton01Action:) forControlEvents:UIControlEventTouchUpInside];
    //[self.topView addSubview:self.allButton01];
    UIView * spView02 = [[UIView alloc]initWithFrame:CGRectMake(0, 61, SIZE_WIDTH, 1)];
    spView02.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    spView02.alpha = 0.8;
    [self.topView addSubview:spView02];
    
    
    self.sgControl03 = [[VOSegmentedControl alloc] initWithSegments:thirdSegmentARR];
    self.sgControl03.contentStyle = VOContentStyleTextAlone;
    self.sgControl03.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    self.sgControl03.selectedTextColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl03.selectedIndicatorColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    //self.sgControl03.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sgControl03.backgroundColor = [UIColor clearColor];
    self.sgControl03.selectedBackgroundColor = self.sgControl03.backgroundColor;
    self.sgControl03.allowNoSelection = NO;
    self.sgControl03.frame = CGRectMake(10, 75, SIZE_WIDTH-10, 20);
    self.sgControl03.indicatorThickness = 0;
    self.sgControl03.tag = 3;
    [self.sgControl03 setSelectedSegmentIndex:-1];
    [self.topView addSubview:self.sgControl03];
    [self.sgControl03 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        VIPFilterListMTLModel * model = weakSelf.thirdConARR[index];
        _currentURL = model.id;
        //[weakSelf.collectionARR removeAllObjects];
        [weakSelf startAFNetworkingWith:weakSelf.sourceID withURL:_currentURL withType:weakSelf.type withIsNexg:NO];
    }];
    [self.sgControl03 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    
    self.allButton02 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allButton02 setFrame:CGRectMake(10,75, 40, 20)];
    [self.allButton02 setTitle:@"全部" forState:UIControlStateNormal];
    self.allButton02.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.allButton02 setTitleColor:[UIColor colorWithhex16stringToColor:Main_BackgroundColor] forState:UIControlStateNormal];
    [self.allButton02 addTarget:self action:@selector(allbutton02Action:) forControlEvents:UIControlEventTouchUpInside];
    //[self.topView addSubview:self.allButton02];
    UIView * spView03 = [[UIView alloc]initWithFrame:CGRectMake(0, 96, SIZE_WIDTH, 1)];
    spView03.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    spView03.alpha = 0.8;
    [self.topView addSubview:spView03];
    
    self.sgControl04 = [[VOSegmentedControl alloc] initWithSegments:fourSegmentARR];
    self.sgControl04.contentStyle = VOContentStyleTextAlone;
    self.sgControl04.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    self.sgControl04.selectedTextColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl04.selectedIndicatorColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    //self.sgControl04.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sgControl04.backgroundColor = [UIColor clearColor];
    self.sgControl04.selectedBackgroundColor = self.sgControl04.backgroundColor;
    self.sgControl04.allowNoSelection = NO;
    self.sgControl04.frame = CGRectMake(10, 110, SIZE_WIDTH-10, 20);
    self.sgControl04.indicatorThickness = 0;
    self.sgControl04.tag = 4;
    [self.topView addSubview:self.sgControl04];
    [self.sgControl04 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        VIPFilterListMTLModel * model = weakSelf.fourConARR[index];
        _currentURL = model.id;
        //[weakSelf.collectionARR removeAllObjects];
        [weakSelf startAFNetworkingWith:weakSelf.sourceID withURL:_currentURL withType:weakSelf.type withIsNexg:NO];
        
    }];
    [self.sgControl04 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    
}

//全部按钮 执行方法
- (void)allbutton01Action:(UIButton *)sender{
    [self.sgControl02 setSelectedSegmentIndex:-1];
}
- (void)allbutton02Action:(UIButton *)sender{
    [self.sgControl03 setSelectedSegmentIndex:-1];
}

- (void)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
    NSLog(@"%@: value --> %@",@(segmentCtrl.tag), @(segmentCtrl.selectedSegmentIndex));
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
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //item 行与行的距离
    layout.minimumLineSpacing = 10;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 10;
    
    [collectionView setCollectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    //collectionView.scrollEnabled = NO;
    //注册item类型
    
    //[self.backCollectionView registerClass:[DianShiQiangCollectionCell class] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    [collectionView registerNib:[UINib nibWithNibName:@"DianYingSubCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DianYingSubCollectionCellID"];
    collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(shanglaShuaXin)];
    
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
    
    static NSString * cellId = @"DianYingSubCollectionCellID";
    DianYingSubCollectionViewCell *cell = (DianYingSubCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    VIP03VideoMTLModel03 * model = [self.collectionARR objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.name;
    cell.subNameLabel.text = model.actor;
    //[cell.smallImageVIew sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:PLACEHOLDER_IMAGE];
    
    //检测缓存中  是否存在图片
    UIImage *myCachedImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.pic];
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
        [cell.smallImageVIew sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"icon_default"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    else{
        NSLog(@"缓存中没有图片时执行方法");
        [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:model.pic] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
           // NSLog(@"处理下载进度");
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
                NSLog(@"下载有错误");
            }
            if (image) {
                //NSLog(@"下载图片完成");
                dispatch_async(dispatch_get_main_queue(), ^{
                    // switch back to the main thread to update your UI
                    [cell.smallImageVIew setImage:image];
                    //[cell layoutSubviews];
                });
                
                
                [[SDImageCache sharedImageCache] storeImage:image forKey:model.pic toDisk:NO completion:^{
                    //NSLog(@"保存到磁盘中。。。。。。");
                }];
                //图片下载完成  在这里进行相关操作，如加到数组里 或者显示在imageView上
            }
        }];
        
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
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
    //        [self.delegate firstSubVC:self withType:0 withName:@"电影" withKey:@"关键字"];
    //    }
     VIP03VideoMTLModel03 * model = [self.collectionARR objectAtIndex:indexPath.row];
//    if (_isCanPlay == YES) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(vipShaiXuanVC:withType:withName:withKey:)]) {
//            [self.delegate vipShaiXuanVC:self withType:2 withName:model.name withKey:model.url];
//        }
//    }
//    else{
//        //用户会员等级  小于  电影VIP等级
//        AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
//        alertZL.titleName = @"VIP等级不够";
//        alertZL.cancelBtnTitle = @"取消";
//        alertZL.okBtnTitle = @"升级";
//        [alertZL cancelBlockAction:^(BOOL success) {
//            [alertZL hideCustomeAlertView];
//        }];
//        [alertZL okButtonBlockAction:^(BOOL success) {
//            [alertZL hideCustomeAlertView];
//            NSLog(@"点击了去支付按钮");
//        }];
//        [alertZL showCustomAlertView];
//    }
    NSLog(@"该电影来源于：%@",model.source);
    [self startPlayAFNetWorkingwithType:self.type withSource:self.sourceID withVid:nil withIDURL:model.url withName:model.name];
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
        url = [NSString stringWithFormat:@"%@&action=vipPlay&type=%@&url=%@&mid=%@&source=%@",URL_Common_ios,type,idURL,memID,source];
    }
    NSLog(@"VIP播放页请求：%@",url);
    NSString * codeString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//去掉特殊字符
    NSLog(@"VIP播放页请求编码后：%@",codeString);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:codeString parameters:nil success:^(id responseObject) {
        [MBManager hideAlert];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"第三方VIP播放页请求数据：%@",dic);
        NSString * isSuccess = [NSString stringWithFormat:@"%@",[dic objectForKey:@"result"]];
        if ([isSuccess isEqualToString:@"success"]) {
            
            if ([dic[@"access"] intValue] != 0) {
                
                if ([type isEqualToString:@"1"]) {
                    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(vipShaiXuanVC:withType:withName:withKey:withJuJIARR:withVid:withSourceNmae:)]) {
                        [weakSelf.delegate vipShaiXuanVC:weakSelf
                                                withType:1
                                                withName:name
                                                 withKey:dic[@"url"]
                                             withJuJIARR:nil
                                                 withVid:dic[@""]
                                          withSourceNmae:source];
                    }
                }
                else{
                    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(vipShaiXuanVC:withType:withName:withKey:withJuJIARR:withVid:withSourceNmae:)]) {
                        [weakSelf.delegate vipShaiXuanVC:weakSelf
                                                withType:0
                                                withName:name
                                                 withKey:dic[@"url"]
                                             withJuJIARR:dic[@"epList"]
                                                 withVid:dic[@"vid"]
                                          withSourceNmae:source];
                    }
                }
            }
            else{
            
                        AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
                        alertZL.titleName = @"VIP等级不够";
                        alertZL.cancelBtnTitle = @"取消";
                        alertZL.okBtnTitle = @"升级";
                        [alertZL cancelBlockAction:^(BOOL success) {
                            [alertZL hideCustomeAlertView];
                        }];
                        [alertZL okButtonBlockAction:^(BOOL success) {
                            [alertZL hideCustomeAlertView];
                            [weakSelf xw_postNotificationWithName:KAITONG_VIP_NOTIFICATION userInfo:nil];
                        }];
                        [alertZL showCustomAlertView];
                
            }
            
        }
        else{
            [MBManager showBriefAlert:@"视频获取失败"];
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

- (void)shanglaShuaXin{
    if (_isHaveNextPage == YES && _nextPageURL != nil) {
        [self startAFNetworkingWith:self.sourceID withURL:_nextPageURL withType:self.type withIsNexg:YES];
    }
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
