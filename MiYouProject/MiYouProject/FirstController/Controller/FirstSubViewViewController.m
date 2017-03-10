//
//  FirstSubViewViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/10.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "FirstSubViewViewController.h"

@interface FirstSubViewViewController (){

    BOOL _Tend;
    CGFloat _index_0_height;
    CGFloat _index_1_height;
    CGFloat _index_2_height;
    CGFloat _index_3_height;
}

@end

@implementation FirstSubViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index_0_height = 315.0/560.0*SIZE_WIDTH;
    // Do any additional setup after loading the view from its nib.
    self.lunXianImageARR = [[NSMutableArray alloc]init];
    [self.lunXianImageARR addObjectsFromArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489137038151&di=f8359be9591004374d8585189541c241&imgtype=0&src=http%3A%2F%2Fpic.365j.com%2Farticle%2Fimage%2F201702%2F23%2F6084932905.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489137038151&di=a486e7d292f3ea0fbd1d6039e2c337c6&imgtype=0&src=http%3A%2F%2Fimg3.cache.netease.com%2Fent%2F2014%2F7%2F22%2F201407221029266b582.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489137038151&di=4c58da342c002a67215c2824e2e0ecfb&imgtype=0&src=http%3A%2F%2Fwww.qulishi.com%2Fuploads%2Fnews%2F201603%2F1456823338865420.png"]];
    
    [self loadTopLunXianView];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(handleSchedule) userInfo:nil repeats:YES];
    
    [self loadRemenView];
    [self loadDianYingCollectionView];
    
}

- (void)loadTopLunXianView{
    //560/315
    
    self.lunXianBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 315.0/560.0*SIZE_WIDTH)];
    self.lunXianBackgroundView.backgroundColor = [UIColor whiteColor];
    
    [self.scrollViewBack addSubview:self.lunXianBackgroundView];
    
    
    self.lunXianScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 315.0/560.0*SIZE_WIDTH)];
    self.lunXianScrollView.delegate = self;
    self.lunXianScrollView.showsVerticalScrollIndicator = NO;
    self.lunXianScrollView.showsHorizontalScrollIndicator = NO;
    //[self.lunXianScrollView setContentSize:CGSizeMake(SIZE_WIDTH*3, 315.0/560.0*SIZE_WIDTH)];
    self.lunXianScrollView.backgroundColor  = [UIColor whiteColor];
    self.lunXianScrollView.bounces = NO;
    self.lunXianScrollView.pagingEnabled = YES;
    
    [self.lunXianBackgroundView addSubview:self.lunXianScrollView];

    self.lunXianPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SIZE_WIDTH-100, 315.0/560.0*SIZE_WIDTH-20, 80, 20)];
    self.lunXianPageControl.userInteractionEnabled = YES;
    
    [self.lunXianBackgroundView addSubview:self.lunXianPageControl];
    
    [self loadLunXianImage];

    
}
//加载 沦陷图片
- (void)loadLunXianImage{
    CGFloat imageScrollViewWidth = SIZE_WIDTH;
    CGFloat imageScrollViewHeight = self.lunXianScrollView.bounds.size.height;
    for (int i=0; i<self.lunXianImageARR.count; i++) {
        UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(imageScrollViewWidth*i, 0, imageScrollViewWidth,imageScrollViewHeight)];
        //NSString * urlStr = self.lunXianImageARR[i][@"imgurl"];
        
//        if ([urlStr hasSuffix:@"webp"]) {
//            [imageview setZLWebPImageWithURLStr:urlStr withPlaceHolderImage:PLACEHOLDER_IMAGE];
//        } else {
            [imageview sd_setImageWithURL:[NSURL URLWithString:self.lunXianImageARR[i]] placeholderImage:[UIImage imageNamed:@"icon_default"]];
//        }
        //NSLog(@"imageview == %@",imageview.sd_imageURL);
        
        // imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.tag = i;
        imageview.userInteractionEnabled = YES;
        //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)];
        //[imageview addGestureRecognizer:singleTap];
        [self.lunXianScrollView addSubview:imageview];
    }
    self.lunXianScrollView.contentSize = CGSizeMake(imageScrollViewWidth*self.lunXianImageARR.count, 0);
    
    self.lunXianPageControl.numberOfPages = self.lunXianImageARR.count;
    self.lunXianPageControl.tintColor = [UIColor whiteColor];
    self.lunXianPageControl.currentPageIndicatorTintColor = [UIColor redColor];

}
//加载热门导航条
- (void)loadRemenView{

    UIView * remenView = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"ReMenView" owner:nil options:nil][0];
    
    //[remenView setFrame:CGRectMake(0, _index_0_height, SIZE_WIDTH, 40)];
    [self.scrollViewBack addSubview:remenView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapReMenViewAction:)];
    [tap setNumberOfTapsRequired:1];
    [remenView addGestureRecognizer:tap];
    
    [remenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.scrollViewBack);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.lunXianBackgroundView.mas_bottom);
        make.left.with.right.mas_equalTo(0);
    }];
    
}
- (void)tapReMenViewAction:(UITapGestureRecognizer *)sender{
    NSLog(@"点击了热门");

}
//创建电影列表
- (void)loadDianYingCollectionView{

    //创建一个Layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为
    layout.itemSize = CGSizeMake((SIZE_WIDTH-30)/2.0, (SIZE_WIDTH-30)/2.0 * 330.0/425.0);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //item 行与行的距离
    layout.minimumLineSpacing = 10;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 10;
    
    
    self.dianYingCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _index_0_height+45, SIZE_WIDTH, SIZE_HEIGHT) collectionViewLayout:layout];
    //self.backCollectionView = [[UICollectionView alloc]initWithFrame:nil collectionViewLayout:layout];
    //self.dianYingCollectionView.collectionViewLayout = layout;
    self.dianYingCollectionView.delegate = self;
    self.dianYingCollectionView.dataSource = self;
    self.dianYingCollectionView.backgroundColor = [UIColor whiteColor];
    //注册item类型
    
    //[self.backCollectionView registerClass:[DianShiQiangCollectionCell class] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    [self.dianYingCollectionView registerNib:[UINib nibWithNibName:@"DianYingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"dianYingCollectionID"];
    //  注册头部脚部视图
    // [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    // 注册脚部视图
    // [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    [self.scrollViewBack addSubview:self.dianYingCollectionView];

}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 6;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"dianYingCollectionID";
    DianYingCollectionViewCell *cell = (DianYingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
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
    
    NSLog(@"---------------------");
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma end mark


#pragma mark ScrollViewDelegate 方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView == self.lunXianScrollView) {
        NSInteger i = scrollView.contentOffset.x/scrollView.frame.size.width + 1;
        self.lunXianPageControl.currentPage = i - 1;
    }
    
}
//定时任务方法调用：（注意计算好最后一页循环滚动）

-(void)handleSchedule{
    
    self.lunXianPageControl.currentPage++;
    if(_Tend){
        
        [self.lunXianScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        self.lunXianPageControl.currentPage=0;

        
    }else{
        
        [self.lunXianScrollView  setContentOffset:CGPointMake(self.lunXianPageControl.currentPage*SIZE_WIDTH, 0) animated:YES];
        
    }
    
    if (self.lunXianPageControl.currentPage==self.lunXianPageControl.numberOfPages-1) {
        
        _Tend=YES;
        
    }else{
        
        _Tend=NO;
        
    }
    
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
