//
//  NavTopCommonImage.m
//  1PXianProject
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 JiJianNetwork. All rights reserved.
//

#import "NavTopCommonImage.h"

@implementation NavTopCommonImage

- (instancetype)initWithTitle:(NSString *)title 
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.frame = CGRectMake(0, 0, SIZE_WIDTH, 60);
        /*
        UIImageView * navBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 64)];
        //navBackImage.backgroundColor = [self makeColorWithHue:44 withSaturation:0.0 withbrightness:0.96 withAlpha:1.0];
        navBackImage.image = [UIImage imageNamed:@"navBackground@2x.png"];
        navBackImage.userInteractionEnabled = YES;
        */
        //self.backgroundColor = [CustomeColorObject makeColorWithHue:46 withSaturation:1 withbrightness:1 withAlpha:1.0f];
        
        self.backgroundColor = [UIColor colorWithhex16stringToColor:Main_BackgroundColor];
        //self.image = [UIImage imageNamed:@"navBackground@2x.png"];
        
        /*
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn setFrame:CGRectMake(7, 35, 25, 19)];
        [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"backBtn@2x.png"] forState:UIControlStateNormal];
        [self addSubview:backBtn];
        */
        
        self.tittleLabel = [[UILabel alloc]initWithFrame:CGRectMake( (SIZE_WIDTH-100)/2, 24, 100, 30)];
        self.tittleLabel.text = title;
        self.tittleLabel.textColor = [UIColor whiteColor];
        self.tittleLabel.font = [UIFont fontWithName:EN_FONT size:17.0f];
        self.tittleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tittleLabel];
        
        UIView * spView = [[UIView alloc]initWithFrame:CGRectMake(0, 62, SIZE_WIDTH, 1.3)];
        //spView.backgroundColor = [HFSUtility hexStringToColor:@"f1f1f1"];
        [self addSubview:spView];
        //[self addSubview:navBackImage];

    }
    return self;
}

- (void)backBtnAction:(UIButton *)sender{
    self.backsBlock(YES);//block方法
}

- (void)backButtonAction:(BackBtnBlock)block
{
    self.backsBlock = block;

}

- (void)loadLeftBackButtonwith:(int)index{
    if (index == 0) {
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(14, 28, 40, 22)];
        //[backBtn setBackgroundColor:[UIColor redColor]];
        [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        //[backBtn setBackgroundImage:[UIImage imageNamed:@"Left_Arrow"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"baisedajiantou"] forState:UIControlStateNormal];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 18);
        [self addSubview:backBtn];
    }

}

- (void)loadNavImageWithTitle:(NSString *)title{

    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
