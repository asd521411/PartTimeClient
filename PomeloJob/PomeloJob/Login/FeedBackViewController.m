//
//  FeedBackViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/25.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UITextField *inputTextFd;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈给我们";
    
    [self.view addSubview:self.backScrollV];
    [self.backScrollV addSubview:self.saveBtn];
    [self.backScrollV addSubview:self.inputTextFd];
    
    
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

- (void)saveBtnAction:(UIButton *)sender {
    
    if (![self.inputTextFd.text n6_isMobile]) {
        [SVProgressHUD showInfoWithStatus:@"手机号有误！"];
        [SVProgressHUD dismissWithDelay:1];
        return ;
    }
    
    NSDictionary *para = @{@"usertel":self.inputTextFd.text};
    [SVProgressHUD show];
    [[HWAFNetworkManager shareManager] opinionRequest:para collectTel:^(BOOL success, id  _Nonnull request) {
        if (success) {
            [SVProgressHUD showInfoWithStatus:request[@"statusMessage"]];
            [SVProgressHUD dismissWithDelay:1];
            if ([request[@"status"] integerValue] == 200) {
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([request[@"status"] integerValue] == 400) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

- (UIScrollView *)backScrollV {
    if (_backScrollV == nil) {
        _backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT + 100);
    }
    return _backScrollV;
}

- (UIButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.backgroundColor = kColor_Main;
        _saveBtn.layer.cornerRadius = 2;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.frame = CGRectMake(30, 340, KSCREEN_WIDTH-60, 40);
        [_saveBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (UITextField *)inputTextFd {
    if (_inputTextFd == nil) {
        _inputTextFd = [[UITextField alloc] initWithFrame:CGRectMake(15, 40, KSCREEN_WIDTH-30, 40)];
        _inputTextFd.placeholder = @"请输入您的手机号";//self.placeHolder
        //_inputTextFd.text = self.placeHolder;
        _inputTextFd.textAlignment = NSTextAlignmentCenter;
        _inputTextFd.keyboardType = UIKeyboardTypeNumberPad;
        [_inputTextFd becomeFirstResponder];
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
                strongSelf.inputTextFd.text = [str substringToIndex:11];
                strongSelf.saveBtn.backgroundColor = kColor_Main;
            }else {
                strongSelf.saveBtn.backgroundColor = kColor_UnSelect;
            }
            
        }];
    }
    return _inputTextFd;
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
