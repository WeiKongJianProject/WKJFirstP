//
//  SecondVC02.h
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "ZLSecondAFNetworking.h"
#import "VIPViewCollectionViewCell.h"
#import "VIPVideoMTLModel.h"
@class SecondVC02;

@protocol SecondVC02Delegate <NSObject>

- (void)secondVC02:(SecondVC02 *)viewController withType:(int) typeInd withName:(NSString *)name withKey:(NSString *)keyId withIsShiKan:(BOOL)isShiKan;

@end


@interface SecondVC02 : ZLBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;
@property (weak, nonatomic) id<SecondVC02Delegate> delegate;

@property (strong, nonatomic) NSMutableArray * collectionViewARR;
@property (strong, nonatomic) NSString * numLabelText;

@property (strong, nonatomic) NSDictionary * currentMemInfoDic;

@property (assign, nonatomic) BOOL isFromFirstVCButton;

@end
