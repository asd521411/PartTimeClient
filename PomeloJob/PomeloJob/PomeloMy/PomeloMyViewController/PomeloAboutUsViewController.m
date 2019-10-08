//
//  PomeloAboutUsViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloAboutUsViewController.h"

@interface PomeloAboutUsViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIImageView *iconImgV;

@end

@implementation PomeloAboutUsViewController

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
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight]);
    [self.view addSubview:self.backScrollV];
    
    CGFloat wid = (SCREENWIDTH - 150 * 2);
    
    self.iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - wid) / 2, KSpaceDistance15, wid, wid)];
    self.iconImgV.image = [UIImage imageNamed:@"loginTopImg"];
    self.iconImgV.layer.cornerRadius = 10;
    self.iconImgV.layer.masksToBounds = YES;
    [self.backScrollV addSubview:self.iconImgV];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.iconImgV.bottom + 50, KSCREEN_WIDTH, 400)];
    lab.font = KFontNormalSize18;
    lab.text = @"app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介app简介";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    [self.backScrollV addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - [ECStyle toolbarHeight] - 100, KSCREEN_WIDTH, 20)];
    lab1.font = KFontNormalSize18;
    lab1.text = @"联系我们";
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - [ECStyle toolbarHeight] - 80, KSCREEN_WIDTH, 20)];
    lab2.font = KFontNormalSize18;
    lab2.text = @"联系电话：021-4878963";
    lab2.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - [ECStyle toolbarHeight] - 60, KSCREEN_WIDTH, 20)];
    lab3.font = KFontNormalSize18;
    lab3.text = @"邮箱：789635498@.com";
    lab3.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:lab3];

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
