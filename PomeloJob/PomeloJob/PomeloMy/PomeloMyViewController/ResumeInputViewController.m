//
//  ResumeInputViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ResumeInputViewController.h"

@interface ResumeInputViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIView *contentTextV;
@property (nonatomic, strong) UITextField *inputTextFd;
@property (nonatomic, strong) UITextField *textFdV;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab1;

@end

@implementation ResumeInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    
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
    
    self.lab1 = [[UILabel alloc] init];
    self.lab1.text = @"请填写工作内容";
    self.lab1.font = kFontNormalSize(16);
    self.lab1.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    //[self.contentTextV addSubview:self.lab1];
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentTextV).offset(10);
        make.height.mas_equalTo(17);
    }];
    
    self.textFdV = [[UITextField alloc] init];
    self.textFdV.backgroundColor = [ECUtil colorWithHexString:@"f1f1f1"];
    self.textFdV.delegate = self;
    self.textFdV.font = kFontNormalSize(14);
    self.textFdV.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    self.textFdV.textAlignment = NSTextAlignmentLeft;
    self.textFdV.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [self.contentTextV addSubview:self.textFdV];
    
    if ([ECUtil isBlankString:self.placeHolder]) {
        self.textFdV.placeholder = @"请填写工作内容";
    }else {
        self.textFdV.text = self.placeHolder;
    }
    [self.textFdV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentTextV).offset(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(self.contentTextV.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.contentTextV.mas_bottom).offset(-30);
    }];
    __weak typeof(self) weakSelf = self;
    [[self.textFdV rac_textSignal] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *str = [NSString stringWithFormat:@"%@", x];
        
//        if (str.length > 0) {
//            strongSelf.lab1.hidden = YES;
//        }else {
//            strongSelf.lab1.hidden = NO;
//        }
        
        if (str.length >= 200) {
            strongSelf.textFdV.text = [str substringToIndex:200];
        }
        strongSelf.lab2.text =  [@"(" stringByAppendingString:[[NSString stringWithFormat:@"%lu", (unsigned long)strongSelf.textFdV.text.length] stringByAppendingString:@"/200)"]];
    }];
    
    self.lab2 = [[UILabel alloc] init];
    self.lab2.text = @"(200)";
    self.lab2.font = kFontNormalSize(16);
    self.lab2.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    [self.contentTextV addSubview:self.lab2];
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.contentTextV).offset(-10);
    }];
}

- (void)saveBtnAction:(UIButton *)sender {
    switch (self.inputType) {
        case InputTypeWorkContent:
            if (self.inputContentBlock) {
                self.inputContentBlock([ECUtil isBlankString:self.textFdV.text]?@"":self.textFdV.text);
            }
            break;
        case InputTypeWorkPosition:
            if (self.inputContentBlock) {
                self.inputContentBlock(self.inputTextFd.text.length==0?@"":self.inputTextFd.text);
            }
        default:
            break;
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
        if (self.placeHolder.length == 0 || [self.placeHolder isEqualToString:@"请输入姓名"] || [self.placeHolder isEqualToString:@"请填写姓名"] || [ECUtil isBlankString:self.placeHolder]) {
            _inputTextFd.placeholder = @"请输入";
            _inputTextFd.text = @"";
        }else {
            _inputTextFd.text = self.placeHolder;
        }
        _inputTextFd.textAlignment = NSTextAlignmentCenter;
        _inputTextFd.textColor = [ECUtil colorWithHexString:@"4a4a4a"];
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
            strongSelf.inputTextFd.text = str;
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
