//
//  FirstViewController.m
//  SecondProject
//
//  Created by wkj on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController (){
    NSString * _newVersionURL;

}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self startBanBenInfo];//请求版本信息
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
    
    
    [self createSearchButton];
    
    __weak typeof(self) weakSelf = self;
    [self xw_addNotificationForName:TIAOZHUAN_NOTICFICATION block:^(NSNotification * _Nonnull notification) {
        NSLog(@"执行了跳转方法");
        NSDictionary * dic = notification.userInfo;
        NSString * useString = [dic objectForKey:@"index"];
        if ([useString isEqualToString:@"0"]) {
            [weakSelf setActiveTabIndex:0];
        }
        else if([useString isEqualToString:@"1"]){
            [weakSelf setActiveTabIndex:1];
        }
        else if ([useString isEqualToString:@"2"]){
            [weakSelf.tabBarController setSelectedIndex:1];
        }else if ([useString isEqualToString:@"3"]){
            [weakSelf.tabBarController setSelectedIndex:2];
        }else if ([useString isEqualToString:@"5"]){
            if (self.itemsTitlesARR.count >= 5) {
                [weakSelf setActiveTabIndex:4];
            }
            
        }else if ([useString isEqualToString:@"6"]){
            if (self.itemsTitlesARR.count >= 6) {
                [weakSelf setActiveTabIndex:5];
            }
        }
        
        
    }];
    
    //开通VIP通知
    [self xw_addNotificationForName:KAITONG_VIP_NOTIFICATION block:^(NSNotification * _Nonnull notification) {
        NSLog(@"调用了开通VIP通知");
        ChongZhiViewController * vc = [[ChongZhiViewController alloc]init];
        vc.UB_or_VIP = VIP_ChongZhi;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];

}
#pragma mark 版本信息 START
- (void)startBanBenInfo{

    __weak typeof(self) weakSelf = self;
    NSString * url = [NSString stringWithFormat:@"%@&action=version&channel=%@",URL_Common_ios,CHANNEL_ID];
    NSLog(@"版本信息URL：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"版本信息：%@",dic);
        if ([dic[@"result"] isEqualToString:@"success"]) {
            NSString * versionStr = dic[@"version"];
            if (![kAppVersion isEqualToString:versionStr]) {
                _newVersionURL = dic[@"url"];
              [weakSelf loadDownView];
            }
            //[weakSelf loadDownView];
        }
        else{
        
        }
    } failure:^(NSError *error) {
        
    }];
    

}
//加载 新版本下载页面
- (void)loadDownView{
    BanBenUIView * banView =(BanBenUIView *)[[NSBundle mainBundle]loadNibNamed:@"BanBenUIView" owner:self options:nil][0];
    [banView.imageView setImageURL:[NSURL URLWithString:XinBanBenImage]];
    [banView setFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    // 当前顶层窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 添加到窗口
    [window addSubview:banView];
    
    [banView.buttonControl addTarget:self action:@selector(newBanBenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:banView];
}
- (void)newBanBenButtonAction:(UIControl *)sender{

    NSString * strIdentifier = _newVersionURL;
    BOOL isExsit = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strIdentifier]];
        if(isExsit) {
                    //NSLog(@"App %@ installed", strIdentifier);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strIdentifier]];
        }
}


#pragma end mark


//网络请求  数据 标题
- (void)getShuJuFromAFNetworking{
    //[MBManager showLoadingInView:self.view];
    __weak typeof(self) weakSelf = self;
    
    NSString * url = nil;
    if ([self isFirstOpen] == YES) {
        url = [NSString stringWithFormat:@"%@&action=index&cate=999&page=1&fresh=1&channel=%@",URL_Common_ios,CHANNEL_ID];
    }
    else{
        url = [NSString stringWithFormat:@"%@&action=index&cate=999",URL_Common_ios];
    }
    NSLog(@"第一次请求的链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        
        //[MBManager hideAlert];
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * bannerARR = [dic objectForKey:@"banner"];
        NSArray  * cateListARR = [dic objectForKey:@"catelist"];
        NSDictionary * memberDic = [dic objectForKey:@"member"];
        NSArray * listARR = [dic objectForKey:@"list"];
        NSString * result = [dic objectForKey:@"result"];
        //NSLog(@"首页第一次加载---结果：%@++++++%@++++",result,dic);
        if ([result isEqualToString:@"success"]) {
            NSArray * arr1 = [MTLJSONAdapter modelsOfClass:[CateListMTLModel class] fromJSONArray:cateListARR error:nil];
            //self.itemsTitlesARR = arr1;
            [weakSelf.itemsTitlesARR removeAllObjects];
            [weakSelf.itemsTitlesARR addObjectsFromArray:arr1];
            
            NSArray * arr2 = [MTLJSONAdapter modelsOfClass:[HOmeBannerMTLModel class] fromJSONArray:bannerARR error:nil];
            [weakSelf.bannerARR removeAllObjects];
            [weakSelf.bannerARR addObjectsFromArray:arr2];
            
            NSArray * arr3 = [MTLJSONAdapter modelsOfClass:[VideoListMTLModel class] fromJSONArray:listARR error:nil];
            //NSLog(@"加载电影列表的个数：%ld",arr3.count);
            [weakSelf.listARR removeAllObjects];
            [weakSelf.listARR addObjectsFromArray:arr3];
            
            if (memberDic != nil && ![memberDic isKindOfClass:[NSNull class]]) {
                weakSelf.memberInfo = [MTLJSONAdapter modelOfClass:[MemberMTLModel class] fromJSONDictionary:memberDic error:nil];
                [[NSUserDefaults standardUserDefaults] setObject:memberDic forKey:MEMBER_INFO_DIC];
                NSString * vipLevel = memberDic[@"vip"];
                [[NSUserDefaults standardUserDefaults] setObject:vipLevel forKey:MEMBER_VIP_LEVEL];
                [[NSUserDefaults standardUserDefaults] setObject:memberDic[@"points"] forKey:MEMBER_POINTS_NUM];
            }
            
            [weakSelf reloadData];
        }
    } failure:^(NSError *error) {
        //[MBManager hideAlert];
        [MBManager showBriefAlert:@"数据加载失败"];
    }];
    
}


//创建 搜索 和菜单按钮
- (void)createSearchButton{
    
    UIView * shadowView = [[UIView alloc]initWithFrame:CGRectMake(SIZE_WIDTH - 40, 20, 1,40 )];
    shadowView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor alpha:0.2];
    
    CALayer * layer = [shadowView layer];
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOpacity = 0.8;
    layer.shadowOffset = CGSizeMake(-0.5, 0);
    layer.shadowRadius = 1;
    layer.masksToBounds = NO;
    
    [self.view addSubview:shadowView];
    
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(SIZE_WIDTH - 35, 20, 30, 30)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"shouyefangdajing"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UIButton * caiDanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [caiDanBtn setFrame:CGRectMake(SIZE_WIDTH - 40, 20, 30, 30)];
    [caiDanBtn setBackgroundImage:[UIImage imageNamed:@"shouyecaidanlan"] forState:UIControlStateNormal];
    [caiDanBtn addTarget:self action:@selector(caiDanBtnButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:caiDanBtn];

    
}
//搜索 按钮 执行方法
- (void)searchButtonAction:(UIButton *)sender{
    NSLog(@"点击了搜索按钮");
    SearchViewController * searchVC = [[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)caiDanBtnButtonAction:(UIButton *)sender{
    NSLog(@"点击了菜单按钮");
    //[self startBanBenInfo];//请求版本信息
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
    return self.itemsTitlesARR.count;
}
//类别-0 类别-1 添加
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index{
    CateListMTLModel *itemModel = [self.itemsTitlesARR objectAtIndex:index];
    
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
    
    ZLLabelCustom * label = [ZLLabelCustom new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15.0];
    //NSString * titleStr = [self.itemsTitlesARR objectAtIndex:index];
    label.text = itemModel.name;
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
//每个Tab对应的控制器
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    if (index == 0) {
        FirstSubViewViewController *vCtrl = [[FirstSubViewViewController alloc]init];
        vCtrl.view.backgroundColor = [UIColor whiteColor];
        vCtrl.delegate = self;
        //[vCtrl setPViewCtrl:self];
        if (index == 0) {
            vCtrl.dianYingCollectionARR = self.listARR;
            //NSLog(@"电影列表的个数dianYingCollectionARR.count:%ld",vCtrl.dianYingCollectionARR.count);
            vCtrl.lunXianImageARR = self.bannerARR;
            
        }
        CateListMTLModel *itemModel = [self.itemsTitlesARR objectAtIndex:index];
        vCtrl.id = [itemModel.id intValue];
        vCtrl.name = itemModel.name;
        return vCtrl;
    }
    else{
        SecondVC02 * vc02 = [[SecondVC02 alloc]init];
        vc02.isFromFirstVCButton = YES;
        vc02.delegate = self;
        
        return vc02;
    }

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


#pragma mark FirstSubDelegate 代理方法
- (void)firstSubVC:(FirstSubViewViewController *)viewC withType:(NSInteger)typeInt withName:(NSString *)name withKey:(NSString *)key withIsShiKan:(BOOL)isShiKan{
    
    switch (typeInt) {
        case 0:{
            DianYingSubViewController * vc = [[DianYingSubViewController alloc]init];
            vc.title = @"电影";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            ShaiXuanViewController * vc = [[ShaiXuanViewController alloc]init];
            vc.title = name;
            vc.id = [key intValue];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            
            if (isShiKan == YES) {
                WMPlayZLViewController  * vc = [[WMPlayZLViewController alloc]init];
                //vc.URLString = @"http://www.w3cschool.cc/try/demo_source/mov_bbb.mp4";
                vc.videoTitleLabel.text = name;
                NSLog(@"电影标题为：%@",name);
                vc.id = key;
                [self.navigationController pushViewController:vc animated:YES];

            }
            else{
            
                PlayerZLViewController * vc = [[PlayerZLViewController alloc]init];
                vc.name = name;
                //NSURL * url = [NSURL URLWithString:key];
                //vc.isBenDi = YES;
                //NSURL * url = [NSURL URLWithString:@"http://www.w3cschool.cc/try/demo_source/mov_bbb.mp4"];
                //vc.url = url;
                vc.id = key;
                [self.navigationController pushViewController:vc animated:YES];
            }
            //KYLocalVideoPlayVC * vc = [[KYLocalVideoPlayVC alloc]init];
            //WMPlayZLViewController
        }
            break;
        default:
            break;
    }
    

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
