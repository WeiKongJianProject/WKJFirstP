//
//  RenZhengViewController.m
//  MiYouProject
//
//  Created by wkj on 2017/3/28.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "RenZhengViewController.h"

@interface RenZhengViewController (){
    
    BOOL isMan;
    
}

@end

@implementation RenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.manButton setImage:[UIImage imageNamed:@"renzhengnannvtubiao"] forState:UIControlStateSelected];
    [self.womanButton setImage:[UIImage imageNamed:@"renzhengnannvtubiao"] forState:UIControlStateSelected];
    [self.manButton addTarget:self action:@selector(manButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.womanButton addTarget:self action:@selector(womanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.PhotoButton addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoButton addTarget:self action:@selector(videoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    NSString * isRenZhengString = [[NSUserDefaults standardUserDefaults] objectForKey:IS_RENZHENG_TIJIAO];
    if ([isRenZhengString isEqualToString:@"1"]) {
        [MBManager showPermanentAlert:@"提交成功，审核中..."];
        //[MBManager showPermanentMessage:@"提交成功,审核中..." InView:self.view];
    }
    else{
        UIBarButtonItem * rightBar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
        [rightBar setTintColor:[UIColor whiteColor]];
        self.navigationItem.rightBarButtonItem = rightBar;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"认证";
}

- (void)manButtonAction:(UIButton *)sender{
    isMan = YES;
    self.manButton.selected = YES;
    self.womanButton.selected = NO;
}
- (void)womanButtonAction:(UIButton *)sender{
    isMan = NO;
    self.manButton.selected = NO;
    self.womanButton.selected = YES;
}

- (void)photoButtonAction:(UIButton *)sender{
    NSLog(@"videoButtonAction");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {        //点击确定按钮的事件处理
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //执行拍照代码
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])        {            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.delegate = self;
            //设置拍照后的图片可被编辑
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:^{}];
        }
        else{
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        }
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //执行从相册选择代码
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }];
    [alert addAction:camera];
    
    [alert addAction:photo];
    
    [alert addAction:cancel];
    __weak typeof(self) weakSelf = self;
    [self presentViewController:alert animated:YES completion:^{
        //[weakSelf.navigationController setNavigationBarHidden:YES];
    }];
    
    
}
- (void)videoButtonAction:(UIButton *)sender{
    //UIImagePickerControllerCameraCaptureModeVideo
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加视频" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {        //点击确定按钮的事件处理
    }];
    
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从图库选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //执行从相册选择代码
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.delegate = self;
        picker.mediaTypes = @[@"public.movie"];
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }];
    [alert addAction:photo];
    
    [alert addAction:cancel];
    __weak typeof(self) weakSelf = self;
    [self presentViewController:alert animated:YES completion:^{
        //[weakSelf.navigationController setNavigationBarHidden:YES];
    }];

    
}
#pragma mark 图片选择控制器
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //[self.navigationController setNavigationBarHidden:NO];
    //objectForKey:UIImagePickerControllerReferenceURL
    //NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
    //NSData *data = [NSData dataWithContentsOfURL:videoUrl];
    //视频  选择
    if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        //NSLog(@"视频选择代理方法");
        [picker dismissViewControllerAnimated:YES completion:nil];
        NSURL * videoUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
        //file:///private/var/mobile/Containers/Data/Application/F0FE81D7-BE20-41E1-B8C6-94E8226140F9/tmp/trim.A3A72F09-945C-4EE3-8EBA-2C3513F6DCEC.MOV
        //assets-library://asset/asset.mp4?id=5EEF26C6-9AEE-4240-948F-3F6FE6FF7BEC&ext=mp4
        NSLog(@"视频的地址为：%@",videoUrl.absoluteString);
        NSData *data = [NSData dataWithContentsOfURL:videoUrl];
        
        if (IOS_VERSION < 9.0) {
            MPMoviePlayerController *iosMPMovie = [[MPMoviePlayerController alloc]initWithContentURL:videoUrl];
            UIImage *img = [iosMPMovie thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
            [self.videoButton setBackgroundImage:img forState:UIControlStateNormal];
        }
        else{
            //视频文件URL地址
            NSURL *url = videoUrl;
            //创建媒体信息对象AVURLAsset
            AVURLAsset *urlAsset = [AVURLAsset assetWithURL:url];
            //创建视频缩略图生成器对象AVAssetImageGenerator
            AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
            //创建视频缩略图的时间，第一个参数是视频第几秒，第二个参数是每秒帧数
            CMTime time = CMTimeMake(0.0, 10);
            CMTime actualTime;//实际生成视频缩略图的时间
            NSError *error = nil;//错误信息
            //使用对象方法，生成视频缩略图，注意生成的是CGImageRef类型，如果要在UIImageView上显示，需要转为UIImage
            CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time
                                                        actualTime:&actualTime
                                                             error:&error];
            if (error) {
                NSLog(@"截取视频缩略图发生错误，错误信息：%@",error.localizedDescription);
                }
            //CGImageRef转UIImage对象
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            //记得释放CGImageRef
            CGImageRelease(cgImage);
            [self.videoButton setBackgroundImage:image forState:UIControlStateNormal];
            
        }

    }else{
        NSLog(@"图片调用代理方法");
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage * backImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.PhotoButton setBackgroundImage:backImage forState:UIControlStateNormal];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    NSLog(@"取消选择");
}
#pragma end mark
#pragma mark 获取视频缩略图
/* 获取视频缩略图 */
- (UIImage *)getThumbailImageRequestAtTimeSecond:(CGFloat)timeBySecond {
    //视频文件URL地址
    NSURL *url = [NSURL URLWithString:@"http://192.168.6.147/2.mp4"];
    //创建媒体信息对象AVURLAsset
    AVURLAsset *urlAsset = [AVURLAsset assetWithURL:url];
    //创建视频缩略图生成器对象AVAssetImageGenerator
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    //创建视频缩略图的时间，第一个参数是视频第几秒，第二个参数是每秒帧数
    CMTime time = CMTimeMake(timeBySecond, 10);
    CMTime actualTime;//实际生成视频缩略图的时间
    NSError *error = nil;//错误信息
    //使用对象方法，生成视频缩略图，注意生成的是CGImageRef类型，如果要在UIImageView上显示，需要转为UIImage
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time
                                                actualTime:&actualTime
                                                     error:&error];
    if (error) {
        NSLog(@"截取视频缩略图发生错误，错误信息：%@",error.localizedDescription);
        return nil;
    }
    //CGImageRef转UIImage对象
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    //记得释放CGImageRef
    CGImageRelease(cgImage);
    return image;
}

- (void)rightButtonAction:(UIBarButtonItem *)sender{
    NSString * isRenZhengString = [[NSUserDefaults standardUserDefaults] objectForKey:IS_RENZHENG_TIJIAO];
    if ([isRenZhengString isEqualToString:@"1"]) {
        
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:IS_RENZHENG_TIJIAO];
        [MBManager showPermanentMessage:@"提交成功,审核中..." InView:self.view];
    }
    
}
/*
 //检查相机是否可用
 - (BOOL)checkCamera
 {
 NSString *mediaType = AVMediaTypeVideo;
 AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
 if(AVAuthorizationStatusRestricted == authStatus ||
 AVAuthorizationStatusDenied == authStatus)
 {
 //相机不可用
 return NO;
 }
 //相机可用
 return YES;
 }
 
 //压缩图片质量
 -(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
 {
 NSData *imageData = UIImageJPEGRepresentation(image, percent);
 UIImage *newImage = [UIImage imageWithData:imageData];
 return newImage;
 }
 //压缩图片尺寸
 - (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
 {
 UIGraphicsBeginImageContext(newSize);
 [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
 UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 return newImage;
 }
 
 
 */
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
