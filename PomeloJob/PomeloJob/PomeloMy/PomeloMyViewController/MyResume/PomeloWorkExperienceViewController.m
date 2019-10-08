//
//  PomeloWorkExperienceViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/16.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloWorkExperienceViewController.h"

@interface PomeloWorkExperienceViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UITextField *textFd1;
@property (nonatomic, strong) UITextField *textFd2;
@property (nonatomic, strong) UITextField *textFd3;
@property (nonatomic, strong) UITextField *textFd4;
@property (nonatomic, strong) UITextField *textFd5;

@end

@implementation PomeloWorkExperienceViewController

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponser:)];
    [self.backScrollV addGestureRecognizer:tap];
    
    
    CGFloat hei = 40;
    // MARK: 公司名称

    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, 20, 80, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize14;
    lab1.text = @"公司名称:";
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];
    
    self.textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd1.placeholder = @"请输入公司名称";
    self.textFd1.textColor = KColor_C8C8C8;
    self.textFd1.font = KFontNormalSize10;
    //self.textFd1.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd1];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    // MARK: 起止时间
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom + KSpaceDistance15, 80, hei)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize14;
    lab2.text = @"起止时间:";
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab2];
    
    self.textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab2.top, KSCREEN_WIDTH - lab2.width - KSpaceDistance15 * 2, hei)];
    self.textFd2.placeholder = @"时间";
    self.textFd2.textColor = KColor_C8C8C8;
    self.textFd2.font = KFontNormalSize10;
    //textFd2.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd2];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];
    
    // MARK: 岗位
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom + KSpaceDistance15, 80, hei)];
    lab3.textColor = KColor_212121;
    lab3.font = KFontNormalSize14;
    lab3.text = @"岗     位:";
    lab3.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab3];
    
    self.textFd3 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab3.top, KSCREEN_WIDTH - lab3.width - KSpaceDistance15 * 2, hei)];
    self.textFd3.placeholder = @"岗位职责";
    self.textFd3.textColor = KColor_C8C8C8;
    self.textFd3.font = KFontNormalSize10;
    //self.textFd3.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd3];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab3.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line3.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line3];
    
    // MARK: 岗位职责
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab3.bottom + KSpaceDistance15, 80, hei)];
    lab4.textColor = KColor_212121;
    lab4.font = KFontNormalSize14;
    lab4.text = @"岗位职责:";
    lab4.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab4];
    
    self.textFd4 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab4.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd4.placeholder = @"请输入岗位职责";
    self.textFd4.textColor = KColor_C8C8C8;
    self.textFd4.font = KFontNormalSize10;
    //self.textFd4.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd4];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab4.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line4.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line4];
    
    // MARK: 工作内容
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab4.bottom + KSpaceDistance15, 80, hei)];
    lab5.textColor = KColor_212121;
    lab5.font = KFontNormalSize14;
    lab5.text = @"工作内容:";
    lab5.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab5];
    
    self.textFd5 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab5.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei * 2)];
    self.textFd5.placeholder = @"请输入工作内容";
    self.textFd5.textColor = KColor_C8C8C8;
    self.textFd5.font = KFontNormalSize10;
    //self.textFd5.keyboardType = UIKeyboardTypeNumberPad;
    self.textFd5.layer.borderColor = KColor_Line.CGColor;
    self.textFd5.layer.borderWidth = KLineWidthMeasure05;
    self.textFd5.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:self.textFd5];
    
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.textFd5.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line5.backgroundColor = KColor_Line;
    //[self.backScrollV addSubview:line5];

    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(95,  self.textFd5.bottom + hei, KSCREEN_WIDTH - 95 * 2, 40);
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"确     认" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    login.adjustsImageWhenHighlighted = NO;
    [ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //__block typeof(weakSelf) strongSelf = weakSelf;
        NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
        NSDictionary *para = @{@"userid":[ECUtil isBlankString:userid]?@"":userid,
                               @"resumeoldcompany":self.textFd1.text.length>0?self.textFd1.text:@"",
                               @"":@"",
                               @"resumeoldcompanypost":self.textFd3.text.length>0?self.textFd3.text:@"",
                               @"resumeoldresponsibility":self.textFd4.text.length>0?self.textFd4.text:@"",
                               @"resumeoldcompangcontent":self.textFd5.text.length>0?self.textFd5.text:@"",
                               };
        [[HWAFNetworkManager shareManager] resume:para resumeCompany:^(BOOL success, id  _Nonnull request) {
            if (success) {
                [HWPorgressHUD HWHudShowStatus:request[@"status"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }];


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
