//
//  ChongZhiViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/15.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ChongZhiViewController.h"

@interface ChongZhiViewController (){


    int _currentJINE;
    
}

@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    [self.menuItems addObjectsFromArray:@[@"U币充值",@"充值VIP"]];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    self.memMTLModel = [MTLJSONAdapter modelOfClass:[MemberMTLModel class] fromJSONDictionary:dic error:nil];
    
    
    
    self.navigationItem.titleView = self.control;
    
    if (self.UB_or_VIP == UB_ChongZhi) {
        self.control.selectedSegmentIndex = 0;
        
        
    }
    else{
        self.control.selectedSegmentIndex = 1;
    }
    
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64)];
    [self.view addSubview:self.backgroundView];
    
    self.UBView = (UBChongZhiView *)[[NSBundle mainBundle] loadNibNamed:@"UBChongZhiView" owner:self options:nil][0];
    [self.UBView setFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-64)];
    [self.UBView.zhiFuButton addTarget:self action:@selector(tanChuZhiFuView) forControlEvents:UIControlEventTouchUpInside];
    
    self.VIPView = (VIPChongZhiView *)[[NSBundle mainBundle] loadNibNamed:@"UBChongZhiView" owner:self options:nil][1];
    [self.VIPView setFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-64)];
    [self.VIPView.zhiFuButton addTarget:self action:@selector(tanChuZhiFuView) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:self.UBView];
    [self.backgroundView addSubview:self.VIPView];
    self.UBView.zhangHaoLabel.text = self.memMTLModel.name;
    [self startAFNetworkingUB];
    [self startAFNetworkingVIP];
    [self.UBView.button01 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.UBView.button02 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.UBView.button03 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.UBView.button04 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.UBView.button05 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.UBView.button06 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.VIPView.button01 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.VIPView.button02 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.VIPView.button03 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.VIPView.button04 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.VIPView.button05 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.VIPView.button06 addTarget:self action:@selector(UBJinEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ubButtonARR addObjectsFromArray:@[self.UBView.button01,self.UBView.button02,self.UBView.button03,self.UBView.button04,self.UBView.button05,self.UBView.button06,self.VIPView.button01,self.VIPView.button02,self.VIPView.button03,self.VIPView.button04,self.VIPView.button05,self.VIPView.button06]];
    
    [self.UBView.button01 setBackgroundImage:[UIImage imageNamed:@"10yuanxuanzhong"] forState:UIControlStateSelected];
     [self.UBView.button02 setBackgroundImage:[UIImage imageNamed:@"20yuanxuanzhong"] forState:UIControlStateSelected];
     [self.UBView.button03 setBackgroundImage:[UIImage imageNamed:@"30yuanxuanzhong"] forState:UIControlStateSelected];
     [self.UBView.button04 setBackgroundImage:[UIImage imageNamed:@"50yuanxuanzhong"] forState:UIControlStateSelected];
     [self.UBView.button05 setBackgroundImage:[UIImage imageNamed:@"100yuanxuanzhong"] forState:UIControlStateSelected];
     [self.UBView.button06 setBackgroundImage:[UIImage imageNamed:@"500yuanxuanzhong"] forState:UIControlStateSelected];
    [self.VIPView.button01 setBackgroundImage:[UIImage imageNamed:@"qingtongxuanzhong"] forState:UIControlStateSelected];
    [self.VIPView.button02 setBackgroundImage:[UIImage imageNamed:@"heijinvip"] forState:UIControlStateSelected];
    [self.VIPView.button03 setBackgroundImage:[UIImage imageNamed:@"huangjinxuanzhong"] forState:UIControlStateSelected];
    [self.VIPView.button04 setBackgroundImage:[UIImage imageNamed:@"baijinxuanzhong"] forState:UIControlStateSelected];
    [self.VIPView.button05 setBackgroundImage:[UIImage imageNamed:@"zuanshixuanzhong"] forState:UIControlStateSelected];
    [self.VIPView.button06 setBackgroundImage:[UIImage imageNamed:@"wangzhexuanzhong"] forState:UIControlStateSelected];
    
    
    self.zhiFuView = (ZhiFuButtonVIew *)[[NSBundle mainBundle] loadNibNamed:@"ZhiFuButtonView" owner:self options:nil][0];
    [self.zhiFuView.closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.zhiFuView.zhiFuBaoButton addTarget:self action:@selector(zhifuBaoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.zhiFuView.weiXinButton addTarget:self action:@selector(weixinZhiFuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundView addSubview:self.zhiFuView];
    CALayer *layer = [self.zhiFuView layer];
    layer.shadowOffset = CGSizeMake(0, 3);
    layer.shadowRadius = 5.0;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.8;
    [self.zhiFuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(160.0f);
        //make.height.mas_equalTo(160.0f);
    }];
}
//关闭支付按钮
- (void)closeButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.zhiFuView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.top.mas_equalTo(self.view.mas_bottom);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(160.0f);
            //make.height.mas_equalTo(160.0f);
        }];
    }];

}
//支付按钮
- (void)tanChuZhiFuView{
    
    if (_currentJINE > 0) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf.zhiFuView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.view.mas_left);
                make.right.mas_equalTo(self.view.mas_right);
                make.top.mas_equalTo(self.view.mas_bottom).offset(-160.0f);
                make.bottom.mas_equalTo(self.view.mas_bottom);
                //make.height.mas_equalTo(160.0f);
            }];
            
        }];
    }
    else{
    
        [MBManager showBriefAlert:@"请选择充值类型"];
    }

    
}
//微信支付
- (void)weixinZhiFuButtonAction:(UIButton *)sender{
    //微信支付
    NSLog(@"微信支付，金额为：%d",_currentJINE);
    
    
}
//支付宝支付
- (void)zhifuBaoButtonAction:(UIButton *)sender{
    NSLog(@"支付宝支付:金额为：%d",_currentJINE);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.clipsToBounds = YES;
    
    //[self updateControlCounts];
    
    if (self.UB_or_VIP == UB_ChongZhi) {
        self.VIPView.hidden = YES;
        self.UBView.hidden = NO;
        self.UB_or_VIP = UB_ChongZhi;
        
        
    }
    else{
        self.UB_or_VIP = VIP_ChongZhi;
        self.UBView.hidden = YES;
        self.VIPView.hidden = NO;
    }
    
}

- (void)startAFNetworkingUB{
    [MBManager showLoadingInView:self.view];
    __weak typeof(self) weakSelf = self;
    NSString * url = [NSString stringWithFormat:@"%@&action=recharge&id=%@",URL_Common_ios,self.memMTLModel.id];
    NSLog(@"VIP充值页面链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"VIP充值页面请求返回的数据为：%@",dic);
        NSString * result = dic[@"result"];
        if ([result isEqualToString:@"success"]) {
            if (!zlObjectIsEmpty(dic[@"points"])) {
              weakSelf.UBView.yuELabel.text = [NSString stringWithFormat:@"账户余额:%d",[dic[@"points"] intValue]];
            }
            if (!zlObjectIsEmpty(dic[@"exchange"])) {
                 weakSelf.UBView.duiHuanLabel.text = [NSString stringWithFormat:@"充值数量:%dU币=1元",[dic[@"exchange"] intValue]];
            }
            if (!zlObjectIsEmpty(dic[@"gift"])) {
                weakSelf.UBView.fuWuLabel.text = dic[@"gift"];
            }
            if (!zlObjectIsEmpty(dic[@"total"])) {
                weakSelf.UBView.renShuLabel.text = [NSString stringWithFormat:@"%d",[dic[@"total"] intValue]];
            }
        }
        [MBManager hideAlert];
    } failure:^(NSError *error) {
        [MBManager hideAlert];
    }];
    
}
- (void)startAFNetworkingVIP{

    __weak typeof(self) weakSelf = self;
    NSString * url = [NSString stringWithFormat:@"%@&action=buyVip&id=%@",URL_Common_ios,self.memMTLModel.id];
    NSLog(@"充值页面链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"充值页面请求返回的数据为：%@",dic);
        NSString * result = dic[@"result"];
        if ([result isEqualToString:@"success"]) {
            if (!zlObjectIsEmpty(dic[@"gift"])) {
                weakSelf.VIPView.fuWuXiaLabel.text = dic[@"gift"];
            }
            if (!zlObjectIsEmpty(dic[@"total"])) {
                weakSelf.VIPView.renShuLabel.text = [NSString stringWithFormat:@"%d",[dic[@"total"] intValue]];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];

}

//+ (void)initialize
//{
//#if DEBUG_APPERANCE
//    
//    [[DZNSegmentedControl appearance] setBackgroundColor:kBakgroundColor];
//    [[DZNSegmentedControl appearance] setTintColor:kTintColor];
//    [[DZNSegmentedControl appearance] setHairlineColor:kHairlineColor];
//    
//    [[DZNSegmentedControl appearance] setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:15.0]];
//    [[DZNSegmentedControl appearance] setSelectionIndicatorHeight:2.5];
//    [[DZNSegmentedControl appearance] setAnimationDuration:0.125];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor], NSFontAttributeName: [UIFont systemFontOfSize:18.0]}];
//    
//#endif
//}
//金额按钮执行方法
- (void)UBJinEButtonAction:(UIButton *)sender{
    // 10  20  30  50  100  500
    
    for (UIButton * btn in self.ubButtonARR) {
        btn.selected = NO;
    }
    sender.selected = YES;
    switch (sender.tag) {
        case 1:{
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 10;
            }
            else{
                _currentJINE = 18;
            }
        
        }
            break;
        case 2:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 20;
            }
            else{
                _currentJINE = 28;
            }
            break;
        case 3:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 30;
            }
            else{
                _currentJINE = 38;
            }
            break;
        case 4:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 50;
            }
            else{
                _currentJINE = 58;
            }
            break;
        case 5:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 100;
            }
            else{
                _currentJINE = 98;
            }
            break;
        case 6:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 500;
            }
            else{
                _currentJINE = 198;
            }
            break;
            
        default:
            break;
    }
}


- (NSMutableArray *)menuItems{
    if (!_menuItems) {
        _menuItems = [[NSMutableArray alloc]init];
    }
    return _menuItems;
}

- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        
        _control.bouncySelectionIndicator = NO;
        _control.height = 44.0f;
        
        //                _control.height = 120.0f;
        //                _control.width = 300.0f;
        //                _control.showsGroupingSeparators = YES;
        //                _control.inverseTitles = YES;
                        _control.backgroundColor = [UIColor clearColor];
                        _control.tintColor = [UIColor whiteColor];
        //                _control.hairlineColor = [UIColor purpleColor];
                        _control.showsCount = NO;
        //                _control.autoAdjustSelectionIndicatorWidth = NO;
        //                _control.selectionIndicatorHeight = 4.0;
        //                _control.adjustsFontSizeToFitWidth = YES;
        
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
}

#pragma mark - ViewController Methods
- (void)addSegment:(id)sender
{
    NSUInteger newSegment = self.control.numberOfSegments;
    
//#if DEBUG_IMAGE
//    [self.control setImage:[UIImage imageNamed:@"icn_clock"] forSegmentAtIndex:newSegment];
//#else
    [self.control setTitle:[@"Favorites" uppercaseString] forSegmentAtIndex:newSegment];
    //[self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:newSegment];
//#endif
}
- (void)refreshSegments:(id)sender
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.menuItems];
    NSUInteger count = [array count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    self.menuItems = array;
    
    [self.control setItems:self.menuItems];
    [self updateControlCounts];
}

- (void)updateControlCounts
{
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:0];
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:1];
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:2];
    
//#if DEBUG_APPERANCE
//    [self.control setTitleColor:kHairlineColor forState:UIControlStateNormal];
//#endif
}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    
    if (control.selectedSegmentIndex == 0) {
        self.VIPView.hidden = YES;
        self.UBView.hidden = NO;
        self.UB_or_VIP = UB_ChongZhi;
    }
    else{
        self.UB_or_VIP = VIP_ChongZhi;
        self.UBView.hidden = YES;
        self.VIPView.hidden = NO;
    }
    
}
#pragma mark - DZNSegmentedControlDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}

- (NSMutableArray *)ubButtonARR{
    if (!_ubButtonARR) {
        _ubButtonARR = [[NSMutableArray alloc]init];
    }
    return _ubButtonARR;
}
- (NSMutableArray *)vipButtonARR{
    if (!_vipButtonARR) {
        _vipButtonARR = [[NSMutableArray alloc]init];
    }
    return _vipButtonARR;
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
