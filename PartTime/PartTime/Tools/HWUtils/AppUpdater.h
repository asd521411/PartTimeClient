//
//  AppUpdater.h
//  chow
//
//  Created by LiuLian on 9/16/14.
//  Copyright (c) 2014 eallcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECUpgrade;

@interface AppUpdater : NSObject

+ (NSString *)localVersion;
+ (void)checkUpgrade;
+ (ECUpgrade *)upgrade;
+ (BOOL)checkFilterVersionChange;
+ (BOOL)checkSubwayVersionChange;

@end
