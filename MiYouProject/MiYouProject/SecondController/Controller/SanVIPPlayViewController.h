//
//  SanVIPPlayViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/4/7.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import <ZFPlayer.h>
#import "DownloadModel.h"
#import "WHCNetWorkKit.h"
#import "UIView+WHC_Toast.h"
#import "PlayVideoTableViewCell.h"
#import "ZLSecondAFNetworking.h"
#import "PlayVideoMTLModel.h"
#import "PlayMemberMTLModel.h"
#import "SiFangMTLModel.h"
#import "XuanJiCollectionViewCell.h"

@interface SanVIPPlayViewController : ZLBaseViewController<ZFPlayerDelegate,ZFPlayerControlViewDelagate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet ZFPlayerView *playerView;
@property (assign,  nonatomic) BOOL isBenDi;
@property (assign, nonatomic) BOOL isDianShiType;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
@property (weak, nonatomic) IBOutlet UIView *backgroundPlayView;

@property (strong, nonatomic) NSURL * benDiUrl;
@property (strong, nonatomic) NSString * benDiName;

@property (strong, nonatomic) NSURL * zaiXianUrl;
@property (strong, nonatomic) NSString * zaiXianName;

@property (strong, nonatomic) NSString * mid;
@property (strong, nonatomic) NSString * id;

@property (strong, nonatomic) SiFangMTLModel * currentSiFangMTLModel;

@property (strong, nonatomic) IBOutlet UICollectionView *collecctionViews;
@property (strong, nonatomic) NSMutableArray * collectionARR;

@property (strong, nonatomic) ZFPlayerModel * zfPlayerModel;

@property (strong, nonatomic) NSString * sourceName;
@property (strong, nonatomic) NSString * vid;

@end
