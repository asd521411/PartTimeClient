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
#import "VerisionUpdateViewController.h"

@interface PomeloAppDelegate ()

@property (nonatomic, assign) NSInteger versionState;

@end

@implementation PomeloAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:1];
    
    // MARK:友盟
    [UMConfigure initWithAppkey:UMENGkEY channel:nil];
    [MobClick setScenarioType:E_UM_NORMAL];//支持普通场景
#ifdef DEBUG
    //开发者需要显式的调用此函数，日志系统才能工作
//    [UMCommonLogManager setUpUMCommonLogManager];
//    [UMConfigure setLogEnabled:YES];//设置打开日志
//    //插屏消息要打开
//    [UMessage openDebugMode:YES];
#endif
    
    NSString *userid = [NSString stringWithFormat:@"%@", [NSUserDefaultMemory defaultGetwithUnityKey:USERID]];
    [MobClick profileSignInWithPUID:userid];
    
    //上传唯一标识
    NSDictionary *para = nil;
    if ([ECUtil isBlankString:userid]) {
        para = @{@"phonecard":[ECUtil getIDFA]};
    }else {
        para = @{@"phonecard":[ECUtil getIDFA], @"userid":userid};
    }
    
    [[HWAFNetworkManager shareManager] accountRequest:para initPhonecard:^(BOOL success, id  _Nonnull request) {
        if (success) {
            if ([request[@"update"] integerValue] == 1) {
                self.versionState = [request[@"update"] integerValue];
                if (self.versionState == 1) {
                    [self addNewFeature];
                }
            }
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
    
    //[self getVersionInfo];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)getVersionInfo {
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"https://itunes.apple.com/lookup?id=1481210769" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"results"];
        if(array.count < 1) {
            return;
        }
        NSDictionary*dic = array[0];
        //AppStore版本号
        NSString *appStoreVersion = dic[@"version"];
        
        if ([currentVersion compare:appStoreVersion] == NSOrderedDescending) {
            //更新
            NSLog(@"去更新");
        }else {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)addNewFeature{
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    back.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:back];
    
    //[self.view addSubview:back];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banbengengxin"]];
    img.frame = CGRectMake((KSCREEN_WIDTH-215)/2, 100, 215, 220);
    img.userInteractionEnabled = YES;
    [back addSubview:img];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, img.width, 20)];
    lab.text = @"版本更新了！";
    lab.textColor = kColor_Main;
    lab.textAlignment = NSTextAlignmentCenter;
    [img addSubview:lab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = kColor_Main;
    btn.frame = CGRectMake((img.width-115)/2, lab.bottom+20, 115, 30);
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"立即更新" forState:UIControlStateNormal];
    [img addSubview:btn];
    __weak typeof(self) weakSelf = self;
    [btn addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)update:(UIButton *)sender {
    [self openItuns];
}

-(void)openItuns{
    NSURL*url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8",@"1481210769"]];
    //NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", @"1481210769"]];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen){   //打开微信
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        });
    }else {
    }
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
