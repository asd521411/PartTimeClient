//
//  LoginViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/17.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "LoginViewController.h"
#import "FindViewController.h"
#import "NoteVerifyFeedbackViewController.h"
#import "PrivacyPolicyViewController.h"
#import <UMAnalytics/MobClick.h>
#import "PomeloResetViewController.h"
#import "VerifyCodeViewController.h"
#import "UserInfoModel.h"

@interface LoginViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *loginStyleBtn;
@property (nonatomic, strong) UITextField *phoneTextFd;
@property (nonatomic, strong) UITextField *verifyCodeTextFd;
@property (nonatomic, strong) UIButton *getCode;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger interger;
@property (nonatomic, strong) UIButton *findPasswordBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) YYLabel *agreement_yylab;
@property (nonatomic, strong) UIView *_86BackV;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    [self setupLayoutSubViews];
    
    [self verificationCodeLoginStyle];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)setupSubViews {
    [self.view addSubview:self.backScrollV];
    [self.backScrollV addSubview:self.backBtn];
    [self.backScrollV addSubview:self.titleLab];
    [self.backScrollV addSubview:self._86BackV];
    [self.backScrollV addSubview:self.phoneTextFd];
    [self.backScrollV addSubview:self.verifyCodeTextFd];
    [self.backScrollV addSubview:self.getCode];
    [self.backScrollV addSubview:self.loginStyle];
    [self.backScrollV addSubview:self.findPasswordBtn];
    [self.backScrollV addSubview:self.loginBtn];
    [self.backScrollV addSubview:self.agreement_yylab];
}

- (void)verificationCodeLoginStyle {
    self.titleLab.text = @"短信验证登陆/注册";
    self.phoneTextFd.placeholder = @"请输入您的手机号";
    self.verifyCodeTextFd.placeholder = @"验证码";
    [self.loginStyle setTitle:@"用密码登陆" forState:UIControlStateNormal];
    self.verifyCodeTextFd.keyboardType = UIKeyboardTypeNumberPad;
    [self.findPasswordBtn setTitle:@"收不到验证码？" forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:kColor_UnSelect];
    //self.loginBtn.userInteractionEnabled = NO;
    self.agreement_yylab.hidden = NO;
}

- (void)passwordLoginStyle {
    self.titleLab.text = @"账号密码登陆";
    self.verifyCodeTextFd.placeholder = @"密码";
    [self.loginStyle setTitle:@"用短信验证登陆/注册" forState:UIControlStateNormal];
    self.verifyCodeTextFd.keyboardType = UIKeyboardTypeASCIICapable;
    [self.findPasswordBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[ECUtil colorWithHexString:@"a8a8a8"]];
    //self.loginBtn.userInteractionEnabled = NO;
    self.agreement_yylab.hidden = YES;
}

#pragma mark action

- (void)getCodeAction:(UIButton *)sender {
//    if (![self inputCheckout]) {
//        return ;
//    }
    [self.phoneTextFd resignFirstResponder];
    [self.verifyCodeTextFd resignFirstResponder];
    if (![self.phoneTextFd.text n6_isMobile]) {
        [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
        [SVProgressHUD dismissWithDelay:1];
        return ;
    }
    [self.timer setFireDate:[NSDate distantPast]];
    self.getCode.userInteractionEnabled = NO;
    self.interger = 60;
    [[HWAFNetworkManager shareManager] accountRequest:@{@"usertel":self.phoneTextFd.text} sendMessage:^(BOOL success, id  _Nonnull request) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
        }
    }];
}

- (void)loginStyleAction:(UIButton *)send {
    if (send.selected) {
        [self verificationCodeLoginStyle];
        self._86BackV.hidden = NO;
//        self.phoneTextFd.text = nil;
        self.verifyCodeTextFd.text = nil;
        [self.phoneTextFd mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(65);
            make.left.mas_equalTo(95);
            make.width.mas_equalTo(KSCREEN_WIDTH-120);
            make.height.mas_equalTo(25);
        }];
    }else {
        [self passwordLoginStyle];
        self._86BackV.hidden = YES;
//        self.phoneTextFd.text = nil;
        self.verifyCodeTextFd.text = nil;
        [self.phoneTextFd mas_updateConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(self.titleLab.mas_bottom).offset(65);
               make.left.mas_equalTo(30);
               make.width.mas_equalTo(KSCREEN_WIDTH-60);
               make.height.mas_equalTo(25);
        }];
    }
    send.selected = !send.selected;
}

- (void)findPasswordAction:(UIButton *)send {
    if (self.loginStyleBtn.selected) {
        FindViewController *find = [[FindViewController alloc] init];
        [self.navigationController pushViewController:find animated:YES];
    }else {
        NoteVerifyFeedbackViewController *note = [[NoteVerifyFeedbackViewController alloc] init];
        [self.navigationController pushViewController:note animated:YES];
    }
}

- (void)loginBtnAction:(UIButton *)send {
    if ([self inputCheckout]) {
        send.backgroundColor = kColor_Main;
        [self.phoneTextFd resignFirstResponder];
        [self.verifyCodeTextFd resignFirstResponder];
        [self login];
    }else {
        send.backgroundColor = [ECUtil colorWithHexString:@"a8a8a8"];
    }
}

#pragma mark custom method

- (void)timer:(NSTimer *)time {
    self.interger--;
    [self.getCode setTitle:[NSString stringWithFormat:@"%ld%@",(long)self.interger, @"s"] forState:UIControlStateNormal];
    
    if (self.interger == 0) {
        [self.getCode setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        self.getCode.userInteractionEnabled = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)login {
    
    
    
    NSDictionary *para = nil;
    if (!self.loginStyleBtn.selected) {//验证码登陆
        para = @{@"usertel":self.phoneTextFd.text,
                 @"Message":self.verifyCodeTextFd.text,
                 @"password":@"",
                 @"phonecard":[ECUtil getIDFA]
        };
    }else {
        para = @{@"usertel":self.phoneTextFd.text,
                 @"Message":@"",
                 @"password":self.verifyCodeTextFd.text,
                 @"phonecard":[ECUtil getIDFA],
        };
    }
    [[HWAFNetworkManager shareManager] accountRequest:para loginByMessageAndPassword:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        NSLog(@"========%@", dic);
        if (success) {
            NSValue *value = dic[@"status"];
            if ([value isEqual:[NSNumber numberWithInt:402]]) {//验证码错误
                [SVProgressHUD showErrorWithStatus:dic[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
            }
            if ([value isEqual:[NSNumber numberWithInt:401]]) {//未注册
                [SVProgressHUD showInfoWithStatus:dic[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                VerifyCodeViewController *verify = [[VerifyCodeViewController alloc] init];
                verify.phoneNum = self.phoneTextFd.text;
                verify.inputCodeType = InputCodeTypePassword;
                [self.navigationController pushViewController:verify animated:YES];
            }
            if ([value isEqual:[NSNumber numberWithInt:402]]) {//验证码错误
                [SVProgressHUD showErrorWithStatus:dic[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
            }
            
            if ([value isEqual:[NSNumber numberWithInt:200]]) {
                [SVProgressHUD showWithStatus:dic[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                if (dic[@"body"]) {
                    [NSUserDefaultMemory defaultSetMemory:dic[@"body"][@"userid"] unityKey:USERID];
                    NSDictionary *body = [NSDictionary dictionaryWithDictionary:dic[@"body"]];
                    [NSUserDefaultMemory defaultSetMemory:body unityKey:USERINFO];
                    [MobClick profileSignInWithPUID:dic[@"userid"]];
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }else {
                    [SVProgressHUD showErrorWithStatus:dic[@"statusMessage"]];
                    [SVProgressHUD dismissWithDelay:1];
                }
            }
        }
    }];
}

- (BOOL)inputCheckout {
    if (self.phoneTextFd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入手机号！"];
        [SVProgressHUD dismissWithDelay:0.5];
        return NO;
    }
    
    if (![self.phoneTextFd.text n6_isMobile] ||  self.phoneTextFd.text.length != 11) {
        [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
        [SVProgressHUD dismissWithDelay:0.5];
        return NO;
    }
    
    if (!self.loginStyleBtn.selected) {
        if (self.verifyCodeTextFd.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入验证码！"];
            [SVProgressHUD dismissWithDelay:0.5];
            return NO;
        }
        
        if (self.verifyCodeTextFd.text.length != 6) {
            [SVProgressHUD showInfoWithStatus:@"验证码有误！"];
            [SVProgressHUD dismissWithDelay:0.5];
            return NO;
        }
    }else {
        if (self.verifyCodeTextFd.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入密码！"];
            [SVProgressHUD dismissWithDelay:0.5];
            return NO;
        }
        if (self.verifyCodeTextFd.text.length < 6) {
            [SVProgressHUD showInfoWithStatus:@"请输入6-16位密码！"];
            [SVProgressHUD dismissWithDelay:0.5];
            return NO;
        }
    }
    return YES;
}

- (void)backScrollVTap:(UIGestureRecognizer *)tap {
    [self.phoneTextFd resignFirstResponder];
    [self.verifyCodeTextFd resignFirstResponder];
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if ([touch.view isDescendantOfView:self.agreement_yylab]) {
//        return NO;
//    }
//    return YES;
//}

- (void)agreementAction{
    PrivacyPolicyViewController *pri = [[PrivacyPolicyViewController alloc] init];
    [self.navigationController pushViewController:pri animated:YES];
}

#pragma mark layout

- (void)setupLayoutSubViews {
    [self.backScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.right.mas_equalTo(KSCREEN_WIDTH-20);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(85);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(KSCREEN_WIDTH-60);
        make.height.mas_equalTo(21);
    }];
    
    [self._86BackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(65);
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *_86 = [[UILabel alloc] init];
    _86.font = kFontBoldSize(18);
    _86.textColor = [UIColor blackColor];
    _86.text = @"+86";
    [__86BackV addSubview:_86];
    [_86 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(__86BackV.mas_top);
        make.left.mas_equalTo(__86BackV.mas_left);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(25);
    }];
    
    UIView *gap = [[UIView alloc] init];
    gap.backgroundColor = [ECUtil colorWithHexString:@"999999"];
    [_86 addSubview:gap];
    [gap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_86.mas_right).offset(5);
        make.centerY.mas_equalTo(_86.mas_centerY);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(12);
    }];
    
    [self.phoneTextFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(65);
        make.left.mas_equalTo(95);
        make.width.mas_equalTo(KSCREEN_WIDTH-120);
        make.height.mas_equalTo(25);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [ECUtil colorWithHexString:@"e5e5e5"];
    [self.backScrollV addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextFd.mas_bottom).offset(7);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(KSCREEN_WIDTH-60);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.verifyCodeTextFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(47);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(KSCREEN_WIDTH-60);
        make.height.mas_equalTo(25);
    }];
    
    [self.getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.verifyCodeTextFd.mas_right);
        make.bottom.mas_equalTo(self.verifyCodeTextFd.mas_bottom);
        make.width.mas_equalTo(90);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [ECUtil colorWithHexString:@"e5e5e5"];
    [self.backScrollV addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(self.verifyCodeTextFd.mas_bottom).offset(7);
        make.width.mas_equalTo(KSCREEN_WIDTH-60);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyCodeTextFd.mas_bottom).offset(45);
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.right.mas_equalTo(self.titleLab.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [self.findPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(15);
        make.right.mas_equalTo(self.loginBtn.mas_right);
        //make.left.mas_equalTo(self.loginStyleBtn.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.loginStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(15);
        make.left.mas_equalTo(self.loginBtn.mas_left);
        make.right.mas_equalTo(self.findPasswordBtn.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [self.agreement_yylab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(83);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(KSCREEN_WIDTH-60);
        make.height.mas_equalTo(20);
    }];
    //暂时解决backScrollV加手势yylabel点击失效
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backScrollV addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(83);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(KSCREEN_WIDTH-60);
        make.height.mas_equalTo(20);
    }];
    [btn addTarget:self action:@selector(agreementAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark getter

- (UIScrollView *)backScrollV {
    if (_backScrollV == nil) {
        _backScrollV = [[UIScrollView alloc] init];
        _backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT+200);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backScrollVTap:)];
        [_backScrollV addGestureRecognizer:tap];
    }
    return _backScrollV;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = kFontBoldSize(20);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UITextField *)phoneTextFd {
    if (_phoneTextFd == nil) {
        _phoneTextFd = [[UITextField alloc] init];
        _phoneTextFd.font = kFontNormalSize(18);
        _phoneTextFd.textAlignment = NSTextAlignmentLeft;
        _phoneTextFd.keyboardType = UIKeyboardTypeNumberPad;
        __weak typeof(self) weakSelf = self;
        [[_phoneTextFd rac_textSignal] subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSString *str = (NSString *)x;
            if (str.length >= 11) {
                strongSelf->_phoneTextFd.text = [str substringToIndex:11];
            }
        }];
    }
    return _phoneTextFd;
}

- (UITextField *)verifyCodeTextFd {
    if (_verifyCodeTextFd == nil) {
        _verifyCodeTextFd = [[UITextField alloc] init];
        _verifyCodeTextFd.font = kFontNormalSize(18);
        _verifyCodeTextFd.textAlignment = NSTextAlignmentLeft;
        __weak typeof(self) weakSelf = self;
        [[_verifyCodeTextFd rac_textSignal] subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSString *str = (NSString *)x;
            if (strongSelf.loginStyleBtn.selected) {
        
                if (str.length >= 16) {
                    strongSelf->_verifyCodeTextFd.text = [str substringToIndex:16];
                }
                
                if (strongSelf.phoneTextFd.text.length == 11) {
                    strongSelf.loginBtn.backgroundColor = kColor_Main;
                }
                
            }else {
                if (str.length >= 6) {
                    strongSelf->_verifyCodeTextFd.text = [str substringToIndex:6];
                    if (strongSelf.phoneTextFd.text.length == 11) {
                        strongSelf.loginBtn.backgroundColor = kColor_Main;
                    }
                }else {
                    strongSelf.loginBtn.backgroundColor = [ECUtil colorWithHexString:@"a8a8a8"];
                }
            }
        }];
    }
    return _verifyCodeTextFd;
}

- (UIButton *)getCode {
    if (_getCode == nil) {
        _getCode = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCode.backgroundColor = kColor_Main;
        _getCode.layer.cornerRadius = 14;
        _getCode.layer.masksToBounds = YES;
        [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCode.titleLabel.font = KFontNormalSize12;
        [_getCode addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCode;
}

- (UIButton *)loginStyle {
    if (_loginStyleBtn == nil) {
        _loginStyleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginStyleBtn setTitleColor:[ECUtil colorWithHexString:@"1b1b1b"] forState:UIControlStateNormal];
//        _loginStyleBtn.layer.cornerRadius = 3;
//        _loginStyleBtn.layer.masksToBounds = YES;
        _loginStyleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_loginStyleBtn addTarget:self action:@selector(loginStyleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginStyleBtn;
}

- (UIButton *)findPasswordBtn {
    if (_findPasswordBtn == nil) {
        _findPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_findPasswordBtn setTitleColor:[ECUtil colorWithHexString:@"8a8a8a"] forState:UIControlStateNormal];
        _findPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_findPasswordBtn addTarget:self action:@selector(findPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findPasswordBtn;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.layer.cornerRadius = 3;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setTitle:@"登 陆" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)backBtn {
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"loginclose"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _backBtn;
}

- (YYLabel *)agreement_yylab {
    if (_agreement_yylab == nil) {
        _agreement_yylab = [[YYLabel alloc] init];
        NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:@"登陆即代表你已同意《柚选隐私政策》"];
        mutStr.yy_alignment = NSTextAlignmentCenter;
        mutStr.yy_font = kFontNormalSize(16);
        mutStr.yy_color = [ECUtil colorWithHexString:@"b7b7b7"];
        __weak typeof(self) weakSelf = self;
        [mutStr yy_setTextHighlightRange:NSMakeRange(mutStr.length-8, 8) color:kColor_Main backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            PrivacyPolicyViewController *pri = [[PrivacyPolicyViewController alloc] init];
            [weakSelf.navigationController pushViewController:pri animated:YES];
        }];
        _agreement_yylab.attributedText = mutStr;//后设置点击才有反应
    }
    return _agreement_yylab;
}

- (UIView *)_86BackV {
    if (__86BackV == nil) {
        __86BackV = [[UIView alloc] init];
    }
    return __86BackV;
}



@end
