//
//  HWAFNetworkManager.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/9.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZHandlerBlock)(BOOL success, id request);

@interface HWAFNetworkManager : AFHTTPSessionManager

+ (instancetype)shareManager;

//acount
- (void)accountRequest:(NSDictionary *)parameters loginByPassword:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters loginByMessageCode:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters sendMessage:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters loginSendMessage:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters login:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters forgetMessage:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters updataPassword:(ZHandlerBlock)handler;
- (void)userLimitPositionRequest:(NSDictionary *)parameters userPosition:(ZHandlerBlock)handler;
- (void)position:(NSDictionary *)parameters postion:(ZHandlerBlock)handler;
- (void)positionRequest:(NSDictionary *)parameters positionInfo:(ZHandlerBlock)handler;
- (void)positionRequest:(NSDictionary *)parameters doJob:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters checkStatus:(ZHandlerBlock)handler;
- (void)accountRequest:(NSDictionary *)parameters initPhonecard:(ZHandlerBlock)handler;
- (void)positionRequest:(NSDictionary *)parameters selectResumeByuserid:(ZHandlerBlock)handler;
//广场
- (void)positionRequest:(NSDictionary *)parameters getStyle:(ZHandlerBlock)handler;

//所有图片
- (void)commonAcquireImg:(NSDictionary *)parameters firstImg:(ZHandlerBlock)handler;

//- (void)positionDetailRequest:(NSDictionary *)parameters positionDetailId:(ZHandlerBlock)handler;
//
- (void)userInfo:(NSDictionary *)parameters postUserInfo:(ZHandlerBlock)handler;
- (void)userInfo:(NSDictionary *)parameters getUserInfo:(ZHandlerBlock)handler;

//简历
- (void)resume:(NSDictionary *)parameters resumeInfo:(ZHandlerBlock)handler;
- (void)resumeInfo:(NSDictionary *)parameters resumeInfo:(ZHandlerBlock)handler;
- (void)resume:(NSDictionary *)parameters resumeHunting:(ZHandlerBlock)handler;
- (void)resume:(NSDictionary *)parameters resumeCompany:(ZHandlerBlock)handler;
- (void)resume:(NSDictionary *)parameters resumeSchool:(ZHandlerBlock)handler;
- (void)discover:(NSDictionary *)parameters defaultFound:(ZHandlerBlock)handler;

//记录操作
- (void)clickOperation:(NSDictionary *)parameters advertismentclick:(ZHandlerBlock)handler;

@end

NS_ASSUME_NONNULL_END
