//
//  CommonHeader.h
//  ZXMeng
//
//  Created by apple on 13-12-25.
//  Copyright (c) 2013年 KingkongWolf. All rights reserved.
//

#ifndef ZXMeng_CommonHeader_h
#define ZXMeng_CommonHeader_h

#define DEV_SCREEN(width, height)	(([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(width, height), [[UIScreen mainScreen] currentMode].size) : NO))
#define iPad			(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone			([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define iPhone_Normal	(DEV_SCREEN(320, 480))
#define iPhone_Retina	(DEV_SCREEN(640, 960))
#define iPhone5			(DEV_SCREEN(640, 1136))
#define iPhone6         (DEV_SCREEN(750, 1334))
#define iPhone6s        (DEV_SCREEN(1242, 2208))
#define iPad_Normal		(DEV_SCREEN(768, 1024))
#define iPad_Retina		(DEV_SCREEN(768*2, 1024*2))

#define	RetinaScree		(iPhone_Retina || iPhone5 || iPad_Retina)
#define NormalScree		(iPad_Normal||iPhone_Normal)

#define IOS_VERSION		([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS(ver)		(IOS_VERSION >= ver)

#define Color(color)					(((float)color)/255.0f)

#define ColorWithRGB(r,g,b)         ([UIColor colorWithRed:Color(r) green:Color(g) blue:Color(b) alpha:1.0f])
#define ColorWithRGBA(r,g,b,a)      ([UIColor colorWithRed:Color(r) green:Color(g) blue:Color(b) alpha:(a)])
#define RadomColor      [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]

#define I2S(v)          ([NSString stringWithFormat:@"%d", v])
#define F2S(v)          ([NSString stringWithFormat:@"%f", v])
#define L2S(v)          ([NSString stringWithFormat:@"%ld", v])

#define debug(v)    NSLog(@"%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d",v,v,v,v,v,v,v,v,v,v,v,v)

#define SIZE_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIZE_HEIGHT [UIScreen mainScreen].bounds.size.height

//申请招标界面的
#define APPLYBACGROUND_MIDDLE_FRAME  CGRectMake(0,0,SIZE_WIDTH,SIZE_HEIGHT)
#define APPLYBACGROUND_RIGHT_FRAME CGRectMake(SIZE_WIDTH,0,SIZE_WIDTH,SIZE_HEIGHT)
#define APPLYBACGROUND_LEFT_FRAME  CGRectMake(-30,0,SIZE_WIDTH,SIZE_HEIGHT)
#define APPLYBACGROUND_TOP_FRAME CGRectMake(0,-170,SIZE_WIDTH,SIZE_HEIGHT)

#define HTTP_COMMON @"http://192.168.1.117:1008/"

#define UMENG_APPKEY @"566fdf2fe0f55a4475001e3f"

//用户信息的关键词
#define PASSWORD @"password"
#define USER_NAME @"userName"
#define LOGINYES_NO @"loginYesNo"

//#import <AVOSCloud/AVOSCloud.h>
//#import <AVOSCloudSNS/AVOSCloudSNS.h>

#define NAVTOP_Height 64
#define NAVBOT_Height 49

#define FontCustomNeue @"HelveticaNeue"
#define FontCustomNeue_Bold @"HelveticaNeue-Bold"
#define FontCustomNeue_Light @"HelveticaNeue-Light"
#define FontHelvetca @"Helvetica"
#define FontHelvetca_Bold @"Helvetica-Bold"

#define DisplayQuestion_Count 4

#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define Login_NSNotification @"logined"

#define CHINA_FONT @"迷你简细圆"

#define EN_FONT @"HelveticaNeue"
#define EN_FONT_LIGHT @"HelveticaNeue-Light"
#define EN_FONT_LIGHTER @"HelveticaNeue-UltraLight"

#define VERSION_NUM  @"V1.0"

#import "Masonry.h"

//ae835d
#define Main_BackgroundColor @"ae835d"
//bab6b7
#define Main_grayBackgroundColor @"bab6b7"
//浅灰
#define Main_lightGrayBackgroundColor @"999999"
//深灰
#define Main_darkGrayBackgroundColor @"625046"
//普色
#define Main_textNormalBackgroundColor @"260e00"
//重要文字
#define Main_textRedBackgroundColor @"f1653e"
//分割线
#define Main_spelBackgroundColor @"dedede"
//边框颜色灰色
#define Main_bianGrayBackgroundColor @"cccccc"

//背景灰
#define Main_beijingGray_BackgroundColor @"f1f1f1"

//按钮背景灰色
#define Main_ButtonGray_backgroundColor @"b9b6b6"
//按钮正常颜色
#define Main_ButtonNormel_backgroundColor @"ae8e5d"

//首页 头部颜色 金色
#define Main_home_jinse_backgroundColor @"625046"

//首页 头部文字 灰色
#define Main_home_huise_backgroundColor @"c29f8c"


#define REQUEST_ERROR_ZL @"服务连接失败"

#define vCFBundleShortVersionStr [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define Message_badge_num   @"message_badge_num"

#define SelectSecondVC_NOTIFICATION     @"SelectSecondVC_NOTIFICATION"


#define PlaceholderImage_Name           @"icon_default"
#define Index3Button_LEFT_NOTICIFICATION    @"Index3Button_LEFT_NOTICIFICATION"
#define Index3Button_RIGHT_NOTICIFICATION   @"Index3Button_RIGHT_NOTICIFICATION"

#import "UIImageView+ZLWebPsetImage.h"
#import "UIButton+ZLWebPSetImage.h"
#endif
