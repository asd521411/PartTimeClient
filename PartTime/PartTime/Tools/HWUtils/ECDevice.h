//
//  ECDevice.h
//  chow
//
//  Created by LiuLian on 5/21/15.
//  Copyright (c) 2015 eallcn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EDeviceType)
{
    EDeviceType_4 = 0,
    EDeviceType_5 = 1,
    EDeviceType_6 = 2,
    EDeviceType_6p = 3,
    EDeviceType_X = 4,
};

@interface ECDevice : NSObject

+ (NSDictionary *)clientInfo;
+ (EDeviceType)getDeviceType;
+ (BOOL)isUnderIPhone5;
+ (float)systemVersion;
+ (BOOL)isIOS8;

@end
