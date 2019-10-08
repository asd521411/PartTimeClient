//
//  PomeloVerifyViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloVerifyViewController.h"
#import "ReactiveCocoa.h"
#import "PomeloResetViewController.h"

@interface PomeloVerifyViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIImageView *iconImgV;

@end

@implementation PomeloVerifyViewController

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
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.iconImgV.bottom + 50, 80, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize14;
    lab1.text = @"验证码：";
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    textFd1.placeholder = @"请输入6位验证码";
    textFd1.textColor = KColor_C8C8C8;
    textFd1.font = KFontNormalSize14;
    textFd1.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:textFd1];
    //    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    //    textFd1.layer.borderWidth = KLineWidthMeasure05;
    [[textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *str = [NSString stringWithFormat:@"%@", x];
        if (str.length >= 6) {
            textFd1.text = [str substringToIndex:6];
        }
    }];
    
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom - 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(95,  textFd1.bottom + 90, KSCREEN_WIDTH - 95 * 2, 40);
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"登  陆" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    login.adjustsImageWhenHighlighted = NO;
    [ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    
    __weak typeof(self) weakSelf = self;
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        [[HWAFNetworkManager shareManager] accountRequest:@{@"usertel":weakSelf.phoneNumOrEmail, @"usermessagecode":textFd1.text} loginByMessageCode:^(BOOL success, id  _Nonnull request) {
            NSDictionary *dic = (NSDictionary *)request;
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"验证成功！"];
                [SVProgressHUD dismissWithDelay:1];
                PomeloResetViewController *set = [[PomeloResetViewController alloc] init];
                [strongSelf.navigationController pushViewController:set animated:YES];
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
