//
//  PomeloMyViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloMyViewController.h"
#import "PomeloSetViewController.h"
#import "PomeloRecordDefaultViewController.h"
#import "ReactiveCocoa.h"
#import "PomeloMyResumeViewController.h"
#import "PomeloPersonalInfoViewController.h"
#import "PomeloLoginViewController.h"
#import "ImgTitleView.h"
#import "UserInfoModel.h"
#import "SSKeychain.h"
#import "LoginNavigationController.h"

@interface PomeloMyViewController ()<UITableViewDelegate, UITableViewDataSource, ImgTitleViewDelegate>

@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UserInfoModel *userInfoModel;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *personalizedLab;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UIView *topBackView;

//@property (nonatomic, strong) UIView *centerBackView;
@property (nonatomic, strong) UIView *itemBackView;
@property (nonatomic, strong) UIView *lowerBackView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) NSArray *nextArr;

@property (nonatomic, copy) NSString *useridStatus;

@end

@implementation PomeloMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    [self setupSubViews];
    
    [self setupTableView];
    
    // Do any additional setup after loading the view.
}




- (BOOL)loginStatus {
    
    //return [[UserInfoManager shareInstance] userLoginStatus];
    
//    NSString *userpassword = [SSKeychain passwordForService:SERVICEKEYCHAIN account:USERACCOUNT];
//    if ([ECUtil isBlankString:userpassword]) {
//        return NO;
//    }
//    return YES;
    
    NSString *status = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    if ([ECUtil isBlankString:status]) {//空未登录
        return NO;
    }else {
        return YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
    if ([self loginStatus]) {
        NSString *status = [NSString stringWithFormat:@"%@", [NSUserDefaultMemory defaultGetwithUnityKey:USERID]];
        [[HWAFNetworkManager shareManager] userInfo:@{@"userid":status} getUserInfo:^(BOOL success, id  _Nonnull request) {
            NSDictionary *dic = (NSDictionary *)request;
            if (success) {
                self.userInfoModel = [UserInfoModel mj_objectWithKeyValues:dic];
                if (![ECUtil isBlankString:self.userInfoModel.username]) {
                    self.userName.text = self.userInfoModel.username;
                }else {
                    self.userName.text = @"昵称";
                }
                
                if (![ECUtil isBlankString:self.userInfoModel.userprofile]) {
                    self.personalizedLab.text = self.userInfoModel.userprofile;
                }else {
                    self.personalizedLab.text = @"暂无个性签名，添加彰显你的个性";
                }
            }
        }];
    }else {
        self.userName.text = @"登录";
        self.personalizedLab.text = @"暂无个性签名，添加彰显你的个性";
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[ECUtil colorWithHexString:@"4a4a4a"],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
}

- (void)setupSubViews {
    
    CGFloat backHeight = 290;
    CGFloat space = 15;
    
    self.headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, backHeight)];
    [self.view addSubview:self.headBackView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance10, self.headBackView.height - KLineWidthMeasure05, KSCREEN_WIDTH - KSpaceDistance10 * 2, KLineWidthMeasure05)];
    line.backgroundColor = KColor_Line;
    [self.headBackView addSubview:line];
    
    // MARK: top

    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, backHeight / 2)];
    [self.headBackView addSubview:self.topBackView];

    CGFloat height = 20;
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(space, space, SCREENWIDTH / 2, height)];
    self.userName.font = KFontNormalSize18;
    [self.topBackView addSubview:self.userName];

    self.personalizedLab = [[UILabel alloc] initWithFrame:CGRectMake(space, self.userName.bottom + space, SCREENWIDTH * 3 / 5, height)];
    self.personalizedLab.font = KFontNormalSize14;
    [self.topBackView addSubview:self.personalizedLab];
    UITapGestureRecognizer *loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topUnloginAction:)];
    [self.topBackView addGestureRecognizer:loginTap];

    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(space, self.personalizedLab.bottom + space, SCREENWIDTH / 2, height)];
    lab3.font = KFontNormalSize14;
    NSArray *arr1 = @[@"沟通 能力强", @"效率高"];
    NSString *text1 = [arr1 componentsJoinedByString:@" "];
    lab3.text = text1;
    //[self.topBackView addSubview:lab3];

    self.headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - space - 80, space, 80, 80)];
    self.headImgV.image = [UIImage imageNamed:@"touxiang"];
    self.headImgV.userInteractionEnabled = YES;
    self.headImgV.layer.cornerRadius = 40;
    self.headImgV.layer.masksToBounds = YES;
    [self.topBackView addSubview:self.headImgV];
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headBackViewAction:)];
    [self.headImgV addGestureRecognizer:headTap];
    
    // MARK: center
    
    CGFloat width = (KSCREEN_WIDTH - 35 * 2 - 45 * 4) / 5;
    self.itemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, backHeight/2 - backHeight / 4 / 3, KSCREEN_WIDTH, width + 37)];
    [self.headBackView addSubview:self.itemBackView];
    
    NSArray *arr = @[@{@"img":@"kanguowo",@"title":@"看过我"},
                     @{@"img":@"wokanguo",@"title":@"我看过"},
                     @{@"img":@"yishenqing",@"title":@"已报名"},
                     @{@"img":@"daimianshi",@"title":@"待面试"},
                     @{@"img":@"shoucang",@"title":@"收藏"}];

    for (NSInteger i = 0; i < arr.count; i++) {
        ImgTitleView *item = [[ImgTitleView alloc] initWithFrame:CGRectMake(35 + (i % 5) * (width + 45), 0, width, width)];
        item.topImgV.image = [UIImage imageNamed:arr[i][@"img"]];
        item.titleLab.text = arr[i][@"title"];
        item.maskBtn.tag = 1000 + i;
        item.delegate = self;
        [self.itemBackView addSubview:item];
//        item.layer.cornerRadius = 2;
//        item.layer.masksToBounds = YES;
    }
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, self.itemBackView.bottom, KSCREEN_WIDTH - 30, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.headBackView addSubview:line2];
    
    // MARK: lower

    self.lowerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.itemBackView.bottom + 15, KSCREEN_WIDTH , backHeight / 4)];
    [self.headBackView addSubview:self.lowerBackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lowerBackViewTap:)];
    [self.lowerBackView addGestureRecognizer:tap];
    
    UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, self.lowerBackView.height - 10, self.lowerBackView.height)];
    imgV1.image = [UIImage imageNamed:@"touxiangbody"];
    [self.lowerBackView addSubview:imgV1];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(imgV1.right + 15, 0, SCREENWIDTH / 2, 20)];
    lab4.font = KFontNormalSize18;
    lab4.text = @"我的简历";
    [self.lowerBackView addSubview:lab4];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(lab4.left, lab4.bottom + 10, KSCREEN_WIDTH - lab4.left, 15)];
    lab5.textColor = KColor_C8C8C8;
    lab5.font = KFontNormalSize14;
    lab5.text = @"完善简历能提高你的录取率哦";
    [self.lowerBackView addSubview:lab5];
    
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBtn.frame = CGRectMake(self.lowerBackView.width - KSCREEN_WIDTH / 5 - 15, self.lowerBackView.height - 20, KSCREEN_WIDTH / 5, 20);
    goBtn.titleLabel.font = KFontNormalSize14;
    goBtn.layer.cornerRadius = 10;
    goBtn.layer.masksToBounds = YES;
    [self.lowerBackView addSubview:goBtn];
    [goBtn setTitle:@"去完善 >" forState:UIControlStateNormal];
    [goBtn setTintColor:[UIColor whiteColor]];
    goBtn.backgroundColor = [ECUtil colorWithHexString:@"e24e77"];
    //[ECUtil gradientLayer:goBtn startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colorArr1:[UIColor colorWithRed:249/255.0 green:53/255.0 blue:145/255.0 alpha:1] colorArr2:[UIColor colorWithRed:247/255.0 green:106/255.0 blue:172/255.0 alpha:1] location1:0 location2:0];
    
    __weak typeof(self) weakSelf = self;
    [[goBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        
        if ([strongSelf loginStatus]) {
            PomeloMyResumeViewController *resume = [[PomeloMyResumeViewController alloc] init];
            self.navigationController.hidesBottomBarWhenPushed = YES;
            [strongSelf.navigationController pushViewController:resume animated:YES];
        }else {
            PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
            self.navigationController.hidesBottomBarWhenPushed = YES;
            [strongSelf.navigationController pushViewController:login animated:YES];
        }
    }];
    
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.tableHeaderView = self.headBackView;
}


#pragma target action
- (void)centerBtnACtion:(UIButton *)send {
    
    PomeloRecordDefaultViewController *record = [[PomeloRecordDefaultViewController alloc] init];
    record.hidesBottomBarWhenPushed = YES;
    record.typeInteger = send.tag - 666;
    [self.navigationController pushViewController:record animated:YES];
}

#pragma mark target action

- (void)topUnloginAction:(UIGestureRecognizer *)tap {
    if ([self loginStatus]) {
//        PomeloPersonalInfoViewController *info = [[PomeloPersonalInfoViewController alloc] init];
//        info.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:info animated:YES];
        LoginNavigationController *na = [[LoginNavigationController alloc] init];
        //[self.navigationController presentViewController:na animated:YES completion:nil];
    
    }else {
        PomeloLoginViewController *log = [[PomeloLoginViewController alloc] init];
        log.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:log animated:YES];
        //[self presentViewController:log animated:YES completion:nil];
    }
}

- (void)headBackViewAction:(UIButton *)send {
    if ([self loginStatus]) {
        PomeloPersonalInfoViewController *info = [[PomeloPersonalInfoViewController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
    }else {
        PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
}

- (void)lowerBackViewTap:(UIGestureRecognizer *)tap {
    if ([self loginStatus]) {
        PomeloMyResumeViewController *resume = [[PomeloMyResumeViewController alloc] init];
        resume.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:resume animated:YES];
    }else {
        PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }
}

#pragma mark delegate

- (void)ImgTitleViewACtion:(NSInteger)index {
    if ([self loginStatus]) {
        PomeloRecordDefaultViewController *record = [[PomeloRecordDefaultViewController alloc] init];
        record.hidesBottomBarWhenPushed = YES;
        record.typeInteger = index - 1000;
        [self.navigationController pushViewController:record animated:YES];
    }else {
        PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.listArr[indexPath.row][@"title"];
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = KFontNormalSize16;
    cell.imageView.image = [UIImage imageNamed:self.listArr[indexPath.row][@"img"]];
    
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 15 - 15, 17, 12, 16)];
    right.image = [UIImage imageNamed:@"rightjiantou"];
    [cell addSubview:right];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, cell.height + 2, KSCREEN_WIDTH - 30, 0.2)];
    line.backgroundColor = KColor_Line;
    [cell addSubview:line];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[NSClassFromString(self.nextArr[indexPath.row]) alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark getter

- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@{@"img":@"shezhi",@"title":@"设置"},
                     @{@"img":@"lianxiwomen",@"title":@"联系我们"},
                     @{@"img":@"yijianfankui",@"title":@"意见反馈"},
                     @{@"img":@"guanyuwomen",@"title":@"关于我们"}];
    }
    return _listArr;
}

- (NSArray *)nextArr {
    if (!_nextArr) {
        _nextArr = @[@"PomeloSetViewController", @"PomeloRelationUsViewController", @"PomeloCoupleBackViewController", @"PomeloAboutUsViewController"];
    }
    return _nextArr;
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
