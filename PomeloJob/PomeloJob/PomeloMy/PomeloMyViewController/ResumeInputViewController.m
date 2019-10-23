//
//  ResumeInputViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ResumeInputViewController.h"

@interface ResumeInputViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIView *contentTextV;
@property (nonatomic, strong) UITextField *inputTextFd;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation ResumeInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作职位";
    
    [self.view addSubview:self.backScrollV];
    [self.backScrollV addSubview:self.saveBtn];
    [self.backScrollV addSubview:self.inputTextFd];
    
    switch (self.inputType) {
        case InputTypeWorkContent:
            [self setupSubViews];
            break;
        case InputTypeWorkPosition:
            self.contentTextV.hidden = YES;
        default:
            break;
    }
    
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
    self.contentTextV = [[UIView alloc] init];
    self.contentTextV.backgroundColor = [ECUtil colorWithHexString:@"f1f1f1"];
    self.contentTextV.layer.cornerRadius = 5;
    self.contentTextV.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.contentTextV];
    [self.contentTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(KSCREEN_WIDTH-30);
        make.height.mas_equalTo(300);
    }];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.text = @"请填写工作内容";
    lab1.font = kFontNormalSize(16);
    lab1.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    [self.contentTextV addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentTextV).offset(10);
        make.height.mas_equalTo(17);
    }];
    
    UITextView *textFdV = [[UITextView alloc] init];
    textFdV.backgroundColor = [ECUtil colorWithHexString:@"f1f1f1"];
    textFdV.delegate = self;
    textFdV.font = kFontNormalSize(14);
    textFdV.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    [self.contentTextV addSubview:textFdV];
    [textFdV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentTextV).offset(10);
        make.top.mas_equalTo(lab1.mas_bottom).offset(10);
        make.right.mas_equalTo(self.contentTextV.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.contentTextV.mas_bottom).offset(-30);
    }];
    
    [[textFdV rac_textSignal] subscribeNext:^(id x) {
        NSString *str = [NSString stringWithFormat:@"%@", x];
        if (str.length > 200) {
            textFdV.text = [str substringToIndex:200];
        }
    }];
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.text = @"(200以内)";
    lab2.font = kFontNormalSize(16);
    lab2.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    [self.contentTextV addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.contentTextV).offset(-10);
    }];
    
}

- (void)saveBtnAction:(UIButton *)sender {
    if (self.inputContentBlock) {
        self.inputContentBlock(self.inputTextFd.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (UITextField *)inputTextFd {
    if (_inputTextFd == nil) {
        _inputTextFd = [[UITextField alloc] initWithFrame:CGRectMake(15, 40, KSCREEN_WIDTH-30, 40)];
        _inputTextFd.placeholder = @"请输入";//self.placeHolder
        //_inputTextFd.text = self.placeHolder;
        _inputTextFd.textAlignment = NSTextAlignmentCenter;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, _inputTextFd.bottom-0.5, KSCREEN_WIDTH-30, 0.5)];
        line.backgroundColor = [ECUtil colorWithHexString:@"e5e5e5"];
        [self.backScrollV addSubview:line];
        __weak typeof(self) weakSelf = self;
        [[_inputTextFd rac_textSignal] subscribeNext:^(id x) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSString *str = [NSString stringWithFormat:@"%@", x];
            if (str.length >= 16) {
                strongSelf.inputTextFd.text = [str substringToIndex:16];
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
