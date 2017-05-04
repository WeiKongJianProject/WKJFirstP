#import <Foundation/Foundation.h>

@interface FWParam : NSObject

#pragma mark -----订单参数-------
/**
 支付金额,必填的参数
 */
@property (nonatomic,copy)NSString *amount;
/**
 商品名称,必填的参数
 */
@property (nonatomic,copy)NSString *goodsname;
/**
 商户自己生成，32位以内，数字和字母,必填的参数
 */
@property (nonatomic,copy)NSString *payid;
/**
 应用注册scheme,Info.plist定义URL types(支付宝必须参数)
 */
@property (nonatomic,copy)NSString *aliScheme;
/**
 可以为空,备注
 */
@property (nonatomic,copy)NSString *remark;



#pragma mark -------身份参数------
/**
 商户的APP唯一标识,由凡伟提供,必填的参数
 */
@property (nonatomic,copy)NSString *appid;
/**
 玩家信息,必填的参数
 */
@property (nonatomic,copy)NSString *playerid;
/**
 可以为空,商户号由凡伟提供。
 */
@property (nonatomic,copy)NSString *partnerId;
/**
 可以为空,电话卡的唯一标示
 */
@property (nonatomic,copy)NSString *imsi;

/**
 可以为空,包名可以看做bundle identifier
 */
@property (nonatomic,copy)NSString *packageName;

/**
 可以为空,给商户做标记没有实际意义
 */
@property (nonatomic,copy)NSString *channelId;

@property (nonatomic,copy)NSString *paymethodchannel;

#pragma mark ------工具方法-----

- (BOOL)isValid;

@end
