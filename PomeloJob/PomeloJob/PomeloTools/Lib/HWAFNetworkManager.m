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
        
    });
    return _instance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 20.0;
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
        
//        if ([response[@"status"] integerValue] == 200) {
//
//        }else if ([response[@"status"] integerValue] == 400) {
//
//        }else if ([response[@"status"] integerValue] == 401) {
//
//        }else {
//            [SVProgressHUD showInfoWithStatus:@"连接超时！"];
//            [SVProgressHUD dismissWithDelay:1];
//        }
        
        [self handleData:response withHandle:handler];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error withHandle:handler];
        [SVProgressHUD showErrorWithStatus:@"请求失败!"];
        [SVProgressHUD dismissWithDelay:1];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statuscode = response.statusCode;
        NSLog(@"error===========%ld", (long)statuscode);
    }];
    
}

- (void)appPost:(NSString *)url parameters:(NSDictionary *)parameters image:(UIImage *)image handler:(void(^)(BOOL success, NSDictionary *response))handler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"apolication/json", @"text/html",@"text/plain",@"image/jpeg",@"image/png", nil];
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 201)];
    manager.requestSerializer.timeoutInterval = 10.0;
    
    
    url = [PartTimeBaseUrl stringByAppendingString:url];
    UIImage *imageq = [UIImage imageNamed:@"portraitImgV"];
    NSData *imageData = UIImageJPEGRepresentation(imageq, 0.5);
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"portrait" fileName:@"imgfile" mimeType:@"JPEG"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        handler(YES, responseObject);
        NSDictionary *response = (NSDictionary *)responseObject;
//        if ([response[@"status"] integerValue] == 200) {
//
//        }else if ([response[@"status"] integerValue] == 400) {
//
//        }else if ([response[@"status"] integerValue] == 401) {
//
//        }else {
//            [SVProgressHUD showInfoWithStatus:@"连接超时！"];
//            [SVProgressHUD dismissWithDelay:1];
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败!"];
        [SVProgressHUD dismissWithDelay:1];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statuscode = response.statusCode;
        NSLog(@"error===========%ld", (long)statuscode);
    }];
}

- (NSURLSessionDataTask *)appPost:(NSString *)url parameters:(NSDictionary *)parameters handler:(void(^)(BOOL success, NSDictionary *response))handler{
    
    if (self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self handleError:[[NSError alloc] initWithDomain:@"network" code:-1009 userInfo:nil] withHandle:nil];
        return nil;
    }
    
    //[SVProgressHUD showWithStatus:@""];
    
    return [self POST:url parameters:[self wrappedParameters:parameters] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        
//        if ([response[@"status"] integerValue] == 200) {
//            
//        }else if ([response[@"status"] integerValue] == 400) {
//            
//        }else if ([response[@"status"] integerValue] == 401) {
//            
//        }else {
//            [SVProgressHUD showInfoWithStatus:@"连接超时！"];
//            [SVProgressHUD dismissWithDelay:1];
//        }
        
        [self handleData:response withHandle:handler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error withHandle:handler];
        [SVProgressHUD showErrorWithStatus:@"请求失败!"];
        [SVProgressHUD dismissWithDelay:1];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statuscode = response.statusCode;
        NSLog(@"error===========%ld", (long)statuscode);
    }];
}

//图片
- (NSURLSessionDataTask *)appPost:(NSString *)url parameters:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void(^)(NSProgress *progress))progress handler:(void(^)(BOOL success, NSDictionary *response))handler{
    if (self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self handleError:[[NSError alloc] initWithDomain:@"network" code:-1009 userInfo:nil] withHandle:nil];
        return nil;
    }
    return [self POST:url parameters:[self wrappedParameters:parameters] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        [self handleData:response withHandle:handler];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败!"];
        [SVProgressHUD dismissWithDelay:1];
        [self handleError:error withHandle:handler];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statuscode = response.statusCode;
        NSLog(@"error===========%ld", (long)statuscode);
    }];
}

- (void)resume:(NSDictionary *)parameters updateResume:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_UPDATERESUME parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
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

//登录1.5
- (void)accountRequest:(NSDictionary *)parameters loginByMessageAndPassword:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_LOGINBYMESSAGEANDPASSWORD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}
- (void)accountRequest:(NSDictionary *)parameters userLogin:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_USERLOGON parameters:parameters handler:^(BOOL success, NSDictionary *response) {
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

//登录的时候传唯一标识
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
//简历1.5

- (void)resume:(NSDictionary *)parameters selectResumeInfo:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_SELECTRESUMEINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)resume:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *)type progress:(ZHandlerProgressBlock)progressHandler updateResume:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_UPDATERESUME parameters:parameters images:images name:name fileName:filename mimeType:type progress:^(NSProgress *progress) {
        progressHandler(progress);
    } handler:^(BOOL success, NSDictionary *response) {
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

//我的新版
- (void)userInfo:(NSDictionary *)parameters queryMymine:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_QUERYMYMINE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)opinionRequest:(NSDictionary *)parameters collectTel:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_COLLECTTEL parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)opinionRequest:(NSDictionary *)parameters collectFeedback:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_COLLECTFEEDBACK parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters findPassword:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_FINDPASSWORD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters updaterefactoruserpassword:(ZHandlerBlock)handler {
    [self appPost:CUSTOMER_UPDATEREFACTORUSERPASSWORD parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)accountRequest:(NSDictionary *)parameters checkMessage:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_CHECKMESSAGE parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)userInfo:(NSDictionary *)parameters selectuserinfo:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_SELECTUSERINFO parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)userInfo:(NSDictionary *)parameters images:(nonnull NSArray<UIImage *> *)images name:(nonnull NSString *)name fileName:(nonnull NSString *)filename mimeType:(nonnull NSString *)type progress:(nonnull ZHandlerProgressBlock)progressHandler updateuserinfo:(nonnull ZHandlerBlock)handler {
    [self appPost:CUSTOMER_UPDATEUSERINFO parameters:parameters images:images name:name fileName:filename mimeType:type progress:^(NSProgress *progress) {
        progressHandler(progress);
    } handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)position:(NSDictionary *)parameters deleteuserposition:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_DELETEUSERPOSITION parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)position:(NSDictionary *)parameters setuserposition:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_SETUSERPOSITION parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

- (void)position:(NSDictionary *)parameters collectFeedback:(ZHandlerBlock)handler {
    [self appGet:CUSTOMER_COLLECTFEEDBACK parameters:parameters handler:^(BOOL success, NSDictionary *response) {
        handler(success, response);
    }];
}

@end
