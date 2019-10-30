//
//  NSUserDefaultMemory.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/10.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "NSUserDefaultMemory.h"

@implementation NSUserDefaultMemory

+ (void)defaultSetMemory:(id)obj unityKey:(NSString *)key {
    
    NSString *str = [NSString stringWithFormat:@"%@", obj];
    [[NSUserDefaults standardUserDefaults] setObject:str.length>0?str:@"" forKey:key];
}

+ (id)defaultGetwithUnityKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
