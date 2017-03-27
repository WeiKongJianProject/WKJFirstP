//
//  ShaiXuanViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/22.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VOSegmentedControl.h>
#import "DianYingSubCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "PlayerZLViewController.h"
#import "ZLSecondAFNetworking.h"
#import "TypeListModel.h"
#import "FilterListModel.h"
#import "VideoListMTLModel.h"

@interface ShaiXuanViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray * collectionARR;

@property (strong, nonatomic) VOSegmentedControl * sgControl01;
@property (strong, nonatomic) VOSegmentedControl * sgControl02;
@property (strong, nonatomic) VOSegmentedControl * sgControl03;
@property (strong, nonatomic) VOSegmentedControl * sgControl04;

@property (assign, nonatomic) int id;

@property (strong, nonatomic) NSMutableArray * firstConARR;
@property (strong, nonatomic) NSMutableArray * secondConARR;
@property (strong, nonatomic) NSMutableArray * thirdConARR;
@property (strong, nonatomic) NSMutableArray * fourConARR;
@property (strong, nonatomic) FilterListModel * filterClassModel;
@property (strong, nonatomic) FilterListModel * filterYearModel;

@property (strong, nonatomic) UIButton * allButton01;
@property (strong, nonatomic) UIButton * allButton02;

@end
