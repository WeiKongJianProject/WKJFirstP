//
//  SiFangCollectionViewCell.h
//  MiYouProject
//
//  Created by wkj on 2017/3/30.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiFangPlayButton.h"

@interface SiFangCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet SiFangPlayButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *pingLunLabel;
@property (weak, nonatomic) IBOutlet UIButton *pingLunButton;
@property (strong, nonatomic) IBOutlet UILabel *subNameLabel;






@end
