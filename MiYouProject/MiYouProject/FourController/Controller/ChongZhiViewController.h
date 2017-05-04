//
//  ChongZhiViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/15.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNSegmentedControl.h>
#import "UBChongZhiView.h"
#import "VIPChongZhiView.h"
#import "MemberMTLModel.h"
#import "ZLSecondAFNetworking.h"
#import "ZhiFuButtonVIew.h"
#import "OrderZLModel.h"
//#import <BmobPaySDK/Bmob.h>
#import "VIPPriceMTLModel.h"
#import "FWInterface.h"


typedef NS_ENUM(NSUInteger,UBorVIP) {
    UB_ChongZhi = 0,
    VIP_ChongZhi
};

@interface ChongZhiViewController : UIViewController<DZNSegmentedControlDelegate,UIScrollViewDelegate,FWInterfaceDelegate>


@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) NSMutableArray *menuItems;
@property (assign, nonatomic) UBorVIP UB_or_VIP;
@property (strong, nonatomic) UIView * backgroundView;
@property (strong, nonatomic) UBChongZhiView * UBView;
@property (strong, nonatomic) VIPChongZhiView * VIPView;
@property (strong, nonatomic) MemberMTLModel * memMTLModel;
@property (strong, nonatomic) NSMutableArray * ubButtonARR;
@property (strong, nonatomic) NSMutableArray * vipButtonARR;
@property (strong, nonatomic) NSMutableArray * vipPriceModelARR;
@property (strong, nonatomic) VIPPriceMTLModel * currentPriceModel;


@property (strong, nonatomic) ZhiFuButtonVIew * zhiFuView;

@property (strong, nonatomic) NSMutableArray * UBMiaoShuARR;
@property (strong, nonatomic) NSMutableArray * VIPMiaoShuARR;


@end
