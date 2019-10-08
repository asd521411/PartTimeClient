//
//  PomeloJobIntentionViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/16.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloJobIntentionViewController.h"
#import "PomeloResumeImproveTableViewController.h"
@interface PomeloJobIntentionViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UILabel *textFd1;
@property (nonatomic, strong) UITextField *textFd2;
@property (nonatomic, strong) UITextField *textFd3;
@property (nonatomic, strong) UILabel *textFd4;
@property (nonatomic, copy) NSString *resumehuntingtype;
@property (nonatomic, copy) NSString *resumehuntingmoney;

@end

@implementation PomeloJobIntentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
    self.backScrollV.scrollEnabled = YES;
    self.backScrollV.bounces = YES;
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [self.view addSubview:self.backScrollV];
    UITapGestureRecognizer *resign = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponser:)];
    [self.backScrollV addGestureRecognizer:resign];
    
    // MARK: 求职类型
    
    CGFloat hei = 40;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, 20, 80, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize14;
    lab1.text = @"求职类型";
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    
    self.textFd1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1.right, lab1.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2 - 10, hei)];
    self.textFd1.textColor = KColor_C8C8C8;
    self.textFd1.font = KFontNormalSize10;
    self.textFd1.text = @"请输入求职类型";
    self.textFd1.textAlignment = NSTextAlignmentLeft;
    self.textFd1.userInteractionEnabled = YES;
    [self.backScrollV addSubview:self.textFd1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(turnRightAction:)];
    [self.textFd1 addGestureRecognizer:tap];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.textFd1.width - 10, 10, 10, 20)];
    img1.image = [UIImage imageNamed:@"rightjiantou"];
    [self.textFd1 addSubview:img1];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    // MARK: 求职区域
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom + KSpaceDistance15, 80, hei)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize14;
    lab2.text = @"求职区域:";
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab2];
    
    self.textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab2.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd2.placeholder = @"请输入区域";
    self.textFd2.textColor = KColor_C8C8C8;
    self.textFd2.font = KFontNormalSize10;
    //self.textFd2.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd2];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];
    
    // MARK: 求职岗位
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom + KSpaceDistance15, 80, hei)];
    lab3.textColor = KColor_212121;
    lab3.font = KFontNormalSize14;
    lab3.text = @"求职岗位:";
    lab3.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab3];
    
    self.textFd3 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab3.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd3.placeholder = @"请输入岗位";
    self.textFd3.textColor = KColor_C8C8C8;
    self.textFd3.font = KFontNormalSize10;
    //self.textFd3.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd3];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab3.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line3.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line3];
    
    // MARK: 期望薪资
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab3.bottom + KSpaceDistance15, 80, hei)];
    lab4.textColor = KColor_212121;
    lab4.font = KFontNormalSize14;
    lab4.text = @"期望薪资:";
    lab4.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab4];
    
    self.textFd4 = [[UILabel alloc] initWithFrame:CGRectMake(lab1.right, lab4.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2 - 10, hei)];
    self.textFd4.textColor = KColor_C8C8C8;
    self.textFd4.font = KFontNormalSize10;
    self.textFd4.text = @"请输入求职类型";
    self.textFd4.textAlignment = NSTextAlignmentLeft;
    self.textFd4.userInteractionEnabled = YES;
    [self.backScrollV addSubview:self.textFd4];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(turnRightAction:)];
    [self.textFd4 addGestureRecognizer:tap4];
    
    UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake(self.textFd4.width - 10, 10, 10, 20)];
    img4.image = [UIImage imageNamed:@"rightjiantou"];
    [self.textFd4 addSubview:img4];
    
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab4.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line4.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line4];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(95,  lab4.bottom + 50, KSCREEN_WIDTH - 95 * 2, 40);
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"确     认" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    login.adjustsImageWhenHighlighted = NO;
    [ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    
    __weak typeof(self) weakSelf = self;
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
        NSDictionary *para = @{@"userid":![ECUtil isBlankString:userid]?userid:@"",
                               @"resumehuntingtype":@"",
                               @"resumehuntingaddress":![ECUtil isBlankString:strongSelf.textFd2.text]?self.textFd2.text:@"",
                               @"resumehuntingpostid":![ECUtil isBlankString:strongSelf.textFd3.text]?self.textFd3.text:@"",
                               @"resumehuntingmoney":![ECUtil isBlankString:strongSelf.resumehuntingmoney]?strongSelf.resumehuntingmoney:@"",
                               };
        [[HWAFNetworkManager shareManager] resume:para resumeHunting:^(BOOL success, id  _Nonnull request) {
            if (success) {
                [SVProgressHUD showWithStatus:@"成功"];
                [SVProgressHUD dismissWithDelay:1];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }];

}

- (void)turnRightAction:(UIGestureRecognizer *)tap {
    
    PomeloResumeImproveTableViewController *improve = [[PomeloResumeImproveTableViewController alloc] init];
    
    if (self.textFd1 == tap.view) {
        improve.resumeImproveType = ResumeImproveType_JobWantedStyle;
    }
    if (self.textFd4 == tap.view) {
        improve.resumeImproveType = ResumeImproveType_Expected_Salary;
        
    }
    __weak typeof(self) weakSelf = self;
    improve.improveSelectonBlock = ^(ResumeImproveType improveType, NSString * _Nonnull type) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (improveType == ResumeImproveType_JobWantedStyle) {
            strongSelf.textFd1.text = type;
            strongSelf.resumehuntingtype = type;
        }
        if (improveType == ResumeImproveType_Expected_Salary) {
            strongSelf.textFd4.text = type;
            strongSelf.resumehuntingmoney = type;
        }
    };
    [self.navigationController pushViewController:improve animated:YES];
    
}

- (void)resignResponser:(UITapGestureRecognizer *)tap {
    for (UIView *v in self.backScrollV.subviews) {
        if ([v isKindOfClass:[UITextField class]]) {
            UITextField *tx = (UITextField *)v;
            [tx resignFirstResponder];
        }
    }
    
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
