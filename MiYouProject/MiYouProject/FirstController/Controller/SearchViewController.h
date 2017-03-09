//
//  SearchViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/9.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"

@interface SearchViewController : ZLBaseViewController<UISearchBarDelegate,UITextFieldDelegate>


@property (strong, nonatomic) UISearchBar * searchBar;
@property (strong, nonatomic) UITextField * searchTextField;

@end
