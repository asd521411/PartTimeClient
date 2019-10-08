//
//  NSUserDefaultMemory.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/10.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaultMemory : NSObject

+ (void)defaultSetMemory:(id)obj unityKey:(NSString *)key;

+ (id)defaultGetwithUnityKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
