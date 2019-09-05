//
//  AppUpdater.m
//  chow
//
//  Created by LiuLian on 9/16/14.
//  Copyright (c) 2014 eallcn. All rights reserved.
//

#import "AppUpdater.h"

@implementation AppUpdater

+ (NSString *)localVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (void)checkUpgrade
{
//    [[AppHttpClient sharedInstance] accountRequest:@{} checkUpgrade:^(BOOL success, id result) {
//        if (result && [result isKindOfClass:[NSDictionary class]] && result[@"new_version"]) {
//            [[NSUserDefaults standardUserDefaults] setObject:result forKey:EC_USER_DEFAULT_KEY_UPGRADE];
//            [[NSNotificationCenter defaultCenter] postNotificationName:EC_NOTIFICATION_NAME_UPGRADE object:result];
//            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//            NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//            //            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//            //             NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//        } else {
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:EC_USER_DEFAULT_KEY_UPGRADE];
//            [[NSNotificationCenter defaultCenter] postNotificationName:EC_NOTIFICATION_NAME_UPGRADE_DEL object:result];
//        }
//    }];
}

+ (ECUpgrade *)upgrade
{
//    id upgrade = [[NSUserDefaults standardUserDefaults] objectForKey:EC_USER_DEFAULT_KEY_UPGRADE];
//    if (upgrade) {
//        return [ECUpgrade modelOfClass:[ECUpgrade class] fromJSONDictionary:upgrade];
//    }
    return nil;
}

+ (BOOL)checkFilterVersionChange
{
//    NSString *documentVersion = [[NSUserDefaults standardUserDefaults] objectForKey:EC_USER_DEFAULT_KEY_FILTER_VERSION];
//    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    if (! documentVersion) {
//        return YES;
//    }
//    if (![appVersion isEqualToString:documentVersion]) {
//        return YES;
//    }
    return NO;
}

+ (BOOL)checkSubwayVersionChange
{
//    NSString *documentVersion = [[NSUserDefaults standardUserDefaults] objectForKey:EC_USER_DEFAULT_KEY_SUBWAY_VERSION];
//    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    if (! documentVersion) {
//        return YES;
//    }
//    if (![appVersion isEqualToString:documentVersion]) {
//        return YES;
//    }
    return NO;
}

@end
