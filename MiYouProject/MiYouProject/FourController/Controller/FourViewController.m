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
    
    [self loadTableview];
}

- (void)loadTableview{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-49.0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark TableviewDelegate方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100.0f;
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
        
    }
    else if (indexPath == 1){
    
    
    }
    else if (indexPath == 2){
    
    
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了");
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
