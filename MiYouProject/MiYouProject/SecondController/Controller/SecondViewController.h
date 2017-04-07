//
//  SecondViewController.h
//  SecondProject
//
//  Created by wkj on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdViewController.h"
#import <AFNetworking.h>
//#import "UIView+WHC_Toast.h"
//#import "UIView+WHC_Loading.h"
//#import "UIView+WHC_ViewProperty.h"
//#import "UIView+HeinQi.h"
//#import "UIView+NFLayout.h"
#import "UIView+BlankPage.h"
#import "AlertViewCustomZL.h"

#import "TestMTLModel.h"
#import "ZLAFNetworking.h"
#import "ZLSecondAFNetworking.h"
#import <FMDB.h>
#import "FMDB+ZL.h"
#import "ViewPagerController.h"
#import "ZLLabelCustom.h"

#import "SearchViewController.h"
#import "DianShiQiangViewController.h"
#import "FirstSubViewViewController.h"

#import "DianYingSubViewController.h"
#import "ShaiXuanViewController.h"

#import "HOmeBannerMTLModel.h"
#import "CateListMTLModel.h"
#import "MemberMTLModel.h"
#import "VideoListMTLModel.h"
#import "SecondVC02.h"
#import "VIPVideoMTLModel.h"
#import "VIPShaiXuanVCViewController.h"
#import "WMPlayZLViewController.h"
#import "SiFangPlayController.h"
#import "SanVIPPlayViewController.h"

@interface SecondViewController : ViewPagerController<CustomIOSAlertViewDelegate,ViewPagerDataSource,ViewPagerDelegate,SecondVC02Delegate,VIPShaiXuanVCDelegate>

@property (strong, nonatomic) NSMutableArray * itemsTitlesARR;
@property (strong, nonatomic) NSMutableArray * bannerARR;
@property (strong, nonatomic) NSMutableArray * listARR;

@property (strong, nonatomic) MemberMTLModel * memberInfo;

@property (strong, nonatomic) NSMutableArray* labelARR;
@property (strong, nonatomic) ZLLabelCustom * currentLabel;

@property (strong, nonatomic) NSDictionary * currentMemInfoDic;
@property (strong, nonatomic) NSDictionary * titleDic;
@property (strong, nonatomic) NSMutableArray * collectionARR;


@end
