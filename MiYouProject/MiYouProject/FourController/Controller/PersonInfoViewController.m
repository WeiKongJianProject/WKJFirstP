//
//  PersonInfoViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/14.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "PersonInfoViewController.h"

@interface PersonInfoViewController ()

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:@"eeeeee"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 340) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.title = @"个人信息";
    
}

#pragma mark TableViewDelegate代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.0f;
    if (indexPath.row == 0) {
        height = 75.0f;
    }
    else{
        height = 50.0f;
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //firstTouXiangID  NormolID
    static NSString * cellID1 = @"firstTouXiangID";
    static NSString * cellID2 = @"NormolID";
    PersonTableViewCell * cell = nil;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell = (PersonTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:self options:nil][0];
        }
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell) {
            cell = (PersonTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:self options:nil][1];
        }
    }
    
    NSDictionary * userDic = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    NSLog(@"用户信息详情页：%@",userDic);
    switch (indexPath.row) {
        case 0:{
            
            //设置圆角
            cell.touXiangImageView.layer.cornerRadius = cell.touXiangImageView.frame.size.width / 2;
            //将多余的部分切掉
            cell.touXiangImageView.layer.masksToBounds = YES;
            
            //[cell.touXiangImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489550112931&di=aaf8556b5dc99730709ee5341c1178ce&imgtype=0&src=http%3A%2F%2Fstar.yule.com.cn%2Fuploadfile%2F2014%2Fcng%2Fyintao%2Fyule0117.jpg"]];
            
            UIImage * image = [self readHeadImageFromUserDefault];
            if (!zlObjectIsEmpty(image)) {
                [cell.touXiangImageView setImage:image];
            }
            else{
                [cell.touXiangImageView setImage:[UIImage imageNamed:@"touxiang"]];
            }
            self.headImageView = cell.touXiangImageView;
        }
            break;
        case 1:
            NSLog(@"第二行");
            cell.leftLabel.text = @"昵称";
            
            if (!zlDictIsEmpty(userDic)) {
                cell.rightNameLabel.text = userDic[@"nickname"];
            }
            break;
        case 2:
            cell.leftLabel.text = @"性别";
            if (!zlDictIsEmpty(userDic)) {
                cell.rightNameLabel.text = userDic[@"sex"];
            }
            break;
        case 3:
            cell.leftLabel.text = @"账号";
            if (!zlDictIsEmpty(userDic)) {
                cell.rightNameLabel.text = userDic[@"name"];
            }
            break;
        case 4:
            cell.leftLabel.text = @"密码";
            if (!zlDictIsEmpty(userDic)) {
                cell.rightNameLabel.text = userDic[@"password"];
            }
            break;
        default:
            break;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了cell");
    if (indexPath.row == 0) {
        [KZPhotoManager getImage:^(UIImage *image) {
            [self updataImage:image];
        } showIn:self AndActionTitle:@"选择照片"];
    }

}

#pragma end mark
- (void)updataImage:(UIImage *) image{
    [self.headImageView setImage:image];
    [self writeImageToUserDefaultWithImage:image];
    //[self.tableView reloadData];
    [self xw_postNotificationWithName:HEAD_IMAGEVIEW_UPDATA_NOTIFICATION userInfo:@{@"head":image}];
}

//读取本地 图片
- (UIImage *)readHeadImageFromUserDefault{
    UIImage *image;
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserHeaderImage"];
    image = [UIImage imageWithData:data];
    return  image;
}
//图片存入本地
- (void)writeImageToUserDefaultWithImage:(UIImage *)image{
    NSData *imgData = UIImageJPEGRepresentation(image, 0.3);
    [[NSUserDefaults standardUserDefaults] setObject:imgData forKey:@"UserHeaderImage"];
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
