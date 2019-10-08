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

@interface CommonDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

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

@end

#define KTableRowFixedWidth     KSCREEN_WIDTH - 100 - 15

@implementation CommonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableViews];
    
    [self tableViewRefresh];

    [self setupConnectViews];
    
    [self setupMaskViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)tableViewRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDown = YES;
        [self loadData];

    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.upOrDown = NO;
        [self loadData];
    }];
}


- (void)setupTableViews {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight]) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 0.1)];
    self.tableView.tableHeaderView = head;
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

- (void)setupConnectViews {
    
    CGFloat height = 50;
    
    self.bottomBackV = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - height - [ECStyle tabbarExtensionHeight], SCREENWIDTH, height)];
    [self.view addSubview:self.bottomBackV];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, SCREENWIDTH / 3, height);
    btn1.backgroundColor = [ECUtil colorWithHexString:@"339cf9"];
    [btn1 setTitle:@"电话咨询" forState:UIControlStateNormal];
    [btn1 setTintColor:[UIColor whiteColor]];
    //[self.bottomBackV addSubview:btn1];
    
    [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(btn1.right, 0, SCREENWIDTH / 3, height);
    btn2.backgroundColor = [ECUtil colorWithHexString:@"f8f8f8"];
    [btn2 setTitle:@"沟通" forState:UIControlStateNormal];
    [btn2 setTintColor:[UIColor whiteColor]];
    //[self.bottomBackV addSubview:btn2];
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 0, SCREENWIDTH, height);
    btn3.backgroundColor = [ECUtil colorWithHexString:@"ff4457"];
    [btn3 setTitle:@"立即报名" forState:UIControlStateNormal];
    [btn3 setTintColor:[UIColor whiteColor]];
    UIBezierPath *pa = [UIBezierPath bezierPathWithRoundedRect:btn3.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(22, 22)];
    CAShapeLayer *lay = [CAShapeLayer layer];
    lay.frame = btn3.frame;
    lay.path = pa.CGPath;
    btn3.layer.mask = lay;
    
    [[HWAFNetworkManager shareManager] accountRequest:@{} checkStatus:^(BOOL success, id  _Nonnull request) {
        if (success) {
            if ([request[@"status"] isEqualToString:@"0"]) {
            }else if ([request[@"status"] isEqualToString:@"1"])
            [self.bottomBackV addSubview:btn3];
        }
    }];
    
    __weak typeof(self) weakSelf = self;
    [[btn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
        if (![ECUtil isBlankString:userid]) {
            NSDictionary *para = @{@"userid":userid};
            [[HWAFNetworkManager shareManager] positionRequest:para selectResumeByuserid:^(BOOL success, id  _Nonnull request) {
                if (success) {
                    if ([request[@"status"] isEqualToString:@"success"]) {
                        strongSelf.connectType.text = strongSelf.commonModel.positionteltype;
                        strongSelf.connectNum.text = strongSelf.commonModel.positiontelnum;
                        strongSelf.maskBackV.hidden = NO;
                    }else if ([request[@"status"] isEqualToString:@"file"]) {
                        //跳到简历页面
                        PomeloMyResumeViewController *resume = [[PomeloMyResumeViewController alloc] init];
                        [strongSelf.navigationController pushViewController:resume animated:YES];
                    }
                }
            }];
        }else {
            PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }
    }];
}

- (void)sendDojob {
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"userid":userid, @"phonecard":[ECUtil getIDFA]};
    [[HWAFNetworkManager shareManager] positionRequest:para doJob:^(BOOL success, id  _Nonnull request) {
        if (success) {
        }
    }];
}


- (void)setupMaskViews {
    self.maskBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    self.maskBackV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.maskBackV.hidden = YES;
    
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    //[self.view addSubview:self.maskBackV];
    [win addSubview:self.maskBackV];
    
    CGFloat wid = KSCREEN_WIDTH - 60;
    CGFloat hei = wid * 259 / 319;
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 112, wid, hei)];
    backImgV.image = [UIImage imageNamed:@"pastebackimg"];
    backImgV.userInteractionEnabled = YES;
    [self.maskBackV addSubview:backImgV];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, backImgV.width - 80, 100)];
    lab.textColor = [ECUtil colorWithHexString:@"cacaca"];
    lab.numberOfLines = 0;
    lab.font = KFontNormalSize14;
    lab.text = @"请主动联系公司咨询相关工作内容，完成录取流程。";
    [backImgV addSubview:lab];
    
    UILabel *connect = [[UILabel alloc] initWithFrame:CGRectMake(0, backImgV.height - 90, backImgV.width / 2 - 50, 20)];
    connect.textAlignment = NSTextAlignmentRight;
    connect.textColor = [ECUtil colorWithHexString:@"5c5c5c"];
    connect.font = KFontNormalSize16;
    connect.text = @"联系方式";
    [backImgV addSubview:connect];
    
    self.connectType = [[UILabel alloc] init];
    self.connectType.textAlignment = NSTextAlignmentLeft;
    //connect1.textColor = [ECUtil colorWithHexString:@"5c5c5c"];
    self.connectType.font = KFontNormalSize16;
    self.connectType.text = @"    ";
    [backImgV addSubview:self.connectType];
    [self.connectType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(connect.mas_right).offset(10);
        make.top.mas_equalTo(connect.mas_top);
    }];
    
    self.connectNum = [[UILabel alloc] init];
    self.connectNum.textAlignment = NSTextAlignmentLeft;
    //connect1.textColor = [ECUtil colorWithHexString:@"5c5c5c"];
    self.connectNum.font = KFontNormalSize16;
    self.connectNum.text = @"   ";
    [backImgV addSubview:self.connectNum];
    [self.connectNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.connectType.mas_right).offset(10);
        make.top.mas_equalTo(connect.mas_top);
    }];
    
    UIButton *pasteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pasteBtn.backgroundColor = [ECUtil colorWithHexString:@"ff4457"];
    pasteBtn.frame = CGRectMake(92, backImgV.height - 57, wid - 92 * 2, 42);
    [pasteBtn setTitle:@"复制" forState:UIControlStateNormal];
    pasteBtn.layer.cornerRadius = 21;
    pasteBtn.layer.masksToBounds = YES;
    [backImgV addSubview:pasteBtn];
    __weak typeof(self) weakSelf = self;
    [[pasteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [self sendDojob];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.commonModel.positiontelnum;
        [HWPorgressHUD HWHudShowStatus:@"复制成功！"];
        strongSelf.maskBackV.hidden = YES;
        if ([strongSelf.commonModel.positionteltype isEqualToString:@"联系微信号"] || [strongSelf.commonModel.positionteltype isEqualToString:@"微信小程序"] || [strongSelf.commonModel.positionteltype isEqualToString:@"微信号联系"]) {
            [strongSelf openWechat];
        }
    }];
}

-(void)openWechat{
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen){   //打开微信
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        });
    }else {
    }
}

- (void)loadData {
    
    NSDictionary *para = @{@"positionid":[ECUtil isBlankString:self.positionid]?@"":self.positionid};
    [[HWAFNetworkManager shareManager] positionRequest:para positionInfo:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            self.commonModel = [CommonModel mj_objectWithKeyValues:dic];
            if (self.upOrDown == YES) {
                [self.listArr removeAllObjects];
                [self.otherRecommendArr removeAllObjects];
                self.otherRecommendArr = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"positionList"]];
                [self.listArr addObject:self.commonModel];
                [self.tableView reloadData];
            }else {
                
            }
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < 4) {
        return self.listArr.count;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CommontTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommontTopTableViewCell"];
        if (!cell) {
            cell = [[CommontTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommontTopTableViewCell"];
        }
        cell.commonModel = self.commonModel;
        __weak typeof(self) weakSelf = self;
        cell.pasteAction = ^(NSString * _Nonnull num) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
            if (![ECUtil isBlankString:userid]) {
                [HWPorgressHUD HWHudShowStatus:@"复制成功"];
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = num;
                if ([strongSelf.commonModel.positionteltype isEqualToString:@"联系微信号"] || [strongSelf.commonModel.positionteltype isEqualToString:@"微信小程序"] || [strongSelf.commonModel.positionteltype isEqualToString:@"微信号联系"]) {
                    [strongSelf openWechat];
                }
            }else {
                PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
                [strongSelf.navigationController pushViewController:login animated:YES];
            }
        };
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3) {
        CommonDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonDetailsTableViewCell"];
        if (!cell) {
            cell = [[CommonDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonDetailsTableViewCell"];
        }
        
        if (indexPath.section == 1) {
//            CGSize size = [ECUtil textSize:self.commonModel.positioninfo font:KFontNormalSize10 bounding:CGSizeMake(KSCREEN_WIDTH - KSpaceDistance15 * 2, CGFLOAT_MAX)];
//            cell.commonModel.cellHeight = size.height;
//            cell.commonModel = self.commonModel;
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.commonModel.positioninfo dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            //cell.workContentLab.text = self.commonModel.positioninfo;
            cell.contentStr = self.commonModel.positioninfo;
            cell.workContentLab.attributedText = attributedString;
        }
        if (indexPath.section == 2) {
//            CGSize size = [ECUtil textSize:self.commonModel.positionworktime font:KFontNormalSize10 bounding:CGSizeMake(KSCREEN_WIDTH - KSpaceDistance15 * 2, CGFLOAT_MAX)];
//            cell.commonModel.cellHeight = size.height;
//            cell.commonModel = self.commonModel;
            cell.workContentLab.text = self.commonModel.positionworktime;
            cell.contentStr = self.commonModel.positionworktime;
            cell.workContentBackV.hidden = YES;
        }
        
        if (indexPath.section == 3) {
            CommonWorkLocationTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CommonWorkLocationTableViewCell"];
            if (!cell1) {
                cell1 = [[CommonWorkLocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonWorkLocationTableViewCell"];
            }
////            cell.workContentLab.text = self.commonModel.positionworkaddressinfo;
////            cell.contentStr = self.commonModel.positionworkaddressinfo;
//            cell.workContentBackV.hidden = YES;
            cell1.commonModel = self.commonModel;
            return cell1;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
        CommonModel *model = self.otherRecommendArr[indexPath.row];
        detail.positionid = model.positionid;
        detail.clickStyleStr = @"其它推荐";
        detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    CommonDetailsModel *model = self.tableVRowArr[indexPath.section];
//    CGFloat H = 0;
//    for (NSNumber *num in model.rowArr) {
//        H = H + num.floatValue + KSpaceDistance10;
//    }
//    return H;
    if (indexPath.section == 0) {
        return 128 + 70;
    }
    if (indexPath.section == 1) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.commonModel.positioninfo dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(KSCREEN_WIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        //CGSize size = [ECUtil textSize:attributedString.string font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 30, CGFLOAT_MAX)];
        return rect.size.height + 30 + 50;
    }
    if (indexPath.section == 2) {
        CGSize size = [ECUtil textSize:self.commonModel.positionworktime font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 30, CGFLOAT_MAX)];
        return size.height + 30;
    }
    
    if (indexPath.section == 3) {
        CGSize size = [ECUtil textSize:self.commonModel.positionworkaddressinfo font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 30, CGFLOAT_MAX)];
        return size.height + 30;
    }
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *head = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, 0, KSCREEN_WIDTH, 34)];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [ECUtil colorWithHexString:@"2f2f2f"];
    label.text = self.sectionArr[section];
    [head addSubview:label];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 34;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}



- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}

- (NSArray *)sectionArr {
    if (!_sectionArr) {
        _sectionArr = @[@" ",@"职位详情",@"工作时间",@"工作地点",@"其它推荐"];
    }
    return _sectionArr;
}

- (NSMutableArray *)otherRecommendArr {
    if (!_otherRecommendArr) {
        _otherRecommendArr = [[NSMutableArray alloc] init];
    }
    return _otherRecommendArr;
}

@end
