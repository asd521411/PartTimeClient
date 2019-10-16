//
//  UserInfoManager.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/16.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "UserInfoManager.h"
#import "SSKeychain.h"
@implementation UserInfoManager

+ (instancetype)shareInstance {
    static UserInfoManager *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[UserInfoManager alloc] init];
    });
    return _shareInstance;
}

- (BOOL)userLoginStatus {
    NSString *password = [SSKeychain passwordForService:SERVICEKEYCHAIN account:USERACCOUNT error:nil];
    return ![ECUtil isBlankString:password];
}

- (BOOL)setUserInfo:(NSString *)password {
    return [SSKeychain setPassword:password forService:SERVICEKEYCHAIN account:USERACCOUNT];
}

- (NSString *)getUserInfoForPassword{
    return [SSKeychain passwordForService:SERVICEKEYCHAIN account:USERACCOUNT];
}

- (BOOL)exitUserInfoForPassword{
    return [SSKeychain deletePasswordForService:SERVICEKEYCHAIN account:USERACCOUNT];
}

- (NSString *)getIDFA {
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}

@end
