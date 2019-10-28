//
//  NoteVerifyFeedbackViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/17.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "NoteVerifyFeedbackViewController.h"
#import "FeedBackViewController.h"

@interface NoteVerifyFeedbackViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UITableView *tableV;

@end

@implementation NoteVerifyFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"为什么收不到短信验证码？";
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [self.view addSubview:self.backScrollV];

    
    NSString *str = @"<font size=4 >如果手机号可正常使用，但无法正常收到验证短信，我们建议：<br>1) 检查手机是否启用了短信拦截；检查短信收件箱是否需要清理；<br>2)部分手机由于所在网络问题，可以尝试重启以及重装SIM卡；<br>3)所在地区信号可能不稳定，需要等待一段时间，或联系当地运营商查询。<br><br>若使用以上办法仍无法正常获取验证码，请联系我们</font>";
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(KSCREEN_WIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, KSCREEN_WIDTH-30, rect.size.height)];
    lab.font = kFontNormalSize(14);
    lab.numberOfLines = 0;
    lab.attributedText = attributedString;
    [self.backScrollV addSubview:lab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = kColor_Main;
    btn.frame = CGRectMake(30, lab.bottom+20, KSCREEN_WIDTH-60, 40);
    [btn setTitle:@"反馈给我们" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backScrollV addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        FeedBackViewController *feed = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feed animated:YES];
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
