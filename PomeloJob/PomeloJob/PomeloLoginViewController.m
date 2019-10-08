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

@interface PomeloLoginViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIImageView *iconImgV;


@end

@implementation PomeloLoginViewController

//- (instancetype)shareInstance {
//    static <#typeClass#> *instance = nil;
//    static dispatch_once_t *once_Token;
//    dispatch_once(once_Token, ^{
//        <#argument#>
//    });
//    return instance;
//}

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
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
    self.backScrollV.scrollEnabled = YES;
    self.backScrollV.bounces = YES;
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [self.view addSubview:self.backScrollV];
    
    CGFloat wid = (SCREENWIDTH - 150 * 2);
    CGFloat hei = 40;
    
    self.iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - wid) / 2, KSpaceDistance15, wid, wid)];
    self.iconImgV.image = [UIImage imageNamed:@"loginTopImg"];
    self.iconImgV.layer.cornerRadius = 10;
    self.iconImgV.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.iconImgV];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.iconImgV.bottom + 50, 80, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize14;
    lab1.text = @"手机号：";
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    textFd1.placeholder = @"请输入手机号";
    textFd1.textColor = KColor_C8C8C8;
    textFd1.font = KFontNormalSize14;
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
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom + KSpaceDistance15 * 2, lab1.width, hei)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize14;
    lab2.text = @"密码：";
    [self.backScrollV addSubview:lab2];
    
    UITextField *textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.bottom + KSpaceDistance15 * 2, SCREENWIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    textFd2.placeholder = @"请输入密码";
    textFd2.textColor = KColor_C8C8C8;
    textFd2.font = KFontNormalSize14;
    [self.backScrollV addSubview:textFd2];
//    textFd2.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
//    textFd2.layer.borderWidth = KLineWidthMeasure05;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];
    
    UIButton *agree = [UIButton buttonWithType:UIButtonTypeCustom];
    agree.frame = CGRectMake(KSpaceDistance15, lab2.bottom + KSpaceDistance15, hei / 2, hei / 2);
    agree.layer.cornerRadius = 3;
    agree.layer.masksToBounds = YES;
    [self.backScrollV addSubview:agree];
    [agree setBackgroundImage:[UIImage imageNamed:@"honggou"] forState:UIControlStateNormal];
    [agree setBackgroundImage:[UIImage imageNamed:@"honggouse"] forState:UIControlStateSelected];
    [[agree rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIButton *btn  = x;
        btn.selected = !btn.selected;
    }];
    
    UILabel *remind = [[UILabel alloc] initWithFrame:CGRectMake(agree.right + 10, agree.top, SCREENWIDTH / 2, hei / 2)];
    remind.textColor = KColor_212121;
    remind.font = KFontNormalSize10;
    remind.text = @"用户注册及使用APP隐私协议";
    [self.backScrollV addSubview:remind];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(KSpaceDistance15, remind.bottom + KSpaceDistance15, 100, hei);
    left.titleLabel.textAlignment = NSTextAlignmentLeft;
    [left setTitle:@"验证码登陆" forState:UIControlStateNormal];
    [left setTitleColor:KColor_212121 forState:UIControlStateNormal];
    [self.backScrollV addSubview:left];
    
    __weak typeof(self) weakSelf = self;

    [[left rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        PomeloVerifyLoginViewController *verify = [[PomeloVerifyLoginViewController alloc] init];
        verify.phoneNum = textFd1.text;
        verify.password = textFd2.text;
        verify.entranceType = VerifyLoginStyle;
        [strongSelf.navigationController pushViewController:verify animated:YES];
    }];
    
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(KSCREEN_WIDTH - left.width - KSpaceDistance15, remind.bottom + KSpaceDistance15, left.width, hei);
    //right.titleLabel.textAlignment = NSTextAlignmentRight;
    //right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //right.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [right setTitle:@"忘记密码" forState:UIControlStateNormal];
    [right setTitleColor:KColor_212121 forState:UIControlStateNormal];
    [self.backScrollV addSubview:right];
    [[right rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        PomeloVerifyLoginViewController *verify = [[PomeloVerifyLoginViewController alloc] init];
        verify.phoneNum = textFd1.text;
        verify.password = textFd2.text;
        verify.entranceType = ForgetPassword;
        [strongSelf.navigationController pushViewController:verify animated:YES];
//        PomeloForgetViewController *forget = [[PomeloForgetViewController alloc] init];
//        [self.navigationController pushViewController:forget animated:YES];
    }];
    
    UIButton *regis = [UIButton buttonWithType:UIButtonTypeCustom];
    regis.frame = CGRectMake(15, left.bottom + 40, (KSCREEN_WIDTH - 30 - 65)/2, 40);
    regis.layer.cornerRadius = 20;
    regis.layer.masksToBounds = YES;
    [self.backScrollV addSubview:regis];
    [regis setTitle:@"注   册" forState:UIControlStateNormal];
    [regis setTintColor:[UIColor whiteColor]];
    regis.adjustsImageWhenHighlighted = NO;
    [ECUtil gradientLayer:regis startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    
    [[regis rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [textFd1 resignFirstResponder];
        [textFd2 resignFirstResponder];
        if (![textFd1.text n6_isMobile]) {
            [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        if (!agree.selected) {
            [SVProgressHUD showInfoWithStatus:@"请同意用户注册及使用APP隐私协议！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        PomeloVerifyLoginViewController *verify = [[PomeloVerifyLoginViewController alloc] init];
        verify.phoneNum = textFd1.text;
        verify.password = textFd2.text;
        verify.entranceType = RegisterStyle;
        [strongSelf.navigationController pushViewController:verify animated:YES];
    }];
    
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(regis.right + 65,  left.bottom + 40, (KSCREEN_WIDTH - 30 - 65)/2, 40);
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"登  陆" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    login.adjustsImageWhenHighlighted = NO;
    [ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];

    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [textFd1 resignFirstResponder];
        [textFd2 resignFirstResponder];
        if (![textFd1.text n6_isMobile]) {
            [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        if (textFd2.text.length < 2) {
            [SVProgressHUD showInfoWithStatus:@"密码过短！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        if (textFd2.text.length > 32) {
            [SVProgressHUD showInfoWithStatus:@"密码过长！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        if (!agree.selected) {
            [SVProgressHUD showInfoWithStatus:@"请同意用户注册及使用APP隐私协议！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        
        //唯一标识
//        NSString *uuid = nil;
//        if ([SSKeychain passwordForService:SERVICEKEYCHAIN account:ALREADYRESIGN]) {
//            uuid = [SSKeychain passwordForService:SERVICEKEYCHAIN account:ALREADYRESIGN];
//        }else {
//            uuid = [ECUtil getUUID];
//            [SSKeychain setPassword:uuid forService:SERVICEKEYCHAIN account:ALREADYRESIGN];
//        }
        NSDictionary *para = @{@"usertel":textFd1.text,
                               @"userpassword":textFd2.text,
                               @"phonecar":[ECUtil getIDFA]
                               };
        
//        NSDictionary *para = @{@"usertel":@"18345067097",
//                               @"userpassword":@"123456",
//                               @"phonecar":[ECUtil getIDFA]
//                               };
        [[HWAFNetworkManager shareManager] accountRequest:para loginByPassword:^(BOOL success, id  _Nonnull request) {
            NSDictionary *dic = (NSDictionary *)request;
            if (success) {
                [SVProgressHUD showSuccessWithStatus:dic[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                
                if ([request[@"status"] isEqualToString:@"fail"]) {
                    PomeloVerifyLoginViewController *reg = [[PomeloVerifyLoginViewController alloc] init];
                    reg.phoneNum = textFd1.text;
                    reg.password = textFd2.text;
                    reg.entranceType = RegisterStyle;
                    [strongSelf.navigationController pushViewController:reg animated:YES];
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
