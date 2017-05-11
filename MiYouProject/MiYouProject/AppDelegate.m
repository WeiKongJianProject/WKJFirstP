//
//  AppDelegate.m
//  MiYouProject
//
//  Created by wkj on 2017/3/8.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import "AppDelegate.h"
#import "UMMobClick/MobClick.h"
#import <Bugly/Bugly.h>
#import "FWInterface.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import <BmobPaySDK/Bmob.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[Bmob registerWithAppKey:@"d4f6c4b18b7e35a7255d724a0ed34d47"];
    UMConfigInstance.appKey = YOUMENG_APP_ID_ZL;
    UMConfigInstance.channelId = @"Custom Channel";
    //UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    
    
    /*
     *推送消息
     */
    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
    [UMessage startWithAppkey:YOUMENG_APP_ID_ZL launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
    //bugly异常统计
    [Bugly startWithAppId:@"4126a8935b"];
    ///开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    self.reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.reach startNotifier]; //开始监听，会启动一个run loop
    // Override point for customization after application launch.
    
    //网络请求缓存
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                         diskCapacity:20 * 1024 * 1024
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    //创建RootViewController
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    KSNavigationController * rootVC = [storyboard instantiateViewControllerWithIdentifier:@"RootNavID"];
    
    //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
    BOOL canShow = [CoreNewFeatureVC canShowNewFeature];
    
    //测试代码，正式版本应该删除
    //canShow = YES;
    
    if(canShow){

        NSURL * url01 = [NSURL URLWithString:@"http://img.miyouad.com:8088/html/img/ioskj1.jpg"];
        NSURL * url02 = [NSURL URLWithString:@"http://img.miyouad.com:8088/html/img/ioskj2.jpg"];
        NSURL * url03 = [NSURL URLWithString:@"http://img.miyouad.com:8088/html/img/ioskj3.jpg"];

        __block NewFeatureModel *m1 = [NewFeatureModel new];//[NewFeatureModel model:[UIImage imageWithColor:[UIColor whiteColor]]];
        
       __block NewFeatureModel *m2 = [NewFeatureModel new];//[NewFeatureModel model:[UIImage imageWithColor:[UIColor whiteColor]]];
        
        __block NewFeatureModel *m3 = [NewFeatureModel new];//[NewFeatureModel model:[UIImage imageWithColor:[UIColor whiteColor]]];
        
        NSArray * urlARR = @[url01,url02,url03];

        
        for (int i = 0; i<3; i++) {
            //创建请求对象
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlARR[i]];
            //NSLog(@"当前的图片链接为：%@",urlARR[i]);
            //2.1创建请求方式(默认是get,这一步可以不写)
            [request setHTTPMethod:@"get"];
            
            //创建响应对象(有时会出错)
            NSURLResponse *response = nil;
            //创建连接对象
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            // = [UIImage imageWithData:data];
            UIImage * image01 = [UIImage imageWithData:data];
            NSURLSession * session = [NSURLSession sharedSession];
            
            //model = [NewFeatureModel model:image01];
            switch (i) {
                case 0:
                    m1 = [NewFeatureModel model:image01];
                    break;
                case 1:
                    m2 = [NewFeatureModel model:image01];
                    break;
                case 2:
                    m3 = [NewFeatureModel model:image01];
                    break;
                default:
                    break;
            }
            
        }

            self.window.rootViewController = [CoreNewFeatureVC newFeatureVCWithModels:@[m1,m2,m3] enterBlock:^{
                
                NSLog(@"进入主页面");
                
                self.window.rootViewController = rootVC;
                //[self autoLogin];
                
            }];

        
        
        
    }else{
        
        
//        MLAnimationViewController * vcs = [[MLAnimationViewController alloc]init];
//        [vcs animationBlockAction:^(BOOL success) {
//            
//            self.window.rootViewController = rootVC;
//            //[self autoLogin];
//        }];
        self.window.rootViewController = rootVC;
        
    }
    
    //聚宝云 支付介入
    // 必须
    // FW code start //测试  35656972  //正式 29660012
    [FWInterface init:@"29660012" useAPI:NO withWXAppId:nil]; // 35656972是appId
    // FW code end
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    // 必须
    // FW code start
    [FWInterface applicationWillEnterForeground:application];
    // FW code end

}


#pragma mark 支付调用接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"支付宝支付结果：result = %@",resultDic);
//        }];
    }
    
    return YES;
}
#pragma end mark 支付接口调用结束

//通知
-(void)reachabilityChanged:(NSNotification*)note {
    Reachability * reach = [note object];
    NSParameterAssert([reach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (status == NotReachable) {
        //        [self.window toastMid:@"网络已断开"];
        [[NSNotificationCenter defaultCenter]postNotificationName:ReachabilityChangedNotification object:NotReachable];
        
    }else if(status == ReachableViaWWAN){
        //        [self.window toastMid:@"移动网络"];
        
    }else if(status == ReachableViaWiFi){
        //        [self.window toastMid:@"WIfi网络"];
        //        NSLog(@"Notification Says WIfi网络 wifinet");
    }
    
}

- (NetworkStatus)currentReachabilityStatus {
    
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSParameterAssert([appDlg.reach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [appDlg.reach currentReachabilityStatus];
    
    return status;
}


- (void)dealloc {
    // 删除通知对象
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}





- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MiYouProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

+(AppDelegate *)shareAppDelegate{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}


#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// iOS SDK 7.0 以后版本的处理
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    
    
}

#else

// iOS SDK 7.0 之前版本的处理

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
    //                                                            message:@"Test On ApplicationStateActive"
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"确定"
    //                                                  otherButtonTitles:nil];
    //
    //        [alertView show];
    //
    //    }
}



#endif


@end
