//
//  KZPhotoManager.h
//  工具类
//
//  Created by MR.Huang on 16/1/18.
//  Copyright © 2016年 MR.Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KZPhotoManager : NSObject
{
    UIImagePickerController *pickerController;
    void (^saveImageCallBack)(UIImage *image);
    
}


+ (void)getImage:(void (^)(UIImage *image))img showIn:(UIViewController *)controller AndActionTitle:(NSString *)title;




@end
