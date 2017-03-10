//
//  SearchViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/9.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    //
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self loadTopSearchView];
    [self registerForKeyboardNotifications];
}
- (void)loadTopSearchView{
    __weak typeof(self) weakSelf = self;
    NavTopCommonImage * topView = [[NavTopCommonImage alloc]initWithTitle:nil];
    [topView loadLeftBackButtonwith:0];
    [topView backButtonAction:^(BOOL succes) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:topView];
    
    
    
    //self.searchBar.delegate = self;
    
    //添加边框和提示
    UIView   *frameView = [[UIView alloc] initWithFrame:CGRectMake(45, 25, SIZE_WIDTH-45-46, 28)] ;
    frameView.backgroundColor = [UIColor whiteColor];
    frameView.layer.cornerRadius = 4.f;
    frameView.layer.masksToBounds = YES;
    
    CGFloat H = frameView.bounds.size.height - 8;
    CGFloat imgW = H;
    CGFloat textW = frameView.bounds.size.width - imgW - 6;
    NSLog(@"textW===%f",textW);
    
    UIImageView *searchImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sousuozhou"]];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(imgW+6, 4, textW, H)];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.enablesReturnKeyAutomatically = YES;
    self.searchTextField.delegate = self;
    self.searchTextField.enabled = YES;
    self.searchTextField.placeholder = @"三生三世";
    
    [frameView addSubview:self.searchTextField];
    [frameView addSubview:searchImg];
    searchImg.frame = CGRectMake(8 , 6, imgW-6, imgW-6);
    
    self.searchTextField.textColor = [UIColor grayColor];
    self.searchTextField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    
    [topView addSubview:frameView];
    
//    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [frameView addGestureRecognizer:singleTap];

    
    
    //弹出系统键盘
    //    [_searchBar becomeFirstResponder];
    //[self.searchTextField becomeFirstResponder];
    
    
    UIBarButtonItem *returnBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(returnAction :)];
    
    NSDictionary * attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    [returnBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [returnBtn setTintColor:RGBA(131, 131, 131, 1)];
    self.navigationItem.rightBarButtonItem = returnBtn;
    
//    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@""  style:UIBarButtonItemStylePlain target:self action:@selector(returnAction :)];
//    item.title = @"";
//    item.image = backButtonImage;
//    item.width = -20;
//    self.navigationItem.leftBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:@"#F6F6F6"];
    
    
    UIButton *  searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setBackgroundColor:[UIColor clearColor]];
    [searchButton setFrame:CGRectMake(SIZE_WIDTH-45, 27, 40, H+2)];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:searchButton];
    
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    [_rootScrollView addGestureRecognizer:gestureRecognizer];
//    gestureRecognizer.cancelsTouchesInView = NO;
//    
//    _context = [NSManagedObjectContext MR_defaultContext];
//    
//    self.edgesForExtendedLayout = UIRectEdgeBottom;
//    
//    self.clearBtn.backgroundColor = RGBA(174, 142, 93, 1);
//    self.clearBtn.layer.borderWidth =1;
//    self.clearBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);//201,201,201
//    self.clearBtn.layer.cornerRadius = 4.f;
//    self.clearBtn.layer.masksToBounds = YES;

    
}





- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
- (void)registerForKeyboardNotifications
{
    
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    NSLog(@"调用了Return方法");
    [self.searchTextField resignFirstResponder];
    
    return YES;
}

- (void)keyboardWasShown:(id)sender{

    NSLog(@"键盘弹出时，通知");
}

- (void)keyboardWillBeHidden:(id)sender{
    NSLog(@"键盘消失时，通知");

}

- (void)searchButtonAction:(UIButton *)sender{

    NSLog(@"点击了搜索按钮");
    [self.searchTextField resignFirstResponder];

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
