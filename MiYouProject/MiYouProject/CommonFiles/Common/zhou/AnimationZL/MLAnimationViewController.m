//
//  MLAnimationViewController.m
//  Matro
//
//  Created by lang on 16/7/20.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#import "MLAnimationViewController.h"

@interface MLAnimationViewController (){

    UIImageView * _imageviews;

}

@end

@implementation MLAnimationViewController{

    YYAnimationIndicator * _indicator;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    
    imageView.image = [UIImage imageNamed:@"lauchLoadzl"];
    
    [self.view addSubview:imageView];
    
    
    _imageviews = [[UIImageView alloc]initWithFrame:CGRectMake((SIZE_WIDTH-250)/2.0, SIZE_HEIGHT-300.0, 250, 15)];
    
    NSMutableArray * imageArr = [[NSMutableArray alloc]init];
    
    for (int i = 1; i<51; i++) {
        
    
        NSString * str = [NSString stringWithFormat:@"loading00%d",i];
        UIImage * image = [UIImage imageNamed:str];
        [imageArr addObject:image];
    }
    
    
    _imageviews.animationImages = imageArr;
    [self.view addSubview:_imageviews];
    
    //设置动画总时间
    _imageviews.animationDuration=1.0;
    //设置重复次数,0表示不重复
    _imageviews.animationRepeatCount=1;
    //开始动画
    [_imageviews startAnimating];
    
    [self performSelector:@selector(animationEndAction:) withObject:nil afterDelay:1.0f];
    /*
    _indicator = [[YYAnimationIndicator alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-60, 100, 120)];
    [_indicator setLoadText:@"努力加载中..."];
    
    [self.view addSubview:_indicator];
    
    [_indicator startAnimation];
     
     */
    // Do any additional setup after loading the view from its nib.
}

- (void)animationEndAction:(id)sender{

    self.block(YES);
}

- (void)animationBlockAction:(AnimationMLBlock)block{
    self.block = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
