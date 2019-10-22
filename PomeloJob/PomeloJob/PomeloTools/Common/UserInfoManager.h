//
//  UserInfoManager.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/16.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoManager : NSObject

+ (instancetype)shareInstance;

- (BOOL)userLoginStatus;
- (BOOL)setUserInfo:(NSString *)password;
- (NSString *)getUserInfoForPassword;
- (BOOL)exit;

- (NSString *)getIDFA;
@end

NS_ASSUME_NONNULL_END
