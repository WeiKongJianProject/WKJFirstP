#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FWParam.h"

@protocol FWInterfaceDelegate <NSObject>
@required
/*
 支付的结果回调
 payid: 单号
 success: YES支付成功，NO支付失败
 message: 结果详细信息
 */
- (void)receiveResult:(NSString*)payid result:(BOOL)success message:(NSString*)message;
@optional
/**
 @abstract Api版本的SDK返回通道信息
 @param types 通道代码数组 1微信支付，2支付宝支付，3点卡支付，4银联支付,QQ支付5，百度支付6，京东支付7
 */
- (void)receiveChannelTypes:(NSArray<NSNumber *>*)types;
@end


@interface FWInterface : NSObject
/*
   @abstract    初始化接口
   @params      appId：APP的唯一标识，由凡伟提供
   @params      wxAppId：在微信开放平台注册的WXAppId。
*/
+(void)init:(NSString *)appId useAPI:(BOOL)useAPI withWXAppId:(NSString *)wxAppId;

/**
 
 @abstract API版本直接支付
 @params controller 视图控制器
 @params params 支付参数
 @params type 通道代码数组 1微信支付，2支付宝支付，3点卡支付，4银联支付,QQ支付5，百度支付6，京东支付7
 @params delegate 支付回调的代理
 
 */
+ (void)start:(UIViewController *)controller withParams:(FWParam *)params withType:(NSUInteger)type withDelegate:(id<FWInterfaceDelegate>)delegate;

/*
    启动接口
    controller 视图控制器
    params 支付参数
    delegate 支付回调对象
    推荐使用这种
*/
+(void)start:(UIViewController *)controller withParams:(FWParam*)params withDelegate:(id<FWInterfaceDelegate>)delegate;
/*
 启动接口
 controller 视图控制器
 params 支付参数
 delegate 支付回调对象
 */
+(void)start:(UIViewController *)controller withParams:(FWParam*)params withDelegate:(id<FWInterfaceDelegate>)delegate withView:(UIView*)view;

/*
 选择通道下单
 */
+(void)selectChannel:(NSInteger)channelType;

/*
    应用进入后台
*/
+(void)applicationWillEnterForeground:(UIApplication *)application;

@end
