//
//  SecondVC02.m
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SecondVC02.h"




#define Collection_item_Width (SIZE_WIDTH-40)/3.0
#define Collection_item_Height (SIZE_WIDTH-40)/3.0 * 300.0/225.0

@interface SecondVC02 (){
    
    NSString * _totalNum;
}

@end
//VIPVideoCellID
static int _currentPage;
@implementation SecondVC02

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    NSString * num = [NSString stringWithFormat:@"片库约为%@部",self.numLabelText];
    self.numLabel.text = num;
    NSLog(@"secondVC02数组个数：%ld",self.collectionViewARR.count);
    [self setZLCollectionView:self.collectionVIew];
    if (self.isFromFirstVCButton == YES) {
        [self.collectionVIew.mj_header beginRefreshing];
    }
}
//网络请求  数据 标题
- (void)getShuJuFromAFNetworkingWithPage:(int)page{
    [MBManager showLoadingInView:self.view];
    __weak typeof(self) weakSelf = self;
    
    NSString * url = nil;
    //    if ([self isFirstOpen] == YES) {
    //        url = [NSString stringWithFormat:@"%@&action=index&mid=999&page=1&fresh=1",URL_Common_ios];
    //    }
    //    else{
    NSDictionary * memDic = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    //page为空时默认为第一页//&action=index&mid=1&level=1&playfrom=youku&hot=1&page=1
    url = [NSString stringWithFormat:@"%@&action=vip&mid=%@&page=%d",URL_Common_ios,memDic[@"id"],page];
    //    }
    
    NSLog(@"第一次请求的链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        
         [MBManager hideAlert];
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"result" ] isEqualToString:@"success"]) {
            
            
            
            if (dic[@"member"] != nil && ![dic[@"member"] isKindOfClass:[NSNull class]]) {
                weakSelf.currentMemInfoDic = dic[@"member"];
                //NSLog(@"会员等级为：%@",weakSelf.currentMemInfoDic[@"vip"]);
                [[NSUserDefaults standardUserDefaults] setObject:weakSelf.currentMemInfoDic[@"vip"] forKey:MEMBER_VIP_LEVEL];
            }
            
            NSArray * arr01 = [MTLJSONAdapter modelsOfClass:[VIPVideoMTLModel class] fromJSONArray:dic[@"list"] error:nil];
            if (!zlArrayIsEmpty(arr01)) {
                [weakSelf.collectionViewARR addObjectsFromArray:arr01];
                
                [weakSelf.collectionVIew reloadData];
            }
            _totalNum = dic[@"total"];
            NSString * num = [NSString stringWithFormat:@"片库约为%@部",_totalNum];
            weakSelf.numLabel.text = num;
            
            [self.collectionVIew.mj_header endRefreshing];
            [self.collectionVIew.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"数据加载失败"];
        [self.collectionVIew.mj_header endRefreshing];
        [self.collectionVIew.mj_footer endRefreshing];
    }];
    
}



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
    
    [collectionView setCollectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    //collectionView.scrollEnabled = NO;
    //注册item类型
    
    //[self.backCollectionView registerClass:[DianShiQiangCollectionCell class] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    [collectionView registerNib:[UINib nibWithNibName:@"VIPViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"VIPViewCellID"];
    collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(shanglaShuaXin)];
    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headShuaXin)];
    collectionView.mj_header.automaticallyChangeAlpha = YES;
}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"self.collectionARR.count的个数为：%ld",self.collectionARR.count);
    return self.collectionViewARR.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"VIPViewCellID";
     VIPViewCollectionViewCell *cell = (VIPViewCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    VIPVideoMTLModel * model = [self.collectionViewARR objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.name;
    //cell.subNameLabel.text = model.subname;
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"vip_default"]];
    
    
    //检测缓存中是否已存在图片
    UIImage *myCachedImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.pic];
    /*
     SDWebImageManager *manager = [SDWebImageManager sharedManager];
     // 取消正在下载的操作
     //[manager cancelAll];
     // 清除内存缓存
     [manager.imageCache clearMemory];
     //释放磁盘的缓存
     [manager.imageCache clearDiskOnCompletion:^{
     
     }];
     */
    
    if (myCachedImage) {
        //NSLog(@"缓存中有图片");
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"icon_default2"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    else{
        //NSLog(@"缓存中没有图片时执行方法");
        [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:model.pic] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            //NSLog(@"处理下载进度");
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
                //NSLog(@"下载有错误");
            }
            if (image) {
                //NSLog(@"下载图片完成");
                dispatch_async(dispatch_get_main_queue(), ^{
                    // switch back to the main thread to update your UI
                    [cell.imageView setImage:image];
                    //[cell layoutSubviews];
                });
                
                
                [[SDImageCache sharedImageCache] storeImage:image forKey:model.pic toDisk:NO completion:^{
                    //NSLog(@"保存到磁盘中。。。。。。");
                }];
                //图片下载完成  在这里进行相关操作，如加到数组里 或者显示在imageView上
            }
        }];
        
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
#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(firstSubVC:withType:withName:withKey:)]) {
    //        [self.delegate firstSubVC:self withType:0 withName:@"电影" withKey:@"关键字"];
    //    }
    
    VIPVideoMTLModel * model = [self.collectionViewARR objectAtIndex:indexPath.row];
    int vipLevel = [model.vip intValue];
    //int memVIPLevel = [[[[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC]objectForKey:@"vip"] intValue];
    int mvipLevel = [[[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_VIP_LEVEL] intValue];
    NSLog(@"电影会员等级为：%d,用户的等级为：%d",vipLevel,mvipLevel);
    if (mvipLevel < vipLevel) {
     //用户会员等级  小于  电影VIP等级
//        AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
//        alertZL.titleName = @"VIP等级不够";
//        alertZL.cancelBtnTitle = @"取消";
//        alertZL.okBtnTitle = @"升级";
//        [alertZL cancelBlockAction:^(BOOL success) {
//            [alertZL hideCustomeAlertView];
//        }];
//        [alertZL okButtonBlockAction:^(BOOL success) {
//            [alertZL hideCustomeAlertView];
//            NSLog(@"点击了去支付按钮");
//        }];
//        [alertZL showCustomAlertView];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(secondVC02:withType:withName:withKey:withIsShiKan:)]) {
            
            [self.delegate secondVC02:self withType:2 withName:model.name withKey:model.id withIsShiKan:YES];
            
        }
    }
    else{
    //用户会员等级  大于等于  电影VIP等级
        if (self.delegate && [self.delegate respondsToSelector:@selector(secondVC02:withType:withName:withKey:withIsShiKan:)]) {
            
            [self.delegate secondVC02:self withType:2 withName:model.name withKey:model.id withIsShiKan:NO];
            
        }
        
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma end mark

- (void)shanglaShuaXin{
    _currentPage++;
    NSString * vipLevel = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_VIP_LEVEL];
    int vipLevelNum = [vipLevel intValue];
    if (_currentPage >=3) {
        if (vipLevelNum >0) {
             [self getShuJuFromAFNetworkingWithPage:_currentPage];
        }
        else{
            __weak typeof(self) weakSelf = self;
            AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
            alertZL.titleName = @"需要开通VIP才能观看更多";
            alertZL.cancelBtnTitle = @"取消";
            alertZL.okBtnTitle = @"开通";
            [alertZL cancelBlockAction:^(BOOL success) {
                [alertZL hideCustomeAlertView];
                [weakSelf.collectionVIew.mj_footer endRefreshing];
            }];
            [alertZL okButtonBlockAction:^(BOOL success) {
                [alertZL hideCustomeAlertView];
                [weakSelf.collectionVIew.mj_footer endRefreshing];
                [weakSelf xw_postNotificationWithName:KAITONG_VIP_NOTIFICATION userInfo:nil];
            }];
            [alertZL showCustomAlertView];
        }
        _currentPage--;
    }
    else{
         [self getShuJuFromAFNetworkingWithPage:_currentPage];
        
    }
    
   
    //[self startAFNetworkingWith:self.id withPage:_currentPage withJuQing:_currentStory withYear:_currentYear withType:_currentType withOrder:_currentOrder];
}
- (void)headShuaXin{
    _currentPage = 1;
    [self.collectionViewARR removeAllObjects];
    [self getShuJuFromAFNetworkingWithPage:_currentPage];

}

#pragma 懒加载
- (NSDictionary *)currentMemInfoDic{
    if (!_currentMemInfoDic) {
        _currentMemInfoDic = [[NSDictionary alloc]init];
    }
    return _currentMemInfoDic;
}

- (NSMutableArray *)collectionViewARR{
    if (!_collectionViewARR) {
        _collectionViewARR = [[NSMutableArray alloc]init];
    }
    return _collectionViewARR;
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
