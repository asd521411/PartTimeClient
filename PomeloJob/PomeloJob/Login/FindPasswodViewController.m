//
//  FindPasswodViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/25.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "FindPasswodViewController.h"

@interface FindPasswodViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIImageView *iconImgV;

@property (nonatomic, strong) UITextField *textFd1;
@property (nonatomic, strong) UITextField *textFd2;
@property (nonatomic, strong) UIButton *login;

@end

@implementation FindPasswodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置密码";
    
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
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
    self.backScrollV.scrollEnabled = YES;
    self.backScrollV.bounces = YES;
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [self.view addSubview:self.backScrollV];
    
    CGFloat wid = (SCREENWIDTH - 150 * 2);
    CGFloat hei = 40;
    
    self.iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - wid) / 2, KSpaceDistance15, wid, wid)];
    //self.iconImgV.image = [UIImage imageNamed:@"loginTopImg"];
    self.iconImgV.layer.cornerRadius = 10;
    self.iconImgV.layer.masksToBounds = YES;
    //[self.backScrollV addSubview:self.iconImgV];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.iconImgV.bottom + 50, 100, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize18;
    lab1.text = @"密码";
    lab1.textAlignment = NSTextAlignmentLeft;
    //[self.backScrollV addSubview:lab1];
    
    self.textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(15, 30, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd1.placeholder = @"密码(最少6位)";
    self.textFd1.textColor = KColor_C8C8C8;
    self.textFd1.font = KFontNormalSize16;
    self.textFd1.secureTextEntry = YES;
    self.textFd1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:self.textFd1];
     __weak typeof(self) weakSelf = self;
    [[self.textFd1 rac_textSignal] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = self;
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 16) {
            self.textFd1.text = [text substringToIndex:16];
        }
        if (self.textFd1.text.length >= 6 && self.textFd2.text.length >= 6) {
            strongSelf.login.backgroundColor = kColor_Main;
        }else {
            strongSelf.login.backgroundColor = kColor_UnSelect;
        }
    }];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.textFd1.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(15, self.textFd1.bottom + 20, KSCREEN_WIDTH - 30, hei)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize18;
    lab2.text = @"确认密码";
    lab2.textAlignment = NSTextAlignmentLeft;
    //[self.backScrollV addSubview:lab2];
    
    self.textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(15, lab2.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd2.placeholder = @"确认密码";
    self.textFd2.textColor = KColor_C8C8C8;
    self.textFd2.font = KFontNormalSize16;
    self.textFd2.secureTextEntry = YES;
    self.textFd2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:self.textFd2];
    [[self.textFd2 rac_textSignal] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *text = [NSString stringWithFormat:@"%@", x];
        if (text.length >= 16) {
            self.textFd2.text = [text substringToIndex:16];
        }
        
        if (self.textFd1.text.length >= 6 && self.textFd2.text.length >= 6) {
            strongSelf.login.backgroundColor = kColor_Main;
        }else {
            strongSelf.login.backgroundColor = kColor_UnSelect;
        }
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.textFd2.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];
    
    self.login = [UIButton buttonWithType:UIButtonTypeCustom];
    self.login.frame = CGRectMake(30,  self.textFd2.bottom + 50, KSCREEN_WIDTH-60, 40);
    self.login.layer.cornerRadius = 2;
    self.login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.login];
    [self.login setTitle:@"确 定" forState:UIControlStateNormal];
    [self.login setTintColor:[UIColor whiteColor]];
    //[ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [self.login setBackgroundColor:kColor_UnSelect];
   
    [[self.login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (self.textFd1.text.length < 6 || self.textFd2.text.length < 6) {
            [SVProgressHUD showInfoWithStatus:@"最少6位密码！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        
        if (![self.textFd1.text isEqualToString:self.textFd2.text]) {
            [SVProgressHUD showInfoWithStatus:@"两次输入密码不匹配！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        
        NSDictionary *para = @{@"usertel":self.phoneNum, @"newpassword":self.textFd1.text};
        [SVProgressHUD show];
        [[HWAFNetworkManager shareManager] accountRequest:para updaterefactoruserpassword:^(BOOL success, id  _Nonnull request) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:request[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                if ([request[@"status"] integerValue] == 200) {
                    [strongSelf.navigationController popToRootViewControllerAnimated:YES];
                }else {
                    
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
