//
//  SecondVC02.h
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "ZLSecondAFNetworking.h"


@interface SecondVC02 : ZLBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;

@property (strong, nonatomic) NSMutableArray * collectionViewARR;
@property (strong, nonatomic) NSString * numLabelText;

@end
