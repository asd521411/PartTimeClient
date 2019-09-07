//
//  VerifyViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "VerifyViewController.h"
#import "ReactiveCocoa.h"
#import "ResetViewController.h"

@interface VerifyViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIImageView *iconImgV;

@end

@implementation VerifyViewController

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
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(space, self.iconImgV.bottom + space, space * 2, hei)];
    lab1.textColor = BLACKCOLOR;
    lab1.font = LARGEFont;
    lab1.text = @"输入验证码";
    [self.backScrollV addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(space, lab1.bottom + hei, SCREENWIDTH / 2, hei)];
    textFd1.placeholder = @"请输入6位验证码";
    [self.backScrollV addSubview:textFd1];
    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    textFd1.layer.borderWidth = LineWidthNormal05;
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(SCREENWIDTH / 3, self.backScrollV.bottom - 200 , SCREENWIDTH / 3, space);
    login.backgroundColor = [HWRandomColor randomColor];
    login.layer.cornerRadius = 5;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"确 定" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    [login setBackgroundColor:[HWRandomColor randomColor]];
    
    
    __weak typeof(self) weakSelf = self;
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = self;
        ResetViewController *set = [[ResetViewController alloc] init];
        [strongSelf.navigationController pushViewController:set animated:YES];
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
