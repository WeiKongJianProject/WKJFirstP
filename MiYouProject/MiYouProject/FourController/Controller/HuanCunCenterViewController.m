//
//  HuanCunCenterViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/16.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "HuanCunCenterViewController.h"



@interface HuanCunCenterViewController (){
    
    BOOL _isEditing;
    BOOL _isAllSelected;
}

@end

@implementation HuanCunCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isEditing = NO;
    _isAllSelected = NO;
    //[self.videoARR addObjectsFromArray:@[@"1",@"3",@"2",@"4",@"5"]];
    [self huoquHuanCunVideoARR];

    self.selectButtonARR  = [[NSMutableArray alloc]init];
    self.buttonsZongARR = [[NSMutableArray alloc]init];
    self.tableview  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-32.0) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    self.footView = [[NSBundle mainBundle] loadNibNamed:@"HuanCunFooterView" owner:self options:nil][0];
    //[self.footView setFrame:CGRectMake(0, SIZE_HEIGHT-32.0, SIZE_WIDTH, 32.0f)];
    
    [self.view addSubview:self.footView];
    self.footView.hidden = YES;
    [self.footView.quanXuanButton addTarget:self action:@selector(quanXuanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView.deleteButton addTarget:self action:@selector(deleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"第一次加载缓存视图中：self.footView.frame.size=x-y-w-h,%g=%g=%g=%g",self.footView.frame.origin.x,self.footView.frame.origin.y,self.footView.frame.size.width,self.footView.frame.size.height);
}
//获取缓存视频
- (void)huoquHuanCunVideoARR{
    
    NSLog(@"获取缓存视频");
    /*
     for (int i = 0; i<3; i++) {
     VideoModelZL * videoModel = [[VideoModelZL alloc]init];
     NSString  * namestr = [NSString stringWithFormat:@"video%d",i];
     videoModel.videoName = namestr;
     [self.videoARR addObject:videoModel];
     }
     */
    NSString * shahePath = [NSFileManagerZL pathDocument];
    NSLog(@"沙盒的路径为：%@",shahePath);
    NSArray * arr = [NSFileManagerZL getAllFloderByName:shahePath];
    
    for (int i =0 ; i<arr.count; i++) {
        
        NSString  * namestr = (NSString *)arr[i];
        
        NSString * quanChengStr = [shahePath stringByAppendingPathComponent:namestr];
        NSURL * urls = [NSURL fileURLWithPath:quanChengStr];
        
        if ([NSFileManagerZL panDuanHouZhuiis:@"mp4" withPath:namestr] || [NSFileManagerZL panDuanHouZhuiis:@"MP4" withPath:namestr]) {
            
            
            VideoModelZL * videoModel = [[VideoModelZL alloc]init];
            NSString * path = [shahePath stringByAppendingPathComponent:namestr];
            videoModel.videoName = namestr;
            videoModel.cachePath = path;
            videoModel.fileSize = [NSFileManagerZL fileSizeAtPath:path];
            videoModel.image = [self thumbnailImageForVideo:urls atTime:0.1];
            [self.videoARR addObject:videoModel];
        }
        
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.title = @"缓存";
    
    self.rightButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self action:@selector(bianjiButtonAction:)];
    self.rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.rightButton;
    NSLog(@"第二次加载缓存视图中：self.footView.frame.size=x-y-w-h,%g=%g=%g=%g",self.footView.frame.origin.x,self.footView.frame.origin.y,self.footView.frame.size.width,self.footView.frame.size.height);
}



//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self.footView setFrame:CGRectMake(0, SIZE_HEIGHT-32.0, SIZE_WIDTH, 32.0f)];
//    NSLog(@"第三次加载缓存视图中：self.footView.frame.size=x-y-w-h,%g=%g=%g=%g",self.footView.frame.origin.x,self.footView.frame.origin.y,self.footView.frame.size.width,self.footView.frame.size.height);
//}

- (NSMutableArray *)videoARR{
    
    if(!_videoARR){
        
        _videoARR = [[NSMutableArray alloc]init];
    }
    return _videoARR;
}

- (void)bianjiButtonAction:(UIBarButtonItem *)sender{
    
    //NSLog(@"点击了编辑按钮");
    _isAllSelected = NO;
    if(self.tableview.isEditing){
        //[self.tableview setFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
        //self.tableview.frame.size
        self.footView.hidden = YES;
        _isEditing = NO;
        [self.tableview setEditing:NO animated:YES];
        [self.rightButton setTitle:@"编辑"];
    }
    else{
        //[self.tableview setFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-64.0)];
        [self.rightButton setTitle:@"完成"];
        self.footView.hidden = NO;
        
        NSLog(@"缓存视图中：self.footView.frame.size=x-y-w-h,%g=%g=%g=%g",self.footView.frame.origin.x,self.footView.frame.origin.y,self.footView.frame.size.width,self.footView.frame.size.height);
        _isEditing = YES;
        [self.tableview setEditing:YES animated:YES];
        
    }
    
}

#pragma mark TableViewDelegate代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoARR.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //firstTouXiangID  NormolID
    static NSString * cellID1 = @"HuanCunZlCellID";
    HuanCunZLTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    //HuanCunZLTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = (HuanCunZLTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"HuanCunZLTableViewCell" owner:self options:nil][0];
    }
    //编辑状态下不缩回
    //cell.shouldIndentWhileEditing = YES;
    //    //清除所有视图，避免显示混乱
    //    for (UIView * view in cell.contentView.subviews) {
    //        [view removeFromSuperview];
    //    }
    //NSLog(@"加载单元格的行为：%ld",indexPath.row);
    [cell.leftButton02 addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.leftButton02.row = indexPath.row;
    NSNumber * num = [NSNumber numberWithInteger:indexPath.row];
    if (![self.buttonsZongARR containsObject:num]) {
        [self.buttonsZongARR addObject:num];
    }
    
    
    if (_isAllSelected) {
        NSLog(@"全选了 按钮");
        NSNumber * num = [NSNumber numberWithInteger:indexPath.row];
        
        [self.selectButtonARR addObject:num];
        
        cell.leftButton02.selected = YES;
    }
    else{
        if ([self.selectButtonARR containsObject:num]) {
            NSLog(@"在已选择按钮里是否存在此按钮：存在");
            cell.leftButton02.selected = YES;
        }
        else{
            //NSLog(@"不存在");
            cell.leftButton02.selected = NO;
        }
    }
    
    if (_isEditing) {
        cell.leftButton02.hidden = NO;
    }
    else{
        cell.leftButton02.hidden = YES;
    }
    
//    NSString * str = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490315625&di=9623f388ed874fa396bbdf09f3e54647&imgtype=jpg&er=1&src=http%3A%2F%2Fimg.cx368.com%2Fuploadfile%2F2017%2F0303%2F20170303095605511.jpg";
//    NSURL * url = [NSURL URLWithString:str];
//    [cell.leftImageView sd_setImageWithURL:url];
    
    VideoModelZL * Vmodel = [self.videoARR objectAtIndex:indexPath.row];
    cell.videoNameLabel.text = Vmodel.videoName;
    float sizeNum = Vmodel.fileSize / (1024.0*1024.0);
    cell.videoSizeLabel.text = [NSString stringWithFormat:@"%.1fMB",sizeNum];
    [cell.leftImageView setImage:Vmodel.image];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"点击了cell");
    VideoModelZL * Vmodel = [self.videoARR objectAtIndex:indexPath.row];
    NSString * filePath = [[NSFileManagerZL pathDocument] stringByAppendingPathComponent:Vmodel.videoName];
    SiFangPlayController * vc = [[SiFangPlayController alloc]init];
    vc.isBenDi  = YES;
    NSURL * url = [NSURL fileURLWithPath:filePath];
    vc.benDiUrl = url;
    vc.benDiName = Vmodel.videoName;
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCellEditingStyleDelete
    //NSLog(@"-----执行了编辑方法02");
    //UITableViewCellEditingStyleNone
    return UITableViewCellEditingStyleNone;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"执行了编辑方法");
    if (_isEditing) {
        HuanCunZLTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        //cell.leftButton02.hidden = NO;
        [self performSelector:@selector(xianShiButton:) withObject:cell afterDelay:0.19];
    }else{
        HuanCunZLTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.leftButton02.hidden = YES;
        cell.leftButton02.selected = NO;
        [self.selectButtonARR removeAllObjects];
    }
    
    return YES;
}
- (void)xianShiButton:(HuanCunZLTableViewCell *)cell{
    
    cell.leftButton02.hidden = NO;
    
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"执行了编辑完成按钮");
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        NSLog(@"点击删除");
        
        //        if (indexPath.row<[self.arrayOfRows count]) {
        //            [self.arrayOfRows removeObjectAtIndex:indexPath.row];//移除数据源的数据
        //            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
        //        }
        if (indexPath.row < self.videoARR.count ) {
            //[self.videoARR removeObjectAtIndex:indexPath.row];
            //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        
        
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
#pragma end mark
//左侧选择按钮执行方法
- (void)leftButtonAction:(ZLButtons *)sender{
    //NSLog(@"点击了左侧按钮");
    _isAllSelected = NO;
    NSNumber * num = [NSNumber numberWithInteger:sender.row];
    if (sender.isSelected) {
        sender.selected = NO;
        [self.selectButtonARR removeObject:num];
    }
    else{
        sender.selected = YES;
        [self.selectButtonARR addObject:num];
    }
    
}
//全选  按钮执行方法
- (void)quanXuanButtonAction:(UIButton *)sender{
    //[NSFileManagerZL pathDocument];

    if (_isAllSelected == YES) {
        [self.selectButtonARR removeAllObjects];
        _isAllSelected = NO;
        [self.tableview reloadData];
    }else{
        _isAllSelected = YES;
        [self.tableview reloadData];
    }
    //NSString * sizeStr = [NSFileManagerZL getCacheSizeWithFilePath:[NSFileManagerZL pathDocument]];
    //NSLog(@"documents文件下的文件大小为：%@",sizeStr);
    //
}

//删除按钮  执行方法
- (void)deleButtonAction:(UIButton *)sender{
    if (_isAllSelected) {
        _isAllSelected = NO;
        [NSFileManagerZL clearCacheWithFilePath:[NSFileManagerZL pathDocument]];
        [self.selectButtonARR removeAllObjects];
        [self.videoARR removeAllObjects];
        [self.tableview reloadData];
        
        
        self.footView.hidden = YES;
        _isEditing = NO;
        [self.tableview setEditing:NO animated:YES];
        [self.rightButton setTitle:@"编辑"];
    }
    else{
        _isAllSelected = NO;
        for (int i = 0; i < self.selectButtonARR.count; i++) {
            NSNumber * num = self.selectButtonARR[i];
            VideoModelZL * model = self.videoARR[[num integerValue]];
            //NSLog(@"选择的按钮的总数为：%ld,视频的总数为：%ld,索要删除的行数为：%d",self.selectButtonARR.count,self.videoARR.count,[num integerValue]);
            if ([NSFileManagerZL deleteFileWithFileName:model.videoName]) {
                NSLog(@"删除成功");
                
                
            }
            else{
                NSLog(@"删除失败");
            }

            //[self tableView:self.tableview commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
            //[self.selectButtonARR removeObject:num];
        }
//        NSMutableArray * indexARR = [[NSMutableArray alloc]init];
//        for (int i =0 ; i<self.selectButtonARR.count; i++) {
//            NSNumber * num = self.selectButtonARR[i];
//            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[num integerValue] inSection:0];
//            [indexARR addObject:indexPath];
//        }
//        [self.tableview deleteRowsAtIndexPaths:indexARR withRowAnimation:UITableViewRowAnimationRight];
        //[self.videoARR removeObjectAtIndex:[num integerValue]];
        [self.videoARR removeAllObjects];
        [self huoquHuanCunVideoARR];
        
        [self.selectButtonARR removeAllObjects];
        [self.tableview reloadData];
    }
    
    
}

//获取 本地视频第一帧图片
- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
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
