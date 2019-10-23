//
//  PomeloAppDelegate.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloAppDelegate.h"
#import "BaseTabBarController.h"
#import "PomeloGuidancePageViewController.h"
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogManager.h>
#import <UMAnalytics/MobClick.h>

@interface PomeloAppDelegate ()

@end

@implementation PomeloAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // MARK:友盟

    [UMConfigure initWithAppkey:UMENGkEY channel:nil];
    [MobClick setScenarioType:E_UM_NORMAL];//支持普通场景
    [UMCommonLogManager setUpUMCommonLogManager];
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    [MobClick profileSignInWithPUID:userid];
    //上传唯一标识
    NSDictionary *para = @{@"phonecard":[ECUtil getIDFA]};
    [[HWAFNetworkManager shareManager] accountRequest:para initPhonecard:^(BOOL success, id  _Nonnull request) {
        if (success) {
        }
    }];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (![NSUserDefaultMemory defaultGetwithUnityKey:FIRSTLAUNCHRECORD]) {
        PomeloGuidancePageViewController *gui = [[PomeloGuidancePageViewController alloc] init];
        self.window.rootViewController = gui;
        [self.window makeKeyAndVisible];
    }else {
        BaseTabBarController *base = [[BaseTabBarController alloc] init];
        self.window.rootViewController = base;
        [self.window makeKeyAndVisible];
    }
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
