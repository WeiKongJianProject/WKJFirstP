//
//  FirstViewController.m
//  SecondProject
//
//  Created by wkj on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelARR = [[NSMutableArray alloc]init];
    //self.title = @"首页";
    //设置 tabbar 图标颜色
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //item.title
    }
    self.tabBarController.tabBar.tintColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    
    [self.itemsTitlesARR addObjectsFromArray:@[@"标题 一",@"标题二",@"标题三",@"标题四",@"标题五",@"标题五",@"标题五"]];
    //设置 ViewPagerController 代理
    
    self.dataSource = self;
    self.delegate = self;
    [self reloadData];
    
    
    
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
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UIButton * caiDanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [caiDanBtn setFrame:CGRectMake(SIZE_WIDTH-40, 20, 30, 30)];
    [caiDanBtn setTitle:@"搜索" forState:UIControlStateNormal];
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
    NSString *item = [self.itemsTitlesARR objectAtIndex:index];
    
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
    NSString * titleStr = [self.itemsTitlesARR objectAtIndex:index];
    label.text = titleStr;
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
    UIViewController *vCtrl = [[UIViewController alloc]init];
    vCtrl.view.backgroundColor = [UIColor yellowColor];
    if (index == 2) {
        vCtrl.view.backgroundColor = [UIColor redColor];
    }
    //[vCtrl setPViewCtrl:self];
    return vCtrl;

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
