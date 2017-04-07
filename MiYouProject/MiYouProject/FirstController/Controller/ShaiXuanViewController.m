//
//  ShaiXuanViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/22.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ShaiXuanViewController.h"
#define Collection_item_Width (SIZE_WIDTH-40)/3.0
#define Collection_item_Height (SIZE_WIDTH-40)/3.0 * 386.0/225.0
@interface ShaiXuanViewController (){
    
    NSString * _currentType;
    NSString * _currentStory;
    NSString * _currentYear;
    NSString * _currentOrder;

}

@end
static int _currentPage;
static int _isFirstOpen;

@implementation ShaiXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    _isFirstOpen = 1;
    _currentType = @"全部";
    _currentStory = @"全部";
    _currentOrder = @"new";
    _currentYear = @"全部";
    
    self.topView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    self.collectionARR = [[NSMutableArray alloc]init];
    //[self.collectionARR addObjectsFromArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    self.firstConARR = [[NSMutableArray alloc]init];
    self.secondConARR = [[NSMutableArray alloc]init];
    self.thirdConARR = [[NSMutableArray alloc]init];
    self.fourConARR = [[NSMutableArray alloc]init];
    
    [self startAFNetworkingWith:self.id withPage:_currentPage withJuQing:@"全部" withYear:@"全部" withType:@"全部" withOrder:@"new"];
    
    //[self settingSegmentView];
    [self settingCollectionView];
    // Do any additional setup after loading the view from its nib.
}
- (void)settingCollectionView{
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
    [self setZLCollectionView:self.collectionView];
}


- (void)startAFNetworkingWith:(int)keyId withPage:(int)page withJuQing:(NSString *)story withYear:(NSString *)year withType:(NSString *)type withOrder:(NSString *) orderType {
        __weak typeof(self) weakSelf = self;
        [MBManager showLoadingInView:weakSelf.view];
    
        
        //http://api4.cn360du.com:88/index.php?m=api-ios&action=lists&cate=999
        NSString * url = [NSString stringWithFormat:@"%@&action=lists&cate=%d&page=%d&juqing=%@&year=%@&type=%@&order=%@",URL_Common_ios,keyId,page,story,year,type,orderType];
        NSLog(@"筛选列表请求链接：%@",url);
        NSString * codeString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//去掉特殊字符
        [[ZLSecondAFNetworking sharedInstance] getWithURLString:codeString parameters:nil success:^(id responseObject) {
            [MBManager hideAlert];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"筛选列表请求数据：%@",dic);
            NSString * isSuccess = [NSString stringWithFormat:@"%@",[dic objectForKey:@"result"]];
            if ([isSuccess isEqualToString:@"success"]) {
                if (_currentPage == 1) {
                    if ([[dic objectForKey:@"typelist"] isKindOfClass:[NSArray class]] && [dic objectForKey:@"typelist"] != nil) {
                        NSArray * arr01 = [dic objectForKey:@"typelist"];
                        NSLog(@"第一栏列表数据为：%ld",arr01.count);
                        if (!zlArrayIsEmpty(arr01)) {
//                            for (int i = 0; i< arr01.count; i++) {
//                                NSDictionary * typeDic = arr01[i];
//                                //TypeListModel * models = [[TypeListModel alloc]init];
//                                TypeListModel * models = [[TypeListModel alloc]init];
//                                models.id = models.id;
//                                models.name = [typeDic objectForKey:@"name"];
//                                [weakSelf.firstConARR addObject:models];
//                            }
                            
                            weakSelf.firstConARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[TypeListModel class] fromJSONArray:[dic objectForKey:@"typelist"] error:nil];
                            //NSLog(@"self.firstConARR。count值为：%ld+++arr01的个数为：%ld",self.firstConARR.count,arr01.count);
                        }
                    }
                    NSDictionary * arr02 = [dic objectForKey:@"filterlist"];
                    if (!zlDictIsEmpty(arr02)) {
                        //                    NSArray * cusArr = [MTLJSONAdapter modelsOfClass:[FilterListModel class] fromJSONArray:[dic objectForKey:@"filterlist"] error:nil];
                        weakSelf.secondConARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[TypeListModel class] fromJSONArray:arr02[@"story"] error:nil];
                        weakSelf.thirdConARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[TypeListModel class] fromJSONArray:arr02[@"year"] error:nil];
                        //NSDictionary * yearDic = [arr02 objectForKey:@"year"];
                        //NSLog(@"年份为：%@",yearDic.allValues[0]);
                        //weakSelf.thirdConARR = (NSMutableArray *)yearDic.allValues;
                        //[weakSelf.thirdConARR addObjectsFromArray:yearDic.allValues];
                        //[ary sortedArrayUsingSelector:@selector(compare:)];//这个是一直默认升序
//                        NSMutableArray *objARR = [[NSMutableArray alloc]init];
//                        for (int i = 0;i< yearDic.allKeys.count;i++) {
//                            
//                            [objARR addObject:[yearDic objectForKey:yearDic.allKeys[i]]];
//                            //[weakSelf.thirdConARR addObject:[yearDic objectForKey:yearDic.allKeys[i]]];
//                        }
//                        [weakSelf.thirdConARR addObjectsFromArray:[ objARR sortedArrayUsingSelector:@selector(compare:)]];
                    }
                    NSArray * arr03 = [dic objectForKey:@"list"];
                    if (!zlArrayIsEmpty(arr03)) {
                        [weakSelf.collectionARR addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[VideoListMTLModel class] fromJSONArray:[dic objectForKey:@"list"] error:nil]];
                    }
                    NSLog(@"筛选列表的isFirstOpen的值为：%d",_isFirstOpen);
                    if(_isFirstOpen == 1){
                        [weakSelf settingSegmentView];
                        _isFirstOpen++;
                    }
                    
                    [weakSelf.collectionView reloadData];
                }
                else{
                    NSArray * arr03 = [dic objectForKey:@"list"];
                    if (!zlArrayIsEmpty(arr03)) {
                        [weakSelf.collectionARR addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[VideoListMTLModel class] fromJSONArray:[dic objectForKey:@"list"] error:nil]];
                    }

                    [weakSelf.collectionView reloadData];
                }
            }
            [weakSelf.collectionView.mj_footer endRefreshing];
            [MBManager hideAlert];
        } failure:^(NSError *error) {
//            [self.tableview.mj_header endRefreshing];
//            [self.tableview.mj_footer endRefreshing];
            [MBManager hideAlert];
            [MBManager showBriefAlert:@"数据加载失败"];
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];

}

- (void)settingSegmentView{

    //NSMutableDictionary * firstDic = [[NSMutableDictionary alloc]init];
    NSMutableArray * firstSegmentARR = [[NSMutableArray alloc]init];
    NSMutableArray * secondSegmentARR = [[NSMutableArray alloc]init];
    NSMutableArray * thirdSegmentARR = [[NSMutableArray alloc]init];
    for (int i = 0; i< self.firstConARR.count; i++) {
        TypeListModel * model = self.firstConARR[i];
        [firstSegmentARR addObject:@{VOSegmentText:model.name}];
        NSLog(@"第一个分类的名称为：%@",model.name);
    }
    for (int i = 0; i<self.secondConARR.count; i++) {
         TypeListModel * model = self.secondConARR[i];
        [secondSegmentARR addObject:@{VOSegmentText:model.name}];
    }
    for (int i = 0; i<self.thirdConARR.count; i++) {
//        NSString * str = [NSString stringWithFormat:@"%d",[self.thirdConARR[i] intValue]];
//        int value = (int)self.thirdConARR[i];
//        NSLog(@"第三个分类值为：%d",value);
        TypeListModel * model = self.thirdConARR[i];
        [thirdSegmentARR addObject:@{VOSegmentText:model.name}];
    }
    
    __weak typeof(self) weakSelf = self;
    self.sgControl01 = [[VOSegmentedControl alloc] initWithSegments:firstSegmentARR];
    self.sgControl01.contentStyle = VOContentStyleTextAlone;
    self.sgControl01.selectedTextColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl01.selectedIndicatorColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl01.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    //self.sgControl01.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sgControl01.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    self.sgControl01.selectedBackgroundColor = self.sgControl01.backgroundColor;
    self.sgControl01.allowNoSelection = NO;
    self.sgControl01.frame = CGRectMake(0, 5, SIZE_WIDTH, 30);
    self.sgControl01.indicatorThickness = 1;
    self.sgControl01.tag = 1;
    [self.topView addSubview:self.sgControl01];
    [self.sgControl01 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        _currentType = firstSegmentARR[index][VOSegmentText];
        _currentPage = 1;
        //__strong typeof(weakSelf) strongSelf = weakSelf;
        [weakSelf.collectionARR removeAllObjects];
       [weakSelf startAFNetworkingWith:weakSelf.id withPage:_currentPage withJuQing:_currentStory withYear:_currentYear withType:_currentType withOrder:_currentOrder];
    }];
    [self.sgControl01 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    //第二个
    self.sgControl02 = [[VOSegmentedControl alloc] initWithSegments:secondSegmentARR];
    self.sgControl02.contentStyle = VOContentStyleTextAlone;
    self.sgControl02.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    self.sgControl02.selectedTextColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl02.selectedIndicatorColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    //self.sgControl02.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sgControl02.backgroundColor = [UIColor clearColor];
    self.sgControl02.selectedBackgroundColor = self.sgControl02.backgroundColor;
    self.sgControl02.allowNoSelection = YES;
    self.sgControl02.frame = CGRectMake(10, 40, SIZE_WIDTH-10, 20);
    self.sgControl02.indicatorThickness = 0;
    self.sgControl02.tag = 2;
    [self.sgControl02 setSelectedSegmentIndex:-1];
    [self.topView addSubview:self.sgControl02];
    [self.sgControl02 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        _currentStory = secondSegmentARR[index][VOSegmentText];
        _currentPage = 1;
         [weakSelf.collectionARR removeAllObjects];
        [weakSelf startAFNetworkingWith:weakSelf.id withPage:_currentPage withJuQing:_currentStory withYear:_currentYear withType:_currentType withOrder:_currentOrder];
    }];
    
    [self.sgControl02 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    
    self.allButton01 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allButton01 setFrame:CGRectMake(10, 40, 40, 20)];
    self.allButton01.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.allButton01 setTitle:@"全部" forState:UIControlStateNormal];
    [self.allButton01 setTitleColor:[UIColor colorWithhex16stringToColor:Main_BackgroundColor] forState:UIControlStateNormal];
    [self.allButton01 addTarget:self action:@selector(allbutton01Action:) forControlEvents:UIControlEventTouchUpInside];
    //[self.topView addSubview:self.allButton01];
    UIView * spView02 = [[UIView alloc]initWithFrame:CGRectMake(0, 61, SIZE_WIDTH, 1)];
    spView02.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    spView02.alpha = 0.8;
    [self.topView addSubview:spView02];
    
    
    self.sgControl03 = [[VOSegmentedControl alloc] initWithSegments:thirdSegmentARR];
    self.sgControl03.contentStyle = VOContentStyleTextAlone;
    self.sgControl03.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    self.sgControl03.selectedTextColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl03.selectedIndicatorColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    //self.sgControl03.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sgControl03.backgroundColor = [UIColor clearColor];
    self.sgControl03.selectedBackgroundColor = self.sgControl03.backgroundColor;
    self.sgControl03.allowNoSelection = YES;
    self.sgControl03.frame = CGRectMake(10, 75, SIZE_WIDTH-10, 20);
    self.sgControl03.indicatorThickness = 0;
    self.sgControl03.tag = 3;
    [self.sgControl03 setSelectedSegmentIndex:-1];
    [self.topView addSubview:self.sgControl03];
    [self.sgControl03 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        _currentYear = thirdSegmentARR[index][VOSegmentText];
        _currentPage = 1;
         [weakSelf.collectionARR removeAllObjects];
        [weakSelf startAFNetworkingWith:weakSelf.id withPage:_currentPage withJuQing:_currentStory withYear:_currentYear withType:_currentType withOrder:_currentOrder];
    }];
    [self.sgControl03 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    
    self.allButton02 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allButton02 setFrame:CGRectMake(10,75, 40, 20)];
    [self.allButton02 setTitle:@"全部" forState:UIControlStateNormal];
    self.allButton02.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.allButton02 setTitleColor:[UIColor colorWithhex16stringToColor:Main_BackgroundColor] forState:UIControlStateNormal];
    [self.allButton02 addTarget:self action:@selector(allbutton02Action:) forControlEvents:UIControlEventTouchUpInside];
    //[self.topView addSubview:self.allButton02];
    UIView * spView03 = [[UIView alloc]initWithFrame:CGRectMake(0, 96, SIZE_WIDTH, 1)];
    spView03.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    spView03.alpha = 0.8;
    [self.topView addSubview:spView03];
    
    self.sgControl04 = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"按更新排序"},
                                                                      @{VOSegmentText: @"按分数排序"}]];
    self.sgControl04.contentStyle = VOContentStyleTextAlone;
    self.sgControl04.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    self.sgControl04.selectedTextColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    self.sgControl04.selectedIndicatorColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
    //self.sgControl04.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.sgControl04.backgroundColor = [UIColor clearColor];
    self.sgControl04.selectedBackgroundColor = self.sgControl04.backgroundColor;
    self.sgControl04.allowNoSelection = NO;
    self.sgControl04.frame = CGRectMake(0, 110, SIZE_WIDTH-170, 20);
    self.sgControl04.indicatorThickness = 0;
    self.sgControl04.tag = 4;
    [self.topView addSubview:self.sgControl04];
    [self.sgControl04 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        switch (index) {
            case 0:
                    _currentOrder = @"new";
                break;
            case 1:
                _currentOrder = @"score";
                break;
            default:
                break;
        }
        _currentPage = 1;
         [weakSelf.collectionARR removeAllObjects];
        [weakSelf startAFNetworkingWith:weakSelf.id withPage:_currentPage withJuQing:_currentStory withYear:_currentYear withType:_currentType withOrder:_currentOrder];
        
    }];
    [self.sgControl04 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];

}

//全部按钮 执行方法
- (void)allbutton01Action:(UIButton *)sender{
    [self.sgControl02 setSelectedSegmentIndex:-1];
}
- (void)allbutton02Action:(UIButton *)sender{
    [self.sgControl03 setSelectedSegmentIndex:-1];
}

- (void)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
    NSLog(@"%@: value --> %@",@(segmentCtrl.tag), @(segmentCtrl.selectedSegmentIndex));
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
    [collectionView registerNib:[UINib nibWithNibName:@"DianYingSubCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DianYingSubCollectionCellID"];
    collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(shanglaShuaXin)];
    
}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"self.collectionARR.count的个数为：%ld",self.collectionARR.count);
    return self.collectionARR.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"DianYingSubCollectionCellID";
    DianYingSubCollectionViewCell *cell = (DianYingSubCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    VideoListMTLModel * model = [self.collectionARR objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.name;
    cell.subNameLabel.text = model.subname;
    [cell.smallImageVIew sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:PLACEHOLDER_IMAGE];
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
    NSLog(@"点击了cell");
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma end mark

- (void)shanglaShuaXin{
    _currentPage++;
    [self startAFNetworkingWith:self.id withPage:_currentPage withJuQing:_currentStory withYear:_currentYear withType:_currentType withOrder:_currentOrder];
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
