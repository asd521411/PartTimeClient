//
//  LoginViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "LoginViewController.h"
#import "ReactiveCocoa.h"
#import "VerifyLoginViewController.h"
#import "ForgetViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIImageView *iconImgV;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.backScrollV.backgroundColor = [HWRandomColor randomColor];
    self.backScrollV.scrollEnabled = YES;
    self.backScrollV.bounces = YES;
    [self.view addSubview:self.backScrollV];
    
    CGFloat wid = SCREENWIDTH / 3;
    CGFloat space = 50;
    CGFloat hei = 40;
    
    self.iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - wid) / 2, [ECStyle navigationbarHeight] + space, wid, wid)];
    self.iconImgV.backgroundColor = [HWRandomColor randomColor];
    self.iconImgV.image = [UIImage imageNamed:@""];
    [self.view addSubview:self.iconImgV];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(space, self.iconImgV.bottom + space / 2, space * 2, hei)];
    lab1.textColor = BLACKCOLOR;
    lab1.font = LARGEFont;
    lab1.text = @"手机号：";
    [self.backScrollV addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, self.iconImgV.bottom + space / 2, SCREENWIDTH / 2, hei)];
    textFd1.placeholder = @"请输入手机号";
    [self.backScrollV addSubview:textFd1];
    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    textFd1.layer.borderWidth = LineWidthNormal05;
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab1.bottom + space, space * 2, hei)];
    lab2.textColor = BLACKCOLOR;
    lab2.font = LARGEFont;
    lab2.text = @"密码：";
    [self.backScrollV addSubview:lab2];
    
    UITextField *textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, textFd1.bottom + space, SCREENWIDTH / 2, hei)];
    textFd2.placeholder = @"请输入密码";
    [self.backScrollV addSubview:textFd2];
    textFd2.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    textFd2.layer.borderWidth = LineWidthNormal05;
    
    UIButton *agree = [UIButton buttonWithType:UIButtonTypeCustom];
    agree.frame = CGRectMake(space, lab2.bottom + space / 2, hei / 2, hei / 2);
    agree.backgroundColor = [HWRandomColor randomColor];
    agree.layer.cornerRadius = 3;
    agree.layer.masksToBounds = YES;
    [self.backScrollV addSubview:agree];
    [agree setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [agree setBackgroundImage:[UIImage imageNamed:@"dagou.png"] forState:UIControlStateSelected];
    
    [[agree rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIButton *btn  = x;
        btn.selected = !btn.selected;
    }];
    
    UILabel *remind = [[UILabel alloc] initWithFrame:CGRectMake(agree.right + 10, agree.top, SCREENWIDTH / 2, hei / 2)];
    remind.textColor = GRAYCOLOR;
    remind.font = SMALLFont;
    remind.text = @"用户注册及使用APP隐私协议";
    [self.backScrollV addSubview:remind];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, space * 2, hei);
    left.center = CGPointMake(SCREENWIDTH / 4, remind.bottom + space);
    [left setTitle:@"验证码登陆" forState:UIControlStateNormal];
    [self.backScrollV addSubview:left];
    
    __weak typeof(self) weakSelf = self;
    
    [[left rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = self;
        VerifyLoginViewController *verify = [[VerifyLoginViewController alloc] init];
        [strongSelf.navigationController pushViewController:verify animated:YES];
    }];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, space * 2, hei);
    right.center = CGPointMake(SCREENWIDTH * 3 / 4, remind.bottom + space);
    [right setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.backScrollV addSubview:right];
    [[right rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ForgetViewController *forget = [[ForgetViewController alloc] init];
        [self.navigationController pushViewController:forget animated:YES];
    }];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(SCREENWIDTH / 3, self.backScrollV.bottom - 200 , SCREENWIDTH / 3, space);
    login.backgroundColor = [HWRandomColor randomColor];
    login.layer.cornerRadius = 5;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"登  陆" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    [login setBackgroundColor:[HWRandomColor randomColor]];
    
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = self;
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
