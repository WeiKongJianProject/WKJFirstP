//
//  UIView+BlankPage.m
//  kongjiazai
//
//  Created by MR.Huang on 16/5/13.
//  Copyright © 2016年 hyh. All rights reserved.
//

#import "UIView+BlankPage.h"
#import <objc/runtime.h>
#import "Masonry.h"
#import "HFSConstants.h"

@implementation UIView (BlankPage)
static char  BlankPageViewKey;

- (void)setBlankPage:(EaseBlankPageView *)blankPage{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (EaseBlankPageView *)blankPage{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData{
    if (hasData) {
        if (self.blankPage) {
            self.blankPage.hidden = YES;
            [self.blankPage removeFromSuperview];
        }
    }else{
        if (!self.blankPage) {
            self.blankPage = [[EaseBlankPageView alloc] initWithFrame:CGRectMake(0, 60, self.bounds.size.width, self.bounds.size.height)];
        }
        self.blankPage.hidden = NO;
        [self.blankPageContainer addSubview:self.blankPage];
        
        
        [self.blankPage configWithType:blankPageType hasData:hasData];
    }
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}


@end



@implementation EaseBlankPageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData{
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageView];
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = RGBA(80, 80, 80, 1);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    //    布局
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(30);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_imageView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
 
    NSString *imageName, *tipStr;
    _curType = blankPageType;
    switch (blankPageType) {
        case EaseBlankPageTypeTuihuo://空退货
        {
            imageName = @"icon_shouhou_kong";
            tipStr = @"您暂时没有可退货订单";
        }
            break;
        case EaseBlankPageTypeShouHou://空收货
        {
            imageName = @"icon_shouhou_kong";
            tipStr = @"您暂时没有售后记录";
        }
            break;
        case EaseBlankPageTypeXiaoxi://空收货
        {
            imageName = @"空消息";
            tipStr = @"您还没有消息";
        }
            break;
        case EaseBlankPageTypeShouCang://空收藏
        {
            imageName = @"icon_shouhou_kong";
            tipStr = @"您还没有收藏的商品";
        }
            break;
        case EaseBlankPageTypeShouCangstore://空收藏
        {
            imageName = @"icon_shouhou_kong";
            tipStr = @"您还没有收藏的店铺";
        }
            break;
        case EaseBlankPageTypeLiuLan://空浏览
        {
            imageName = @"icon_zuji_kong";
            tipStr = @"您还没有浏览的商品";
            
        }
        break;
            
        case EaseBlankPageTypeGouWuDai://空购物袋
        {
            imageName = @"wufaxianshi";
            tipStr = @"购物袋还空着呢";
           
        }
        break;
        case EaseBlankPageTypeDingdan://空订单
        {
            imageName = @"icon_wudingdan";
            tipStr = @"您目前还没有订单";
            
        }
            break;
        case EaseBlankPageTypeShouhuodizhi://空地址记录
        {
            imageName = @"icon_zanwu";
            tipStr = @"暂无收货地址，请直接新增";
            
        }
            break;
        case EaseBlankPageTypeZhuiZong://空浏览
        {
            imageName = @"";
            tipStr = @"暂无物流信息";
        }
            break;
        case EaseBlankPageTypePingjia://空评价
        {
            imageName = @"";
            tipStr = @"没有评价信息额";
        }
            break;
    }
    [_imageView setImage:[UIImage imageNamed:imageName]];
    _tipLabel.text = tipStr;
    
    if (blankPageType>=EaseBlankPageTypeShouCang) {
        
        //新增按钮
        UIButton *actionBtn=({
            UIButton *button=[UIButton new];
            [button setBackgroundImage:[UIImage imageNamed:@"btn_tijiao"] forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
        [self addSubview:actionBtn];
        actionBtn.layer.cornerRadius = 5.f;
        actionBtn.layer.masksToBounds = YES;
        
        [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200 , 40));
            make.top.equalTo(_tipLabel.mas_bottom).offset(15);
            make.centerX.equalTo(self);
        }];
        if (blankPageType == EaseBlankPageTypeShouhuodizhi) {
            [actionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_tipLabel.mas_bottom).offset(15);
                make.centerX.equalTo(self);
                make.left.mas_equalTo(self).offset(50);
                make.right.mas_equalTo(self).offset(-50);
                make.height.mas_equalTo(40);
            }];
            actionBtn.layer.masksToBounds = YES;
            actionBtn.layer.cornerRadius = 3.f;
        }
        
        NSString *titleStr;
        switch (blankPageType) {
            case EaseBlankPageTypeShouCang:{
                actionBtn.hidden = YES;
                //titleStr=@"去逛逛";
                break;
            }
                
            case EaseBlankPageTypeShouCangstore:{
                actionBtn.hidden = YES;
                //titleStr=@"去逛逛";
                break;
            }
                
            case EaseBlankPageTypeLiuLan:{
                titleStr=@"去逛逛";
                break;
            }
               
            case EaseBlankPageTypeGouWuDai:{
                
                titleStr=@"去逛逛";
                break;
            }
            case EaseBlankPageTypeDingdan:{
                _tipLabel.textColor = RGBA(80, 80, 80, 1);
                titleStr=@"去逛逛";
                break;
            }
            case EaseBlankPageTypeShouhuodizhi:{
                titleStr = @"新增收货地址";
                break;
            }
            case EaseBlankPageTypePingjia:{
                actionBtn.hidden = YES;
                //titleStr = @"新增收货地址";
                break;
            }
            default:
                break;
        }
        
        
        [actionBtn setTitle:titleStr forState:UIControlStateNormal];
        
    }

  
}


-(void)btnAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_clickButtonBlock) {
            _clickButtonBlock(_curType);
        }
    });
}


@end













