//
//  FirstSubViewViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/10.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "FirstSubViewViewController.h"

#define Collection_item_Width (SIZE_WIDTH-30)/2.0
#define Collection_item_Height (SIZE_WIDTH-30)/2.0 * 330.0/425.0

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
    
    _currentPage = 1;//当前页面
    
    _index_0_height = 315.0/560.0*SIZE_WIDTH;
    _index_1_height = 40.0f;
    
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    // Do any additional setup after loading the view from its nib.
    //self.lunXianImageARR = [[NSMutableArray alloc]init];
    //self.dianYingCollectionARR = [[NSMutableArray alloc]init];
    //[self.dianYingCollectionARR addObjectsFromArray:@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08"]];
    //设置背景  ScrollView
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-49.0-60) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    //下拉刷新设置
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(xiaLaShuaXin)];
    //自动改变 透明度
    self.tableview.mj_header.automaticallyChangeAlpha = YES;
    [self.tableview.mj_header beginRefreshing];
    //上拉刷新
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(shangLaShuaXin)];
    //[self.lunXianImageARR addObjectsFromArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489137038151&di=f8359be9591004374d8585189541c241&imgtype=0&src=http%3A%2F%2Fpic.365j.com%2Farticle%2Fimage%2F201702%2F23%2F6084932905.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489137038151&di=a486e7d292f3ea0fbd1d6039e2c337c6&imgtype=0&src=http%3A%2F%2Fimg3.cache.netease.com%2Fent%2F2014%2F7%2F22%2F201407221029266b582.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489137038151&di=4c58da342c002a67215c2824e2e0ecfb&imgtype=0&src=http%3A%2F%2Fwww.qulishi.com%2Fuploads%2Fnews%2F201603%2F1456823338865420.png"]];
    //[self loadTopLunXianView];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(handleSchedule) userInfo:nil repeats:YES];
    //[self loadRemenView];
    //[self loadDianYingCollectionView];
}
#pragma mark 下拉刷新
- (void)xiaLaShuaXin{
    NSLog(@"下拉刷新");
    _currentPage = 1;
    [self.lunXianImageARR removeAllObjects];
    [self.dianYingCollectionARR removeAllObjects];
    [self startAFnetWorkingWithCateID:self.id withPage:_currentPage];
}
- (void)shangLaShuaXin{
    NSLog(@"上拉刷新");
    _currentPage++;
    [self startAFnetWorkingWithCateID:self.id withPage:_currentPage];
}
#pragma end mark

- (void)startAFnetWorkingWithCateID:(int)currenID withPage:(int) currentPage {

    [MBManager showLoadingInView:self.view];
    __weak typeof(self) weakSelf = self;
    
    
    NSString * url = [NSString stringWithFormat:@"%@&action=index&cate=%d&page=%d",URL_Common_ios,currenID,currentPage];

    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        
        [MBManager hideAlert];
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * bannerARR = [dic objectForKey:@"banner"];
//        NSArray  * cateListARR = [dic objectForKey:@"catelist"];
//        NSDictionary * memberDic = [dic objectForKey:@"member"];
        NSArray * listARR = [dic objectForKey:@"list"];
        NSString * result = [dic objectForKey:@"result"];
        NSLog(@"数据加载：%@++++++%@++++",result,dic);
        if ([result isEqualToString:@"success"]) {
//            NSArray * arr1 = [MTLJSONAdapter modelsOfClass:[CateListMTLModel class] fromJSONArray:cateListARR error:nil];
//            //self.itemsTitlesARR = arr1;
//            [weakSelf.itemsTitlesARR removeAllObjects];
//            [weakSelf.itemsTitlesARR addObjectsFromArray:arr1];
            if (_currentPage == 1) {
                NSArray * arr2 = [MTLJSONAdapter modelsOfClass:[HOmeBannerMTLModel class] fromJSONArray:bannerARR error:nil];
                [weakSelf.lunXianImageARR removeAllObjects];
                [weakSelf.lunXianImageARR addObjectsFromArray:arr2];
            }

            
            
            NSArray * arr3 = [MTLJSONAdapter modelsOfClass:[VideoListMTLModel class] fromJSONArray:listARR error:nil];
            NSLog(@"加载电影列表的个数：%ld",arr3.count);
            //[weakSelf.dianYingCollectionARR removeAllObjects];
            [weakSelf.dianYingCollectionARR addObjectsFromArray:arr3];
            
//            if (memberDic != nil && ![memberDic isKindOfClass:[NSNull class]]) {
//                weakSelf.memberInfo = [MTLJSONAdapter modelOfClass:[MemberMTLModel class] fromJSONDictionary:memberDic error:nil];
//                [[NSUserDefaults standardUserDefaults] setObject:memberDic forKey:MEMBER_INFO_DIC];
//            }
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
            [weakSelf.tableview reloadData];
            
        }
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"数据加载失败"];
    }];

}


- (void)loadTopLunXianView{
    //560/315
    
    self.lunXianBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 315.0/560.0*SIZE_WIDTH)];
    self.lunXianBackgroundView.backgroundColor = [UIColor whiteColor];
    
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
        HOmeBannerMTLModel * bannerModel = self.lunXianImageARR[i];
        [imageview sd_setImageWithURL:[NSURL URLWithString:bannerModel.pic] placeholderImage:[UIImage imageNamed:@"icon_default"]];
        //        }
        //NSLog(@"imageview == %@",imageview.sd_imageURL);
        
        // imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.tag = i;
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)];
        [imageview addGestureRecognizer:singleTap];
        [self.lunXianScrollView addSubview:imageview];
    }
    self.lunXianScrollView.contentSize = CGSizeMake(imageScrollViewWidth*self.lunXianImageARR.count, 0);
    
    self.lunXianPageControl.numberOfPages = self.lunXianImageARR.count;
    self.lunXianPageControl.tintColor = [UIColor whiteColor];
    self.lunXianPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
}
- (void)photoTapped:(UITapGestureRecognizer *)sender{
    NSLog(@"点击了第几张:%ld",sender.view.tag);
    HOmeBannerMTLModel * bannerModel = self.lunXianImageARR[sender.view.tag];
    NSString * isVIP = [[NSUserDefaults standardUserDefaults] objectForKey:IS_MEMBER_VIP];
    NSString * bannerVIP = [NSString stringWithFormat:@"%d",[bannerModel.vip intValue]];
    if ([bannerVIP isEqualToString:@"1"]) {
        if ([isVIP isEqualToString:@"1"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
                NSString * keyID = [NSString stringWithFormat:@"%d",[bannerModel.id intValue]];
                [self.delegate firstSubVC:self withType:2 withName:bannerModel.name withKey:keyID];
            }
        }
        else{
            AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
            alertZL.titleName = @"需要开通VIP才能观看";
            alertZL.cancelBtnTitle = @"取消";
            alertZL.okBtnTitle = @"开通";
            [alertZL cancelBlockAction:^(BOOL success) {
                [alertZL hideCustomeAlertView];
            }];
            [alertZL okButtonBlockAction:^(BOOL success) {
                NSLog(@"点击了去支付按钮");
            }];
            [alertZL showCustomAlertView];
        }

    }else{
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
            NSString * keyID = [NSString stringWithFormat:@"%d",[bannerModel.id intValue]];
            [self.delegate firstSubVC:self withType:2 withName:bannerModel.name withKey:keyID];
        }
    }
    

    
}

//加载热门导航条
- (void)loadRemenView{
    
    UIView * remenView = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"ReMenView" owner:nil options:nil][0];
    remenView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    //[remenView setFrame:CGRectMake(0, _index_0_height, SIZE_WIDTH, 40)];
    [self.tableview addSubview:remenView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapReMenViewAction:)];
    [tap setNumberOfTapsRequired:1];
    [remenView addGestureRecognizer:tap];
    
    [remenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.tableview);
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
    layout.itemSize = CGSizeMake(Collection_item_Width, Collection_item_Height);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //item 行与行的距离
    layout.minimumLineSpacing = 10;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 10;
    
    
    self.dianYingCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, (Collection_item_Height+10) * ((self.dianYingCollectionARR.count+1) / 2)) collectionViewLayout:layout];
    //self.backCollectionView = [[UICollectionView alloc]initWithFrame:nil collectionViewLayout:layout];
    //self.dianYingCollectionView.collectionViewLayout = layout;
    self.dianYingCollectionView.delegate = self;
    self.dianYingCollectionView.dataSource = self;
    self.dianYingCollectionView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    
    self.dianYingCollectionView.scrollEnabled = NO;
    //注册item类型
    
    //[self.backCollectionView registerClass:[DianShiQiangCollectionCell class] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    [self.dianYingCollectionView registerNib:[UINib nibWithNibName:@"DianYingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"dianYingCollectionID"];
    //  注册头部脚部视图
    // [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    // 注册脚部视图
    // [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    //[self.tableview addSubview:self.dianYingCollectionView];
    
}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dianYingCollectionARR.count;
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
    VideoListMTLModel * vModel = [self.dianYingCollectionARR objectAtIndex:indexPath.row];
    cell.dianYingNameLabel.text = vModel.name;
    /*
     时间戳转化
     */
    //    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //    [formatter setDateFormat:@"HHMMss"];//@"yyyy-MM-dd-HHMMss"
    //    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[vModel.duration intValue]];
    //    NSString* dateString = [formatter stringFromDate:date];
    int zongTime = [vModel.duration intValue];
    int m,s;
    m = zongTime/60;
    s = zongTime-60;
    
    NSString * timeString = [NSString stringWithFormat:@"%d:%d",m,s];
    
    
    cell.timeLabel.text = timeString;
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
    VideoListMTLModel * model = [self.dianYingCollectionARR objectAtIndex:indexPath.row];
    NSString * modelVIP = [NSString stringWithFormat:@"%d",[model.vip intValue]];
    NSString * isMemberVIP = [[NSUserDefaults standardUserDefaults] objectForKey:IS_MEMBER_VIP];
    if ([modelVIP isEqualToString:@"1"]) {
        if ([isMemberVIP isEqualToString:@"1"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
                NSString * keyID = [NSString stringWithFormat:@"%d",[model.id intValue]];
                [self.delegate firstSubVC:self withType:2 withName:model.name withKey:keyID];
            }
        }
        else{
            AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
            alertZL.titleName = @"需要开通VIP才能观看";
            alertZL.cancelBtnTitle = @"取消";
            alertZL.okBtnTitle = @"开通";
            [alertZL cancelBlockAction:^(BOOL success) {
                [alertZL hideCustomeAlertView];
            }];
            [alertZL okButtonBlockAction:^(BOOL success) {
                NSLog(@"点击了去支付按钮");
            }];
            [alertZL showCustomAlertView];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
            NSString * keyID = [NSString stringWithFormat:@"%d",[model.id intValue]];
            [self.delegate firstSubVC:self withType:2 withName:model.name withKey:keyID];
        }
    
    }
//    if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
//        [self.delegate firstSubVC:self withType:2 withName:model.name withKey:model.video];
//    }
    
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma end mark


#pragma mark ScrollViewDelegate 方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //NSLog(@"执行了scrollViewDidScroll方法");
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

#pragma mark TableViewDelegate 代理方法开始

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.0f;
    if (indexPath.row == 0) {
        height = _index_0_height;
    }
    else if(indexPath.row == 1){
        height = _index_1_height;
    }
    else if(indexPath.row ==2 ){
        
        height =  (Collection_item_Height+10) * ((self.dianYingCollectionARR.count+1) / 2);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"tableviewCellID";
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    
    switch (indexPath.row) {
        case 0:
            [self loadTopLunXianView];
            [cell addSubview:self.lunXianBackgroundView];
            break;
        case 1:{
            ReMenView * remenView = (ReMenView *)[[NSBundle mainBundle] loadNibNamed:@"ReMenView" owner:nil options:nil][0];
            
            //            //[remenView setFrame:CGRectMake(0, _index_0_height, SIZE_WIDTH, 40)];
            //            [self.tableview addSubview:remenView];
            //            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapReMenViewAction:)];
            //            [tap setNumberOfTapsRequired:1];
            //            [remenView addGestureRecognizer:tap];
            remenView.titleLabel.text = self.name;
            [cell addSubview:remenView];
            [remenView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(cell);
                make.height.mas_equalTo(40);
                make.top.mas_equalTo(0);
                make.left.with.right.mas_equalTo(0);
            }];
        }
            break;
        case 2:
            
            [self loadDianYingCollectionView];
            [cell addSubview:self.dianYingCollectionView];
            
            break;
        default:
            break;
    }
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
            [self.delegate firstSubVC:self withType:1 withName:self.name withKey:[NSString stringWithFormat:@"%d",self.id]];
        }
    }
}

#pragma end mark

#pragma mark 懒加载
- (NSMutableArray *)dianYingCollectionARR{
    
    if (!_dianYingCollectionARR) {
        _dianYingCollectionARR = [[NSMutableArray alloc]init];
    }
    return _dianYingCollectionARR;
}
- (NSMutableArray *)lunXianImageARR{
    if (!_lunXianImageARR) {
        _lunXianImageARR = [[NSMutableArray alloc]init];
    }
    return _lunXianImageARR;
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
