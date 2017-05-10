//
//  CoreNewFeatureVC.m
//  CoreNewFeatureVC
//
//  Created by 冯成林 on 15/4/27.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreNewFeatureVC.h"
#import "NewFeatureScrollView.h"
#import "NewFeatureImageV.h"
#import "UIApplication+Extend.h"
#import "UIView+NFLayout.h"


NSString *const NewFeatureVersionKey = @"NewFeatureVersionKey";

@interface CoreNewFeatureVC (){

    UIButton * _mianZeButton;
}


/** 模型数组 */
@property (nonatomic,strong) NSArray *models;

/** scrollView */
@property (nonatomic,weak) NewFeatureScrollView *scrollView;

@property (nonatomic,copy) void(^enterBlock)();

@end

@implementation CoreNewFeatureVC

/*
 *  初始化
 */
+(instancetype)newFeatureVCWithModels:(NSArray *)models enterBlock:(void(^)())enterBlock{
    
    CoreNewFeatureVC *newFeatureVC = [[CoreNewFeatureVC alloc] init];
    
    newFeatureVC.models = models;
    
    //记录block
    newFeatureVC.enterBlock =enterBlock;
    
    return newFeatureVC;
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //控制器准备
    [self vcPrepare];
    
    //显示了版本新特性，保存版本号
    [self saveVersion];
}


/*
 *  显示了版本新特性，保存版本号
 */
-(void)saveVersion{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //[UIApplication sharedApplication].version;
    
    //保存版本号
    [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
}



/*
 *  控制器准备
 */
-(void)vcPrepare{
    
    //添加scrollView
    NewFeatureScrollView *scrollView = [[NewFeatureScrollView alloc] init];
    
    _scrollView = scrollView;

    //添加
    [self.view addSubview:scrollView];
    
    //添加约束
    [scrollView autoLayoutFillSuperView];
    
    //添加图片
    [self imageViewsPrepare];
}




/*
 *  添加图片
 */
-(void)imageViewsPrepare{
    
    [self.models enumerateObjectsUsingBlock:^(NewFeatureModel *model, NSUInteger idx, BOOL *stop) {
        
        NewFeatureImageV *imageV = [[NewFeatureImageV alloc] init];
        
        //设置图片
        imageV.image = model.image;
        
        //记录tag
        imageV.tag = idx;
        
        if(idx == self.models.count -1) {
            
            //开启交互
            imageV.userInteractionEnabled = YES;
            
            //添加手势
            //[imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)]];
            /*
             zhoulu修改 start
            */
            _mianZeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _mianZeButton.centerX = [[UIScreen mainScreen] bounds].size.width/2.0-45;
            _mianZeButton.width = 15;
            _mianZeButton.height = 15;
            _mianZeButton.bottom = [[UIScreen mainScreen] bounds].size.height-200;
            [_mianZeButton setBackgroundImage:[UIImage imageNamed:@"weixuanzhongmianze"] forState:UIControlStateNormal];
            [_mianZeButton setBackgroundImage:[UIImage imageNamed:@"xuanzhongmianze"] forState:UIControlStateSelected];
            _mianZeButton.selected = YES;
            [_mianZeButton addTarget:self action:@selector(buttonSelectedOrNO:) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:_mianZeButton];
            NSMutableAttributedString * one = [[NSMutableAttributedString alloc] initWithString:@"免责声明"];
            one.font = [UIFont systemFontOfSize:13.0];
            one.underlineStyle = NSUnderlineStyleSingle;
            
            [one setTextHighlightRange:one.rangeOfAll color:[UIColor whiteColor] backgroundColor:[UIColor colorWithWhite:0.0 alpha:0.22] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                NSLog(@"点击了免责声明");
                
                MianZeViewController02 * vc = [[MianZeViewController02 alloc]init];
                
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
                
            }];
            
            YYLabel * labelyy = [YYLabel new];
            labelyy.attributedText = one;
            labelyy.centerX = [[UIScreen mainScreen] bounds].size.width/2.0-30;
            labelyy.width = 70;
            labelyy.height = 15;
            labelyy.bottom = [[UIScreen mainScreen] bounds].size.height-200;
            labelyy.textAlignment = NSTextAlignmentCenter;
            labelyy.numberOfLines = 0;
            labelyy.backgroundColor = [UIColor clearColor];
            [imageV addSubview:labelyy];
//            labelyy.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//                NSLog(@"再次点击");
//            };
            
            UIButton * buttonStart = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonStart.width = SIZE_WIDTH;
            buttonStart.height = 50;
            buttonStart.bottom = SIZE_HEIGHT-70;
            buttonStart.backgroundColor = [UIColor clearColor];
            [buttonStart addTarget:self action:@selector(startButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:buttonStart];
            /*
             zhoulu修改 end
            */
            
            
        }
        
        [_scrollView addSubview:imageV];
    }];
}

//zhoulu修改 start
- (void)buttonSelectedOrNO:(UIButton *)sender{

    if (sender.isSelected == YES) {
        sender.selected = NO;
    }
    else{
        sender.selected = YES;
    }

}

- (void)startButtonAction{
    
    if (_mianZeButton.selected == YES) {
        NSLog(@"点击了进入按钮");
        [self dismiss];
    }
    else{
    
    }
    

}

//zhoulu修改  end


-(void)gestureAction:(UITapGestureRecognizer *)tap{
    
//    UIView *tapView = tap.view;
//    
//    //禁用
//    tapView.userInteractionEnabled = NO;
//    
//    if(UIGestureRecognizerStateEnded == tap.state) {
//        [self dismiss];
//    }
}

-(void)dismiss{
    
    if(self.enterBlock != nil) _enterBlock();
}

/*
 *  是否应该显示版本新特性页面
 */
+(BOOL)canShowNewFeature{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //[UIApplication sharedApplication].version;
    
    //[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
    //读取本地版本号
    NSString *versionLocal = [[NSUserDefaults standardUserDefaults] objectForKey:NewFeatureVersionKey];
    NSLog(@"++++---当前的版本号为：%@-----%@",versionValueStringForSystemNow,versionLocal);
    if(versionLocal!=nil && [versionValueStringForSystemNow isEqualToString:versionLocal]){//说明有本地版本记录，且和当前系统版本一致
        
        return NO;
        
    }else{//无本地版本记录或本地版本记录与当前系统版本不一致
        
        //保存
        [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
        
        return YES;
    }
}
@end
