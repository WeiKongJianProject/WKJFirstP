//
//  ThirdViewController.h
//  SecondProject
//
//  Created by wkj on 2017/3/6.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface ThirdViewController : ZLBaseViewController<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic) WKWebView* webView;

@end
