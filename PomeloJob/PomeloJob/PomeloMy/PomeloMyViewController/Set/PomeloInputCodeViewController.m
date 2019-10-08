//
//  PomeloInputCodeViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloInputCodeViewController.h"
#import "ReactiveCocoa.h"
#import "UIView+HWUtilView.h"
#import "PomeloChangePasswordViewController.h"

@interface PomeloInputCodeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *backScroll;
@property (nonatomic, strong) UITextField *textFd1;

@end

@implementation PomeloInputCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输入验证码";
    
    self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight])];
    self.backScroll.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [self.view addSubview:self.backScroll];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, [ECStyle navigationbarHeight] + 100, KSCREEN_WIDTH - KSpaceDistance15 * 2, 14)];
    title.font = KFontNormalSize14;
    title.textColor = KColor_212121;
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"请输入验证码";
    [self.backScroll addSubview:title];
    
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    CGFloat wid = 44;
    CGFloat space = (KSCREEN_WIDTH - KSpaceDistance15 * 2 - 44 * 6) / 5;
    
    self.textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(KSpaceDistance15, title.bottom + KSpaceDistance15, KSCREEN_WIDTH - KSpaceDistance15 * 2, 44)];
    self.textFd1.textColor = [UIColor whiteColor];
    self.textFd1.tintColor = [UIColor whiteColor];
    [self.backScroll addSubview:self.textFd1];
    self.textFd1.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, title.bottom + KSpaceDistance15, KSCREEN_WIDTH - KSpaceDistance15 * 2, wid)];
    back.backgroundColor = [UIColor whiteColor];
    back.userInteractionEnabled = YES;
    //[self.backScroll addSubview:back];
    for (int i = 0; i < 6; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15 + (i % 6) * (wid + space), title.bottom + KSpaceDistance15, wid, wid)];
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = KFontNormalSize18;
        lab.textColor = KColor_C8C8C8;
        lab.userInteractionEnabled = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        [self.backScroll addSubview:lab];
        [UIView HWShadowDraw:lab shadowColor:KColorGradient_light shadowOffset:CGSizeMake(0, 2) shadowOpacity:1 shadowRadius:1];
        [mutArr addObject:lab];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFirstResponse:)];
        [lab addGestureRecognizer:tap];
    }
    
    [[self.textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *str = [NSString stringWithFormat:@"%@", x];
        UILabel *lab;
        if (str.length <= 6) {
            for (int i = 0; i < str.length; i++) {
                NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
                lab = mutArr[i];
                lab.text = s;
            }
            for (NSUInteger i = str.length; i < 6; i++) {
                lab = mutArr[i];
                lab.text = @"";
                }
        }else {
            str = [str substringToIndex:6];
            self.textFd1.text = str;
            return ;
        }
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(95, self.textFd1.bottom + 100, KSCREEN_WIDTH - 95 * 2, 44);
    btn.backgroundColor = [HWRandomColor randomColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [ECUtil  gradientLayer:btn startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [self.backScroll addSubview:btn];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        PomeloChangePasswordViewController *change = [[PomeloChangePasswordViewController alloc] init];
        change.verifyCode = strongSelf.textFd1.text;
        [strongSelf.navigationController pushViewController:change animated:YES];
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)selectFirstResponse:(UITapGestureRecognizer *)tap {
    [self.textFd1 becomeFirstResponder];
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
