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


@interface FirstSubViewViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewBack;
@property (strong, nonatomic) UIView * lunXianBackgroundView;
@property (strong, nonatomic) UIScrollView * lunXianScrollView;
@property (strong, nonatomic) UIPageControl * lunXianPageControl;
@property (strong, nonatomic) NSMutableArray * lunXianImageARR;
@property (strong, nonatomic) UICollectionView * dianYingCollectionView;



@end
