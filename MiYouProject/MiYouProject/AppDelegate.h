//
//  AppDelegate.h
//  MiYouProject
//
//  Created by wkj on 2017/3/8.
//  Copyright © 2017年 junhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"
#import "CoreNewFeatureVC.h"
#import "KSNavigationController.h"
#import "UMessage.h"
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) Reachability *reach;

- (void)saveContext;


- (NetworkStatus)currentReachabilityStatus;

+(AppDelegate *)shareAppDelegate;

@end

