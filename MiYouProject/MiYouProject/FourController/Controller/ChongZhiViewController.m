//
//  ChongZhiViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/15.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ChongZhiViewController.h"

@interface ChongZhiViewController ()

@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    [self.menuItems addObjectsFromArray:@[@"U币充值",@"充值VIP"]];
    
    self.navigationItem.titleView = self.control;
    
    if (self.UB_or_VIP == UB_ChongZhi) {
        self.control.selectedSegmentIndex = 0;
        
        
    }
    else{
        self.control.selectedSegmentIndex = 1;
    }
    
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64)];
    [self.view addSubview:self.backgroundView];
    
    self.UBView = (UBChongZhiView *)[[NSBundle mainBundle] loadNibNamed:@"UBChongZhiView" owner:self options:nil][0];
    [self.UBView setFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-64)];
    
    self.VIPView = (VIPChongZhiView *)[[NSBundle mainBundle] loadNibNamed:@"UBChongZhiView" owner:self options:nil][1];
    [self.VIPView setFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-64)];
    [self.backgroundView addSubview:self.UBView];
    [self.backgroundView addSubview:self.VIPView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.clipsToBounds = YES;
    
    //[self updateControlCounts];
    
    if (self.UB_or_VIP == UB_ChongZhi) {
        self.VIPView.hidden = YES;
        self.UBView.hidden = NO;
        self.UB_or_VIP = UB_ChongZhi;
        
        
    }
    else{
        self.UB_or_VIP = VIP_ChongZhi;
        self.UBView.hidden = YES;
        self.VIPView.hidden = NO;
    }
    
}
//+ (void)initialize
//{
//#if DEBUG_APPERANCE
//    
//    [[DZNSegmentedControl appearance] setBackgroundColor:kBakgroundColor];
//    [[DZNSegmentedControl appearance] setTintColor:kTintColor];
//    [[DZNSegmentedControl appearance] setHairlineColor:kHairlineColor];
//    
//    [[DZNSegmentedControl appearance] setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:15.0]];
//    [[DZNSegmentedControl appearance] setSelectionIndicatorHeight:2.5];
//    [[DZNSegmentedControl appearance] setAnimationDuration:0.125];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor], NSFontAttributeName: [UIFont systemFontOfSize:18.0]}];
//    
//#endif
//}
- (NSMutableArray *)menuItems{
    if (!_menuItems) {
        _menuItems = [[NSMutableArray alloc]init];
    }
    return _menuItems;
}

- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        
        _control.bouncySelectionIndicator = NO;
        _control.height = 44.0f;
        
        //                _control.height = 120.0f;
        //                _control.width = 300.0f;
        //                _control.showsGroupingSeparators = YES;
        //                _control.inverseTitles = YES;
                        _control.backgroundColor = [UIColor clearColor];
                        _control.tintColor = [UIColor whiteColor];
        //                _control.hairlineColor = [UIColor purpleColor];
                        _control.showsCount = NO;
        //                _control.autoAdjustSelectionIndicatorWidth = NO;
        //                _control.selectionIndicatorHeight = 4.0;
        //                _control.adjustsFontSizeToFitWidth = YES;
        
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
}

#pragma mark - ViewController Methods
- (void)addSegment:(id)sender
{
    NSUInteger newSegment = self.control.numberOfSegments;
    
//#if DEBUG_IMAGE
//    [self.control setImage:[UIImage imageNamed:@"icn_clock"] forSegmentAtIndex:newSegment];
//#else
    [self.control setTitle:[@"Favorites" uppercaseString] forSegmentAtIndex:newSegment];
    //[self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:newSegment];
//#endif
}
- (void)refreshSegments:(id)sender
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.menuItems];
    NSUInteger count = [array count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    self.menuItems = array;
    
    [self.control setItems:self.menuItems];
    [self updateControlCounts];
}

- (void)updateControlCounts
{
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:0];
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:1];
//    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:2];
    
//#if DEBUG_APPERANCE
//    [self.control setTitleColor:kHairlineColor forState:UIControlStateNormal];
//#endif
}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    
    if (control.selectedSegmentIndex == 0) {
        self.VIPView.hidden = YES;
        self.UBView.hidden = NO;
        self.UB_or_VIP = UB_ChongZhi;
    }
    else{
        self.UB_or_VIP = VIP_ChongZhi;
        self.UBView.hidden = YES;
        self.VIPView.hidden = NO;
    }
    
}
#pragma mark - DZNSegmentedControlDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
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
