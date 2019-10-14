//
//  PomeloVerifyViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloVerifyLoginViewController.h"
#import "ReactiveCocoa.h"
#import "PomeloResetViewController.h"
#import <UMAnalytics/MobClick.h>

@interface PomeloVerifyLoginViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIImageView *iconImgV;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger interger;

@property (nonatomic, strong) UIButton *getCode;



@end

@implementation PomeloVerifyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.interger = 60;
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [self.timer setFireDate:[NSDate distantFuture]];
    
}

- (void)timer:(NSTimer *)time {
//    self.interger--;
//    [self.getCode setTitle:[NSString stringWithFormat:@"%ld%@",(long)self.interger, @"s"] forState:UIControlStateNormal];
//
//    if (self.interger == 0) {
//        [self.getCode setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
//         self.getCode.userInteractionEnabled = YES;
//        [self.timer setFireDate:[NSDate distantFuture]];
//    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.timer invalidate];
//    self.timer = nil;
}


- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    self.backScrollV.scrollEnabled = YES;
    self.backScrollV.bounces = YES;
    [self.view addSubview:self.backScrollV];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
    [self.backScrollV addGestureRecognizer:tap1];
    
    CGFloat wid = (SCREENWIDTH - 150 * 2);
    CGFloat hei = 40;
    
    self.iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - wid) / 2, KSpaceDistance15, wid, wid)];
    self.iconImgV.image = [UIImage imageNamed:@"loginTopImg"];
    self.iconImgV.layer.cornerRadius = 10;
    self.iconImgV.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.iconImgV];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.iconImgV.bottom + 50, 80, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize18;
    lab1.text = @"手机号";
//    switch (self.entranceType) {
//        case VerifyLoginStyle:
//            lab1.text = @"手机号：";
//            break;
//        case ForgetPassword:
//            lab1.text = @"手机号";
//            break;
//        case RegisterStyle:
//            lab1.text = @"注册手机号";
//        default:
//            break;
//    }
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.bottom + 10, KSCREEN_WIDTH - 30 - lab1.width, hei)];
//    switch (self.entranceType) {
//        case VerifyLoginStyle:
//            textFd1.placeholder = @"请输入手机号";
//            break;
//        case ForgetPassword:
//            textFd1.placeholder = @"请输入手机号";
//        case RegisterStyle:
//            if (![ECUtil isBlankString:self.phoneNum]) {
//                textFd1.placeholder = self.phoneNum;
//            }else {
//                textFd1.placeholder = @"请输入手机号";
//            }
//        default:
//            break;
//    }
    if (![ECUtil isBlankString:self.phoneNum]) {
        textFd1.placeholder = self.phoneNum;
    }else {
        textFd1.placeholder = @"请输入手机号";
    }
    textFd1.text = self.phoneNum;
    textFd1.textColor = KColor_C8C8C8;
    textFd1.font = KFontNormalSize16;
    textFd1.keyboardType = UIKeyboardTypeNumberPad;
    //textFd1.secureTextEntry = YES;
    [self.backScrollV addSubview:textFd1];
    //    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    //    textFd1.layer.borderWidth = KLineWidthMeasure05;
    [[textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 11) {
            textFd1.text = [text substringToIndex:11];
        }
    }];
    self.getCode = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getCode.frame = CGRectMake(KSCREEN_WIDTH - 70 - KSpaceDistance15, textFd1.bottom - 25, 70, 15);
    self.getCode.backgroundColor = [HWRandomColor randomColor];
    //[self.backScrollV addSubview:self.getCode];
    self.getCode.layer.cornerRadius = 1;
    self.getCode.layer.masksToBounds = YES;
    [ECUtil gradientLayer:self.getCode startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0.5 location2:1];
    [self.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getCode.titleLabel.font = KFontNormalSize10;
    
    __weak typeof(self) weakSelf = self;
    [[self.getCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (![textFd1.text n6_isMobile] || textFd1.text.length != 11) {
            [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.timer setFireDate:[NSDate distantPast]];
        strongSelf.getCode.userInteractionEnabled = NO;
        strongSelf.interger = 60;

        [[HWAFNetworkManager shareManager] accountRequest:@{@"usertel":textFd1.text} sendMessage:^(BOOL success, id  _Nonnull request) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
            }
        }];
    }];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, textFd1.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(15, textFd1.bottom + 20, KSCREEN_WIDTH - 30, hei)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize18;
    lab2.text = @"密 码";
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab2];
    
    UITextField *textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab2.bottom + 10, SCREENWIDTH - 30 - lab1.width, hei)];
    textFd2.placeholder = @"请输入密码";
    textFd2.textColor = KColor_C8C8C8;
    textFd2.font = KFontNormalSize16;
    //textFd2.keyboardType = UIKeyboardTypeNumberPad;
    textFd2.secureTextEntry = YES;
    [self.backScrollV addSubview:textFd2];
    //    textFd2.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    //    textFd2.layer.borderWidth = KLineWidthMeasure05;
    [[textFd2 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 16) {
            textFd2.text = [text substringToIndex:16];
        }
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, textFd2.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(95,  lab2.bottom + 90, KSCREEN_WIDTH - 95 * 2, 40);
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    switch (self.entranceType) {
        case VerifyLoginStyle:
            [login setTitle:@"登   陆" forState:UIControlStateNormal];
            break;
        case ForgetPassword:
            [login setTitle:@"输入新密码" forState:UIControlStateNormal];
        case RegisterStyle:
            [login setTitle:@"提     交" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [login setTintColor:[UIColor whiteColor]];
    login.adjustsImageWhenHighlighted = NO;
    //[ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [login setBackgroundColor:[UIColor colorWithRed:70/255.0 green:222/255.0 blue:160/255.0 alpha:1]];
    
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (![textFd1.text n6_isMobile]) {
            [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }

//        if (textFd2.text.length >= 16) {
//            [SVProgressHUD showInfoWithStatus:@"密码过长！"];
//            [SVProgressHUD dismissWithDelay:1];
//            return ;
//        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        switch (strongSelf.entranceType) {
            case VerifyLoginStyle:{
//                NSDictionary *para = @{@"usertel":@"18345067097",
//                                       @"usermessagecode":@"123456",
//                                       @"phonecar":[ECUtil getIDFA]
//                                       };
                NSDictionary *para = @{@"usertel":textFd1.text,
                                       @"userpassword":textFd2.text,
                                       @"phonecar":[ECUtil getIDFA]
                                       };
                [[HWAFNetworkManager shareManager] accountRequest:para loginByPassword:^(BOOL success, id  _Nonnull request) {
                    if (success) {
                        [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
                        [SVProgressHUD dismissWithDelay:1];
                        
                        if ([request[@"status"] isEqualToString:@"success"]) {
                            [NSUserDefaultMemory defaultSetMemory:request[@"userid"] unityKey:USERID];
                            [MobClick profileSignInWithPUID:request[@"userid"]];
                            [strongSelf.navigationController popToRootViewControllerAnimated:YES];
                            UITabBarController *tabBarVc = strongSelf.navigationController.tabBarController;
                            tabBarVc.selectedIndex = 0;
                        }
                        if ([request[@"status"] isEqualToString:@"fail"]) {
                            
                        }
                        
                    }
                }];
            } break;
                
            case ForgetPassword:{
//                NSDictionary *para = @{@"usertel":@"18345067097",
//                                       @"usermessagecode":@"123456",
//                                       };
                
                NSDictionary *para = @{@"usertel":textFd1.text,
                                       @"usermessagecode":textFd2.text,
                                       };
                [[HWAFNetworkManager shareManager] accountRequest:para forgetMessage:^(BOOL success, id  _Nonnull request) {
                    if (success) {
                        [SVProgressHUD showWithStatus:request[@"statusMessage"]];
                        [SVProgressHUD dismissWithDelay:1];
                        if ([request[@"status"] isEqualToString:@"fail"]) {
                            
                        }
                        if ([request[@"status"] isEqualToString:@"success"]) {
                            PomeloResetViewController *set = [[PomeloResetViewController alloc] init];
                            set.phoneNum = textFd1.text;
                            set.password = strongSelf.password;
                            set.entranceType = ForgetPassword;
                            [strongSelf.navigationController pushViewController:set animated:YES];
                        }
                    }
                }];
            }
                break;
            case RegisterStyle:{

                NSDictionary *para = @{@"usertel":textFd1.text,
                                       @"usermessagecode":textFd2.text,
                                       @"phonecar":[ECUtil getIDFA]
                                       };
//                NSDictionary *para = @{@"usertel":textFd1.text,
//                                       @"usermessagecode":textFd2.text,
//                                       };
//                [[HWAFNetworkManager shareManager] accountRequest:para loginSendMessage:^(BOOL success, id  _Nonnull request) {
//                    if (success) {
//                        if ([request[@"status"] isEqualToString:@"fail"]) {
//                            [SVProgressHUD showInfoWithStatus:request[@"statusMessage"]];
//                            [SVProgressHUD dismissWithDelay:1];
//                        }
//                        if ([request[@"status"] isEqualToString:@"success"]) {
//                            [SVProgressHUD showInfoWithStatus:request[@"statusMessage"]];
//                            [SVProgressHUD dismissWithDelay:1];
//                            
//                            PomeloResetViewController *set = [[PomeloResetViewController alloc] init];
//                            set.phoneNum = textFd1.text;
//                            set.password = strongSelf.password;
//                            set.entranceType = RegisterStyle;
//                            [strongSelf.navigationController pushViewController:set animated:YES];
//                        }
//                    }
//                }];
            }break;
            default:
                break;
        }
    }];
    
}

- (void)tapAction1:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
