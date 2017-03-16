//
//  HuanCunCenterViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/16.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "HuanCunCenterViewController.h"

@interface HuanCunCenterViewController (){
    
    BOOL _isEditing;
}

@end

@implementation HuanCunCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isEditing = NO;
    [self.videoARR addObjectsFromArray:@[@"1",@"3",@"2",@"4",@"5"]];
    self.selectButtonARR  = [[NSMutableArray alloc]init];
    self.buttonsZongARR = [[NSMutableArray alloc]init];
    self.tableview  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-64.0) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.title = @"缓存";
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"编辑"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self action:@selector(bianjiButtonAction:)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
}
- (NSMutableArray *)videoARR{
    
    if(!_videoARR){
        
        _videoARR = [[NSMutableArray alloc]init];
    }
    return _videoARR;
}

- (void)bianjiButtonAction:(UIBarButtonItem *)sender{
    
    NSLog(@"点击了编辑按钮");
    
    if(self.tableview.isEditing){
        _isEditing = NO;
        [self.tableview setEditing:NO animated:YES];
    }
    else{
        _isEditing = YES;
        [self.tableview setEditing:YES animated:YES];
        
    }
    
}

#pragma mark TableViewDelegate代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;//self.videoARR.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //firstTouXiangID  NormolID
    static NSString * cellID1 = @"HuanCunZlCellID";
    HuanCunZLTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    //HuanCunZLTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = (HuanCunZLTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"HuanCunZLTableViewCell" owner:self options:nil][0];
    }
    //编辑状态下不缩回
    //cell.shouldIndentWhileEditing = YES;
    //    //清除所有视图，避免显示混乱
    //    for (UIView * view in cell.contentView.subviews) {
    //        [view removeFromSuperview];
    //    }
    NSLog(@"加载单元格的行为：%ld",indexPath.row);
    [cell.leftButton02 addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.leftButton02.row = indexPath.row;
    NSNumber * num = [NSNumber numberWithInteger:indexPath.row];
    if (![self.buttonsZongARR containsObject:num]) {
        [self.buttonsZongARR addObject:num];
    }
    
    if ([self.selectButtonARR containsObject:num]) {
        NSLog(@"在已选择按钮里是否存在此按钮：存在");
        cell.leftButton02.selected = YES;
    }
    else{
        NSLog(@"不存在");
        cell.leftButton02.selected = NO;
    }
    
    if (_isEditing) {
        cell.leftButton02.hidden = NO;
    }
    else{
        cell.leftButton02.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了cell");
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCellEditingStyleDelete
    //NSLog(@"-----执行了编辑方法02");
    return UITableViewCellEditingStyleNone;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"执行了编辑方法");
    if (_isEditing) {
        HuanCunZLTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.leftButton02.hidden = NO;
    }else{
        HuanCunZLTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.leftButton02.hidden = YES;
        cell.leftButton02.selected = NO;
        [self.selectButtonARR removeAllObjects];
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"执行了编辑完成按钮");
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        NSLog(@"点击删除");
        
        //        if (indexPath.row<[self.arrayOfRows count]) {
        //            [self.arrayOfRows removeObjectAtIndex:indexPath.row];//移除数据源的数据
        //            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
        //        }
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
#pragma end mark
//左侧选择按钮执行方法
- (void)leftButtonAction:(ZLButtons *)sender{
    NSLog(@"点击了左侧按钮");
    NSNumber * num = [NSNumber numberWithInteger:sender.row];
    if (sender.isSelected) {
        sender.selected = NO;
        [self.selectButtonARR removeObject:num];
    }
    else{
        sender.selected = YES;
        [self.selectButtonARR addObject:num];
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
