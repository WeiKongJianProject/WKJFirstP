//
//  ChongZhiViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/15.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ChongZhiViewController.h"


#define ZHIFU_NOTIFICATION_RESUALT @"ZHIFU_NOTIFICATION_RESUALT"

@interface ChongZhiViewController (){
    int _currentJINE;
    NSString * _currentOrderNUM;
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
    self.UBView.scrollView.showsVerticalScrollIndicator = NO;
    self.UBView.scrollView.scrollEnabled = NO;
    [self.UBView setFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-64)];
    [self.UBView.zhiFuButton addTarget:self action:@selector(tanChuZhiFuView) forControlEvents:UIControlEventTouchUpInside];
    
    self.VIPView = (VIPChongZhiView *)[[NSBundle mainBundle] loadNibNamed:@"UBChongZhiView" owner:self options:nil][1];
    self.VIPView.scrollView.showsVerticalScrollIndicator = NO;
    self.VIPView.scrollView.scrollEnabled = NO;
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
    __weak typeof(self) weakSelf = self;
    //滚动速度
    CGFloat offSet=300.0;
//    
//    //若果字幕滚动到第二部分重复的部分则把偏移置0，设为第一部分,实现无限循环
//    if (weakSelf.UBView.scrollView.contentOffset.y>=weakSelf.UBView.scrollView.contentSize.height / 2) {
//        
//        weakSelf.UBView.scrollView.contentOffset=CGPointMake(0, -90);
//    }
//    if (weakSelf.VIPView.scrollView.contentOffset.y>=weakSelf.VIPView.scrollView.contentSize.height / 2) {
//        
//        weakSelf.VIPView.scrollView.contentOffset=CGPointMake(0, -90);
//    }
    //[weakSelf.UBView.scrollView setBackgroundColor:[UIColor grayColor]];
        //[weakSelf.UBView.scrollView setContentOffset:CGPointMake(0, 300)];
        NSLog(@"UBView.contentOffset的值为：=%g----=%g",self.UBView.scrollView.contentOffset.x,self.UBView.scrollView.contentOffset.y);
//        [UIView animateWithDuration:59.0f animations:^{
//            [weakSelf.UBView.scrollView setContentOffset:CGPointMake(0, 300)];
//            NSLog(@"UBView.contentOffset的值为：=%g----=%g",self.UBView.scrollView.contentOffset.x,self.UBView.scrollView.contentOffset.y);
//        } completion:^(BOOL finished) {
//             [weakSelf.UBView.scrollView setContentOffset:CGPointMake(0, 0)];
//        }];
    [UIView animateWithDuration:29.0 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        NSLog(@"执行了动画方法");
        
        //weakSelf.UBView.scrollView.contentOffset = CGPointMake(weakSelf.UBView.scrollView.contentOffset.x, weakSelf.UBView.scrollView.contentOffset.y+offSet);
        [weakSelf.UBView.scrollView setContentOffset:CGPointMake(0, 90)];
    } completion:nil];
    [UIView animateWithDuration:10.0 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:59.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.VIPView.scrollView.contentOffset = CGPointMake(weakSelf.VIPView.scrollView.contentOffset.x, weakSelf.VIPView.scrollView.contentOffset.y+offSet);
    } completion:nil];
    //滚动动画
    [NSTimer scheduledTimerWithTimeInterval:59.0f target:self selector:@selector(addAnimationScrollview) userInfo:nil repeats:YES];
    
    
    [self xw_addNotificationForName:ZHIFU_NOTIFICATION_RESUALT block:^(NSNotification * _Nonnull notification) {
        NSString * type = notification.userInfo[@"type"];
        [weakSelf zhifushibaiActionWithType:type];
    }];
    
}
//滚动动画
- (void)addAnimationScrollview{
    __weak typeof(self) weakSelf = self;

    
    //滚动速度
    CGFloat offSet=300.0;
    
    //若果字幕滚动到第二部分重复的部分则把偏移置0，设为第一部分,实现无限循环
    if (weakSelf.UBView.scrollView.contentOffset.y>=weakSelf.UBView.scrollView.contentSize.height / 2) {
        
        weakSelf.UBView.scrollView.contentOffset=CGPointMake(0, -90);
    }
    if (weakSelf.VIPView.scrollView.contentOffset.y>=weakSelf.VIPView.scrollView.contentSize.height / 2) {
        
        weakSelf.VIPView.scrollView.contentOffset=CGPointMake(0, -90);
    }
    //切割每次动画滚动距离
    NSLog(@"UBView.contentOffset的值为：=%g----=%g",self.UBView.scrollView.contentOffset.x,self.UBView.scrollView.contentOffset.y);
    
    [UIView animateWithDuration:59.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.UBView.scrollView.contentOffset = CGPointMake(weakSelf.UBView.scrollView.contentOffset.x, weakSelf.UBView.scrollView.contentOffset.y+offSet);
    } completion:nil];
    [UIView animateWithDuration:59.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.VIPView.scrollView.contentOffset = CGPointMake(weakSelf.VIPView.scrollView.contentOffset.x, weakSelf.VIPView.scrollView.contentOffset.y+offSet);
    } completion:nil];
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
    
    if (self.UB_or_VIP == UB_ChongZhi) {
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
    else{
        if (self.currentPriceModel != nil) {
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
    NSLog(@"UB充值页面链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"UB充值页面请求返回的数据为：%@",dic);
        NSString * result = dic[@"result"];
        if ([result isEqualToString:@"success"]) {
            if (!zlObjectIsEmpty(dic[@"points"])) {
                weakSelf.UBView.yuELabel.text = [NSString stringWithFormat:@"账户余额:%d",[dic[@"points"] intValue]];
            }
            if (!zlObjectIsEmpty(dic[@"exchange"])) {
                weakSelf.UBView.duiHuanLabel.text = [NSString stringWithFormat:@"充值数量:%dU币=1元",[dic[@"exchange"] intValue]];
            }
            NSArray * arrGift = dic[@"gift"];
            if (!zlArrayIsEmpty(arrGift)) {
                weakSelf.UBMiaoShuARR = arrGift;
                //weakSelf.UBView.fuWuLabel.text = ;
            }
            if (!zlObjectIsEmpty(dic[@"total"])) {
                weakSelf.UBView.renShuLabel.text = [NSString stringWithFormat:@"%d",[dic[@"total"] intValue]];
            }
            if (!zlObjectIsEmpty(dic[@"desc"])) {
                //dic[@"desc"]
                 NSString * removeStr = [self removeHTML:dic[@"desc"]];
                weakSelf.UBView.jieShaoLabel.text = removeStr;
            }
            
            NSArray * arr00 = dic[@"rechargeList"];
            if (!zlArrayIsEmpty(arr00)) {
                NSString * string = [NSString stringWithFormat:@""];
                for (NSDictionary * dic00 in arr00) {
                    NSString * name = dic00[@"name"];
                    NSString * con = dic00[@"content"];
                    NSString * str = [NSString stringWithFormat:@"%@ %@\n",name,con];
                    //NSLog(@"解析已充值的用户：%@",str);
                    string = [string stringByAppendingString:str];
                }
                //NSLog(@"已充值的UB的用户：%@",string);
                UILabel * label = [[UILabel alloc]init];
                label.numberOfLines = 0;
                label.font = [UIFont systemFontOfSize:12.0f];
                label.textColor = [UIColor blackColor];
                label.text = string;
                [weakSelf.UBView.scrollView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.with.bottom.mas_equalTo(weakSelf.UBView.scrollView);
                    make.left.with.right.mas_equalTo(weakSelf.UBView.scrollView).offset(20.0f);
                }];
                
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
    NSLog(@"充值VIP页面链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"充值VIP页面请求返回的数据为：%@",dic);
        NSString * result = dic[@"result"];
        if ([result isEqualToString:@"success"]) {
            NSArray *  giftARR = dic[@"gift"];
            if (!zlArrayIsEmpty(giftARR)) {
                weakSelf.VIPMiaoShuARR = giftARR;
                //weakSelf.VIPView.fuWuXiaLabel.text = @"";
            }
            if (!zlObjectIsEmpty(dic[@"total"])) {
                weakSelf.VIPView.renShuLabel.text = [NSString stringWithFormat:@"%d",[dic[@"total"] intValue]];
            }
            if (!zlObjectIsEmpty(dic[@"desc"])) {
                NSString * removeStr = [self removeHTML:dic[@"desc"]];
               //NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[(NSString *)dic[@"desc"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                weakSelf.VIPView.jieshaoLabel.text = removeStr;
            }
            NSArray * arr00 = dic[@"buyVipList"];
            if (!zlArrayIsEmpty(arr00)) {
                NSString * string = [NSString stringWithFormat:@""];
                for (NSDictionary * dic00 in arr00) {
                    NSString * name = dic00[@"name"];
                    NSString * con = dic00[@"content"];
                    NSString * str = [NSString stringWithFormat:@"%@ %@\n",name,con];
                    //NSLog(@"解析VIP已充值的用户：%@",str);
                    string = [string stringByAppendingString:str];
                }
                //NSLog(@"已充值的VIP的用户：%@",string);
                UILabel * label = [[UILabel alloc]init];
                label.numberOfLines = 0;
                label.font = [UIFont systemFontOfSize:12.0f];
                label.textColor = [UIColor blackColor];
                label.text = string;
                //label.backgroundColor = [UIColor grayColor];
                [weakSelf.VIPView.scrollView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.with.bottom.mas_equalTo(weakSelf.VIPView.scrollView);
                    make.left.with.right.mas_equalTo(weakSelf.VIPView.scrollView).offset(20.0f);
                }];
                
            }
            NSArray * arrPriceARR = dic[@"grouplist"];
            if (!zlArrayIsEmpty(arrPriceARR)) {
                self.vipPriceModelARR = (NSMutableArray *)[MTLJSONAdapter modelsOfClass:[VIPPriceMTLModel class] fromJSONArray:arrPriceARR error:nil];
            }
            NSLog(@"会员等级数组列表个数：%ld",self.vipPriceModelARR.count);
        }
        
    } failure:^(NSError *error) {
        [MBManager showBriefAlert:@"服务器连接失败"];
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
                if (self.vipPriceModelARR.count > 0) {
                    self.currentPriceModel = self.vipPriceModelARR[0];
                }
                // _currentJINE = 18;
            }
            
        }
            break;
        case 2:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 20;
            }
            else{
                if (self.vipPriceModelARR.count > 1) {
                    self.currentPriceModel = self.vipPriceModelARR[0];
                }
                //_currentJINE = 28;
            }
            break;
        case 3:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 30;
            }
            else{
                if (self.vipPriceModelARR.count > 2) {
                    self.currentPriceModel = self.vipPriceModelARR[0];
                }
                // _currentJINE = 38;
            }
            break;
        case 4:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 50;
            }
            else{
                if (self.vipPriceModelARR.count > 3) {
                    self.currentPriceModel = self.vipPriceModelARR[0];
                }
                //_currentJINE = 58;
            }
            break;
        case 5:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 100;
            }
            else{
                if (self.vipPriceModelARR.count > 4) {
                    self.currentPriceModel = self.vipPriceModelARR[0];
                }
                //_currentJINE = 98;
            }
            break;
        case 6:
            if (self.UB_or_VIP == UB_ChongZhi) {
                _currentJINE = 500;
            }
            else{
                if (self.vipPriceModelARR.count > 5) {
                    self.currentPriceModel = self.vipPriceModelARR[0];
                }
                //_currentJINE = 198;
            }
            break;
            
        default:
            break;
    }
    
    if (sender.tag-1 < self.VIPMiaoShuARR.count && sender.tag-1 < self.UBMiaoShuARR.count) {
        self.UBView.fuWuLabel.text = self.UBMiaoShuARR[sender.tag-1];
        self.VIPView.fuWuXiaLabel.text = self.VIPMiaoShuARR[sender.tag-1];
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
    [self closeButtonAction:nil];
    if (control.selectedSegmentIndex == 0) {
        self.VIPView.hidden = YES;
        self.UBView.hidden = NO;
        self.UB_or_VIP = UB_ChongZhi;
        _currentJINE = 0;
        self.currentPriceModel = nil;
    }
    else{
        self.UB_or_VIP = VIP_ChongZhi;
        self.UBView.hidden = YES;
        self.VIPView.hidden = NO;
        _currentJINE = 0;
        self.currentPriceModel = nil;
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
#pragma mark 支付宝  微信支付  接口调用  START
//微信支付
- (void)weixinZhiFuButtonAction:(UIButton *)sender{
    //微信支付
    NSLog(@"微信支付，金额为：%d",_currentJINE);
    
    
    [self zhifuButtonWithType:@"wechat"];
    
}
//支付宝支付
- (void)zhifuBaoButtonAction:(UIButton *)sender{
    
    //[self alipayPostWithUID:UID withJinE:_currentJINE];
    [self zhifuButtonWithType:@"alipay"];
}
- (void)zhifuButtonWithType:(NSString *)type{
    //用户信息
    NSDictionary * userDic = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    NSString * UID = userDic[@"id"];
    NSLog(@"生成订单：用户的ID：%@,支付宝支付:金额为：%d",UID,_currentJINE);
    
    __weak typeof(self) weakSelf = self;
    NSString * url = nil;
    if (self.UB_or_VIP == UB_ChongZhi) {
        //wechat
        url = [NSString stringWithFormat:@"%@&action=doRecharge&id=%@&money=%d&type=%@&channel=%@",URL_Common_ios,UID,_currentJINE,type,CHANNEL_ID];
    }
    else{
        url = [NSString stringWithFormat:@"%@&action=doBuyVip&id=%@&vip=%d&type=%@&channel=%@",URL_Common_ios,UID,[self.currentPriceModel.id intValue],type,CHANNEL_ID];
    }
    
    
    NSLog(@"支付宝充值VIP页面链接：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        
        // 1.判断当前对象是否能够转换成JSON数据.
        // YES if obj can be converted to JSON data, otherwise NO
        //BOOL isYes = [NSJSONSerialization isValidJSONObject:responseObject];
        //NSString *str = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //NSData* xmlData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary * dic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // BOOL isYes = [NSJSONSerialization isValidJSONObject:responseObject];
        NSLog(@"支付宝充值VIP页面请求返回的数据为：%@----是否可以解析：",dic);
        if (!zlDictIsEmpty(dic)) {
            NSString * result = dic[@"result"];
            if ([result isEqualToString:@"success"]) {
                
                if (self.UB_or_VIP == UB_ChongZhi) {
                    //UB充值
                    if ([type isEqualToString:@"alipay"]) {
                        _currentOrderNUM = dic[@"orderNo"];
                        //@"https://qr.alipay.com/bax00225fwvaxotgyqcj602a"
                        NSString * strIdentifier = dic[@"url"];
                        BOOL isExsit = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strIdentifier]];
                        if(isExsit) {
                            //NSLog(@"App %@ installed", strIdentifier);
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strIdentifier]];
                            AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
                            alertZL.titleName = @"支付结果";
                            alertZL.cancelBtnTitle = @"支付失败";
                            alertZL.okBtnTitle = @"支付完成";
                            [alertZL cancelBlockAction:^(BOOL success) {
                                [alertZL hideCustomeAlertView];
                                [weakSelf xw_postNotificationWithName:ZHIFU_NOTIFICATION_RESUALT userInfo:@{@"type":@"UB"}];
                            }];
                            [alertZL okButtonBlockAction:^(BOOL success) {
                                [alertZL hideCustomeAlertView];
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                                NSLog(@"点击了去支付按钮");
                            }];
                            [alertZL showCustomAlertView];
                        }
                    }
                    else{
                        [MBManager showBriefAlert:@"生成订单失败"];
                    }
                    
                }
                else{
                    //VIP会员购买
                    if ([type isEqualToString:@"alipay"]) {
                        _currentOrderNUM = dic[@"orderNo"];
                        NSLog(@"当前的订单号为：%@",_currentOrderNUM);
                        //@"https://qr.alipay.com/bax00225fwvaxotgyqcj602a"
                        NSString * strIdentifier = dic[@"url"];
                        BOOL isExsit = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strIdentifier]];
                        if(isExsit) {
                            //NSLog(@"App %@ installed", strIdentifier);
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strIdentifier]];
                            AlertViewCustomZL * alertZL = [[AlertViewCustomZL alloc]init];
                            alertZL.titleName = @"支付结果";
                            alertZL.cancelBtnTitle = @"支付失败";
                            alertZL.okBtnTitle = @"支付完成";
                            [alertZL cancelBlockAction:^(BOOL success) {
                                [alertZL hideCustomeAlertView];
                                [weakSelf xw_postNotificationWithName:ZHIFU_NOTIFICATION_RESUALT userInfo:@{@"type":@"VIP"}];
                            }];
                            [alertZL okButtonBlockAction:^(BOOL success) {
                                [alertZL hideCustomeAlertView];
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                                NSLog(@"点击了去支付按钮");
                            }];
                            [alertZL showCustomAlertView];
                        }
                        
                    }
                    else{
                        
                        [MBManager showBriefAlert:@"生成订单失败"];
                    }
                    
                    
                }
                
                
            }
            else{
                [MBManager showBriefAlert:@"生成订单失败"];
            }
            
        }else{
            [MBManager showBriefAlert:@"生成订单失败"];
        }
    } failure:^(NSError *error) {
        [MBManager showBriefAlert:@"生成订单失败"];
    }];
    
}
- (void)zhifushibaiActionWithType:(NSString *)type{
    __weak typeof(self) weakSelf = self;
    //wechat
    NSString * url  = nil;
    
    if ([type isEqualToString:@"VIP"]) {
        
        url = [NSString stringWithFormat:@"%@&action=doBuyVip&orderNo=%@",URL_Common_ios,_currentOrderNUM];
    }else{
        
        url = [NSString stringWithFormat:@"%@&action=doRecharge&orderNo=%@",URL_Common_ios,_currentOrderNUM];
    }
    
    
    NSLog(@"获取充值结果URL：%@",url);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {
        
        // 1.判断当前对象是否能够转换成JSON数据.
        // YES if obj can be converted to JSON data, otherwise NO
        //BOOL isYes = [NSJSONSerialization isValidJSONObject:responseObject];
        //NSString *str = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //NSData* xmlData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary * dic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // BOOL isYes = [NSJSONSerialization isValidJSONObject:responseObject];
        //NSLog(@"支付宝充值VIP页面请求返回的数据为：%@----是否可以解析：",dic);
        
        
        if (!zlDictIsEmpty(dic)) {
            NSString * result = dic[@"result"];
            if ([result isEqualToString:@"success"]) {
                [MBManager showBriefAlert:@"支付成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            else{
                [MBManager showBriefAlert:@"支付失败"];
            }
        }else{
            [MBManager showBriefAlert:@"支付失败"];
        }
    } failure:^(NSError *error) {
        [MBManager showBriefAlert:@"服务器连接失败"];
    }];
    
}
#pragma end mark  支付结束
-(void)alipayPostWithUID:(NSString *)UIDS withJinE:(int)jinE
{
    NSString *totalpay;
    NSString *outtradenum;
    
    totalpay = [NSString stringWithFormat:@"%d.00",_currentJINE];
    int orderNum = 123456 + arc4random()%99999999;
    outtradenum = [NSString stringWithFormat:@"%d",orderNum];
    //    if (_paramDic) {
    //        totalpay = _paramDic[@"totalFee"];
    //        outtradenum = _paramDic[@"order_trade_no"];
    //    }
    //    else
    //    {
    //        totalpay=[NSString stringWithFormat:@"%.2f",_orderDetail.DDJE];
    //        outtradenum =_orderDetail.JLBH?:@"";
    //    }
    
    
    NSDictionary * ret = @{@"order_id":outtradenum,@"payment_type":@"alipay"};
    /*
     [MLHttpManager post:ZhiFu_LIUSHUI_URLString params:ret m:@"product" s:@"pay" success:^(id responseObject) {
     NSDictionary * results = (NSDictionary *)responseObject;
     //        NSLog(@"请求订单流水：%@",results);
     if ([results[@"code"] isEqual:@0]) {
     NSDictionary *dic = @{@"out_trade_no":self.order_id,
     @"subject":@"美罗全球精品购",
     @"body":@"美罗全球精品购",
     @"total_fee":[NSString stringWithFormat:@"%.2f",self.order_sum]
     };
     [[HFSServiceClient sharedPayClient] POST:ALIPAY_SERVICE_URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSDictionary *result = (NSDictionary *)responseObject;
     NSLog(@"支付宝支付result %@",result);
     
     [self hideFengHuoLun];
     if (result) {
     AliPayOrder *order = [[AliPayOrder alloc] init];
     order.partner = result[@"partner"];
     order.seller = result[@"seller_id"];
     order.tradeNO = result[@"out_trade_no"];
     order.productName = result[@"subject"];
     order.productDescription = result[@"body"];
     order.amount = result[@"total_fee"];
     order.notifyURL = result[@"notify_url"];
     order.service = result[@"service"];
     order.paymentType = result[@"payment_type"];
     order.inputCharset = result[@"_input_charset"];
     order.itBPay = result[@"it_b_pay"];
     
     //将商品信息拼接成字符串
     NSString *orderSpec = [order description];
     NSString *signedString =result[@"sign"];
     //将签名成功字符串格式化为订单字符串,请严格按照该格式
     NSString *orderString = nil;
     NSString *appScheme = @"Matro";
     if (signedString != nil) {
     signedString = [signedString gtm_stringByEscapingForURLArgument];
     
     orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
     orderSpec, signedString, @"RSA"];
     NSLog(@"支付宝支付签名%@",orderString);
     [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
     
     if ([resultDic[@"resultStatus"] intValue]==9000) {
     [_hud show:YES];
     _hud.mode = MBProgressHUDModeText;
     _hud.labelText = resultDic[@"memo"];
     [_hud hide:YES afterDelay:2];
     MLPayresultViewController * payResultVC = [[MLPayresultViewController alloc]init];
     payResultVC.hidesBottomBarWhenPushed = YES;
     payResultVC.isSuccess = YES;
     payResultVC.order_id = self.order_id;
     [self.navigationController pushViewController:payResultVC animated:YES];
     
     }
     else{
     NSString *resultMes = resultDic[@"memo"];
     resultMes = (resultMes.length<=0?@"支付失败":resultMes);
     MLPayShiBaiViewController * shiBaiVC = [[MLPayShiBaiViewController alloc]init];
     shiBaiVC.hidesBottomBarWhenPushed = YES;
     
     [self.navigationController pushViewController:shiBaiVC animated:YES];
     }
     NSLog(@"支付宝支付结果reslut = %@",resultDic);
     }];
     }
     }
     
     
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     [self hideFengHuoLun];
     [_hud show:YES];
     NSLog(@"error kkkk %@",error);
     _hud.mode = MBProgressHUDModeText;
     _hud.labelText = REQUEST_ERROR_ZL;
     [_hud hide:YES afterDelay:2];
     }];
     
     
     }
     
     } failure:^(NSError *error) {
     [self hideFengHuoLun];
     [_hud show:YES];
     NSLog(@"error kkkk %@",error);
     _hud.mode = MBProgressHUDModeText;
     _hud.labelText = REQUEST_ERROR_ZL;
     [_hud hide:YES afterDelay:2];
     }];
     
     */
}

#pragma mark 支付宝  微信支付  接口调用  END


- (NSMutableArray *)UBMiaoShuARR{
    
    if (!_UBMiaoShuARR) {
        _UBMiaoShuARR = [[NSMutableArray alloc]init];
    }
    return _UBMiaoShuARR;
}
- (NSMutableArray *)VIPMiaoShuARR{
    if (!_VIPMiaoShuARR) {
        _VIPMiaoShuARR = [[NSMutableArray alloc]init];
    }
    return _VIPMiaoShuARR;
    
}
// 过滤HTML的标签
- (NSString *)removeHTML:(NSString *)html {
    
//    NSScanner *theScanner = [NSScanner scannerWithString:html];
//    
//    NSString *text = nil;
//    
//    while ([theScanner isAtEnd] == NO) {
//        
//        // 找到标签的起始位置
//        
//        [theScanner scanUpToString:@"<" intoString:nil] ;
//        
//        // 找到标签的结束位置
//        
//        [theScanner scanUpToString:@">" intoString:&text] ;
//        
//        // 替换字符
//        
//        //(you can filter multi-spaces out later if you wish)
//        
//        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
//    }
    /*
     iOS中对字符串进行UTF-8编码：输出str字符串的UTF-8格式
     [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     解码：把str字符串以UTF-8规则进行解码
     [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     */
    
    //html stringByReplacingOccurrencesOfString:<#(nonnull NSString *)#> withString:<#(nonnull NSString *)#>
    //NSString * testStr = @"<html><body><p>充值描述</p>充值描述充值描述充值描述</body></html>";
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[(NSString *)html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];html = [html stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //NSLog(@"去掉HTML之前的字符串：%@----%@",attrStr,attrStr.string);
    NSString * CustomString = nil;
    CustomString = [attrStr.string stringByReplacingOccurrencesOfString:@"<p>" withString:@"·"];
    CustomString = [CustomString stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    //NSLog(@"去掉HTML字符串：%@",CustomString);
    return CustomString;
    
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
