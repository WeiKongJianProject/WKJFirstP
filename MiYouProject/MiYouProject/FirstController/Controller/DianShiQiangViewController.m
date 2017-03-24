//
//  DianShiQiangViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/10.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "DianShiQiangViewController.h"

@interface DianShiQiangViewController ()

@end

@implementation DianShiQiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"电视墙";
    
    [self.imageNameARR addObjectsFromArray:@[@"dianshiqiangtuijian",@"diansqiangremeng",@"dianshiqiangzuashi",@"dianshiqiangmeinv",@"dianshiqiangdianying",@"dianshiqiangdongman"]];
    
    [self.nameLabelARR addObjectsFromArray:@[@"推荐",@"热门",@"VIP",@"美女",@"电影",@"动漫"]];
    //设置CollectionView
    [self settingCollectionView];
}
//懒加载
- (NSMutableArray *)imageNameARR{

    if (!_imageNameARR) {
        _imageNameARR  = [[NSMutableArray alloc]init];
    }
    return _imageNameARR;
}
- (NSMutableArray *)nameLabelARR{

    if (!_nameLabelARR) {
        _nameLabelARR = [[NSMutableArray alloc]init];
    }
    return _nameLabelARR;
}


//设置CollectionView
- (void)settingCollectionView{

    //创建一个Layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为
    layout.itemSize = CGSizeMake((SIZE_WIDTH-40)/3.0, (SIZE_WIDTH-40)/3.0);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //item 行与行的距离
    layout.minimumLineSpacing = 10;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 10;
    
    
    //self.backCollectionView = [[UICollectionView alloc]initWithFrame:nil collectionViewLayout:layout];
    self.backCollectionView.collectionViewLayout = layout;
    self.backCollectionView.delegate = self;
    self.backCollectionView.dataSource = self;
    
    //注册item类型
    
    //[self.backCollectionView registerClass:[DianShiQiangCollectionCell class] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    [self.backCollectionView registerNib:[UINib nibWithNibName:@"DianShiQiangCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    //  注册头部脚部视图
    // [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    // 注册脚部视图
    // [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
}

#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 6;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellId = @"dianShiQiangCellId";
    DianShiQiangCollectionCell *cell = (DianShiQiangCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    switch (indexPath.row) {
        case 0:
            [cell.imageView setImage:[UIImage imageNamed:self.imageNameARR[0]]];
            cell.nameLabel.text = self.nameLabelARR[0];
            break;
        case 1:
            [cell.imageView setImage:[UIImage imageNamed:self.imageNameARR[1]]];
            cell.nameLabel.text = self.nameLabelARR[1];
            break;
        case 2:
            [cell.imageView setImage:[UIImage imageNamed:self.imageNameARR[2]]];
            cell.nameLabel.text = self.nameLabelARR[2];
            break;
        case 3:
            [cell.imageView setImage:[UIImage imageNamed:self.imageNameARR[3]]];
            cell.nameLabel.text = self.nameLabelARR[3];
            break;
        case 4:
            [cell.imageView setImage:[UIImage imageNamed:self.imageNameARR[4]]];
            cell.nameLabel.text = self.nameLabelARR[4];
            break;
        case 5:
            [cell.imageView setImage:[UIImage imageNamed:self.imageNameARR[5]]];
            cell.nameLabel.text = self.nameLabelARR[5];
            break;
        default:
            break;
    }
    /*
    UIImage * JHimage = self.dataSourceArray[indexPath.row];
    //    UIImage * JHImage = [UIImage imageNamed:imageNamed];
    cell.myImgView.image = JHimage;
    cell.close.hidden = self.isDelItem;
    cell.delegate = self;
    //    cell.backgroundColor = arcColor;
     */
    return cell;

    
    
}

#pragma end mark

#pragma mark CollectionView  的  delegete 方法
#pragma mark  定义每个UICollectionView的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return  CGSizeMake(SIZE_WIDTH/3.0,100.0f);
//}
//
//
//
//#pragma mark  定义整个CollectionViewCell与整个View的间距
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0,10, 0);//（上、左、下、右）
//}
//
//
//#pragma mark  定义每个UICollectionView的横向间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//
//#pragma mark  定义每个UICollectionView的纵向间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:{
            [self xw_postNotificationWithName:TIAOZHUAN_NOTICFICATION userInfo:@{@"index":@"0"}];
             [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case 1:{
            [self xw_postNotificationWithName:TIAOZHUAN_NOTICFICATION userInfo:@{@"index":@"1"}];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 2:{
            NSLog(@"点击了第三个视图");
            //首页
            //UITabBarController *rootViewController = (UITabBarController *)((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
           //UINavigationController * naVC = (UINavigationController *)((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
            [self xw_postNotificationWithName:TIAOZHUAN_NOTICFICATION userInfo:@{@"index":@"2"}];
            [self.navigationController popViewControllerAnimated:NO];
            
        }
            break;
        case 3:{

            [self xw_postNotificationWithName:TIAOZHUAN_NOTICFICATION userInfo:@{@"index":@"3"}];
            [self.navigationController popViewControllerAnimated:NO];
            
        }
            break;
        case 4:
        {
            [self xw_postNotificationWithName:TIAOZHUAN_NOTICFICATION userInfo:@{@"index":@"5"}];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 5:
        {
            [self xw_postNotificationWithName:TIAOZHUAN_NOTICFICATION userInfo:@{@"index":@"6"}];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma end mark



- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     //[self.navigationController setNavigationBarHidden:YES];
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
