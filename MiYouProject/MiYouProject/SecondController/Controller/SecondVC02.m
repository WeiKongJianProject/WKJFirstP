//
//  SecondVC02.m
//  MiYouProject
//
//  Created by wkj on 2017/3/31.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SecondVC02.h"

@interface SecondVC02 ()

@end
//VIPVideoCellID
@implementation SecondVC02

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * num = [NSString stringWithFormat:@"片库约为%@部",self.numLabelText];
    self.numLabel.text = num;
    NSLog(@"secondVC02数组个数：%ld",self.collectionViewARR.count);
    // Do any additional setup after loading the view from its nib.
}

- (NSMutableArray *)collectionViewARR{
    if (!_collectionViewARR) {
        _collectionViewARR = [[NSMutableArray alloc]init];
    }
    return _collectionViewARR;
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
