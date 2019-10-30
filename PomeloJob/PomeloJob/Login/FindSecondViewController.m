//
//  FindSecondViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/25.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "FindSecondViewController.h"
#import "NoteVerifyFeedbackViewController.h"
#import "FindPasswodViewController.h"

@interface FindSecondViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UITextField *inputTextFd;
@property (nonatomic, strong) UIButton *findPasswordBtn;

@property (nonatomic, strong) UIButton *getCode;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger interger;

@end

@implementation FindSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self setupSubViews];
    
    self.interger = 60;
    
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
    //[self.timer setFireDate:[NSDate distantFuture]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] init];
    [self.view addSubview:self.backScrollV];
    self.backScrollV.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.text = @"输入验证码";
    lab1.font = kFontBoldSize(18);
    lab1.textColor = [ECUtil colorWithHexString:@"4a4a4a"];
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:lab1];
    lab1.frame = CGRectMake(15, 45, KSCREEN_WIDTH - 30, 20);
    
    UILabel *lab2 = [[UILabel alloc] init];
    NSString *num = [[@"已向你的手机+86" stringByAppendingFormat:@"%@", self.phoneNum] stringByAppendingString:@"发送了验证码"];
    lab2.text = num;
    lab2.font = kFontBoldSize(14);
    lab2.textColor = [ECUtil colorWithHexString:@"4a4a4a"];
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab2];
    lab2.frame = CGRectMake(30, lab1.bottom+30, KSCREEN_WIDTH-60, 20);
    
    [self.backScrollV addSubview:self.inputTextFd];
    self.inputTextFd.frame = CGRectMake(30, lab2.bottom+20, KSCREEN_WIDTH-50-60, 20);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, self.inputTextFd.bottom+10, KSCREEN_WIDTH-30, 0.5)];
    line.backgroundColor = [ECUtil colorWithHexString:@"e5e5e5"];
    [self.backScrollV addSubview:line];
    
    [self.backScrollV addSubview:self.getCode];
    self.getCode.frame = CGRectMake(KSCREEN_WIDTH-90-15, self.inputTextFd.top, 90, 28);
    
    [self.backScrollV addSubview:self.saveBtn];
    self.saveBtn.frame = CGRectMake(30, self.inputTextFd.bottom+80, KSCREEN_WIDTH-60, 40);
}


- (void)saveBtnAction:(UIButton *)sender {
    
    if (self.inputTextFd.text.length != 6) {
        [SVProgressHUD showInfoWithStatus:@"验证码有误！"];
        [SVProgressHUD dismissWithDelay:1];
        return ;
    }
    NSDictionary *para = @{@"usertel":self.phoneNum, @"usermessagecode":self.inputTextFd.text};
    [[HWAFNetworkManager shareManager] accountRequest:para checkMessage:^(BOOL success, id  _Nonnull request) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
            [SVProgressHUD dismissWithDelay:1];
            if ([request[@"status"] integerValue] == 200) {
                FindPasswodViewController *password = [[FindPasswodViewController alloc] init];
                password.phoneNum = self.phoneNum;
                [self.navigationController pushViewController:password animated:YES];
            }else {
                self.saveBtn.userInteractionEnabled = NO;
            }

        }
    }];
 
//    FindPasswodViewController *password = [[FindPasswodViewController alloc] init];
//    password.phoneNum = self.phoneNum;
//    [self.navigationController pushViewController:password animated:YES];
}

- (void)findPasswordAction:(UIButton *)send {
    NoteVerifyFeedbackViewController *note = [[NoteVerifyFeedbackViewController alloc] init];
    [self.navigationController pushViewController:note animated:YES];
}

- (void)getCodeAction:(UIButton *)sender {
    
    [self.inputTextFd resignFirstResponder];
    [self.timer setFireDate:[NSDate distantPast]];
    self.getCode.userInteractionEnabled = NO;
    self.interger = 60;
    [[HWAFNetworkManager shareManager] accountRequest:@{@"usertel":self.phoneNum} sendMessage:^(BOOL success, id  _Nonnull request) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
        }
    }];
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


- (UITextField *)inputTextFd {
    if (_inputTextFd == nil) {
        _inputTextFd = [[UITextField alloc] init];
        _inputTextFd.placeholder = @"请输入验证码";
        _inputTextFd.textAlignment = NSTextAlignmentLeft;
        _inputTextFd.keyboardType = UIKeyboardTypeNumberPad;
        [_inputTextFd becomeFirstResponder];
        __weak typeof(self) weakSelf = self;
        [[_inputTextFd rac_textSignal] subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSString *str = [NSString stringWithFormat:@"%@", x];
            if (str.length >= 6) {
                strongSelf.inputTextFd.text = [str substringToIndex:6];
            }
            if (str.length == 6) {
                strongSelf.saveBtn.backgroundColor = kColor_Main;
            }else {
                strongSelf.saveBtn.backgroundColor = kColor_UnSelect;
            }
            
        }];
    }
    return _inputTextFd;
}

- (UIButton *)getCode {
    if (_getCode == nil) {
        _getCode = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCode.backgroundColor = kColor_Main;
        _getCode.layer.cornerRadius = 14;
        _getCode.layer.masksToBounds = YES;
        [_getCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCode.titleLabel.font = KFontNormalSize12;
        [_getCode addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCode;
}

- (UIButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.backgroundColor = kColor_UnSelect;
        _saveBtn.layer.cornerRadius = 2;
        _saveBtn.layer.masksToBounds = YES;
        [_saveBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
