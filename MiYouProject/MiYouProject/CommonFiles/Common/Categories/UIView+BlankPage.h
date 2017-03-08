//
//  UIView+BlankPage.h
//  kongjiazai
//
//  Created by MR.Huang on 16/5/13.
//  Copyright © 2016年 hyh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EaseBlankPageView;
typedef NS_ENUM(NSInteger,EaseBlankPageType){
    EaseBlankPageTypeTuihuo,
    EaseBlankPageTypeShouHou,
    EaseBlankPageTypeXiaoxi,
    EaseBlankPageTypeZhuiZong,
    EaseBlankPageTypeShouCang,
    EaseBlankPageTypeShouCangstore,
    EaseBlankPageTypeShouhuodizhi,
    EaseBlankPageTypeGouWuDai,
    EaseBlankPageTypeDingdan,
    EaseBlankPageTypeLiuLan,
    EaseBlankPageTypePingjia,
};


@interface UIView (BlankPage)

@property (nonatomic,strong)EaseBlankPageView *blankPage;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData;

@end

@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (assign, nonatomic) EaseBlankPageType curType;

@property (copy, nonatomic) void(^clickButtonBlock)(EaseBlankPageType curType);
- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData;
@end