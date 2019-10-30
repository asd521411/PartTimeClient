//
//  HWAppMacros.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/9.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#ifndef HWAppMacros_h
#define HWAppMacros_h

// MARK: test

//本地
//#define PartTimeBaseUrl                                           @"http://192.168.200.63:8080/"
//服务器
#define PartTimeBaseUrl                                           @"http://114.116.230.97:8080/"
//#define PartTimeBaseUrl                                              @"http://26aq970368.zicp.vip/"

//测试
//#define PartTimeBaseUrl                                           @"http://114.116.230.97:9091/"

//手机号登录
#define CUSTOMER_LOGINBYPASSWORD                                   @"loginByPassword"
//发送验证码
#define CUSTOMER_SENDMESSAGE                                       @"sendMessage"
//验证码登录
#define CUSTOMER_LOGINBYMESSAGECODE                                @"loginByMessageCode"
//注册验证验证码
#define CUSTOMER_LOGONSENDMESSAGE                                  @"logonsendMessage"
//注册
#define  CUSTOMER_LOGON                                            @"logon"

#define CUSTOMERFORGINMESSAGE                                       @"forginMessage"
#define CUSTOMER_UPDATEPASSWORD                                     @"updatePassword"

//新接口===================
#define CUSTOMER_LOGINBYMESSAGEANDPASSWORD                          @"loginByMessageAndPassword"
#define CUSTOMER_USERLOGON                                          @"userlogon"

//首页
#define CUSTOMER_FIRSTIMG                                           @"firstimg"
// MARK: 看过我、我看过、已申请、待面试、收藏的职位列表，有权限
#define CUSTOMER_USERPOSITION                                      @"userPosition"
//获取普通职位列表
#define CUSTOMER_POSITION                                          @"position"
//登录的时候传唯一标识符
#define CUSTOMER_INITPHONECARD                                     @"initphonecard"
//简历状态
#define CUSTOMER_SELECTRESUMEBYUSERID                              @"selectResumeByuserid"

//列表详情
#define CUSTOMER_POSITIONINFO                                      @"positionInfo"
//是否审核中
#define CUSTOMER_CHECKSTATUS                                       @"checkStatus"

//立即报名复制上传
#define CUSTOMER_DOJOB                                             @"dojob"
//发现
#define CUSTOMER_DEFAULTFOUND                                      @"defaultfount"

//广场
#define CUSTOMER_GETSQUAREIMG                                      @"getSquareImg"

//我的简历
#define CUSTOMER_RESUMEINFO                                        @"resumeinfo"
//求职期望
#define CUSTOMER_RESUMEHUNTING                                     @"resumehunting"
//工作经验
#define CUSTOMER_RESUMECOMPANY                                     @"resumecompany"
//教育信息
#define CUSTOMER_RESUMESCHOOL                                      @"resumeschool"

// MARK: user-key
#define USERID                                                     @"userid"
#define USERINFO                                                   @"userInfo"
#define USERNAME                                                   @"username"
#define USERIMG                                                    @"suerimg"
#define USERBIRTHDAY                                               @"userbirthday"
#define USERSEX                                                    @"usersex"
#define USERTEL                                                    @"usertel"

//个人信息
#define CUSTOMER_USERINFO                                           @"user"

//记录操作点击
#define CUSTOMER_ADVERTISEMENTCLICK                                 @"advertismentclick"

//查询是否安装过
#define CUSOMER_SELECTAGEBYPHONECARD                                @"selectageByphonecard"
//上传年龄
#define CUSTOMER_UPDATEAGEBYPHONECARD                               @"updateageByphonecard"

//我的
#define CUSTOMER_QUERYMYMINE                                         @"queryMymine"

//简历1.5
//简历加载
#define CUSTOMER_SELECTRESUMEINFO                                    @"selectResumeInfo"
//简历上传
#define CUSTOMER_UPDATERESUME                                        @"updateResume"
//反馈
#define CUSTOMER_COLLECTTEL                                          @"collectTel"
//意见反馈
#define CUSTOMER_COLLECTFEEDBACK                                      @"collectFeedback"

#define CUSTOMER_FINDPASSWORD                                         @"findPassword"
#define CUSTOMER_UPDATEREFACTORUSERPASSWORD                           @"updaterefactoruserpassword"
#define CUSTOMER_CHECKMESSAGE                                         @"checkMessage"
#define CUSTOMER_SELECTUSERINFO                                       @"selectuserinfo"
#define CUSTOMER_UPDATEUSERINFO                                       @"updateuserinfo"
#define CUSTOMER_DELETEUSERPOSITION                                   @"deleteuserposition"
#define CUSTOMER_SETUSERPOSITION                                      @"setuserposition"
#define CUSTOMER_COLLECTFEEDBACK                                      @"collectFeedback"

#endif /* HWAppMacros_h */
