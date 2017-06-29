//
//  FirstViewController.h
//  SecondProject
//
//  Created by wkj on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"
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
#import "SecondVC02.h"
#import "DianYingSubViewController.h"
#import "ShaiXuanViewController.h"

#import "HOmeBannerMTLModel.h"
#import "CateListMTLModel.h"
#import "MemberMTLModel.h"
#import "VideoListMTLModel.h"

#import "WMPlayZLViewController.h"


#import "ChongZhiViewController.h"

#import "BanBenUIView.h"

@interface FirstViewController : ViewPagerController<ViewPagerDataSource,ViewPagerDelegate,FirstSubViewDelegate,SecondVC02Delegate>

@property (strong, nonatomic) NSMutableArray * itemsTitlesARR;
@property (strong, nonatomic) NSMutableArray * bannerARR;
@property (strong, nonatomic) NSMutableArray * listARR;

@property (strong, nonatomic) MemberMTLModel * memberInfo;

@property (strong, nonatomic) NSMutableArray* labelARR;
@property (strong, nonatomic) ZLLabelCustom * currentLabel;


@end
