//
//  RenZhengViewController.h
//  MiYouProject
//
//  Created by wkj on 2017/3/28.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
@interface RenZhengViewController : ZLBaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nsmeTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *womanButton;
@property (weak, nonatomic) IBOutlet UIButton *PhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;

@end
