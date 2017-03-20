//
//  SearchViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/9.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "ZLBaseViewController.h"

@interface SearchViewController : ZLBaseViewController<UISearchBarDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UISearchBar * searchBar;
@property (strong, nonatomic) UITextField * searchTextField;
@property (strong, nonatomic) UIView * headerView;
@property (strong, nonatomic) UITableView * tableview;
@property (strong, nonatomic) NSMutableArray * lishiARR;



@end
