//
//  KZPhotoManager.m
//  工具类
//
//  Created by MR.Huang on 16/1/18.
//  Copyright © 2016年 MR.Huang. All rights reserved.
//

#import "KZPhotoManager.h"

@interface KZPhotoManager()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end


@implementation KZPhotoManager

+ (instancetype)sharedPhotoManager {
    static id s;
    if (s == nil) {
        s = [[KZPhotoManager alloc] init];
    }
    return s;
}


- (instancetype)init
{
    if (self = [super init]) {
        pickerController = [[UIImagePickerController alloc] init];
             pickerController.delegate = self;
    }
    return self;
}


+ (void)getImage:(void (^)(UIImage *image))img showIn:(UIViewController *)controller AndActionTitle:(NSString *)title
{
    [[KZPhotoManager sharedPhotoManager] getImage:img showIn:controller AndActionTitle:title];
}

- (void)getImage:(void (^)(UIImage *image))img showIn:(UIViewController *)controller AndActionTitle:(NSString *)title;
{
    saveImageCallBack = [img copy];
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title?title:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // Create the actions.
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //构建图像选择器
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [controller presentViewController:pickerController animated:YES completion:nil];
        }
        
        //        [pickerController.view setTag:actionSheet.tag];
        
        
    }];
    UIAlertAction *otherAction1 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [controller presentViewController:pickerController animated:YES completion:nil];
    }];
    
    // Add the actions.
    [alertVc addAction:cancelAction];
    [alertVc addAction:otherAction];
    [alertVc addAction:otherAction1];
    [controller presentViewController:alertVc animated:YES completion:nil];
    
}

#pragma mark 图片选择回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (saveImageCallBack) {
        saveImageCallBack(image);
    }
}


@end
