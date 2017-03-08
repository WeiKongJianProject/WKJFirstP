//
//  GJCircleViewController.m
//  NnGJTry
//
//  Created by NN on 16/2/26.
//  Copyright © 2016年 HeinQi. All rights reserved.
//

#ifndef HFSConstants_h
#define HFSConstants_h

//#define SERVICE_BASE_URL @"http://app-test.matrojp.com/P2MLinkCenter/"
//#define SERVICE_BASEPAY_URL @"http://app-test.matrojp.com/PayCenter/"
//#define SERVICE_GETBASE_URL @"http://61.155.212.163:81/"

//http://app-test.matrojp.com
//http://app.matrojp.com/P2MLinkCenter/
/*
 1.测试环境
    1.CRM正式域名切换，http://app-test.matrojp.com
    2.CRM，正式KEY切换
    "appId" : "test0002",
    "appSecret" : ""123456"",
    3.BBC正式域名切换，http://bbctest.matrojp.com
 
 
 2.正式环境
    1.CRM正式域名切换，http://vip.matrojp.com
    2.CRM，正式KEY切换
    "appId" : "01d689a05d4841c6a29d0080502bde67",
    "appSecret" : "cca95b6b0f9a416e8ab865b3d31b7a54",
    3.BBC正式域名切换，http://www.matrojp.com
 
 */





#define ZHOULU_ML_BASE_URLString        @"http://www.matrojp.com"
#define MATROJP_BASE_URL                @"http://www.matrojp.com"
#define SERVICE_GETBASE_URL             @"http://www.matrojp.com/"
#define ZHOULU_ML_CRM_URLString         @"http://vip.matrojp.com"
#define APP_ID_ZHOU                     @"01d689a05d4841c6a29d0080502bde67"
#define APP_Secrect_ZHOU                @"cca95b6b0f9a416e8ab865b3d31b7a54"
#define CHOGNZHI_PAY_URLSTRING          @"http://pay.matrojp.com"



//#define ZHOULU_ML_BASE_URLString        @"http://bbctest.matrojp.com"
//#define MATROJP_BASE_URL                @"http://bbctest.matrojp.com"
//#define SERVICE_GETBASE_URL             @"http://bbctest.matrojp.com/"
//#define ZHOULU_ML_CRM_URLString         @"http://app-test.matrojp.com"
//#define APP_ID_ZHOU                     @"test0002"
//#define APP_Secrect_ZHOU                @"123456"
//#define CHOGNZHI_PAY_URLSTRING          @"http://pay-test.matrojp.com"



#define SERVICE_BASE_URL @"http://app.matrojp.com/P2MLinkCenter/"
//#define SERVICE_BASE_URL @"http://bbctest.matrojp.com/"http://pay.matrojp.com/PayCenter/app/v200/alipay
#define SERVICE_BASEPAY_URL @"http://pay.matrojp.com/PayCenter/"
//订单支付
#define ALIPAY_SERVICE_URL      @"http://pay.matrojp.com/PayCenter/app/v200/alipay"
#define WXPAY_SERVICE_URL       @"http://pay.matrojp.com/PayCenter/app/v200/wxpay"
#define UPPPAY_SERVICE_URL      @"http://pay.matrojp.com/PayCenter/app/v200/unionpay"

//话费充值
#define ALIPAY_HUAFEI_URL       CHOGNZHI_PAY_URLSTRING@"/PayCenter/app/v200/alipay/csfw"
#define WXPAY_HUAFEI_URL        CHOGNZHI_PAY_URLSTRING@"/PayCenter/app/v200/wxpay/csfw"
#define YINLIANG_HUAFEI_URL     CHOGNZHI_PAY_URLSTRING@"/PayCenter/app/v200/unionpay/csfw"


//http://www.matrojp.com/
//#define SERVICE_GETBASE_URL @"http://app-test.matrojp.com/"


#define kNOTIFICATIONWXPAY      @"wxPayResult"



#define NETWORK_ERROR_MESSAGE @"您的网络好像不太给力，请稍后再试"


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define DOCUMENT_FOLDER_PATH    (NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0])

//#define APP_ID @"testapp2"
#define APP_ID @"3E125E14E3313B1A"
#define NONCE_STR @"12345678"


#define KeFuDianHua @"400-8850-668"

#define MAIN_TINT_COLOR     @"#FFFFFF"

#define tel(phoneNumber) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])

#define MAIN_SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define MAIN_SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)

// Notifications
#define NOTIFICATION_GOTO_PROD_DETAILS @"NOTIFICATION_GOTO_PROD_DETAILS"
//#define NOTIFICATION_GOTO_MEAL_DETAILS @"NOTIFICATION_GOTO_MEAL_DETAILS"
//#define NOTIFICATION_GOTO_NEWS_DETAILS @"NOTIFICATION_GOTO_NEWS_DETAILS"
#define NOTIFICATION_GOTO_ODRE_LISTS   @"NOTIFICATION_GOTO_ODRE_LISTS"
#define NOTIFICATION_GOTO_ODRE_LISTS_ZHOULU   @"NOTIFICATION_GOTO_ODRE_LISTS_ZHOULU"
//#define NOTIFICATION_UPDATA_PROFILE_UI @"NOTIFICATION_UPDATA_PROFILE_UI"
#define NOTIFICATION_WEICHAT_PAY_SUCCESS @"NOTIFICATION_WEICHAT_PAY_SUCCESS"
#define NOTIFICATION_WEICHAT_PAY_FAIL @"NOTIFICATION_WEICHAT_PAY_FAIL"
#define NOTIFICATION_CHANGEUSERINFO  @"NOTIFICATION_CHANGEUSERINFO"
#define kNOTIFICATIONBINDSUC   @"NOTIFICATION_BINDSUCCESS"

//#define WECHAT_MCH_ID @""
//#define WECHAT_PARTNER_ID @""
//#define WECHAT_NOTIFY_URL @""
//#define WECHAT_SP_URL @""
//
#define WECHAT_APP_ID @"wx220f2459690a865b"
#define WECHAT_APP_SECRET @"d4624c36b6795d1d99dcf0547af5443d"

#define SHARE_APP_KEY @"e5cccbc5912a"
#define SHARE_APP_SECRET @"aa81c9f15d62695dbf821e053b6f6d46"

#define TENCENT_APP_ID @"100371282"
#define TENCENT_APP_SECRET @"aed9b0303e3ed1e27bae87c33761161d"
//
//#define BUGLY_APP_ID @"900008207"
//
#define SMS_APP_ID @"e5c8612eb410"
#define SMS_APP_SECRET @"01af4d357271852e7a73d36fc23703c6"

#define kUSERDEFAULT_USERNAME              @"USER_NAME"
#define kUSERDEFAULT_USERID                @"USER_ID"
#define kUSERDEFAULT_USERCARDNO            @"USER_CARDNO"
#define kUSERDEFAULT_USERSEX               @"USER_SEX"
#define kUSERDEFAULT_USERADRESS            @"USER_USERADRESS"
#define kUSERDEFAULT_USERPHONE             @"USER_PHONE"
#define kUSERDEFAULT_USERBIRTH             @"USER_BIRTH"
#define kUSERDEFAULT_USERHOSPITAL          @"USER_HOSPITAL "
#define kUSERDEFAULT_USERJOBPOSITION       @"USER_JOBPOSITION "
#define kUSERDEFAULT_USERAVATOR            @"USER_AVATOR"

#define kUSERDEFAULT_FRISTUSER             @"FRISTUSER"
#define kUSERDEFAULT_ACCCESSTOKEN          @"ACCCESS_TOKEN"
#define kUSERDEFAULT_RONGCLOUDTOKEN        @"RONGCLOUDTOKEN"
#define kUSERDEFAULT_USERHEADER            @"ACCCESS_USERHEADER"
#define kUSERDEFAULT_USERDATA              @"USERDEFAULT_USERDATA"
#define kUSERDEFAULT_LOGINTYPE             @"USERDEFAULT_LOGINTYPE"

#define kHOME_VIEW_FILE_VRESION            @"HOME_VIEW_FILE_VRESION"
#define kUSERDEFAULT_BASE_URL              @"USERDEFAULT_BASE_URL"
#define ZIP_FILE_NAME                      @"home_html"

/*zhoulu*/
#define KUSERDEFAULT_PASSWORD_ZL                @"USER_PASSWORD_ZL"

#define KUSERDEFAULT_ISHAVE_DEFAULTCARD_BOOL    @"ISHAVE_DEFAULTCARD_BOOL"
//身份证号
#define KUSERDEFAULT_IDCARD_SHENFEN             @"USER_IDCARD_SHENFEN"
//会员类型
#define KUSERDEFAULT_CARDTYPE_CURRENT           @"USER_CARDTYPE_CURRENT"
//李佳 BBCtoken
#define KUSERDEFAULT_BBC_ACCESSTOKEN_LIJIA      @"USER_BBC_ACCESSTOKEN"
//时间戳
#define KUSERDEFAULT_TIMEINTERVAR_LIJIA         @"TIMEINTERVAR_LIJIA"

#define ZHAOHUIPASSWORD_CURRENT_PHONE           @"ZHAOHUIPASSWORD_PHONE"

//设备ID
#define DEVICE_ID_JIGUANG_LU                    @"device_id_jiguang_lu"

//李佳接口认证成功后 通知名
#define RENZHENG_LIJIA_Notification             @"renzheng_lijia_notification"
#define RENZHENG_LIJIA_HOME_Notification             @"renzheng_lijia_home_notification"

//首页切换  视图 按钮 通知名
#define HOMEVIEW_BUTTON_INDEX_NOTIFICATION      @"homeview_button_index_notification"
//银联支付回调通知
#define YinLianPay_NOTICIFICATION_SUCCESS       @"YINLIAN_ZHIFU_NOTICIFICATION_SUCCESS"
#define YinLianPay_NOTICIFICATION_FAIL          @"YINLIAN_ZHIFU_NOTICIFICATION_FAIL"
#define YinLianPay_NOTICIFICATION_CANCEL        @"YINLIAN_ZHIFU_NOTICIFICATION_CANCEL"


//从后台返回前台 激活应用
#define APPLICATION_BECOME_ACTIVE_NOTIFICATION  @"APPLICATION_BECOME_ACTIVE_NOTIFICATION"

//所有支付成功
#define PaySuccess_NOTIFICATION_SUCCESS         @"PaySuccess_NOTIFICATION_SUCCESS"

//领取优惠券  成功
#define LingQuYouHuiQuan_NOTIFICATION_SUCCESS   @"LingQuYouHuiQuan_NOTIFICATION_SUCCESS"

//手机充值 支付成功
#define SHOUJI_CHONGZHI_PAYSUCCESS_NOTIFICATION @"SHOUJI_CHONGZHI_PAYSUCCESS_NOTIFICATION"

//手机充值支付失败
#define SHOUJI_CHONGZHI_PAY_FAIL_NOTIFICATION   @"SHOUJI_CHONGZHI_PAY_FAIL_NOTIFICATION"

//退出登录发送通知
#define LOGOUT_TUICHU_NOTIFICATION              @"logout_tuichu_notification"

/*zhoulu*/

#define LoadNibWithSelfClassName [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject]


typedef NS_ENUM(NSUInteger, PaymentType) {
    ALIPAY = 1,
    WECHATPAY = 2,
    UNIONPAY = 3
};

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define PLACEHOLDER_IMAGE [UIImage imageNamed:@"icon_default"]

/*zhouluSTART*/

//#define HTTP_BASE_ZHOULU_URL            @"http://app-test.matrojp.com"

//登录接口
#define Login_URLString                 ZHOULU_ML_CRM_URLString@"/member/ajax/app/sso/login"
//注册接口
#define Regist_URLString                ZHOULU_ML_CRM_URLString@"/member/ajax/app/sso/register"
//验证码 接口
#define Code_URLString                  @"http://app.matrojp.com/P2MLinkCenter/common/sendsms"
//判断手机号是否注册过
#define PhoneIsRegisted_URLString       ZHOULU_ML_CRM_URLString@"/member/ajax/app/sso/phoneIsRegister"
//退出登录
#define Logout_URLString                ZHOULU_ML_CRM_URLString@"/member/ajax/app/access/loginOut"
//第三方登录
#define ThirdLogin_URLString            ZHOULU_ML_CRM_URLString@"/member/ajax/app/sso/thirdPartyLogin"
//第三方登录 绑定手机号
#define ThirdLogin_BindPhone_URLString  ZHOULU_ML_CRM_URLString@"/member/ajax/app/sso/thirdPartyLoginBind"
//修改密码
#define XiuGaiPassword_URLString        ZHOULU_ML_CRM_URLString@"/member/ajax/app/access/updatePsw"
//绑定会员卡
#define BindCard_URLString              ZHOULU_ML_CRM_URLString@"/member/ajax/app/access/cardBind"
//忘记密码
#define ForgetPassword_URLString        ZHOULU_ML_CRM_URLString@"/member/ajax/app/sso/forgetPsw"
//会员信息查询
#define VIPInfo_URLString               ZHOULU_ML_CRM_URLString@"/member/ajax/app/access/getUser"
//会员卡可用积分
#define VIPCardJiFen_URLString          ZHOULU_ML_CRM_URLString@"/member/ajax/app/access/getOfflineVipCard"
//消费记录
#define VIPCardJiLu_URLString           ZHOULU_ML_CRM_URLString@"/member/ajax/app/access/getVipSaleItem"
//修改账户信息
#define XiuGaiInfo_URLString            ZHOULU_ML_CRM_URLString@"/member/ajax/app/access/updateUserInfo"

//会员卡消费记录
#define VIPCARD_HISTORY_URLString       ZHOULU_ML_CRM_URLString@"/member/ajax/app/access/getVipSaleItem"

//会员卡的默认名称
#define VIPCARDIMG_DEFAULTNAME          @"jinkazhoulu"

//上传头像
#define UPLOADTOUXIANG_IMAGE_URLString  ZHOULU_ML_BASE_URLString@"/api.php?m=uploadimg&s=index"

//查询实名认证
#define CHAXUNRENZHENG_RENZHENG_URLStrign ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_member&action=sel_identity_card"
//上传认证信息
#define SHANGCHUAN_RENZHENG_URLString   ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_member&action=add_identity_card"

//请求所有优惠券 信息
#define QingQiuYouHuiQuan_URLString     ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_coupons&action=all_coupons"
//领取 优惠券 列表
#define LingQuYouHuiQuan_URLString      ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_coupons&action=coupons"
//领取优惠券
#define LingQuanAction_URLString        ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_coupons&action=set_coupons"

//用户的优惠券
#define YOUHUIQUANLIST_YiLingQu_URLString  ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_coupons&action=all_coupons"

//品牌馆
#define PinPaiGuanList_URLString        ZHOULU_ML_BASE_URLString@"/api.php?m=brand&s=brand&method=list"
//首页地址
//http://61.155.212.146:3000
//#define HomeHTML_URLString              @"http://61.155.212.146:3000"
#define HomeHTML_URLString              @"http://h5.matrojp.com"

//店铺ID
#define DIANPU_MAIJIA_UID               @"dainpu_maijia_uid"

//请求标题数据

#define HomeTitles_URLString            ZHOULU_ML_BASE_URLString@"/api.php?m=product&s=webframe&method=title"

//更新头像
#define GenXinTouXiang_URLString        ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_member&action=update_img"

#define QianDao_URLString               ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_member&action=add_qd"

#define ZiChan_URLString                ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=assets&action=sel_assets"

//请求订单  数量
#define OrderNum_URLString              ZHOULU_ML_BASE_URLString@"/api.php?m=shop&s=status&action=sel"

//获取支付流水
#define ZhiFu_LIUSHUI_URLString         ZHOULU_ML_BASE_URLString@"/api.php?m=product&s=pay"




//余额 会员卡的优惠券余额
#define YOUHUIQUAN_YUE_CARD_URLString   ZHOULU_ML_BASE_URLString@"/api.php?m=member&s=admin_coupons&action=all_coupons"
//注册协议
#define ZHUCEXIEYI_URLString            ZHOULU_ML_BASE_URLString@"/api.php?m=setinfo&s=setinfo&method=GetRegConfig"

//请求品牌馆标题
#define PinPaiGuanTitle_URLString       ZHOULU_ML_BASE_URLString@"/api.php?m=brand&s=brand&method=GetBrandByID&brandid="

#define FenLeiName_URLString            ZHOULU_ML_BASE_URLString@"/api.php?m=category&s=list&method=GetCategoryByID&catid="

//店铺链接
#define DianPuURL_URLString             @"http://h5.matrojp.com"
//#define DianPuURL_URLString              @"http://61.155.212.146:3000"

//手机充值  查询
#define SHOUJI_CHONGZHI_CHAXUN_URLString    ZHOULU_ML_BASE_URLString@"/api.php?m=recharge&s=phone_recharge&action=query"

//手机充值 下单
#define SHOUJI_CHONGZHI_XIADAN_URLString    ZHOULU_ML_BASE_URLString@"/api.php?m=recharge&s=phone_recharge&action=inorder"

/*zhouluEND*/





#import "UIImageView+ZLWebPsetImage.h"
#import "UIButton+ZLWebPSetImage.h"
#endif /* HFSConstants_h */
