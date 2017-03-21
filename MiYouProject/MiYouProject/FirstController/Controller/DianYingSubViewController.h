//
//  DianYingSubViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/20.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DianYingSubTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "DianYingSubCollectionViewCell.h"
#import "PlayerZLViewController.h"

@interface DianYingSubViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UITableView * tableview;
@property (strong, nonatomic) NSMutableArray * collectionARR;


@end
