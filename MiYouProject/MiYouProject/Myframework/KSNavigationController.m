//
//  KSNavigationController.m
//  Navigation
//
//  Created by 史金亮 on 15/12/9.
//  Copyright © 2015年 kamy. All rights reserved.
//

#import "KSNavigationController.h"

@interface KSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self childViewControllerForStatusBarStyle];
    [self childViewControllerForStatusBarHidden];
    //设置手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    //设置NavigationBar
    [self setupNavigationBar];
    
}

//设置导航栏主题
- (void)setupNavigationBar
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式。
    [appearance setBarTintColor:[UIColor getColor:@"fb9c0a"]];
    
    //导航栏title格式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttribute];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 26)];
        [backButton setImage:[UIImage imageNamed:@"baisedajiantou"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"baisedajiantou"] forState:UIControlStateHighlighted];
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 13)];
        [backButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popView
{
    [self popViewControllerAnimated:YES];
}

//手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden{

    return self.topViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
