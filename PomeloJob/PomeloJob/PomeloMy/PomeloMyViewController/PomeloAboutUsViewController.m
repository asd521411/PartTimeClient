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
    self.title = @"关于我们";
    //[self setupSubViews];
    [self setup];
    
    // Do any additional setup after loading the view.
}




- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[ECUtil colorWithHexString:@"4a4a4a"],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
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

- (void)setup {
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle tabbarExtensionHeight])];
    self.backScrollV.scrollEnabled = NO;
    self.backScrollV.bounces = YES;
    //self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] + 50);
    [self.view addSubview:self.backScrollV];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((KSCREEN_WIDTH-100)/2, 80, 100, 100)];
    img.image = [UIImage imageNamed:@"commonicon"];
    [self.backScrollV addSubview:img];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(30, img.bottom+10, KSCREEN_WIDTH-60, 30)];
    lab1.text = @"柚选兼职";
    lab1.textColor = [ECUtil colorWithHexString:@"383838"];
    lab1.font = kFontBoldSize(20);
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:lab1];
    
    NSString *str2 = @"<font size=4 color=616161>柚选兼职自由职业者服务交易平台， 在这里就能找到心仪的兼职让生活更加充实，全面发展，为成为不一样的自己而努力奋斗</font>";
    NSAttributedString *attributedString2 = [[NSAttributedString alloc] initWithData:[str2 dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    CGRect rect2 = [attributedString2 boundingRectWithSize:CGSizeMake(KSCREEN_WIDTH - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(30, lab1.bottom+50, KSCREEN_WIDTH-60, rect2.size.height)];
    lab2.numberOfLines = 0;
    lab2.attributedText = attributedString2;
    [self.backScrollV addSubview:lab2];
    
    NSString *str3 = @"<p><font size=5 color=616161 style=text-align:center>特色功能</font></p><hr><font size=4 color=616161><p>「柚选信息真实有保障」</p><p>「知名企业高薪招聘等你来」</p><p>「发现生活中的赚钱方式，展示最新岗位」</p></font>";
    NSAttributedString *attributedString3 = [[NSAttributedString alloc] initWithData:[str3 dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    CGRect rect3 = [attributedString3 boundingRectWithSize:CGSizeMake(KSCREEN_WIDTH - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    UITextView *lab3 = [[UITextView alloc] initWithFrame:CGRectMake(30, lab2.bottom+50, KSCREEN_WIDTH-60, rect3.size.height)];
    lab3.scrollEnabled = NO;
    lab3.attributedText = attributedString3;
    lab3.textAlignment = NSTextAlignmentCenter;
    [self.backScrollV addSubview:lab3];
    
    
    CGFloat wid = (SCREENWIDTH - 150 * 2);
    self.iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - wid) / 2, KSpaceDistance15, wid, wid)];
    self.iconImgV.image = [UIImage imageNamed:@"loginTopImg"];
    self.iconImgV.layer.cornerRadius = 10;
    self.iconImgV.layer.masksToBounds = YES;
    //[img addSubview:self.iconImgV];
    
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
