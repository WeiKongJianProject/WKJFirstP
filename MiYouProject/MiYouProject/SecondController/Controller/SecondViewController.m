//
//  SecondViewController.m
//  SecondProject
//
//  Created by wkj on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController (){

    NSString * _totalNum;
    
    
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //_isSecondVC = YES;
    self.isSecondVC = YES;
    
    self.labelARR = [[NSMutableArray alloc]init];
    self.bannerARR = [[NSMutableArray alloc]init];
    self.listARR = [[NSMutableArray alloc]init];
    //self.title = @"首页";
    //设置 tabbar 图标颜色
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //item.title
    }
    
    for (int i = 0; i<5; i++) {
        CateListMTLModel * model = [[CateListMTLModel alloc]init];
        model.name = @"热门";
        model.id = @"1";
        [self.itemsTitlesARR addObject:model];
    }
    //请求数据
    [self getShuJuFromAFNetworking];
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    
    //设置 ViewPagerController 代理
    
    self.dataSource = self;
    self.delegate = self;
    //[self reloadData];
    
    
    
    /*
     TestDataModel *model = [MTLJSONAdapter modelOfClass:[TestDataModel class] fromJSONDictionary:dict error:nil];
     NSLog(@"%@",model);
     */
    
    /*
     [ZLAFNetworking getWithURLString:@"http://api.openweathermap.org/data/2.5/weather?lat=37.785834&lon=-122.406417&units=imperial" parameters:nil success:^(NSDictionary *successData) {
     NSLog(@"网络请求成功");
     TestMTLModel *model = [MTLJSONAdapter modelOfClass:[TestMTLModel class] fromJSONDictionary:successData error:nil];
     NSLog(@"%@",model);
     } failure:^(NSError *error) {
     NSLog(@"网络请求失败！！！！！");
     }];
     */
    //    ZLSecondAFNetworking * zlsecond = [ZLSecondAFNetworking sharedInstance];
    //    [zlsecond getWithURLString:@"https://www.baidu.com" parameters:nil success:^(id responseObject) {
    //        //NSLog(@"请求的数据为：%@",responseObject);
    //    } failure:^(NSError *error) {
    //
    //    }];
    //    [self createFMDB];
    
    
    //[self createSearchButton];
    
//    __weak typeof(self) weakSelf = self;
//    [self xw_addNotificationForName:TIAOZHUAN_NOTICFICATION block:^(NSNotification * _Nonnull notification) {
//        NSLog(@"执行了跳转方法");
//        NSDictionary * dic = notification.userInfo;
//        NSString * useString = [dic objectForKey:@"index"];
//        if ([useString isEqualToString:@"0"]) {
//            [weakSelf setActiveTabIndex:0];
//        }
//        else if([useString isEqualToString:@"1"]){
//            [weakSelf setActiveTabIndex:1];
//        }
//        else if ([useString isEqualToString:@"2"]){
//            [weakSelf.tabBarController setSelectedIndex:1];
//        }else if ([useString isEqualToString:@"3"]){
//            [weakSelf.tabBarController setSelectedIndex:2];
//        }else if ([useString isEqualToString:@"5"]){
//            [weakSelf setActiveTabIndex:4];
//        }else if ([useString isEqualToString:@"6"]){
//            [weakSelf setActiveTabIndex:5];
//        }
//        
//        
//    }];
    
}
//网络请求  数据 标题
- (void)getShuJuFromAFNetworking{
    //[MBManager showLoadingInView:self.view];
    __weak typeof(self) weakSelf = self;
    
    NSString * url = nil;
//    if ([self isFirstOpen] == YES) {
//        url = [NSString stringWithFormat:@"%@&action=index&mid=999&page=1&fresh=1",URL_Common_ios];
//    }
//    else{
    NSDictionary * memDic = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    //page为空时默认为第一页//&action=index&mid=1&level=1&playfrom=youku&hot=1&page=1
        url = [NSString stringWithFormat:@"%@&action=vip&mid=%@&page=1",URL_Common_ios,memDic[@"id"]];
//    }
    
    NSLog(@"VIP第二个控制器第一次请求的链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        
       // [MBManager hideAlert];
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"result" ] isEqualToString:@"success"]) {
            if (dic[@"member"] != nil && ![dic[@"member"] isKindOfClass:[NSNull class]]) {
               weakSelf.currentMemInfoDic = dic[@"member"];
                [[NSUserDefaults standardUserDefaults] setObject:weakSelf.currentMemInfoDic[@"vip"] forKey:MEMBER_VIP_LEVEL];
            }
            weakSelf.titleDic = dic[@"sourceList"];
            weakSelf.collectionARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[VIPVideoMTLModel class] fromJSONArray:dic[@"list"] error:nil];
            _totalNum = dic[@"total"];
            [weakSelf reloadData];
        }
    } failure:^(NSError *error) {
        //[MBManager hideAlert];
        [MBManager showBriefAlert:@"数据加载失败"];
    }];
    
}


//创建 搜索 和菜单按钮
- (void)createSearchButton{
    
    UIView * shadowView = [[UIView alloc]initWithFrame:CGRectMake(SIZE_WIDTH-80, 20, 1,40 )];
    shadowView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor alpha:0.2];
    
    CALayer * layer = [shadowView layer];
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOpacity = 0.8;
    layer.shadowOffset = CGSizeMake(-0.5, 0);
    layer.shadowRadius = 1;
    layer.masksToBounds = NO;
    
    [self.view addSubview:shadowView];
    
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(SIZE_WIDTH-75, 20, 30, 30)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"shouyefangdajing"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UIButton * caiDanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [caiDanBtn setFrame:CGRectMake(SIZE_WIDTH-40, 20, 30, 30)];
    [caiDanBtn setBackgroundImage:[UIImage imageNamed:@"shouyecaidanlan"] forState:UIControlStateNormal];
    [caiDanBtn addTarget:self action:@selector(caiDanBtnButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:caiDanBtn];
    
    
}
//搜索 按钮 执行方法
- (void)searchButtonAction:(UIButton *)sender{
    NSLog(@"点击了搜索按钮");
    SearchViewController * searchVC = [[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)caiDanBtnButtonAction:(UIButton *)sender{
    NSLog(@"点击了菜单按钮");
    
    DianShiQiangViewController * dianshiVC = [[DianShiQiangViewController alloc]init];
    
    [self.navigationController pushViewController:dianshiVC animated:YES];
    
}

//懒加载
- (NSMutableArray *)itemsTitlesARR{
    
    if (!_itemsTitlesARR) {
        _itemsTitlesARR = [[NSMutableArray alloc]init];
    }
    
    return _itemsTitlesARR;
}


//创建数据库  FMDB
- (void)createFMDB{
    //测试 创建FMDB 数据库
    FMDB_ZL * fmdbzl = [FMDB_ZL sharedInstance];
    //1.创建数据库
    FMDatabase *db = [fmdbzl createDBwithName:@"secondFMDB"];
    //2.查询路径
    NSString * lujingStr = [fmdbzl dbLuJing:@"secondFMDB"];
    //创建表
    [fmdbzl createDbTablewithTableName:@"t_lishi" withDB:db withSQLiteInfo:@"CREATE TABLE IF NOT EXISTS t_lishi (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL);"];
    //插入数据
    [fmdbzl insertTableWithDBlujing:lujingStr withSQLiteInfo:@"INSERT INTO t_lishi(name) VALUES (?);" withCanSHu01:@"周周周周" withCanShu02:nil withCanShu03:nil withCanShu04:nil];
    //删除数据
    [fmdbzl deleteTableWithDBlujing:lujingStr withSQLiteInfo:@"delete from t_lishi where id = ?;"withCanSHu01:@"9" withCanShu02:nil withCanShu03:nil withCanShu04:nil];
    //更新数据
    [fmdbzl updateTableWithDBlujing:lujingStr withSQLiteInfo:@"update t_lishi set name = ? where name = ?;" withCanSHu01:@"zhouwang" withCanShu02:@"wang" withCanShu03:nil withCanShu04:nil];
    //查询数据
    FMResultSet * result = [fmdbzl chaXunQueryTableWWithDBlujing:lujingStr withSQLiteInfo:@"SELECT * FROM t_lishi"];
    while ([result next]) {
        NSString *name = [result stringForColumn:@"name"];
        int id = [result intForColumn:@"id"];
        NSLog(@"查询数据库中的数据为：%d-----%@----",id,name);
    }
}

- (void)btnAction:(UIButton *)senbder{
    
    SecondViewController * secVC = [[SecondViewController alloc]init];
    
    [self.navigationController pushViewController:secVC animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    //[self.navigationItem setTitle:@"首页"];
    //self.navigationController.navigationBar.topItem.title=@"BS LZ";
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO];
}

#pragma mark ViewPagerController代理  实现方法
//Tab数量
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager{
    NSLog(@"数组的数量为：%ld",self.itemsTitlesARR.count);
    return self.titleDic.allKeys.count+1;
}
//类别-0 类别-1 添加
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index{
    //CateListMTLModel *itemModel = [self.titleDic objectAtIndex:index];
    
    //    UILabel *label = [UILabel new];
    //    label.backgroundColor = [UIColor clearColor];
    //    label.font = [UIFont fontWithName:EN_FONT_LIGHT size:13.0f];
    //    //[UIFont systemFontOfSize:13.0];
    //    if (item) {
    //        label.text = item;
    //    }
    //    label.textAlignment = NSTextAlignmentCenter;
    //    label.textColor = [UIColor colorWithhex16stringToColor:@"f4f4f4"];
    //    [label sizeToFit];
    if (index == 0) {
        ZLLabelCustom * label = [ZLLabelCustom new];
        
        
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = @"VIP电影";
        //NSString * titleStr = [self.itemsTitlesARR objectAtIndex:index];
        //label.text = itemModel.name;
        //label.text = [NSString stringWithFormat:@"全球购%ld", index];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithhex16stringToColor:@"606060"];
        [label sizeToFit];
        
        [_labelARR addObject:label];
        
        label.spView  = [[UIView alloc]initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y+21, label.frame.size.width, 1)];
        label.spView.backgroundColor = [UIColor whiteColor];
        label.spView.hidden = YES;
        [label addSubview:label.spView];
        return label;
    }
    else{
        NSString * titleString = [self.titleDic.allValues objectAtIndex:index-1];
        ZLLabelCustom * label = [ZLLabelCustom new];
        
        
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = titleString;
        //NSString * titleStr = [self.itemsTitlesARR objectAtIndex:index];
        //label.text = itemModel.name;
        //label.text = [NSString stringWithFormat:@"全球购%ld", index];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithhex16stringToColor:@"606060"];
        [label sizeToFit];
        
        [_labelARR addObject:label];
        
        label.spView  = [[UIView alloc]initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y+21, label.frame.size.width, 1)];
        label.spView.backgroundColor = [UIColor whiteColor];
        label.spView.hidden = YES;
        [label addSubview:label.spView];
        return label;
    
    }

}
//每个Tab对应的控制器
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    
    if (index == 0) {
        SecondVC02 * vc = [[SecondVC02 alloc]init];
        vc.numLabelText = _totalNum;
        NSLog(@"++++片库为：%@",_totalNum);
        vc.collectionViewARR = [self.collectionARR mutableCopy];
        vc.delegate = self;
        return vc;
    }
    else{
        
        NSString * sourceID = [self.titleDic.allKeys objectAtIndex:index-1];
        
        VIPShaiXuanVCViewController * vc = [[VIPShaiXuanVCViewController alloc]init];
        vc.delegate = self;
        vc.sourceID = sourceID;
        vc.type = @"1";
        
        return vc;
    }
    
//    FirstSubViewViewController *vCtrl = [[FirstSubViewViewController alloc]init];
//    vCtrl.view.backgroundColor = [UIColor whiteColor];
//    vCtrl.delegate = self;
//    //[vCtrl setPViewCtrl:self];
//    if (index == 0) {
//        vCtrl.dianYingCollectionARR = self.listARR;
//        //NSLog(@"电影列表的个数dianYingCollectionARR.count:%ld",vCtrl.dianYingCollectionARR.count);
//        vCtrl.lunXianImageARR = self.bannerARR;
//    }
//    CateListMTLModel *itemModel = [self.itemsTitlesARR objectAtIndex:index];
//    vCtrl.id = [itemModel.id intValue];
//    vCtrl.name = itemModel.name;
//    return vCtrl;
}
//代理实现方法
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    CGFloat result = 0.0;
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            result = 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            result = 0.0;
            break;
        case ViewPagerOptionTabLocation:
            result = 1.0;
            break;
        case ViewPagerOptionTabWidth:
            result = self.view.frame.size.width / 5;
            break;
        default:
            result = value;
            break;
    }
    
    return result;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [UIColor redColor];
            break;
        case ViewPagerContent:
            return [UIColor whiteColor];
            break;
        case ViewPagerTabsView:
            return [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
            break;
        default:
            break;
    }
    
    return color;
}

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index{
    
    for (ZLLabelCustom * lab in _labelARR) {
        lab.spView.hidden = YES;
        lab.textColor = [UIColor colorWithhex16stringToColor:@"606060"];
    }
    
    ZLLabelCustom * label = (ZLLabelCustom *)[_labelARR objectAtIndex:index];
    self.currentLabel = label;
    label.spView.hidden = NO;
    label.textColor = [UIColor whiteColor];
    
    
}

#pragma end mark


//- (NSMutableArray *)labelARR{
//
//    if (!_labelARR) {
//        _labelARR = [[NSMutableArray alloc]init];
//    }
//    return _labelARR;
//}


#pragma mark SecondSubDelegate 代理方法
- (void)secondVC02:(SecondVC02 *)viewController withType:(int)typeInd withName:(NSString *)name withKey:(NSString *)keyId withIsShiKan:(BOOL)isShiKan{
    switch (typeInd) {
        case 0:{
            DianYingSubViewController * vc = [[DianYingSubViewController alloc]init];
            vc.title = @"电影";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            ShaiXuanViewController * vc = [[ShaiXuanViewController alloc]init];
            vc.title = name;
            vc.id = [keyId intValue];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            if (isShiKan == YES) {
                WMPlayZLViewController * vc = [[WMPlayZLViewController alloc]init];
                vc.id = keyId;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                PlayerZLViewController * vc = [[PlayerZLViewController alloc]init];
                vc.name = name;
                //NSURL * url = [NSURL URLWithString:key];
                //vc.url = url;
                vc.id = keyId;
                [self.navigationController pushViewController:vc animated:YES];
            }
            

        }
            break;
        default:
            break;
    }

}


#pragma end mark
#pragma mark VIPShaiXuanDelegate代理方法
- (void)vipShaiXuanVC:(VIPShaiXuanVCViewController *)class
             withType:(int)typeInd withName:(NSString *)name
              withKey:(NSString *)keyId
          withJuJIARR:(NSArray *)arr withVid:(NSString *)vid
       withSourceNmae:(NSString *)sourceName{
    
    SanVIPPlayViewController * vc = [[SanVIPPlayViewController alloc]init];
    vc.zaiXianName = name;

    if(typeInd == 1){
        vc.collecctionViews.hidden = YES;
        //NSURL * url = [NSURL URLWithString:key];
        //vc.url = url;
        if (!zlObjectIsEmpty(keyId)) {
            if (![keyId isEqualToString:@""] && keyId != nil) {
                NSURL * urld = [NSURL URLWithString:keyId];
                vc.zaiXianUrl = urld;
            }
        }

        
    }
    else{
        vc.collecctionViews.hidden = NO;
        vc.collectionARR = (NSMutableArray *)arr;
        if (!zlObjectIsEmpty(keyId)) {
            if (![keyId isEqualToString:@""] && keyId != nil) {
                NSURL * urld = [NSURL URLWithString:keyId];
                vc.zaiXianUrl = urld;
            }
        }
        vc.vid = vid;
    }
    vc.sourceName = sourceName;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)vipShaiXuanVC:(VIPShaiXuanVCViewController *)class withTypeChongZhi:(int)type{


}


#pragma end mark


#pragma mark 是否是第一次登录
- (BOOL)isFirstOpen{
    BOOL isFirst;
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:IS_FIRST_OPEN];
    if (str != nil && ![str isEqualToString:@""] && ![str isKindOfClass:[NSNull class]]) {
        isFirst = NO;
    }else{
        isFirst = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"user" forKey:IS_FIRST_OPEN];
    }
    
    return isFirst;
}
#pragma end mark


/*
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
*/
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
/*
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
*/
/*
- (void)btnAction:(UIButton *)sender{

    AlertViewCustomZL * alertView = [[AlertViewCustomZL alloc]init];
   
    alertView.titleName = @"需要支付1999U";
    alertView.cancelBtnTitle = @"取消";
    alertView.okBtnTitle = @"支付";
     [alertView showCustomAlertView];
    [alertView cancelBlockAction:^(BOOL success) {
        [alertView hideCustomeAlertView];
    }];
    [alertView okButtonBlockAction:^(BOOL success) {
        [alertView hideCustomeAlertView];
    }];
}
*/
/*
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:NO];
    //self.navigationItem.title = @"KSMainView";
    //self.navigationController.navigationBar.topItem.title=@"测试二";
     //self.tabBarController.navigationItem.title = @"正解";
}
*/
#pragma mark 自定义AlertController 代理方法


#pragma end mark


- (NSDictionary *)currentMemInfoDic{

    if (!_currentMemInfoDic) {
        _currentMemInfoDic = [[NSDictionary alloc]init];
    }
    return _currentMemInfoDic;
}
- (NSDictionary *)titleDic{
    if (!_titleDic) {
        _titleDic = [[NSDictionary alloc]init];
    }
    return _titleDic;
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
