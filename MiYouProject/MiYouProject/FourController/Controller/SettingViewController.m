//
//  SettingViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-64.0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark TableViewDelegate代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"SettingCellID";
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (SettingTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"SettingTableViewCell" owner:self options:nil][0];
    }
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            [cell.leftImageViews setImage:[UIImage imageNamed:@"mianzeshengming"]];
            cell.nameLabel.text = @"免责声明";
            break;
        case 2:
            [cell.leftImageViews setImage:[UIImage imageNamed:@"guanyuwomeng"]];
            cell.nameLabel.text = @"关于我们";
            break;
        case 3:
            [cell.leftImageViews setImage:[UIImage imageNamed:@"yijianfankui"]];
            cell.nameLabel.text = @"意见反馈";
            break;
        default:
            break;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了cell");
    switch (indexPath.row) {
        case 0:
        {
            RenZhengViewController * vc = [[RenZhengViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            AboutUSViewController * vc = [[AboutUSViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            GuanYuUSViewController * vc = [[GuanYuUSViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 3:{
            YiJianViewController * vc = [[YiJianViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }

            
            break;
        default:
            break;
    }
}

#pragma end mark

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"设置";
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
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
