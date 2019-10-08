//
//  PomeloChangePasswordViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloChangePasswordViewController.h"
#import "ReactiveCocoa.h"
#import "PomeloLoginViewController.h"
#import "UIView+HWUtilView.h"

@interface PomeloChangePasswordViewController ()

@property (nonatomic, strong) UIScrollView *backScroll;

@end

@implementation PomeloChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight])];
    self.backScroll.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [self.view addSubview:self.backScroll];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREENWIDTH - 40, 50)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.textColor = KColor_C8C8C8;
    lab.font = KFontNormalSize12;
    lab.text = @"*更改密码后将回到登陆界面重新登陆";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 2;
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.backScroll addSubview:lab];
    //[UIView HWShadowDraw:lab shadowColor:KColorGradient_light shadowOffset:CGSizeMake(0, 2) shadowOpacity:1 shadowRadius:1];
    
    CGFloat hei = 40;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab.bottom + hei, 100, hei)];
    lab1.textColor = BLACKCOLOR;
    lab1.font = KFontNormalSize12;
    lab1.text = @"原始密码";
    [self.backScroll addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab.bottom + hei, SCREENWIDTH / 2, hei)];
    textFd1.placeholder = @"请输入原始密码";
    textFd1.font = KFontNormalSize12;
    //textFd1.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScroll addSubview:textFd1];
//    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
//    textFd1.layer.borderWidth = KLineWidthMeasure05;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScroll addSubview:line1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom + hei, 100, hei)];
    lab2.textColor = BLACKCOLOR;
    lab2.font = KFontNormalSize12;
    lab2.text = @"新密码";
    [self.backScroll addSubview:lab2];
    
    UITextField *textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.bottom + hei, SCREENWIDTH / 2, hei)];
    textFd2.placeholder = @"请输入新密码";
    textFd2.font = KFontNormalSize12;
    //textFd2.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScroll addSubview:textFd2];
//    textFd2.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
//    textFd2.layer.borderWidth = KLineWidthMeasure05;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScroll addSubview:line2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom + hei, 100, hei)];
    lab3.textColor = BLACKCOLOR;
    lab3.font = KFontNormalSize12;
    lab3.text = @"确认密码";
    [self.backScroll addSubview:lab3];
    
    UITextField *textFd3 = [[UITextField alloc] initWithFrame:CGRectMake(lab3.right, lab2.bottom + hei, SCREENWIDTH / 2, hei)];
    textFd3.placeholder = @"请再次输入确认";
    textFd3.font = KFontNormalSize12;
    //textFd3.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScroll addSubview:textFd3];
//    textFd3.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
//    textFd3.layer.borderWidth = KLineWidthMeasure05;
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab3.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line3.backgroundColor = KColor_Line;
    [self.backScroll addSubview:line3];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab3.bottom + 1, KSCREEN_WIDTH - KSpaceDistance15 * 2, 50)];
    lab4.backgroundColor = [UIColor whiteColor];
    lab4.textColor = DARKGRAYCOLOR;
    lab4.font = KFontNormalSize12;
    lab4.text = @"*密码不得少于6位的数字，字符组合";
    lab4.textAlignment = NSTextAlignmentLeft;
    lab4.numberOfLines = 2;
    lab4.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.backScroll addSubview:lab4];
    //[UIView HWShadowDraw:lab4 shadowColor:KColorGradient_light shadowOffset:CGSizeMake(0, 2) shadowOpacity:1 shadowRadius:1];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(95, textFd3.bottom + 100, KSCREEN_WIDTH - 95 * 2, 44);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [self.backScroll addSubview:btn];
    [ECUtil gradientLayer:btn startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController popToRootViewControllerAnimated:YES];
        PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
        UITabBarController *tabbar = strongSelf.navigationController.tabBarController;
        UINavigationController *na = tabbar.viewControllers[4];
        [na.navigationController pushViewController:login animated:YES];
        [strongSelf.navigationController popToViewController:login animated:YES];
        
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
