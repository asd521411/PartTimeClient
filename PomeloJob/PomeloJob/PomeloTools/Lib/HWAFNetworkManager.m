//
//  HWAFNetworkManager.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/9.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "HWAFNetworkManager.h"
#import "AFNetworkActivityIndicatorManager.h"


@implementation HWAFNetworkManager

+ (instancetype)shareManager {
    static HWAFNetworkManager *_instance = nil;
    static dispatch_once_t once_Token;
    dispatch_once(&once_Token, ^{
        _instance = [[HWAFNetworkManager alloc] initWithBaseURL:[NSURL URLWithString:PartTimeBaseUrl]];
        //_instance = [[HWAFNetworkManager alloc] initWithBaseURL:nil];
    });
    return _instance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        //self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        __weak HWAFNetworkManager *weakSelf = self;
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"" object:nil] subscribeNext:^(id x) {
            __block HWAFNetworkManager *strongSelf = weakSelf;
            [strongSelf networkStatusChanged:x];
        }];
    }
    return self;
}

- (void)networkStatusChanged:(NSNotification *)notification
{
    NSOperationQueue *operationQueue = self.operationQueue;
    switch (self.reachabilityManager.networkReachabilityStatus) {
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi:
            [operationQueue setSuspended:NO];
            break;
        case AFNetworkReachabilityStatusNotReachable:
        default:
            [operationQueue setSuspended:YES];
            break;
    }
}

- (NSDictionary *)wrappedParameters:(NSDictionary *)parameters {
    
    
//    NSMutableArray *headers = [[NSMutableArray alloc] init];
//    for (NSString *key in md) {
//        [headers addObject:[NSString stringWithFormat:@"%@=%@", key, [md objectForKey:key]]];
//    }
//    NSString *identifier = [headers componentsJoinedByString:@"&"];
//    [self.requestSerializer setValue:identifier forHTTPHeaderField:@"dryidentifier"];

    return parameters;
}

- (NSURLSessionDataTask *)appGet:(NSString *)url parameters:(NSDictionary *)parameters handler:(void(^)(BOOL success, NSDictionary *response))handler{
    
    if (self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self handleError:[[NSError alloc] initWithDomain:@"network" code:-1009 userInfo:nil] withHandle:nil];
        return nil;
    }
    url = [PartTimeBaseUrl stringByAppendingString:url];
    return [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        [self handleData:response withHandle:handler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error withHandle:handler];
    }];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    url = [PartTimeBaseUrl stringByAppendingString:url];
//    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"======%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"------%@", error);
//    }];
    
}

- (NSURLSessionDataTask *)appPost:(NSString *)url parameters:(NSDictionary *)parameters handler:(void(^)(BOOL success, NSDictionary *response))handler{
    
    if (self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        
        [self handleError:[[NSError alloc] initWithDomain:@"network" code:-1009 userInfo:nil] withHandle:nil];
        return nil;
    }
    
    return [self POST:url parameters:[self wrappedParameters:parameters] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        [self handleData:response withHandle:handler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error withHandle:handler];
    }];
}


// MARK: response state

- (void)handleData:(NSDictionary *)data withHandle:(void(^)(BOOL success, NSDictionary *response))handler {
//    NSInteger errorCode = [data[@"code"] integerValue];
//    if (errorCode == 0) {
        id response = data;
        handler(YES, response);
//    }else {
//        if (errorCode == -405) {
//            handler(NO, data);
//        }
//    }
}

- (void)handleError:(NSError *)error withHandle:(void(^)(BOOL success, NSDictionary *response))handler {
    NSLog(@"handleError--------%ld--------!!!!!!!", (long)error.code);
    if (error.code == -1009) {
        //handler(NO, @{@"code":@"-1009"});
    }else {
        //handler(NO, @{@"code":@"error"});
    }
}



















- (void)accountRequest:(NSDictionary *)parameters loginByPassword:(nonnull ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGINBYPASSWORD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters loginByMessageCode:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGINBYMESSAGECODE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters sendMessage:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_SENDMESSAGE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters loginSendMessage:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGONSENDMESSAGE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters login:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGON parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters forgetMessage:(ZHandlerBlock)handler {
    [self appPost:CUSTOMERFORGINMESSAGE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters updataPassword:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_UPDATEPASSWORD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

//权限
- (void)userLimitPositionRequest:(NSDictionary *)parameters userPosition:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_USERPOSITION parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)position:(NSDictionary *)parameters postion:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_POSITION parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)positionRequest:(NSDictionary *)parameters positionInfo:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_POSITIONINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)positionRequest:(NSDictionary *)parameters doJob:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_DOJOB parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)positionRequest:(NSDictionary *)parameters getStyle:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_GETSQUAREIMG parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

//查询审核状态
- (void)accountRequest:(NSDictionary *)parameters checkStatus:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_CHECKSTATUS parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

//登陆的时候传唯一标识
- (void)accountRequest:(NSDictionary *)parameters initPhonecard:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_INITPHONECARD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
//简历状态
- (void)positionRequest:(NSDictionary *)parameters selectResumeByuserid:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_SELECTRESUMEBYUSERID parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}




//- (void)positionDetailRequest:(NSDictionary *)parameters positionDetailId:(ZHandlerBlock)handler {
//    [self appGet:nil parameters:parameters handler:^(BOOL success, NSDictionary *response) {
//        handler(success, response);
//    }];
//}

//加载图片
- (void)commonAcquireImg:(NSDictionary *)parameters firstImg:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_FIRSTIMG parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)resume:(NSDictionary *)parameters resumeInfo:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_RESUMEINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)resumeInfo:(NSDictionary *)parameters resumeInfo:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_RESUMEINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)resume:(NSDictionary *)parameters resumeHunting:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_RESUMEHUNTING parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)resume:(NSDictionary *)parameters resumeCompany:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_RESUMECOMPANY parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)resume:(NSDictionary *)parameters resumeSchool:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_RESUMESCHOOL parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)userInfo:(NSDictionary *)parameters postUserInfo:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_USERINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)userInfo:(NSDictionary *)parameters getUserInfo:(ZHandlerBlock)handler{
    [self appGet:CUSTOMER_USERINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

//发现
- (void)discover:(NSDictionary *)parameters defaultFound:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_DEFAULTFOUND parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

//记录操作
- (void)clickOperation:(NSDictionary *)parameters advertismentclick:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_ADVERTISEMENTCLICK parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)clickOperation:(NSDictionary *)parameters selectAgeByPhonecar:(ZHandlerBlock)handler {
    [self appGet:CUSOMER_SELECTAGEBYPHONECARD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)clickOperation:(NSDictionary *)parameters updateageByphonecard:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_UPDATEAGEBYPHONECARD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

@end
