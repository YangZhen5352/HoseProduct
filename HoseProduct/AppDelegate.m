//
//  AppDelegate.m
//  HoseProduct
//
//  Created by edz on 2017/3/6.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "AppDelegate.h"
#import "UserLoginVC.h"
#import "YYAdViewController.h"
#import "NSString+HMAC.h"

//微信分享
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 友盟分享
    [UMSocialData setAppKey: UMAPP_KEY];
    [UMSocialWechatHandler setWXAppId:WXAPP_ID appSecret:WXAPP_SECRET url:APP_URL];
    
    // 设置数字提醒
    NSArray *arr = GetObjcForKey(@"readMsg");
    SetIntegerForKey((21 - arr.count), @"peopleCenterNumber");
    // 设置消息数字
    NSInteger msgNumber = GetIntegerForKey(@"peopleCenterNumber");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: msgNumber];
    // 通知授权：在iOS8以后的版本，需要先授权，才能显示app右上角数字提醒
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 注册远程消息通知
        [application registerForRemoteNotifications];
    }
    
    NSLog(@"01 --- didFinishLaunchingWithOptions");
    // Override point for customization after application launch.
    
    // 测试哈希MD5
//    NSString *temp = @"Hello";
//    NSString *value1 = [@"46052543" HMACWithSecret:temp];
//    NSLog(@"value1 => %@, %ld", value1, value1.length);
//    temp = @"HelloHelloHelloHello";
//    NSString *value2 = [@"2" HMACWithSecret:temp];
//    NSLog(@"value2 => %@, %ld", value2, value2.length);
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    if (GetBoolForKey(@"userLogin")) {
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Ad" bundle:nil];
//        YYAdViewController *ad = sb.instantiateInitialViewController;
//        self.window.rootViewController = ad;
//    } else {
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"UserLoginVC" bundle:nil];
//        UserLoginVC *u = sb.instantiateInitialViewController;
//        self.window.rootViewController = u;
//    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Ad" bundle:nil];
    YYAdViewController *ad = sb.instantiateInitialViewController;
    self.window.rootViewController = ad;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"04 --- applicationWillResignActive");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"05 --- applicationDidEnterBackground");
    // 设置消息数字
    NSInteger msgNumber = GetIntegerForKey(@"peopleCenterNumber");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: msgNumber];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// 将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"02 --- applicationWillEnterForeground");
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

// 完全进入活跃状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"03 --- applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// 杀死后进入
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"06 --- applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
