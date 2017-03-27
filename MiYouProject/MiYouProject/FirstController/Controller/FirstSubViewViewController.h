//
//  FirstSubViewViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/10.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZLPageControl.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "DianYingCollectionViewCell.h"

#import "HOmeBannerMTLModel.h"
#import "VideoListMTLModel.h"

#import "ZLSecondAFNetworking.h"
#import "ReMenView.h"

@class FirstSubViewViewController;


static int _currentPage;

@protocol FirstSubViewDelegate <NSObject>

- (void)firstSubVC:(FirstSubViewViewController *)viewC withType:(NSInteger) typeInt withName:(NSString *)name withKey:(NSString *)key;

@end

@interface FirstSubViewViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIView * lunXianBackgroundView;
@property (strong, nonatomic) UIScrollView * lunXianScrollView;
@property (strong, nonatomic) UIPageControl * lunXianPageControl;
@property (strong, nonatomic) NSMutableArray * lunXianImageARR;
@property (strong, nonatomic) NSMutableArray * dianYingCollectionARR;
@property (strong, nonatomic) UICollectionView * dianYingCollectionView;
@property (strong, nonatomic) UITableView * tableview;
@property (weak, nonatomic) id<FirstSubViewDelegate> delegate;

@property (assign, nonatomic) int id;
@property (assign, nonatomic) NSString * name;


//@property (strong, nonatomic) NSMutableArray * bannerARR;
//@property (strong, nonatomic) NSMutableArray * listARR;

@end