//
//  FourViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/8.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "FourViewController.h"


@interface FourViewController (){

    
    CGFloat _index_0_height;//295.0/675.0
    CGFloat _index_1_height;
    CGFloat _index_2_height;

}

@end

static int jd;

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * memDic = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_INFO_DIC];
    self.userInfoModel = [MTLJSONAdapter modelOfClass:[UserInfoMTLModel class] fromJSONDictionary:memDic error:nil];
    
    _index_0_height = SIZE_WIDTH*(295.0/675.0);
    _index_1_height = SIZE_WIDTH*(50.0/325.0);
    [self loadTableview];
    
    __weak typeof(self) weakSelf = self;
    [self xw_addNotificationForName:HEAD_IMAGEVIEW_UPDATA_NOTIFICATION block:^(NSNotification * _Nonnull notification) {
        [weakSelf.headImageView setImage:notification.userInfo[@"head"]];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    jd = 1;//加载会员图片 时判断
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self startAFNetworking];
    
}

- (void)startAFNetworking{
    //&action=memberCenter&id=1
    [MBManager showLoadingInView:self.view];
    /*
     "member":{
     "id":1,
     "name":"\u5f20\u4e09",
     "password":"123456",
     “group”:0,
     }
     */
    __weak typeof(self) weakSelf = self;
    NSString * urlstring = [NSString stringWithFormat:@"%@&action=memberCenter&id=%@",URL_Common_ios,self.userInfoModel.id];
    NSLog(@"用户中心请求的链接为：%@",urlstring);
    [[ZLSecondAFNetworking sharedInstance] getWithURLString:urlstring parameters:nil success:^(id responseObject) {
        NSDictionary *  dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"用户中心请求的数据为：%@",dic);
        if ([dic[@"result"] isEqualToString:@"success"]) {
            weakSelf.userMessageModel = [MTLJSONAdapter modelOfClass:[UserMessageMTLModel class] fromJSONDictionary:dic error:nil];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"points"] forKey:MEMBER_POINTS_NUM];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"vip"] forKey:MEMBER_VIP_LEVEL];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           [weakSelf.tableView reloadData];
        });
        [MBManager hideAlert];
    } failure:^(NSError *error){
        [MBManager hideAlert];
         [MBManager showBriefAlert:@"加载失败"];
    }];
   
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
}
- (void)loadTableview{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-49.0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithhex16stringToColor:Main_grayBackgroundColor];
    [self.view addSubview:self.tableView];
    
}
#pragma mark TableviewDelegate方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.0f;
    if (indexPath.row == 0) {
        height = _index_0_height;
    }
    else if (indexPath.row == 1){
        height = 60.0f;
    }
    else{
        height = 60.0f;
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"PersonCenterCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor redColor];
    if (indexPath.row == 0) {
        static NSString * headerCellID = @"HeadCellID";
       PersonHederTableViewCell* hcell = (PersonHederTableViewCell *)[tableView dequeueReusableCellWithIdentifier:headerCellID];
        if (!hcell) {
            hcell = (PersonHederTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"PersonHederTableViewCell" owner:self options:nil][0];
        }
        hcell.userNameLabel.text = self.userInfoModel.nickname;
        hcell.huiYuanDengJiLabel.text = self.userInfoModel.vipName;
        hcell.UBiNumLabel.text = [NSString stringWithFormat:@"%d",[self.userMessageModel.points intValue]];
        UIImage * image = [self readHeadImageFromUserDefault];
        if (!zlObjectIsEmpty(image)) {
            [hcell.headerImageVIew setImage:image];
        }

//        //设置圆角
//        cellhead.headerImageVIew.layer.cornerRadius = cellhead.imageView.frame.size.width / 2;
//        //将多余的部分切掉
//        cellhead.headerImageVIew.layer.masksToBounds = YES;
        self.headImageView = hcell.headerImageVIew;
        cell = hcell;
    }
    else if (indexPath.row == 1){
    //  325/50  ButtonsCellID
        static NSString * buttonCellID = @"ButtonsCellID";
        ButtonsTableViewCell * fcell = (ButtonsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ButtonsTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ButtonsTableViewCell" owner:self options:nil][0];
        }
        [fcell.firstButtonControl addTarget:self action:@selector(firstButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [fcell.secondButtonCOntrol addTarget:self action:@selector(secondButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [fcell.thirdButtonControl addTarget:self action:@selector(thirdButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.userMessageModel.messageNum intValue] > 0) {
            NSString * value = [NSString stringWithFormat:@"%d",[self.userMessageModel.messageNum intValue]];
            [fcell.xiaoXiImageVIew showBadgeValue:value];
        }
        
        cell = fcell;
    }
    else if (indexPath.row == 2){
    
        static NSString * buttonCellID = @"ThirdTeQuanTableViewCellID";
        ThirdTeQuanTableViewCell * fcell = (ThirdTeQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ThirdTeQuanTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ThirdTeQuanTableViewCell" owner:self options:nil][0];
        }
        for (UIButton * btn in fcell.VIPButtonARR) {
            btn.hidden = YES;
        }
        NSArray * vipListARR = [self.userMessageModel.viplist mutableCopy];
        NSLog(@"请求的用户VIP特权为：%ld,cell.ButtonARR的个数为：%ld",vipListARR.count,fcell.VIPButtonARR.count);
        NSInteger zonButNum;
        if (vipListARR.count > fcell.VIPButtonARR.count) {
            zonButNum = fcell.VIPButtonARR.count;
        }
        else{
            zonButNum = vipListARR.count;
        }
        
        for (int i = 0; i<zonButNum; i++) {
            NSString * stringURL = vipListARR[i];
            UIButton * btn = (UIButton *)fcell.VIPButtonARR[i];
            btn.hidden = NO;
            NSLog(@"会员图标的链接：%@--%p",stringURL,btn);
            //[btn sd_setBackgroundImageWithURL:[NSURL URLWithString:stringURL] forState:UIControlStateNormal];
            //[btn sd_setBackgroundImageWithURL:[NSURL URLWithString:stringURL] forState:UIControlStateNormal placeholderImage:PLACEHOLDER_IMAGE];
            //"https://www.baidu.com/img/bdlogo.png"
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:stringURL] forState:UIControlStateNormal placeholderImage:PLACEHOLDER_IMAGE options:SDWebImageRetryFailed];
            //[btn sd_setImageWithURL:[NSURL URLWithString:stringURL] forState:UIControlStateNormal placeholderImage:PLACEHOLDER_IMAGE options:SDWebImageLowPriority];
            //[btn sd_setImageWithURL:[NSURL URLWithString:stringURL] forState:UIControlStateNormal placeholderImage:PLACEHOLDER_IMAGE];
//            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:stringURL] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                NSLog(@"会员图片设置完成！");
////                if (i == zonButNum-1) {
////                    //[self.tableView reloadData];
////                    NSLog(@"jd的值为：%d",jd);
////                    if (jd == 1) {
////                        [self.tableView reloadData];
////                        jd++;
////                    }
////                }
//                
//            }];
            
            if (i == zonButNum-1) {
                                    //[self.tableView reloadData];
                                    NSLog(@"jd的值为：%d",jd);
                                    if (jd == 1) {
                                        //[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                        jd++;
                                    }
            }
            //[btn setNeedsDisplay];
        }
        //[fcell setNeedsDisplay];
        cell = fcell;
    }
    else if (indexPath.row == 3){
        static NSString * buttonCellID = @"ThirdTeQuanTableViewCellID";
        ThirdTeQuanTableViewCell * fcell = (ThirdTeQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ThirdTeQuanTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ThirdTeQuanTableViewCell" owner:self options:nil][0];
        }
        fcell.nameLabel.text = @"我的钱包";
        [fcell.leftImageView setImage:[UIImage imageNamed:@"wodeqianbao"]];
        fcell.aiQiYiButton.hidden = YES;
        fcell.youKuButton.hidden = YES;
        fcell.leShiButton.hidden = YES;
        fcell.tuDouButton.hidden = YES;
        fcell.mangGuoButton.hidden = YES;
        fcell.souHuButton.hidden = YES;
        cell = fcell;
    }
    else if (indexPath.row == 4){
        static NSString * buttonCellID = @"ThirdTeQuanTableViewCellID";
        ThirdTeQuanTableViewCell * fcell = (ThirdTeQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ThirdTeQuanTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ThirdTeQuanTableViewCell" owner:self options:nil][0];
        }
        fcell.nameLabel.text = @"离线中心";
        [fcell.leftImageView setImage:[UIImage imageNamed:@"lixianzhongxing"]];
        fcell.aiQiYiButton.hidden = YES;
        fcell.youKuButton.hidden = YES;
        fcell.leShiButton.hidden = YES;
        fcell.tuDouButton.hidden = YES;
        fcell.mangGuoButton.hidden = YES;
        fcell.souHuButton.hidden = YES;
        cell = fcell;
    }
    else if (indexPath.row == 5){
        static NSString * buttonCellID = @"ThirdTeQuanTableViewCellID";
        ThirdTeQuanTableViewCell * fcell = (ThirdTeQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
        if (!fcell) {
            fcell = (ThirdTeQuanTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ThirdTeQuanTableViewCell" owner:self options:nil][0];
        }
        fcell.nameLabel.text = @"设置";
        [fcell.leftImageView setImage:[UIImage imageNamed:@"shezhi"]];
        fcell.aiQiYiButton.hidden = YES;
        fcell.youKuButton.hidden = YES;
        fcell.leShiButton.hidden = YES;
        fcell.tuDouButton.hidden = YES;
        fcell.mangGuoButton.hidden = YES;
        fcell.souHuButton.hidden = YES;
        cell = fcell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了");
    if (indexPath.row == 3) {
        MyYuEViewController * yuEVC = [[MyYuEViewController alloc]init];
        //yuEVC.yuELabel.text = [NSString stringWithFormat:@"%d",[self.userMessageModel.points intValue]];
        yuEVC.userModel = self.userMessageModel;
        [self.navigationController pushViewController:yuEVC animated:YES];
    }
    if (indexPath.row == 0) {
        PersonInfoViewController * vc = [[PersonInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        HuanCunCenterViewController * vc = [[HuanCunCenterViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 5) {
        SettingViewController * setVC = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
    
}

#pragma end mark
//三个按钮组的执行方法
- (void)firstButtonAction:(UIControl *)sender{
    NSLog(@"执行了消息按钮");
    XiaoXiViewController * vc = [[XiaoXiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)secondButtonAction:(UIControl *)sender{
    NSLog(@"执行了充值UB按钮");
    ChongZhiViewController * VC = [[ChongZhiViewController alloc]init];
    VC.UB_or_VIP = UB_ChongZhi;
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)thirdButtonAction:(UIControl *)sender{
    NSLog(@"执行了VIP按钮");
    ChongZhiViewController * VC = [[ChongZhiViewController alloc]init];
    VC.UB_or_VIP = VIP_ChongZhi;
    [self.navigationController pushViewController:VC animated:YES];
}
//读取本地 图片
- (UIImage *)readHeadImageFromUserDefault{
    UIImage *image;
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserHeaderImage"];
    image = [UIImage imageWithData:data];
    return  image;
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
