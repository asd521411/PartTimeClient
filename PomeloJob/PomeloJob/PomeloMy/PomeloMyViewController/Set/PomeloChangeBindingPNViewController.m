//
//  ChangePhNumViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloChangeBindingPNViewController.h"
#import "ReactiveCocoa.h"
#import "PomeloInputCodeViewController.h"
#import "UIView+HWUtilView.h"

@interface PomeloChangeBindingPNViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, weak) UITextField *textFd1;

@end

@implementation PomeloChangeBindingPNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改绑定手机";
    
    [self setupSubViews];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, SCREENHEIGHT)];
    self.backScrollV.contentSize =CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [self.view addSubview:self.backScrollV];
    UITapGestureRecognizer *resign = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerTextField:)];
    [self.backScrollV addGestureRecognizer:resign];
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREENWIDTH - 40, 50)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.textColor = DARKGRAYCOLOR;
    //lab.font = LARGEFont;
    lab.text = @"更改手机号后，下次登录请使用新绑定手机号登录";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 2;
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.backScrollV addSubview:lab];
    [UIView HWShadowDraw:lab shadowColor:KColorGradient_light shadowOffset:CGSizeMake(0, 2) shadowOpacity:0.5 shadowRadius:1];
    
    CGFloat hei = 40;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab.bottom + 100, 100, hei)];
    lab1.textColor = BLACKCOLOR;
    lab1.font = KFontNormalSize12;
    lab1.text = @"+86";
    [self.backScrollV addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab.bottom + 100, KSCREEN_WIDTH - KSpaceDistance15 * 2 - lab1.width, hei)];
    textFd1.placeholder = @"请输入手机号";
    textFd1.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:textFd1];
    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    self.textFd1 = textFd1;
    [[textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *str = [NSString stringWithFormat:@"%@", x];
        if (str.length >= 11) {
            textFd1.text = [str substringToIndex:11];
        }
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(95,  textFd1.bottom + 40, KSCREEN_WIDTH - 95 * 2, 44);
    btn.backgroundColor = [HWRandomColor randomColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [self.backScrollV addSubview:btn];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [ECUtil gradientLayer:btn startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    __weak typeof(self) weakSelf = self;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
//        if (![textFd1.text n6_isMobile]) {
//            [HWPorgressHUD HWHudShowStatus:@"手机号错误！"];
//            return ;
//        }
        
        [HWAFNetworkManager shareManager] ;
        
        PomeloInputCodeViewController *input = [[PomeloInputCodeViewController alloc] init];
        input.phoneStr = textFd1.text;
        [weakSelf.navigationController pushViewController:input animated:YES];
    }];
}

- (void)registerTextField:(UIGestureRecognizer *)tap {
    [self.textFd1 resignFirstResponder];
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
