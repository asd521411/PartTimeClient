//
//  CommonDetailsViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonDetailsViewController.h"
#import "ReactiveCocoa.h"
#import "CommonModel.h"
#import "CommonDetailsTableViewCell.h"
#import "MJExtension.h"
#import "CommontTopTableViewCell.h"
#import "CommonTableViewCell.h"
#import "MJRefresh.h"
#import "PomeloMyResumeViewController.h"
#import "PomeloLoginViewController.h"
#import "CommonWorkLocationTableViewCell.h"
#import "PomeloIndividualResumeViewController.h"
#import "TopMaskBackViewController.h"
#import "DetailBottomBar.h"
#import "CommonRemindTableViewCell.h"
#import "LoginViewController.h"
#import "LoginNavigationController.h"
#import "MyResumeViewController.h"
#import "NoneTableViewCell.h"

@interface CommonDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, DetailBottomBarDelegate>

@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, copy) NSString *text2;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CommonModel *commonModel;
@property (nonatomic, strong) NSArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) BOOL upOrDown;
@property (nonatomic, strong) NSMutableArray *otherRecommendArr;

@property (nonatomic, strong) UIView *bottomBackV;
@property (nonatomic, strong) UILabel *connectType;
@property (nonatomic, strong) UILabel *connectNum;
@property (nonatomic, strong) UIView *maskBackV;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *applyBtn3;

@property (nonatomic, strong) UIView *topMaskBackV;
@property (nonatomic, strong) UIPickerView *pickerV;
@property (nonatomic, strong) NSMutableArray *ageListArr;
@property (nonatomic, copy) NSString *ageStr;
@property (nonatomic, assign) BOOL firstLoginMark;

@property (nonatomic, strong) DetailBottomBar *detailBottomBar;

@property (nonatomic, strong) UIView *resumeMaskBackV;
@property (nonatomic, strong) UIButton *completeBtn;

@property (nonatomic, assign) NSInteger loginState;

@end

#define KTableRowFixedWidth     KSCREEN_WIDTH - 100 - 15

@implementation CommonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位详情";
    ////[self firstLogin];

    [self setupTableViews];

    [self tableViewRefresh];

    [self setupConnectViews];

    ////[self setupTopMaskViews];

    [self setupMaskViews];

    [self resumeMaskSubViews];

    [self.tableView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[ECUtil colorWithHexString:@"4a4a4a"],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
    NSDictionary *para = @{@"adtype":self.clickStyleStr,
                           @"adindex":self.indexStr,
                           @"phonecard":[ECUtil getIDFA]};
    [[HWAFNetworkManager shareManager] clickOperation:para advertismentclick:^(BOOL success, id  _Nonnull request) {
        if (success) {
        }
    }];
    
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //self.navigationController.navigationBar.translucent = NO;
    
//    [self.tableView.mj_header endRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

//- (void)firstLogin {
//    NSDictionary *para = @{@"phonecard":[ECUtil getIDFA]};
//    [[HWAFNetworkManager shareManager] clickOperation:para selectAgeByPhonecar:^(BOOL success, id  _Nonnull request) {
//        if (success) {
//            if ([request[@"status"] isEqualToString:@"success"]) {
//                NSDictionary *dic = (NSDictionary *)request;
//                NSNumber * boolNum = dic[@"statuscode"];
//                self.firstLoginMark = [boolNum boolValue];
//            }
//        }
//    }];
//}

- (void)tableViewRefresh {
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.upOrDown = YES;
        [weakSelf loadData];
    }];
    
//    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        self.upOrDown = NO;
//        [self loadData];
//    }];
}


- (void)setupTableViews {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT-[ECStyle navigationbarHeight]-(42+[ECStyle tabbarExtensionHeight]+5)) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 0.1)];
    self.tableView.tableHeaderView = head;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setupConnectViews {
    
    CGFloat height = 42;
    
    self.bottomBackV = [[UIView alloc] initWithFrame:CGRectMake(15, SCREENHEIGHT - (height+[ECStyle tabbarExtensionHeight]+5), SCREENWIDTH-30, height+[ECStyle tabbarExtensionHeight]+5)];
    [self.view addSubview:self.bottomBackV];
    self.bottomBackV.hidden = YES;
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake(0, 0, (SCREENWIDTH-30)/2, height);
    self.collectBtn.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
//    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
//    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"yishoucang"] forState:UIControlStateSelected];
    [self.collectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [self.collectBtn setImage:[UIImage imageNamed:@"yishoucang"] forState:UIControlStateSelected];
//    self.collectBtn.layer.masksToBounds = YES;
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
    [self.collectBtn setTitleColor:kColor_Main forState:UIControlStateNormal];
    [self.collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    self.collectBtn.adjustsImageWhenHighlighted = NO;
    [self.bottomBackV addSubview:self.collectBtn];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.collectBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(height/2, height/2)];
    CAShapeLayer *lay = [CAShapeLayer layer];
    lay.frame = self.collectBtn.bounds;
    lay.path = path.CGPath;
    self.collectBtn.layer.mask = lay;
    
    if ([self.commonModel.relationtypecollect isEqualToString:@"已收藏"]) {
        //self.collectBtn.userInteractionEnabled = NO;
        self.collectBtn.selected = YES;
    }else {
        self.collectBtn.selected = NO;
    }
    
    __weak typeof(self) weakSelf = self;
    [[self.collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIButton *btn = (UIButton *)x;
        
        NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
        if (![ECUtil isBlankString:userid]) {
            NSDictionary *para = @{@"userid":userid, @"positionid":self.commonModel.positionid, @"relationtype":@"已收藏"};
            if (btn.selected == NO) {
                [SVProgressHUD show];
                [[HWAFNetworkManager shareManager] position:para setuserposition:^(BOOL success, id  _Nonnull request) {
                    if (success) {
                        [SVProgressHUD showWithStatus:request[@"statusMessage"]];
                        [SVProgressHUD dismissWithDelay:1];
                        if ([request[@"status"] integerValue] == 200) {
                        }
                        if ([request[@"status"] integerValue] == 400) {

                        }
                    }
                }];
            }else {
                [[HWAFNetworkManager shareManager] position:para deleteuserposition:^(BOOL success, id  _Nonnull request) {
                    if (success) {
                        [SVProgressHUD showWithStatus:request[@"statusMessage"]];
                        [SVProgressHUD dismissWithDelay:1];
                        if ([request[@"status"] integerValue] == 200) {
                            
                        }
                    }
                }];
            }
        }else {
            LoginViewController *log = [[LoginViewController alloc] init];
            LoginNavigationController *na = [[LoginNavigationController alloc] initWithRootViewController:log];
            na.modalPresentationStyle = UIModalPresentationFullScreen;
            [weakSelf presentViewController:na animated:YES completion:nil];
        }
        btn.selected = !btn.selected;
    
    }];
    
    self.applyBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyBtn3.frame = CGRectMake(self.collectBtn.right, 0, (SCREENWIDTH-30)/2, height);
    self.applyBtn3.backgroundColor = kColor_Main;
//    [self.applyBtn3 setBackgroundImage:[UIImage imageNamed:@"baoming"] forState:UIControlStateNormal];
//    [self.applyBtn3 setBackgroundImage:[UIImage imageNamed:@"yibaoming"] forState:UIControlStateSelected];
    [self.applyBtn3 setTitle:@"立即报名" forState:UIControlStateNormal];
    [self.applyBtn3 setTitle:@"已报名" forState:UIControlStateSelected];
    [self.bottomBackV addSubview:self.applyBtn3];
    UIBezierPath *applyPath = [UIBezierPath bezierPathWithRoundedRect:self.applyBtn3.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(height/2, height/2)];
    CAShapeLayer *appLay = [CAShapeLayer layer];
    appLay.frame = self.applyBtn3.bounds;
    appLay.path = applyPath.CGPath;
    self.applyBtn3.layer.mask = appLay;
    
    if ([self.commonModel.relationtype isEqualToString:@"已报名"]) {
        self.applyBtn3.userInteractionEnabled = NO;
        self.applyBtn3.selected = YES;
    }else {
        self.applyBtn3.selected = NO;
    }
    
    //审核状态
    [[HWAFNetworkManager shareManager] accountRequest:@{} checkStatus:^(BOOL success, id  _Nonnull request) {
        if (success) {
            if ([request[@"status"] isEqualToString:@"0"]) {
                self.bottomBackV.hidden = YES;
            }else if ([request[@"status"] isEqualToString:@"1"]){
                self.bottomBackV.hidden = NO;
            }
        }
    }];
    
    [[self.applyBtn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
        if (![ECUtil isBlankString:userid]) {
            NSDictionary *para = @{@"userid":userid, @"positionid":self.commonModel.positionid, @"relationtype":@"已报名"};
            [SVProgressHUD show];
            [[HWAFNetworkManager shareManager] positionRequest:para selectResumeByuserid:^(BOOL success, id  _Nonnull request) {
                if (success) {
                    [SVProgressHUD dismiss];
                    if ([request[@"status"] integerValue] == 200) {
                        strongSelf.connectType.text = strongSelf.commonModel.positionteltype;
                        NSString *str = nil;
                        if (strongSelf.commonModel.positiontelnum.length > 4) {
                            str = [strongSelf.commonModel.positiontelnum stringByReplacingCharactersInRange:NSMakeRange(2, strongSelf.commonModel.positiontelnum.length-4) withString:@"******"];
                        }
                        strongSelf.connectNum.text = str;
                        strongSelf.maskBackV.hidden = NO;
                        strongSelf.applyBtn3.userInteractionEnabled = NO;
                        strongSelf.applyBtn3.selected = YES;
                        
                    }else if ([request[@"status"] integerValue] == 400) {
                        //跳到简历页面
//                        PomeloIndividualResumeViewController *resume = [[PomeloIndividualResumeViewController alloc] init];
                        self.resumeMaskBackV.hidden = NO;
                    }
                }
            }];
        }else {
//            PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
//            [self.navigationController pushViewController:login animated:YES];
            LoginViewController *log = [[LoginViewController alloc] init];
            LoginNavigationController *na = [[LoginNavigationController alloc] initWithRootViewController:log];
            na.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:na animated:YES completion:nil];
        }
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)resumeMaskSubViews {
    
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    [win addSubview:self.resumeMaskBackV];
    self.resumeMaskBackV.hidden = YES;

    CGFloat wid = 275;//KSCREEN_WIDTH - 130;
    CGFloat hei = 184;//wid * 331 / 492;
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake((KSCREEN_WIDTH-wid)/2, 100, wid, hei)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 20;
    back.layer.masksToBounds = YES;
    [self.resumeMaskBackV addSubview:back];
    
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    backImgV.backgroundColor = [UIColor whiteColor];
    backImgV.image = [UIImage imageNamed:@"resumbackimg"];
    backImgV.center = CGPointMake(back.width/2, 60);
    [back addSubview:backImgV];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, backImgV.bottom+10, back.width, 18)];
    lab.textColor = kColor_Main;
    lab.numberOfLines = 0;
    lab.font = kFontNormalSize(16);
    lab.text = @"还没完善简历呢，快去完善简历吧！";
    lab.textAlignment = NSTextAlignmentCenter;
    [back addSubview:lab];
    
    self.completeBtn.frame = CGRectMake(70, lab.bottom+10, back.width-140, 32);
    [back addSubview:self.completeBtn];
    
}

- (void)sendDojob {
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"userid":userid, @"phonecard":[ECUtil getIDFA]};
    [[HWAFNetworkManager shareManager] positionRequest:para doJob:^(BOOL success, id  _Nonnull request) {
        if (success) {
        }
    }];
}

- (void)setupTopMaskViews {
    self.topMaskBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    self.topMaskBackV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:self.topMaskBackV];
    
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    [win addSubview:self.topMaskBackV];
    self.topMaskBackV.hidden= YES;
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(50, 170, KSCREEN_WIDTH - 100, 200)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 5;
    back.layer.masksToBounds = YES;
    [self.topMaskBackV addSubview:back];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, back.width, 40)];
    lab.text = @"请选择你的年龄";
    lab.textAlignment = NSTextAlignmentCenter;
    [back addSubview:lab];
    
    self.pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, lab.bottom, back.width, 160)];
    self.pickerV.delegate = self;
    self.pickerV.dataSource = self;
    [back addSubview:self.pickerV];
    
    __weak typeof(self) weakSelf = self;
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(back.left + back.width / 4 - 30, back.bottom + 30, back.width / 2 + 60, 40);
    btn2.backgroundColor = [ECUtil colorWithHexString:@"ff4457"];
    btn2.layer.cornerRadius = 20;
    btn2.layer.masksToBounds = YES;
    [self.topMaskBackV addSubview:btn2];
    [btn2 setTitle:@"确 认" forState:UIControlStateNormal];
    self.ageStr = @"18";
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.topMaskBackV.hidden = YES;
        NSDictionary *para = @{@"phonecard":[ECUtil getIDFA], @"age":strongSelf.ageStr};
        [[HWAFNetworkManager shareManager] clickOperation:para updateageByphonecard:^(BOOL success, id  _Nonnull request) {
            if (success) {
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0  inSection:0];
//                CommontTopTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//                cell.showConnect = NO;
//                [strongSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.firstLoginMark = YES;
                [strongSelf.tableView reloadData];
            }
        }];
        
    }];
  
}

- (void)setupMaskViews {
    
    self.maskBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    self.maskBackV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.maskBackV.hidden = YES;
    
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    //[self.view addSubview:self.maskBackV];
    [win addSubview:self.maskBackV];
    
    CGFloat wid = 275;//KSCREEN_WIDTH - 130;
    CGFloat hei = 184;//wid * 331 / 492;
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:CGRectMake((KSCREEN_WIDTH-wid)/2, 112, wid, hei)];
    backImgV.backgroundColor = [UIColor whiteColor];
    backImgV.layer.cornerRadius = 5;
    backImgV.layer.masksToBounds = YES;
    //backImgV.image = [UIImage imageNamed:@"pastebackimg"];
    backImgV.userInteractionEnabled = YES;
    [self.maskBackV addSubview:backImgV];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, backImgV.width - 80, 100)];
    lab.textColor = [ECUtil colorWithHexString:@"cacaca"];
    lab.numberOfLines = 0;
    lab.font = KFontNormalSize14;
    lab.text = @"请主动联系公司咨询相关工作内容，完成录取流程。";
    //[backImgV addSubview:lab];
    
    CGFloat w = 80;
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiangqingtishi"]];
    img.frame = CGRectMake((backImgV.width-w)/2, 10, w, w);
    [backImgV addSubview:img];
    
    UILabel *connect = [[UILabel alloc] initWithFrame:CGRectMake(10, img.bottom, backImgV.width-20, 16)];
    connect.textAlignment = NSTextAlignmentCenter;
    connect.textColor = kColor_Main;
    connect.font = KFontNormalSize16;
    connect.text = @"报名成功，快去联系吧！";
    [backImgV addSubview:connect];
    
    self.connectType = [[UILabel alloc] init];
    self.connectType.textAlignment = NSTextAlignmentCenter;
    self.connectType.textColor = kColor_Main;
    self.connectType.font = KFontNormalSize16;
    self.connectType.text = @"联系方式";
    [backImgV addSubview:self.connectType];
    [self.connectType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(connect.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
    }];
    
    self.connectNum = [[UILabel alloc] init];
    self.connectNum.textAlignment = NSTextAlignmentLeft;
    self.connectNum.textColor = kColor_Main;
    self.connectNum.font = KFontNormalSize16;
    self.connectNum.text = @"   ";
    self.connectNum.textAlignment = NSTextAlignmentCenter;
    [backImgV addSubview:self.connectNum];
    [self.connectNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.connectType.mas_right).offset(10);
        make.top.mas_equalTo(self.connectType.mas_top);
        make.right.mas_equalTo(-30);
    }];
    
    UIButton *pasteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pasteBtn.backgroundColor = kColor_Main;
    pasteBtn.frame = CGRectMake(60, backImgV.height - 42, wid - 60 * 2, 32);
    [pasteBtn setTitle:@"复制联系方式" forState:UIControlStateNormal];
    pasteBtn.layer.cornerRadius = 16;
    pasteBtn.layer.masksToBounds = YES;
    [backImgV addSubview:pasteBtn];
    __weak typeof(self) weakSelf = self;
    [[pasteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [weakSelf sendDojob];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = strongSelf.commonModel.positiontelnum;
        [HWPorgressHUD HWHudShowStatus:@"复制成功！"];
        [SVProgressHUD showWithStatus:@" "];
        [SVProgressHUD dismissWithDelay:1];
        strongSelf.maskBackV.hidden = YES;
        if ([strongSelf.commonModel.positionteltype isEqualToString:@"联系微信号"] || [strongSelf.commonModel.positionteltype isEqualToString:@"公众号联系"] || [strongSelf.commonModel.positionteltype isEqualToString:@"微信号联系"]) {
            [strongSelf openWechat];
        }
        if ([strongSelf.commonModel.positionteltype isEqualToString:@"支付宝联系"]) {
            [strongSelf openAlipay];
        }
        
        //记录点击次数
        NSDictionary *para = @{@"adtype":@"报名",
                               @"adindex":self.commonModel.positionid,
                               @"phonecard":[ECUtil getIDFA]};
        [[HWAFNetworkManager shareManager] clickOperation:para advertismentclick:^(BOOL success, id  _Nonnull request) {
            [SVProgressHUD dismiss];
        }];

    }];
}

-(void)openWechat{
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen){   //打开微信
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
                [[UIApplication sharedApplication] openURL:url];
            }
        });
    }
}

- (void)openAlipay {
    NSURL * url = [NSURL URLWithString:@"alipays://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen){   //打开支付宝
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
                [[UIApplication sharedApplication] openURL:url];
            }
        });
    }else {
    }
}

- (void)loadData {
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"positionid":[ECUtil isBlankString:self.positionid]?@"":self.positionid, @"userid":[ECUtil isBlankString:userid]?@"":userid};
    
    [[HWAFNetworkManager shareManager] positionRequest:para positionInfo:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            if (![ECUtil isBlankString:[NSString stringWithFormat:@"%@", dic[@"status"]]] && [dic[@"status"] integerValue] == 400) {
                self.bottomBackV.hidden = YES;
                self.loginState = 400;
                [self.tableView reloadData];
            }else {
            
                self.commonModel = [CommonModel mj_objectWithKeyValues:dic];
                if ([self.commonModel.relationtype isEqualToString:@"已报名"]) {
                    self.applyBtn3.userInteractionEnabled = NO;
                    self.applyBtn3.selected = YES;
                }else {
                    self.applyBtn3.userInteractionEnabled = YES;
                    self.applyBtn3.selected = NO;
                }
                if ([self.commonModel.relationtypecollect isEqualToString:@"已收藏"]) {
                    //self.collectBtn.userInteractionEnabled = NO;
                    self.collectBtn.selected = YES;
                }else {
                    //self.collectBtn.userInteractionEnabled = YES;
                    self.collectBtn.selected = NO;
                }
                
                if (self.upOrDown == YES) {
                    [self.listArr removeAllObjects];
                    [self.otherRecommendArr removeAllObjects];
                    self.otherRecommendArr = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"positionList"]];
                    [self.listArr addObject:self.commonModel];
                    [self.tableView reloadData];
                }
            }
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)completeBtnAction:(UIButton *)sender {
    self.resumeMaskBackV.hidden = YES;
    MyResumeViewController *resume = [[MyResumeViewController alloc] init];
    resume.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resume animated:YES];
}

#pragma mark custom delegate

- (void)bottomBarcollect {
    
}

- (void)bottomBarSignup {
    
}

#pragma mark UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.loginState == 400) {
        return 1;
    }else {
        return self.sectionArr.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if (self.loginState == 400) {
         return 1;
     }else {
         if (section < 5) {
             return self.listArr.count;
         }else {
             return 3;
         }
     }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.loginState == 400) {
        NoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoneTableViewCell"];
        if (!cell) {
            cell = [[NoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoneTableViewCell"];
        }
        cell.showImgV.image = [UIImage imageNamed:@"deletebackimg"];
        cell.remindLab.text = @"你来晚了，职位已被删除";
        return cell;
    }else {
        if (indexPath.section == 0) {
                    CommontTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommontTopTableViewCell"];
                    if (!cell) {
                        cell = [[CommontTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommontTopTableViewCell"];
                    }
                    
        //            cell.showConnect = self.firstLoginMark;
                    cell.showConnect = YES;
                    cell.commonModel = self.commonModel;
                    __weak typeof(self) weakSelf = self;
                    cell.pasteAction = ^(NSString * _Nonnull num) {
                       // __strong typeof(weakSelf) strongSelf = weakSelf;
                        
        //                if (strongSelf.firstLoginMark == YES) {
        //                    //安装过
        //                    strongSelf.topMaskBackV.hidden = YES;
                            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                            pasteboard.string = weakSelf.commonModel.positiontelnum;
                            [HWPorgressHUD HWHudShowStatus:@"复制成功！"];
                            if ([weakSelf.commonModel.positionteltype isEqualToString:@"联系微信号"] || [weakSelf.commonModel.positionteltype isEqualToString:@"公众号联系"] || [weakSelf.commonModel.positionteltype isEqualToString:@"微信号联系"]) {
                                [weakSelf openWechat];
                            }
                            if ([weakSelf.commonModel.positionteltype isEqualToString:@"支付宝联系"]) {
                                [weakSelf openAlipay];
                            }
                            
                            //记录点击次数
                            NSDictionary *para = @{@"adtype":@"复制",
                                                   @"adindex":weakSelf.commonModel.positionid,
                                                   @"phonecard":[ECUtil getIDFA]};
                            [[HWAFNetworkManager shareManager] clickOperation:para advertismentclick:^(BOOL success, id  _Nonnull request) {
                                if (success) {
                                }
                            }];
                            
        //                }else {
        //                    strongSelf.topMaskBackV.hidden = NO;
        //
        //                }
                    };
                    return cell;
                }else if (indexPath.section == 1) {
                    CommonDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonDetailsTableViewCell"];
                    if (!cell) {
                        cell = [[CommonDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonDetailsTableViewCell"];
                    }
                    cell.contentStr = self.commonModel.positioninfo;
                    cell.workContentBackV.hidden = YES;
                    return cell;
                }else if (indexPath.section == 2 || indexPath.section == 3) {
                    CommonWorkLocationTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CommonWorkLocationTableViewCell"];
                    if (!cell1) {
                        cell1 = [[CommonWorkLocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonWorkLocationTableViewCell"];
                        }
                    if (indexPath.section == 2) {
                        cell1.componyLocationLab.text = self.commonModel.positionworktime;
                    }
                    if (indexPath.section == 3) {
                        cell1.componyLocationLab.text = self.commonModel.positionworkaddressinfo;
                    }
                    return cell1;
                }else if (indexPath.section == 4) {
                    CommonRemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonRemindTableViewCell"];
                    if (!cell) {
                        cell = [[CommonRemindTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonRemindTableViewCell"];
                    }
                    return cell;
                }else {
                    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
                    cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonTableViewCell"];
                    if (self.otherRecommendArr.count > 0) {
                        cell.commonModel = self.otherRecommendArr[indexPath.row];
                    }
                    return cell;
                }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView == tableView) {
        if (indexPath.section == 5) {
            CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
            CommonModel *model = self.otherRecommendArr[indexPath.row];
            detail.positionid = model.positionid;
            detail.clickStyleStr = @"其它推荐";
            detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tableView == tableView) {
        if (indexPath.section == 0) {
            return 128 + 26;
        }
        if (indexPath.section == 1) {
//            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.commonModel.positioninfo dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//            CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(KSCREEN_WIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            return [self getHTMLHeightByStr:self.commonModel.positioninfo font:nil lineSpacing:5 width:KSCREEN_WIDTH-30];
        }
        if (indexPath.section == 2) {
            CGSize size = [ECUtil textSize:self.commonModel.positionworktime font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 30, CGFLOAT_MAX)];
            return size.height + 25;
        }
        
        if (indexPath.section == 3) {
            CGSize size = [ECUtil textSize:self.commonModel.positionworkaddressinfo font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 30, CGFLOAT_MAX)];
            return size.height + 30;
        }
        if (indexPath.section == 4) {
            CGSize size = [ECUtil textSize:@"凡是涉及到工作内容不符、收费、违法信息传播的工作，请您警惕并收集相关证据向我们举报" font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 90, CGFLOAT_MAX)];
            return size.height + 20;
        }
    }
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.tableView == tableView) {
        UIView *head = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, 0, KSCREEN_WIDTH, 34)];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textColor = [ECUtil colorWithHexString:@"2f2f2f"];
        label.text = self.sectionArr[section];
        [head addSubview:label];
        return head;
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.tableView == tableView) {
        if (section == 0) {
            return 0;
        }
        if (section == 4) {
            return 0;
        }
        return 34;
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.ageListArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.ageListArr[row] stringByAppendingString:@"岁"];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.ageStr = self.ageListArr[row];
}


- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}

- (NSArray *)sectionArr {
    if (!_sectionArr) {
        _sectionArr = @[@" ",@"职位详情",@"工作时间",@"工作地点",@"",@"更多岗位推荐"];
    }
    return _sectionArr;
}

- (NSMutableArray *)otherRecommendArr {
    if (!_otherRecommendArr) {
        _otherRecommendArr = [[NSMutableArray alloc] init];
    }
    return _otherRecommendArr;
}

- (NSMutableArray *)ageListArr {
    if (!_ageListArr) {
        _ageListArr = [[NSMutableArray alloc] init];
        for (int i = 18; i <= 60; i++) {
            NSString *str = [NSString stringWithFormat:@"%d", i];
            [_ageListArr addObject:str];
        }
    }
    return _ageListArr;
}

- (DetailBottomBar *)detailBottomBar {
    if (_detailBottomBar) {
        _detailBottomBar = [[DetailBottomBar alloc] initWithFrame:CGRectMake(15, KSCREEN_HEIGHT - [ECStyle tabbarExtensionHeight], KSCREEN_WIDTH - 30, 40)];
        _detailBottomBar.delegate = self;
    }
    return _detailBottomBar;
}

- (UIView *)resumeMaskBackV {
    if (_resumeMaskBackV == nil) {
        _resumeMaskBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _resumeMaskBackV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return _resumeMaskBackV;
}

- (UIButton *)completeBtn {
    if (_completeBtn == nil) {
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.backgroundColor = kColor_Main;
        _completeBtn.layer.cornerRadius = 16;
        _completeBtn.layer.masksToBounds = YES;
        [_completeBtn setTitle:@"完善简历" forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(completeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}


/**
 计算html字符串高度

 @param str html 未处理的字符串
 @param font 字体设置
 @param lineSpacing 行高设置
 @param width 容器宽度设置
 @return 富文本高度
 */
-(CGFloat )getHTMLHeightByStr:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width
{
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
//    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [htmlString length])];
    
    CGSize contextSize = [htmlString boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return contextSize.height ;
}


@end
