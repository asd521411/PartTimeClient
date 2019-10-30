//
//  VerifyCodeViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/22.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "VerifyCodeViewController.h"

@interface VerifyCodeViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation VerifyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输入密码";
    
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
    
    CGFloat hei = 40;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, 100, 100, hei)];
    lab1.textColor = [ECUtil colorWithHexString:@"b4b4b4"];
    lab1.font = kFontBoldSize(18);
    lab1.text = @"密码";
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    
    __weak typeof(self) weakSelf = self;
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    textFd1.placeholder = @"";
    textFd1.textColor = KColor_C8C8C8;
    textFd1.font = kFontBoldSize(16);
    textFd1.secureTextEntry = YES;
    [self.backScrollV addSubview:textFd1];
    [[textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 16) {
            textFd1.text = [text substringToIndex:16];
        }
    }];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, textFd1.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(15, textFd1.bottom + 40, KSCREEN_WIDTH - 30, hei)];
    lab2.textColor = [ECUtil colorWithHexString:@"b4b4b4"];
    lab2.font = kFontBoldSize(18);
    lab2.text = @"确认密码";
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab2];
    
    UITextField *textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab2.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    textFd2.placeholder = @"";
    textFd2.textColor = KColor_C8C8C8;
    textFd2.font = kFontBoldSize(16);
    textFd2.secureTextEntry = YES;
    [self.backScrollV addSubview:textFd2];
    
    [[textFd2 rac_textSignal] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 16) {
            textFd2.text = [text substringToIndex:16];
        }
        if (textFd2.text.length >6 && textFd1.text.length > 6) {
            strongSelf.loginBtn.backgroundColor = kColor_Main;
        }else {
            strongSelf.loginBtn.backgroundColor = kColor_UnSelect;
        }
    }];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, textFd2.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(30,  textFd2.bottom + 50, KSCREEN_WIDTH-60, 40);
    self.loginBtn.layer.cornerRadius = 3;
    self.loginBtn.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.loginBtn];
    [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.loginBtn setTintColor:[UIColor whiteColor]];
    [self.loginBtn setBackgroundColor:kColor_UnSelect];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        
        if (textFd1.text.length < 6 || textFd2.text.length < 6) {
            [SVProgressHUD showWithStatus:@"6-16位密码！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        
        if (![textFd1.text isEqualToString:textFd2.text]) {
            [SVProgressHUD showInfoWithStatus:@"两次输入密码不匹配！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        
        [textFd1 resignFirstResponder];
        [textFd2 resignFirstResponder];
        
        switch (strongSelf.inputCodeType) {
            case InputCodeTypePassword:{
                NSDictionary *para = @{@"usertel":self.phoneNum,
                                       @"password":textFd1.text,
                                       @"phonecard":[ECUtil getIDFA]};
                [[HWAFNetworkManager shareManager] accountRequest:para userLogin:^(BOOL success, id  _Nonnull request) {
                    if (success) {
                        if ([request[@"status"] integerValue] == 200) {
                            [SVProgressHUD showWithStatus:request[@"statusMessage"]];
                            [SVProgressHUD dismissWithDelay:1];
                            
                            if([request[@"userid"] intValue] >0){
                                [NSUserDefaultMemory defaultSetMemory:@([request[@"userid"] intValue]) unityKey:USERID];
                            }else{
                                [NSUserDefaultMemory defaultSetMemory:@"" unityKey:USERID];
                            }
                            [NSUserDefaultMemory defaultSetMemory:request[@"username"] unityKey:USERNAME];
                            [MobClick profileSignInWithPUID:request[@"userid"]];
                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                        }else if ([request[@"status"] integerValue] == 400) {
                            
                        }
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
