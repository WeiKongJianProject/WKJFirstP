//
//  ThirdViewController.h
//  SecondProject
//
//  Created by wkj on 2017/3/6.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <DZNSegmentedControl.h>
#import "SiFangCollectionViewCell.h"
#import "SiFangMTLModel.h"
#import "ZLSecondAFNetworking.h"
#import "SiFangPlayController.h"
#import "MemberMTLModel.h"
#import "SiFangPlayButton.h"
#import "AlertViewCustomZL.h"
#import "ChongZhiViewController.h"
#import "PingLunViewController.h"

@interface ThirdViewController : ZLBaseViewController<WKUIDelegate,WKNavigationDelegate,DZNSegmentedControlDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) WKWebView* webView;


@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) NSMutableArray *menuItems;
@property (strong, nonatomic) UICollectionView * collectionView;
@property (strong, nonatomic) NSMutableArray * collectionViewARR01;
@property (strong, nonatomic) NSMutableArray * collectionViewARR02;
@property (strong, nonatomic) NSMutableArray * collectioinViewARR;
@property (strong, nonatomic) MemberMTLModel * currentMemberMTLModel;

@end
