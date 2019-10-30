//
//  PomeloCoupleBackViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloCoupleBackViewController.h"

@interface PomeloCoupleBackViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIView *contentTextV;
@property (nonatomic, strong) UITextField *inputTextFd;
@property (nonatomic, strong) UITextView *textFdV;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UITextField *phoneTextFd;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation PomeloCoupleBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[ECUtil colorWithHexString:@"4a4a4a"],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
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
    
    [self.view addSubview:self.backScrollV];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, 15, 80, 20)];
    lab.textColor = [ECUtil colorWithHexString:@"4a4a4a"];
    lab.font = kFontBoldSize(14);
    lab.text = @"意见与反馈";
    lab.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    self.contentTextV = [[UIView alloc] init];
    self.contentTextV.backgroundColor = [ECUtil colorWithHexString:@"f1f1f1"];
    self.contentTextV.layer.cornerRadius = 5;
    self.contentTextV.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.contentTextV];
    [self.contentTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lab.mas_bottom).offset(15);
        make.width.mas_equalTo(KSCREEN_WIDTH-30);
        make.height.mas_equalTo(240);
    }];
    
    self.lab1 = [[UILabel alloc] init];
    self.lab1.text = @"请填写意见";
    self.lab1.font = kFontNormalSize(14);
    self.lab1.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    [self.contentTextV addSubview:self.lab1];
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentTextV).offset(10);
        make.height.mas_equalTo(15);
    }];

    self.textFdV = [[UITextView alloc] init];
    self.textFdV.backgroundColor = [ECUtil colorWithHexString:@"f1f1f1"];
    self.textFdV.delegate = self;
    self.textFdV.font = kFontNormalSize(14);
    self.textFdV.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    [self.contentTextV addSubview:self.textFdV];
    [self.textFdV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentTextV).offset(10);
        make.top.mas_equalTo(self.lab1.mas_bottom);
        make.right.mas_equalTo(self.contentTextV.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.contentTextV.mas_bottom).offset(-30);
    }];
    __weak typeof(self) weakSelf = self;
    [[self.textFdV rac_textSignal] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *str = [NSString stringWithFormat:@"%@", x];

        if (str.length > 0) {
            strongSelf.lab1.hidden = YES;
        }else {
            strongSelf.lab1.hidden = NO;
        }

        if (str.length >= 200) {
            strongSelf.textFdV.text = [str substringToIndex:200];
        }
        strongSelf.lab2.text =  [@"(" stringByAppendingString:[[NSString stringWithFormat:@"%lu", (unsigned long)strongSelf.textFdV.text.length] stringByAppendingString:@"/200)"]];
        
        if (strongSelf.textFdV.text.length > 0 && [strongSelf.phoneTextFd.text n6_isMobile]) {
            strongSelf.loginBtn.backgroundColor = kColor_Main;
            strongSelf.loginBtn.userInteractionEnabled = YES;
        }else {
            strongSelf.loginBtn.backgroundColor = kColor_UnSelect;
            strongSelf.loginBtn.userInteractionEnabled = NO;
        }
        
    }];

    self.lab2 = [[UILabel alloc] init];
    self.lab2.text = @"(200)";
    self.lab2.font = kFontNormalSize(16);
    self.lab2.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    [self.contentTextV addSubview:self.lab2];
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.contentTextV).offset(-10);
    }];

    UILabel *lab3 = [[UILabel alloc] init];
    lab3.textColor = [ECUtil colorWithHexString:@"4a4a4a"];
    lab3.font = kFontBoldSize(14);
    lab3.text = @"你的联系方式";
    lab3.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lab2.mas_bottom).offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [lab3.superview layoutIfNeeded];
    
    [self.backScrollV addSubview:self.phoneTextFd];
    self.phoneTextFd.frame = CGRectMake(15, lab3.bottom + 15, KSCREEN_WIDTH-30, 30);
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, self.phoneTextFd.bottom, KSCREEN_WIDTH-30, 0.5)];
    line.backgroundColor = [ECUtil colorWithHexString:@"e5e5e5"];
    [self.backScrollV addSubview:line];
    
    [self.backScrollV addSubview:self.loginBtn];
    self.loginBtn.frame = CGRectMake(30, self.phoneTextFd.bottom+40, KSCREEN_WIDTH-60, 40);
    
}

- (void)loginBtnAction:(UIButton *)send {
    
    if (![self.phoneTextFd.text n6_isMobile]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确手机号！"];
        [SVProgressHUD dismissWithDelay:1];
        return ;
    }
    if (self.textFdV.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入您的意见！"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    
    NSDictionary *para = @{@"feedbackusertel":self.phoneTextFd.text, @"feedbackinfo":self.textFdV.text};
    [[HWAFNetworkManager shareManager] position:para collectFeedback:^(BOOL success, id  _Nonnull request) {
        
        if (success) {
            if ([request[@"status"] integerValue] == 200) {
                [SVProgressHUD showWithStatus:request[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

- (void)backScrollVAction:(UIGestureRecognizer *)tap {
    [self.phoneTextFd resignFirstResponder];
}

- (UIScrollView *)backScrollV {
    if (_backScrollV == nil) {
        _backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT + 100);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backScrollVAction:)];
        [_backScrollV addGestureRecognizer:tap];
    }
    return _backScrollV;
}

- (UITextField *)phoneTextFd {
    if (_phoneTextFd == nil) {
        _phoneTextFd = [[UITextField alloc] init];
        _phoneTextFd.placeholder = @"请输入手机号";
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
            if (strongSelf.textFdV.text.length > 0 && [strongSelf.phoneTextFd.text n6_isMobile]) {
                strongSelf.loginBtn.backgroundColor = kColor_Main;
                strongSelf.loginBtn.userInteractionEnabled = YES;
            }else {
                strongSelf.loginBtn.backgroundColor = kColor_UnSelect;
                strongSelf.loginBtn.userInteractionEnabled = NO;
            }
        }];
    }
    return _phoneTextFd;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.backgroundColor = kColor_UnSelect;
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.layer.cornerRadius = 3;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
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
