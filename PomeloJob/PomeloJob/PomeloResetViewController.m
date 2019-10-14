//
//  PomeloResetViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloResetViewController.h"
#import "ReactiveCocoa.h"
#import "PomeloLoginViewController.h"

@interface PomeloResetViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIImageView *iconImgV;

@end

@implementation PomeloResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.iconImgV.bottom + 50, 100, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize18;
    lab1.text = @"新密码";
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.bottom, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    textFd1.placeholder = @"请输入新密码";
    textFd1.textColor = KColor_C8C8C8;
    textFd1.font = KFontNormalSize16;
    textFd1.secureTextEntry = YES;
    [self.backScrollV addSubview:textFd1];
    [[textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 16) {
            textFd1.text = [text substringToIndex:16];
        }
    }];
    //    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    //    textFd1.layer.borderWidth = KLineWidthMeasure05;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, textFd1.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(15, textFd1.bottom + 20, KSCREEN_WIDTH - 30, hei)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize18;
    lab2.text = @"再次确认密码";
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab2];
    
    UITextField *textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab2.bottom + 20, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    textFd2.placeholder = @"请再次确认密码";
    textFd2.textColor = KColor_C8C8C8;
    textFd2.font = KFontNormalSize16;
    textFd2.secureTextEntry = YES;
    [self.backScrollV addSubview:textFd2];
    [[textFd2 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 16) {
            textFd2.text = [text substringToIndex:16];
        }
    }];
    //    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    //    textFd1.layer.borderWidth = KLineWidthMeasure05;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, textFd2.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];
    
    UIButton *login1 = [UIButton buttonWithType:UIButtonTypeCustom];
    login1.frame = CGRectMake(KSpaceDistance15, line2.bottom + 100, (KSCREEN_WIDTH - KSpaceDistance15 * 2 - 65)/2, 40);
    login1.layer.cornerRadius = 20;
    login1.layer.masksToBounds = YES;
    //[self.backScrollV addSubview:login1];
    [login1 setTitle:@"取  消" forState:UIControlStateNormal];
    [login1 setTintColor:[UIColor whiteColor]];
    [ECUtil gradientLayer:login1 startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colorArr1:KColorGradient_dark colorArr2:KColorGradient_light location1:0 location2:0];
    
    __weak typeof(self) weakSelf = self;
    [[login1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        switch (strongSelf.entranceType) {
            case VerifyLoginStyle:{
                for(UIViewController *temp in strongSelf.navigationController.viewControllers) {
                    if ([temp isKindOfClass:[PomeloLoginViewController class]]) {
                        [strongSelf.navigationController popToViewController:temp animated:YES];
                    }
                }
            }break;
            case ForgetPassword:{
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }
            case RegisterStyle:{
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }break;
            default:
                break;
        }
    }];
    
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake((KSCREEN_WIDTH - 221)/2,  textFd2.bottom + 50, 221, 44);
    login.layer.cornerRadius = 22;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"确 定" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    //[ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [login setBackgroundColor:[UIColor colorWithRed:70/255.0 green:222/255.0 blue:160/255.0 alpha:1]];
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        
        if (![textFd1.text isEqualToString:textFd2.text]) {
            [SVProgressHUD showInfoWithStatus:@"两次输入密码不匹配！"];
            return ;
        }
        
        switch (strongSelf.entranceType) {
            case VerifyLoginStyle:{
                NSDictionary *para = @{@"usertel":textFd1.text,
                                       @"userpassword":textFd2.text,
                                       };
                [[HWAFNetworkManager shareManager] accountRequest:para loginByMessageCode:^(BOOL success, id  _Nonnull request) {
                    if (success) {
                        
                    }
                    for(UIViewController *temp in strongSelf.navigationController.viewControllers) {
                        if ([temp isKindOfClass:[PomeloLoginViewController class]]) {
                            [strongSelf.navigationController popToViewController:temp animated:YES];

                        }
                    }

                }];
            }
                break;
            case ForgetPassword:{
                NSDictionary *para = @{@"usertel":textFd1.text,
                                       @"userpassword":textFd2.text,
                                       };
//                [[HWAFNetworkManager shareManager] accountRequest:para updataPassword:^(BOOL success, id  _Nonnull request) {
//                    if (success) {
//                        [SVProgressHUD showWithStatus:request[@"statusMessage"]];
//                        [SVProgressHUD dismissWithDelay:1];
//                        for(UIViewController *temp in strongSelf.navigationController.viewControllers) {
//                            if ([temp isKindOfClass:[PomeloLoginViewController class]]) {
//                                [strongSelf.navigationController popToViewController:temp animated:YES];
//
//                            }
//                        }
//                    }
//                }];
            }
                break;
            case RegisterStyle:{
                
                NSDictionary *para = @{@"usertel":self.phoneNum,
                                       @"userpassword":textFd2.text,
                                       @"phonecar":[ECUtil getIDFA]
                                       };
//                NSDictionary *para = @{@"usertel":@"18345067097",
//                                       @"userpassword":@"123456",
//                                       @"phonecar":[ECUtil getIDFA]
//                                       };
                //60572DCB-A8BC-4BA4-9F41-B6CEA819AC5D
                [[HWAFNetworkManager shareManager] accountRequest:para login:^(BOOL success, id  _Nonnull request) {
                    if (success) {
                        [SVProgressHUD showWithStatus:request[@"statusMessage"]];
                        [SVProgressHUD dismissWithDelay:1];
                        
                        if ([request[@"status"] isEqualToString:@"Success"]) {
                            if (request[@"userid"]) {
                                [NSUserDefaultMemory defaultSetMemory:request[@"userid"] unityKey:USERID];
                            }
                        }
                        [self.navigationController popToRootViewControllerAnimated:YES];
//                        for(UIViewController *temp in strongSelf.navigationController.viewControllers) {
//                            if ([temp isKindOfClass:[PomeloLoginViewController class]]) {
//                                [strongSelf.navigationController popToViewController:temp animated:YES];
//
//                            }
//                        }
                        
                    }
                }];
            }
                break;
            default:
                break;
        }
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
