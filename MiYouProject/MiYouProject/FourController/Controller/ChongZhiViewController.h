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
typedef NS_ENUM(NSUInteger,UBorVIP) {
    UB_ChongZhi = 0,
    VIP_ChongZhi
};

@interface ChongZhiViewController : UIViewController<DZNSegmentedControlDelegate>


@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) NSMutableArray *menuItems;
@property (assign, nonatomic) UBorVIP UB_or_VIP;
@property (strong, nonatomic) UIView * backgroundView;
@property (strong, nonatomic) UBChongZhiView * UBView;
@property (strong, nonatomic) VIPChongZhiView * VIPView;

@end
