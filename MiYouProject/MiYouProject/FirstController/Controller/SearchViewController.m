//
//  SearchViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/9.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SearchViewController.h"

#define SEARCH_KEY  @"sousuoLishi"
@interface SearchViewController (){

    NSString * _currentSearchTitle;
    
}

@end

static int _currentPage;

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    self.lishiARR = [[NSMutableArray alloc]init];
    self.resultARR = [[NSMutableArray alloc]init];
    [self readShuJuFromUserDefault];
    
    [self loadTopSearchView];
    [self registerForKeyboardNotifications];
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, SIZE_WIDTH, 40)];
    self.headerView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    [self.view addSubview:self.headerView];
    UILabel * souLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 30)];
    souLabel.text = @"搜索历史";
    [self.headerView addSubview:souLabel];
    UIButton * deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"sousuolajixiang"] forState:UIControlStateNormal];
    [deleteButton setFrame:CGRectMake(SIZE_WIDTH-60, 7, 27, 27)];
    [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:deleteButton];
    
    
    if (self.lishiARR.count > 0) {
        __weak typeof(self) weakSelf = self;
        self.secondView = [[MSSAutoresizeLabelFlow alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) titles:self.lishiARR selectedHandler:^(NSUInteger index, NSString *title) {
            NSLog(@"%@",title);
            [weakSelf.resultARR removeAllObjects];
            _currentPage = 1;
            _currentSearchTitle = title;
            [weakSelf startAFNetworkingWithsearchKey:title withPage:_currentPage];
        }];
        [self.view addSubview:self.secondView];
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, SIZE_WIDTH, SIZE_HEIGHT-150) style:UITableViewStylePlain];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableview];
        self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footShuaXin)];
    }else{
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, SIZE_WIDTH, SIZE_HEIGHT-100) style:UITableViewStylePlain];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableview];
    }
}
- (void)readShuJuFromUserDefault{

    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [self.lishiARR addObjectsFromArray:[userDefault arrayForKey:SEARCH_KEY]];
    
}


- (void)deleteButtonAction:(UIButton *)sender{
    
    if (self.lishiARR.count > 0) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:SEARCH_KEY];
        [self.lishiARR removeAllObjects];
        [self.secondView reloadAllWithTitles:self.lishiARR];
        self.secondView.hidden = YES;
        
        [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom);
            make.left.with.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        
        [self.tableview reloadData];
    }

}
#pragma mark tableView  代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultARR.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"lishiTableViewCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    SearchResultModel * model = self.resultARR[indexPath.row];
    NSString * key = model.name;
    
    cell.textLabel.text = key;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    //NSString  * key = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    SearchResultModel * model = [self.resultARR objectAtIndex:indexPath.row];
    
    NSString * vipLevel = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_VIP_LEVEL];
    if ([vipLevel intValue] < [model.vip intValue]) {
        WMPlayZLViewController * vc = [[WMPlayZLViewController alloc]init];
        vc.id = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        PlayerZLViewController * vc = [[PlayerZLViewController alloc]init];
        vc.id = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    
//}
#pragma end mark

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];

}
- (void)loadTopSearchView{
    __weak typeof(self) weakSelf = self;
    NavTopCommonImage * topView = [[NavTopCommonImage alloc]initWithTitle:nil];
    [topView loadLeftBackButtonwith:0];
    [topView backButtonAction:^(BOOL succes) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:topView];

    //self.searchBar.delegate = self;
    
    //添加边框和提示
    UIView   *frameView = [[UIView alloc] initWithFrame:CGRectMake(45, 25, SIZE_WIDTH-45-46, 28)] ;
    frameView.backgroundColor = [UIColor whiteColor];
    frameView.layer.cornerRadius = 4.f;
    frameView.layer.masksToBounds = YES;
    
    CGFloat H = frameView.bounds.size.height - 8;
    CGFloat imgW = H;
    CGFloat textW = frameView.bounds.size.width - imgW - 6;
    NSLog(@"textW===%f",textW);
    
    UIImageView *searchImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sousuozhou"]];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(imgW+6, 4, textW, H)];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.enablesReturnKeyAutomatically = YES;
    self.searchTextField.delegate = self;
    self.searchTextField.enabled = YES;
    self.searchTextField.placeholder = @"三生三世";
    
    [frameView addSubview:self.searchTextField];
    [frameView addSubview:searchImg];
    searchImg.frame = CGRectMake(8 , 6, imgW-6, imgW-6);
    
    self.searchTextField.textColor = [UIColor grayColor];
    self.searchTextField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    
    [topView addSubview:frameView];
    
//    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [frameView addGestureRecognizer:singleTap];

    
    
    //弹出系统键盘
    //    [_searchBar becomeFirstResponder];
    //[self.searchTextField becomeFirstResponder];
    
    
    UIBarButtonItem *returnBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(returnAction :)];
    
    NSDictionary * attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    [returnBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [returnBtn setTintColor:RGBA(131, 131, 131, 1)];
    self.navigationItem.rightBarButtonItem = returnBtn;
    
//    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@""  style:UIBarButtonItemStylePlain target:self action:@selector(returnAction :)];
//    item.title = @"";
//    item.image = backButtonImage;
//    item.width = -20;
//    self.navigationItem.leftBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:@"#F6F6F6"];
    
    
    UIButton *  searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setBackgroundColor:[UIColor clearColor]];
    [searchButton setFrame:CGRectMake(SIZE_WIDTH-45, 27, 40, H+2)];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:searchButton];
    
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    [_rootScrollView addGestureRecognizer:gestureRecognizer];
//    gestureRecognizer.cancelsTouchesInView = NO;
//    
//    _context = [NSManagedObjectContext MR_defaultContext];
//    
//    self.edgesForExtendedLayout = UIRectEdgeBottom;
//    
//    self.clearBtn.backgroundColor = RGBA(174, 142, 93, 1);
//    self.clearBtn.layer.borderWidth =1;
//    self.clearBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);//201,201,201
//    self.clearBtn.layer.cornerRadius = 4.f;
//    self.clearBtn.layer.masksToBounds = YES;

    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)registerForKeyboardNotifications
{
    
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    NSLog(@"调用了Return方法");
    [self.searchTextField resignFirstResponder];
    [self startSearch];
    return YES;
}

- (void)keyboardWasShown:(id)sender{

    NSLog(@"键盘弹出时，通知");
}

- (void)keyboardWillBeHidden:(id)sender{
    NSLog(@"键盘消失时，通知");

}

- (void)searchButtonAction:(UIButton *)sender{

    NSLog(@"点击了搜索按钮");
    [self.searchTextField resignFirstResponder];
    [self startSearch];
}

- (void)startSearch{
    NSLog(@"开始搜索的文字为：%@",self.searchTextField.text);
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [self.lishiARR addObject:self.searchTextField.text];
//    NSMutableArray *searTXT = [[NSMutableArray alloc] init];
//    if (self.lishiARR) {
//        searTXT = [self.lishiARR mutableCopy];
//    }
//    [searTXT addObject:self.searchTextField.text];
    /*
     //归档
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject: person];
     //  存储
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     [userDefaults setObject: person forKey:@"person"];
     读取代码如下：
     
     NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
     //  读取数据
     NSdData *data = [userDefaults objectForKey:@"person"];
     //  反归档
     Person *person = [NSKeyedUnarchiver unarchiveObjectWithData:data];
     
     */
    [userDefault setObject:self.lishiARR forKey:SEARCH_KEY];
    _currentPage = 1;
    _currentSearchTitle = self.searchTextField.text;
    [self.resultARR removeAllObjects];
    [self startAFNetworkingWithsearchKey:self.searchTextField.text withPage:_currentPage];
    
}

- (void)footShuaXin{

    _currentPage++;
    [self startAFNetworkingWithsearchKey:_currentSearchTitle withPage:_currentPage];
    
}

- (void)startAFNetworkingWithsearchKey:(NSString *)string withPage:(int)page{
    [MBManager showLoadingInView:self.view];
    __weak typeof(self) weakSelf = self;
    NSString * url = [NSString stringWithFormat:@"%@&action=search&keyword=%@&page=%d",URL_Common_ios,string,page];
    //NSLog(@"请求的链接为：%@",url);
    //NSString * codeString =  [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * codeString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//去掉特殊字符
    NSLog(@"编码后的搜索请求链接：%@",codeString);
    //[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]//去掉特殊字符
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:codeString parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"搜索结果：%@",dic);
        if ([dic[@"result"] isEqualToString:@"success"]) {
            NSArray * arr01 = dic[@"list"];
            if (!zlArrayIsEmpty(arr01)) {
                [weakSelf.resultARR addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[SearchResultModel class] fromJSONArray:[dic objectForKey:@"list"] error:nil]];
                if (zlArrayIsEmpty(self.resultARR)) {
                    //[MBManager showBriefAlert:@"没有搜索到相关结果"];
                }
                else{
                    [weakSelf.tableview reloadData];
                }
            }else{
            
                if (_currentPage == 1) {
                    [weakSelf.resultARR removeAllObjects];
                     [weakSelf.tableview reloadData];
                     //[MBManager showBriefAlert:@"没有搜索到相关结果"];
                }
                
            }
            
        }
        [MBManager hideAlert];
        [self.tableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [self.tableview.mj_footer endRefreshing];
    }];
    //[MBManager hideAlert];
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
