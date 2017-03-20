//
//  DianYingSubViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/20.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "DianYingSubViewController.h"

#define Collection_item_Width (SIZE_WIDTH-40)/3.0
#define Collection_item_Height (SIZE_WIDTH-40)/3.0 * 225.0/386.0

@interface DianYingSubViewController (){

    CGFloat  _index_0_height;
    CGFloat _index_1_height;
    CGFloat _index_2_height;
    BOOL _isZhanKai;

}

@end

@implementation DianYingSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadtopView];
    _isZhanKai = NO;
    _index_0_height = 155.0f;
    _index_1_height = 85.0f;
    _index_2_height = 300.0f;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH, SIZE_HEIGHT-60) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    //self.tableview registerNib:[UINib alloc] forCellReuseIdentifier:<#(nonnull NSString *)#>
    
}


#pragma mark tableView  代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.0f;
    if (indexPath.row == 0) {
        height = _index_0_height;
    }
    else if (indexPath.row == 1){
        if (_isZhanKai == NO) {
            height = 85.0f;
        }
        else{
            height = _index_1_height+50.0f;
        }
        
    }
    else{
        height = _index_2_height;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
    switch (indexPath.row) {
        case 0:{
            static NSString * cellID = @"DianYingSubCellHeadID";
            DianYingSubTableViewCell * cell0 = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell0) {
                cell0 = (DianYingSubTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"DianYingSubTableViewCell" owner:self options:nil][0];
                //[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = cell0;
        }
            break;
        case 1:{
            static NSString * cellID = @"DianYingSubCellSecondCellID";
            DianYingSubTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell1) {
                cell1 = (DianYingSubTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"DianYingSubTableViewCell" owner:self options:nil][1];
                //[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            //cell1.jianJieLabel
            _index_1_height = [self textHeight:cell1.jianJieLabel.text];
            [cell1.zhanKaiButton addTarget:self action:@selector(zhanKaiButtonAcion:) forControlEvents:UIControlEventTouchUpInside];
            
            if (_isZhanKai == NO) {
                cell1.jianJieLabel.numberOfLines = 1;
            }
            else{
                cell1.jianJieLabel.numberOfLines = 0;
            }
            
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = cell1;
        }
            break;
        case 2:{
            static NSString * cellID = @"ThirdTableViewCellID";
            DianYingSubTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell1) {
                cell1 = (DianYingSubTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"DianYingSubTableViewCell" owner:self options:nil][2];
                //[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            
            [self setZLCollectionView:cell1.thirdCollectionView];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = cell1;
        }
            break;
        default:
            break;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
#pragma end mark
#pragma mark CollectionViewCellDelegate 代理方法
//设置CollectionView
- (void)setZLCollectionView:(UICollectionView *)collectionView{
    //创建一个Layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为
    layout.itemSize = CGSizeMake(Collection_item_Width, Collection_item_Height);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //item 行与行的距离
    layout.minimumLineSpacing = 10;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 10;
    
    
}


#pragma end mark

//展开按钮
- (void)zhanKaiButtonAcion:(UIButton *)sender{

    if (_isZhanKai == NO) {
        _isZhanKai = YES;
        [self.tableview reloadData];
    }else{
        _isZhanKai = NO;
        [self.tableview reloadData];
    }
    
}

-(CGFloat)textHeight:(NSString *)string{
    //传字符串返回高度
    CGRect rect =[string boundingRectWithSize:CGSizeMake(SIZE_WIDTH-20, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];//计算字符串所占的矩形区域的大小
    return rect.size.height;//返回高度
}

- (void)loadtopView{
    __weak typeof(self) weakSelf = self;
    NavTopCommonImage * image = [[NavTopCommonImage alloc]initWithTitle:@"电影"];
    [image loadLeftBackButtonwith:0];
    [image backButtonAction:^(BOOL succes) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:image];
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
