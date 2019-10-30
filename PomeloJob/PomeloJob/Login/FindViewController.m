//
//  FindViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/17.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "FindViewController.h"
#import "FindSecondViewController.h"

@interface FindViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UITextField *inputTextFd;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
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

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] init];
    [self.view addSubview:self.backScrollV];
    self.backScrollV.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.text = @"用手机号找回密码";
    lab1.font = kFontBoldSize(18);
    lab1.textColor = [ECUtil colorWithHexString:@"4a4a4a"];
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:lab1];
    lab1.frame = CGRectMake(15, 45, KSCREEN_WIDTH - 30, 20);
    
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.text = @"请输入你的帐号绑定的手机号";
    lab2.font = kFontBoldSize(14);
    lab2.textColor = [ECUtil colorWithHexString:@"4a4a4a"];
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab2];
    lab2.frame = CGRectMake(30, lab1.bottom+30, KSCREEN_WIDTH-60, 20);
    
    
    UILabel *lab = [[UILabel alloc] init];
    lab.font = kFontBoldSize(18);
    lab.textColor = [ECUtil colorWithHexString:@"000000"];
    lab.text = @"+86  |";
    [self.backScrollV addSubview:lab];
    lab.frame = CGRectMake(30, lab2.bottom+20, 50, 20);
    
    [self.backScrollV addSubview:self.inputTextFd];
    self.inputTextFd.frame = CGRectMake(lab.right+20, lab2.bottom+20, KSCREEN_WIDTH-50-60-20, 20);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, self.inputTextFd.bottom+10, KSCREEN_WIDTH-30, 0.5)];
    line.backgroundColor = [ECUtil colorWithHexString:@"e5e5e5"];
    [self.backScrollV addSubview:line];
    
    [self.backScrollV addSubview:self.saveBtn];
    self.saveBtn.frame = CGRectMake(30, self.inputTextFd.bottom+80, KSCREEN_WIDTH-60, 40);
}

- (void)saveBtnAction:(UIButton *)sender {
    
    if (![self.inputTextFd.text n6_isMobile]) {
        [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
        [SVProgressHUD dismissWithDelay:1];
        return ;
    }
    NSDictionary *para = @{@"usertel":self.inputTextFd.text};
    [[HWAFNetworkManager shareManager] accountRequest:para findPassword:^(BOOL success, id  _Nonnull request) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
            [SVProgressHUD dismissWithDelay:1];
            if ([request[@"status"] integerValue] == 200) {
                self.saveBtn.userInteractionEnabled = YES;
                FindSecondViewController *second = [[FindSecondViewController alloc] init];
                second.phoneNum = self.inputTextFd.text;
                [self.navigationController pushViewController:second animated:YES];
            }else if([request[@"status"] integerValue] == 40) {
                [self.navigationController popViewControllerAnimated:YES];
            }
         }
     }];
//    FindSecondViewController *second = [[FindSecondViewController alloc] init];
//    second.phoneNum = self.inputTextFd.text;
//    [self.navigationController pushViewController:second animated:YES];
}

- (UITextField *)inputTextFd {
    if (_inputTextFd == nil) {
        _inputTextFd = [[UITextField alloc] init];
        _inputTextFd.placeholder = @"请输入您的手机号";
        _inputTextFd.textAlignment = NSTextAlignmentLeft;
        _inputTextFd.keyboardType = UIKeyboardTypeNumberPad;
        //[_inputTextFd becomeFirstResponder];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, _inputTextFd.bottom-0.5, KSCREEN_WIDTH-30, 0.5)];
        line.backgroundColor = [ECUtil colorWithHexString:@"e5e5e5"];
        [self.backScrollV addSubview:line];
        __weak typeof(self) weakSelf = self;
        [[_inputTextFd rac_textSignal] subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSString *str = [NSString stringWithFormat:@"%@", x];
            if (str.length >= 11) {
                strongSelf.inputTextFd.text = [str substringToIndex:11];
            }
            if (strongSelf.inputTextFd.text.length == 11) {
                strongSelf.saveBtn.backgroundColor = kColor_Main;
                strongSelf.saveBtn.userInteractionEnabled = YES;
            }else {
                strongSelf.saveBtn.backgroundColor = kColor_UnSelect;
            }
            
        }];
    }
    return _inputTextFd;
}

- (UIButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.backgroundColor = kColor_UnSelect;
        _saveBtn.layer.cornerRadius = 2;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.userInteractionEnabled = NO;
        [_saveBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
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
