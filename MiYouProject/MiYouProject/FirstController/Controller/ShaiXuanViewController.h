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

@interface ShaiXuanViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray * collectionARR;

@property (strong, nonatomic) VOSegmentedControl * sgControl01;
@property (strong, nonatomic) VOSegmentedControl * sgControl02;
@property (strong, nonatomic) VOSegmentedControl * sgControl03;
@property (strong, nonatomic) VOSegmentedControl * sgControl04;

@end
