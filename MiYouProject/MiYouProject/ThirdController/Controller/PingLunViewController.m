//
//  PingLunViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PingLunViewController.h"

@interface PingLunViewController ()

@end

static int _currentPage;

@implementation PingLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    self.title = @"评论";
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headXiaLaShuaXin)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footShuaXin)];
    [self.faSongButton addTarget:self action:@selector(faBuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self startAFNetWorkingWithid:self.id withPage:_currentPage];
}

- (void)startAFNetWorkingWithid:(NSInteger )ids withPage:(int)page{

    __weak typeof(self) weakSelf = self;
    NSString * url = [NSString stringWithFormat:@"%@&action=comment&id=%ld&page=%d",URL_Common_ios,ids,page];
    NSLog(@"评论的链接：%@",url);
    [MBManager showLoadingInView:self.view];
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"评论的数据为：%@",dic);
        if ([dic[@"result"] isEqualToString:@"success"]) {
            NSArray * arr02 = [MTLJSONAdapter modelsOfClass:[PingLunMTLModel class] fromJSONArray:dic[@"list"] error:nil];
            //NSArray * arr = [MTLJSONAdapter modelsOfClass:[PingLunMTLModel class] fromJSONArray:dic[@"list"] error:nil];
            
            if (arr02.count > 0) {
                
                [self.tableviewARR addObjectsFromArray:arr02];
                
                [self.tableView reloadData];
            }
            
        }
        [MBManager hideAlert];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    
}

- (void)headXiaLaShuaXin{
    _currentPage = 1;
    [self.tableviewARR removeAllObjects];
    [self startAFNetWorkingWithid:self.id withPage:_currentPage];
}
- (void)footShuaXin{
    _currentPage++;
    [self startAFNetWorkingWithid:self.id withPage:_currentPage];
}


#pragma mark TableviewDelegate代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tableviewARR.count;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    
    PingLunMTLModel * model = [self.tableviewARR objectAtIndex:indexPath.row];
    NSString * pingLunStr = model.content;
    CGFloat  height01 = [self textHeight:pingLunStr];
    if (height01+27.0 > 50.0) {
        height = height01 + 27.0;
    }
    else{
        height = 50.0;
    }
    
    return height;
}
//PingLunCellID
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"PingLunTableVIewCellID";
    PingLunTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = (PingLunTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"PingLunTableViewCell" owner:self options:nil][0];
    }
    PingLunMTLModel * model = self.tableviewARR[indexPath.row];
    
    
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
    NSLog(@"评论的时间为：%@",res);
    return cell;
}

#pragma end mark TableView 代理方发 结束

- (NSMutableArray *)tableviewARR{
    if (!_tableviewARR) {
        _tableviewARR = [[NSMutableArray alloc]init];
    }
    return _tableviewARR;
}

//自定义Label高度
-(CGFloat)textHeight:(NSString *)string{
    //传字符串返回高度
    CGRect rect =[string boundingRectWithSize:CGSizeMake(SIZE_WIDTH-53, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];//计算字符串所占的矩形区域的大小
    return rect.size.height;//返回高度
}

//发布评论
- (void)faBuButtonAction:(UIButton *)sender{

    //NSLog(@"发布评论");
    [self.textField resignFirstResponder];
    [self startFaBuAFNetWorkingWithid:self.id];
}
- (void)startFaBuAFNetWorkingWithid:(NSInteger )ids{
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary * memInfo = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    NSString * mid = [memInfo objectForKey:@"id"];
    
    NSString * url = [NSString stringWithFormat:@"%@&action=doComment&id=%ld&mid=%@&content=%@",URL_Common_ios,ids,mid,self.textField.text];
    NSLog(@"发布评论的链接为：%@",url);
    NSString * codeString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:codeString parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"result"] isEqualToString:@"success"]) {
           
            [MBManager showBriefAlert:dic[@"message"]];
            weakSelf.textField.text = @"";
            
        }


    } failure:^(NSError *error) {

    }];
    
    
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
