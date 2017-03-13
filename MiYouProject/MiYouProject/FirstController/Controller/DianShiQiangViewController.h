//
//  DianShiQiangViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/10.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "DianShiQiangCollectionCell.h"
#import "AppDelegate.h"
#import "FirstViewController.h"
@interface DianShiQiangViewController : ZLBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *backCollectionView;

@property (strong, nonatomic) NSMutableArray * imageNameARR;
@property (strong, nonatomic) NSMutableArray * nameLabelARR;

@end
