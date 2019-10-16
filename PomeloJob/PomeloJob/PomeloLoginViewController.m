//
//  PomeloLoginViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloLoginViewController.h"
#import "PomeloVerifyLoginViewController.h"
#import "PomeloForgetViewController.h"
#import <UMAnalytics/MobClick.h>
#import "PrivacyPolicyViewController.h"
#import "PomeloResetViewController.h"

@interface PomeloLoginViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIImageView *iconImgV;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger interger;
@property (nonatomic, strong) UIButton *getCode;


@end

@implementation PomeloLoginViewController


- (instancetype)shareInstance {
    static PomeloLoginViewController *instance = nil;
    static dispatch_once_t *once_Token;
    dispatch_once(once_Token, ^{
        instance = [[PomeloLoginViewController alloc] init];
    });
    return instance;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
    self.backScrollV.scrollEnabled = YES;
    self.backScrollV.bounces = YES;
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
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
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.iconImgV.bottom + 50, 80, hei)];
    lab.textColor = KColor_212121;
    lab.font = KFontNormalSize18;
    lab.text = @"手机号";
    lab.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab];
    
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab.bottom, 80, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize18;
    lab1.text = @"+86 |";
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    textFd1.placeholder = @"请输入手机号";
    textFd1.textColor = KColor_C8C8C8;
    textFd1.font = KFontNormalSize16;
    textFd1.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:textFd1];
//    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
//    textFd1.layer.borderWidth = KLineWidthMeasure05;
    [[textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 11) {
            textFd1.text = [text substringToIndex:11];
        }
    }];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom + 30, lab1.width, hei)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize18;
    lab2.text = @"验证码";
    [self.backScrollV addSubview:lab2];
    
    UITextField *textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab2.bottom, SCREENWIDTH - lab1.width - 30, hei)];
    textFd2.placeholder = @"请输入验证码";
    textFd2.textColor = KColor_C8C8C8;
    textFd2.font = KFontNormalSize16;
    textFd2.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:textFd2];
//    textFd2.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
//    textFd2.layer.borderWidth = KLineWidthMeasure05;
    
    [[textFd2 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 6) {
            textFd2.text = [text substringToIndex:6];
        }
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, textFd2.bottom - 1, KSCREEN_WIDTH - 30, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];
    
    self.getCode = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getCode.frame = CGRectMake(KSCREEN_WIDTH - 90 - KSpaceDistance15, textFd2.bottom - 28, 90, 28);
    self.getCode.backgroundColor = [UIColor colorWithRed:70/255.0 green:222/255.0 blue:160/255.0 alpha:1];
    self.getCode.layer.cornerRadius = 14;
    self.getCode.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.getCode];
    //[ECUtil gradientLayer:self.getCode startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0.5 location2:1];
    [self.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getCode.titleLabel.font = KFontNormalSize12;
    
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
    
    
//    UIButton *agree = [UIButton buttonWithType:UIButtonTypeCustom];
//    agree.frame = CGRectMake(KSpaceDistance15, lab2.bottom + KSpaceDistance15, hei / 2, hei / 2);
//    agree.layer.cornerRadius = 3;
//    agree.layer.masksToBounds = YES;
//    [self.backScrollV addSubview:agree];
//    [agree setBackgroundImage:[UIImage imageNamed:@"honggou"] forState:UIControlStateNormal];
//    [agree setBackgroundImage:[UIImage imageNamed:@"honggouse"] forState:UIControlStateSelected];
//    [[agree rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        UIButton *btn  = x;
//        btn.selected = !btn.selected;
//    }];
    
    
//
//    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
//    left.frame = CGRectMake(KSpaceDistance15, remind.bottom + KSpaceDistance15, 100, hei);
//    left.titleLabel.textAlignment = NSTextAlignmentLeft;
//    //[left setTitle:@"验证码登陆" forState:UIControlStateNormal];
//    [left setTitleColor:KColor_212121 forState:UIControlStateNormal];
//    [self.backScrollV addSubview:left];
//
    
//    [[left rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        PomeloVerifyLoginViewController *verify = [[PomeloVerifyLoginViewController alloc] init];
//        verify.phoneNum = textFd1.text;
//        verify.password = textFd2.text;
//        verify.entranceType = VerifyLoginStyle;
//        [strongSelf.navigationController pushViewController:verify animated:YES];
//    }];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(KSCREEN_WIDTH - 15 - 220, line2.bottom + KSpaceDistance15, 220, hei);
    //right.titleLabel.textAlignment = NSTextAlignmentRight;
    //right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //right.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [right setTitle:@"获取不到验证码？用密码登陆" forState:UIControlStateNormal];
    right.titleLabel.font = KFontNormalSize16;
    right.titleLabel.textAlignment = NSTextAlignmentRight;
    [right setTitleColor:[ECUtil colorWithHexString:@"7f7f7f"] forState:UIControlStateNormal];
    [self.backScrollV addSubview:right];
    
    [[right rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        PomeloVerifyLoginViewController *verify = [[PomeloVerifyLoginViewController alloc] init];
        verify.phoneNum = textFd1.text;
        verify.password = textFd2.text;
        verify.entranceType = VerifyLoginStyle;
        [strongSelf.navigationController pushViewController:verify animated:YES];
        
        
    }];
    
//    UIButton *regis = [UIButton buttonWithType:UIButtonTypeCustom];
//    regis.frame = CGRectMake(15, left.bottom + 40, (KSCREEN_WIDTH - 30 - 65)/2, 40);
//    regis.layer.cornerRadius = 20;
//    regis.layer.masksToBounds = YES;
//    //[self.backScrollV addSubview:regis];
//    [regis setTitle:@"注   册" forState:UIControlStateNormal];
//    [regis setTintColor:[UIColor whiteColor]];
//    regis.adjustsImageWhenHighlighted = NO;
//    [ECUtil gradientLayer:regis startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
//
//    [[regis rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [textFd1 resignFirstResponder];
//        [textFd2 resignFirstResponder];
//        if (![textFd1.text n6_isMobile]) {
//            [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
//            [SVProgressHUD dismissWithDelay:1];
//            return ;
//        }
////        if (!agree.selected) {
////            [SVProgressHUD showInfoWithStatus:@"请同意用户注册及使用APP隐私协议！"];
////            [SVProgressHUD dismissWithDelay:1];
////            return ;
////        }
//        PomeloVerifyLoginViewController *verify = [[PomeloVerifyLoginViewController alloc] init];
//        verify.phoneNum = textFd1.text;
//        verify.password = textFd2.text;
//        verify.entranceType = RegisterStyle;
//        [strongSelf.navigationController pushViewController:verify animated:YES];
//    }];
//
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake((KSCREEN_WIDTH - 221)/2,  right.bottom + 10, 221, 40);
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"登  陆" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    login.adjustsImageWhenHighlighted = NO;
    //[ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [login setBackgroundColor:[UIColor colorWithRed:70/255.0 green:222/255.0 blue:160/255.0 alpha:1]];
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [textFd1 resignFirstResponder];
        [textFd2 resignFirstResponder];
        if (![textFd1.text n6_isMobile]) {
            [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        if (textFd2.text.length != 6) {
            [SVProgressHUD showInfoWithStatus:@"验证码错误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
//        if (textFd2.text.length > 32) {
//            //[SVProgressHUD showInfoWithStatus:@"密码过长！"];
//            [SVProgressHUD dismissWithDelay:1];
//            return ;
//        }
//        if (!agree.selected) {
//            [SVProgressHUD showInfoWithStatus:@"请同意用户注册及使用APP隐私协议！"];
//            [SVProgressHUD dismissWithDelay:1];
//            return ;
//        }
        
        //唯一标识
//        NSString *uuid = nil;
//        if ([SSKeychain passwordForService:SERVICEKEYCHAIN account:ALREADYRESIGN]) {
//            uuid = [SSKeychain passwordForService:SERVICEKEYCHAIN account:ALREADYRESIGN];
//        }else {
//            uuid = [ECUtil getUUID];
//            [SSKeychain setPassword:uuid forService:SERVICEKEYCHAIN account:ALREADYRESIGN];
//        }
        NSDictionary *para = @{@"usertel":textFd1.text,
                               @"usermessagecode":textFd2.text,
                               @"phonecard":[ECUtil getIDFA]
                               };
        
//        NSDictionary *para = @{@"usertel":@"18345067097",
//                               @"userpassword":@"123456",
//                               @"phonecard":[ECUtil getIDFA]
//                               };
        [[HWAFNetworkManager shareManager] accountRequest:para loginByMessageCode:^(BOOL success, id  _Nonnull request) {
            NSDictionary *dic = (NSDictionary *)request;
            if (success) {
                [SVProgressHUD showSuccessWithStatus:dic[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                
                if ([request[@"status"] isEqualToString:@"fail"]) {
//                    PomeloVerifyLoginViewController *reg = [[PomeloVerifyLoginViewController alloc] init];
//                    reg.phoneNum = textFd1.text;
//                    reg.password = textFd2.text;
//                    reg.entranceType = RegisterStyle;
//                    [strongSelf.navigationController pushViewController:reg animated:YES];
                    
                    if ([request[@"statusMessage"] isEqualToString:@"验证码错误"]) {
                        [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
                        [SVProgressHUD dismissWithDelay:1];
                    }
                    
                    if ([request[@"statusMessage"] isEqualToString:@"用户没有注册，请注册"]) {
                        PomeloResetViewController *reset = [[PomeloResetViewController alloc] init];
                        reset.phoneNum = textFd1.text;
                        reset.password = textFd2.text;
                        reset.entranceType = RegisterStyle;
                        [self.navigationController pushViewController:reset animated:YES];
                    }
                }
                
                if ([request[@"status"] isEqualToString:@"success"]) {
                    if (dic[@"userid"]) {
                        [NSUserDefaultMemory defaultSetMemory:dic[@"userid"] unityKey:USERID];
                        [MobClick profileSignInWithPUID:dic[@"userid"]];
                        [strongSelf.navigationController popToRootViewControllerAnimated:YES];
                    }else {
                        [SVProgressHUD showSuccessWithStatus:@"请求错误！"];
                        [SVProgressHUD dismissWithDelay:1];
                    }
                }
            }
        }];

    }];
    
    UILabel *remind = [[UILabel alloc] initWithFrame:CGRectMake(15, login.bottom + 50, KSCREEN_WIDTH - 30, hei)];
    
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:@"登陆即代表你已同意"];
    [mutStr addAttributes:@{NSForegroundColorAttributeName:[ECUtil colorWithHexString:@"b7b7b7"], NSFontAttributeName:KFontNormalSize16} range:NSMakeRange(0, 9)];
    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc] initWithString:@"《柚选隐私政策》"];
    [mutStr1 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:70/255.0 green:222/255.0 blue:160/255.0 alpha:1], NSFontAttributeName:KFontNormalSize16} range:NSMakeRange(0, 8)];
    [mutStr appendAttributedString:mutStr1];
    remind.attributedText = mutStr;
    remind.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:remind];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    [remind addGestureRecognizer:tap];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.frame = CGRectMake(15, login.bottom + 50, KSCREEN_WIDTH - 30, hei);
    [self.backScrollV addSubview:bu];
    [bu addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)tapAction1:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

//- (void)tapAction:(UIGestureRecognizer *)tap {
//    PrivacyPolicyViewController *pri = [[PrivacyPolicyViewController alloc] init];
//    [self.navigationController pushViewController:pri animated:YES];
//}

- (void)tapAction:(UIButton *)send {
    PrivacyPolicyViewController *pri = [[PrivacyPolicyViewController alloc] init];
    [self.navigationController pushViewController:pri animated:YES];
}

- (void)timer:(NSTimer *)time {
    self.interger--;
    [self.getCode setTitle:[NSString stringWithFormat:@"%ld%@",(long)self.interger, @"s"] forState:UIControlStateNormal];
    
    if (self.interger == 0) {
        [self.getCode setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        self.getCode.userInteractionEnabled = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
    }
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
