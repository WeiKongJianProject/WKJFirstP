//
//  FourViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/8.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "FourViewController.h"


@interface FourViewController (){

    
    CGFloat _index_0_height;//295.0/675.0
    CGFloat _index_1_height;
    CGFloat _index_2_height;

}

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _index_0_height = SIZE_WIDTH*(295.0/675.0);
    _index_1_height = SIZE_WIDTH*(50.0/325.0);
    [self loadTableview];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
}
- (void)loadTableview{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-49.0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    [self.view addSubview:self.tableView];
    
}
#pragma mark TableviewDelegate方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.0f;
    if (indexPath.row == 0) {
        height = _index_0_height;
    }
    else if (indexPath.row == 1){
        height = 50.0f;
    }
    else{
        height = 60.0f;
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"PersonCenterCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor redColor];
    if (indexPath.row == 0) {
        static NSString * headerCellID = @"HeadCellID";
       cell = (PersonHederTableViewCell *)[tableView dequeueReusableCellWithIdentifier:headerCellID];
        if (!cell) {
            cell = (PersonHederTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"PersonHederTableViewCell" owner:self options:nil][0];
        }
        
//        //设置圆角
//        cellhead.headerImageVIew.layer.cornerRadius = cellhead.imageView.frame.size.width / 2;
//        //将多余的部分切掉
//        cellhead.headerImageVIew.layer.masksToBounds = YES;
        
    }
    else if (indexPath.row == 1){
    //  325/50  ButtonsCellID
        static NSString * buttonCellID = @"ButtonsCellID";
        ButtonsTableViewCell * fcell = (ButtonsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ButtonsTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ButtonsTableViewCell" owner:self options:nil][0];
        }
        [fcell.firstButtonControl addTarget:self action:@selector(firstButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [fcell.secondButtonCOntrol addTarget:self action:@selector(secondButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [fcell.thirdButtonControl addTarget:self action:@selector(thirdButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell = fcell;
    }
    else if (indexPath.row == 2){
    
        static NSString * buttonCellID = @"ThirdTeQuanTableViewCellID";
        ThirdTeQuanTableViewCell * fcell = (ThirdTeQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ThirdTeQuanTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ThirdTeQuanTableViewCell" owner:self options:nil][0];
        }
        
        
        cell = fcell;
    
    }
    else if (indexPath.row == 3){
        
        static NSString * buttonCellID = @"ThirdTeQuanTableViewCellID";
        ThirdTeQuanTableViewCell * fcell = (ThirdTeQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ThirdTeQuanTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ThirdTeQuanTableViewCell" owner:self options:nil][0];
        }
        fcell.nameLabel.text = @"我的钱包";
        [fcell.leftImageView setImage:[UIImage imageNamed:@"wodeqianbao"]];
        fcell.aiQiYiButton.hidden = YES;
        fcell.youKuButton.hidden = YES;
        fcell.leShiButton.hidden = YES;
        fcell.tuDouButton.hidden = YES;
        fcell.mangGuoButton.hidden = YES;
        fcell.souHuButton.hidden = YES;
        
        cell = fcell;
        
    }
    else if (indexPath.row == 4){
        
        static NSString * buttonCellID = @"ThirdTeQuanTableViewCellID";
        ThirdTeQuanTableViewCell * fcell = (ThirdTeQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ThirdTeQuanTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ThirdTeQuanTableViewCell" owner:self options:nil][0];
        }
        fcell.nameLabel.text = @"离线中心";
        [fcell.leftImageView setImage:[UIImage imageNamed:@"wodeqianbao"]];
        fcell.aiQiYiButton.hidden = YES;
        fcell.youKuButton.hidden = YES;
        fcell.leShiButton.hidden = YES;
        fcell.tuDouButton.hidden = YES;
        fcell.mangGuoButton.hidden = YES;
        fcell.souHuButton.hidden = YES;
        
        cell = fcell;
        
    }
    else if (indexPath.row == 5){
        
        static NSString * buttonCellID = @"ThirdTeQuanTableViewCellID";
        ThirdTeQuanTableViewCell * fcell = (ThirdTeQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ThirdTeQuanTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ThirdTeQuanTableViewCell" owner:self options:nil][0];
        }
        fcell.nameLabel.text = @"设置";
        [fcell.leftImageView setImage:[UIImage imageNamed:@"wodeqianbao"]];
        fcell.aiQiYiButton.hidden = YES;
        fcell.youKuButton.hidden = YES;
        fcell.leShiButton.hidden = YES;
        fcell.tuDouButton.hidden = YES;
        fcell.mangGuoButton.hidden = YES;
        fcell.souHuButton.hidden = YES;
        
        cell = fcell;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了");
    if (indexPath.row == 3) {
        MyYuEViewController * yuEVC = [[MyYuEViewController alloc]init];
        [self.navigationController pushViewController:yuEVC animated:YES];
    }
    if (indexPath.row == 0) {
        
    }
    if (indexPath.row == 4) {
        
    }
    if (indexPath.row == 5) {
        SettingViewController * setVC = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
    
}

#pragma end mark
//三个按钮组的执行方法
- (void)firstButtonAction:(UIControl *)sender{
    NSLog(@"执行了消息按钮");
}
- (void)secondButtonAction:(UIControl *)sender{
    NSLog(@"执行了充值UB按钮");
}
- (void)thirdButtonAction:(UIControl *)sender{
    NSLog(@"执行了VIP按钮");
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
