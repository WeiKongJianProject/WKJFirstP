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
    //self.title = @"首页";
    //设置 tabbar 图标颜色
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //item.title
    }
    self.tabBarController.tabBar.tintColor = [UIColor colorWithHexString:@"#ffc034"];
    
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
    
    
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
    ZLSecondAFNetworking * zlsecond = [ZLSecondAFNetworking sharedInstance];
    [zlsecond getWithURLString:@"https://www.baidu.com" parameters:nil success:^(id responseObject) {
        //NSLog(@"请求的数据为：%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
 
    
    [self createFMDB];
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
    //[self.navigationController setNavigationBarHidden:YES];
    //[self.navigationItem setTitle:@"首页"];
    self.navigationController.navigationBar.topItem.title=@"BS LZ";
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO];
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
