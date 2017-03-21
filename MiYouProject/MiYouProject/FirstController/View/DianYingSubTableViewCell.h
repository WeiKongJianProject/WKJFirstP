//
//  DianYingSubTableViewCell.h
//  MiYouProject
//
//  Created by wkj on 2017/3/20.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DianYingSubTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *jianJieLabel;

@property (weak, nonatomic) IBOutlet UIButton *zhanKaiButton;

@property (strong, nonatomic) IBOutlet UICollectionView *thirdCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *caiNiLikeButton;
@property (weak, nonatomic) IBOutlet UIButton *tongZhuYanButton;
@property (weak, nonatomic) IBOutlet UIButton *tongDaoButton;
@property (weak, nonatomic) IBOutlet UIButton *PlayButton;


@end
