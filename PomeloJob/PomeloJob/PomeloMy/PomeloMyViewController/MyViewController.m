//
//  MyViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "MyViewController.h"
#import "PomeloSetViewController.h"
#import "PomeloRecordDefaultViewController.h"
#import "ReactiveCocoa.h"
#import "PomeloMyResumeViewController.h"
#import "PomeloPersonalInfoViewController.h"
#import "PomeloLoginViewController.h"
#import "ImgTitleView.h"
#import "UserInfoModel.h"
#import "SSKeychain.h"
#import "LoginViewController.h"
#import "LoginNavigationController.h"
#import "HeadBackView.h"
#import "CompleteTableViewCell.h"
#import "MyResumeViewController.h"
#import "ChangePersonInfoViewController.h"
#import "MyWeChatTableViewCell.h"
#import "UserInfoModel.h"
#import "UIButton+WebCache.h"
#import "PomeloLimitThreeTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "YUXPWkWebViewController.h"

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource, HeadBackViewDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) HeadBackView *headBackView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, copy) NSString *resumecompleteness;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (BOOL)loginStatus {
    NSString *userid = [NSString stringWithFormat:@"%@", [NSUserDefaultMemory defaultGetwithUnityKey:USERID]];
    if ([ECUtil isBlankString:userid]) {//空未登录
        return NO;
    }else {
        return YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];//去线
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:kColor_Main];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
    if ([self loginStatus]) {
        
        NSString *userid = [NSString stringWithFormat:@"%@", [NSUserDefaultMemory defaultGetwithUnityKey:USERID]];
        NSDictionary *para = @{@"userid":userid};
        
        [[HWAFNetworkManager shareManager] userInfo:para queryMymine:^(BOOL success, id  _Nonnull request) {
            if (success) {
                if ([request[@"status"] integerValue] == 200) {
//                    [SVProgressHUD showWithStatus:request[@""]];
//                    [SVProgressHUD dismissWithDelay:1];
                    if ([ECUtil isBlankString:request[@"body"][@"resumecompleteness"]]) {
                         self.resumecompleteness = @"0%";
                    }else {
                        self.resumecompleteness = request[@"body"][@"resumecompleteness"];
                        
                    }
                    
                    if (![ECUtil isBlankString:request[@"body"][@"name"]]) {
                        self.headBackView.modificationControl.nameStr = request[@"body"][@"name"];
                    }else {
                        self.headBackView.modificationControl.nameStr = [NSUserDefaultMemory defaultGetwithUnityKey:USERNAME];
                    }
                    
                    if (![ECUtil isBlankString:request[@"body"][@"userimg"]]) {
                        [self.headBackView.portraitImgV sd_setImageWithURL:[NSURL URLWithString:request[@"body"][@"userimg"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"portraitImgV"]];
                    }else {
                        [self.headBackView.portraitImgV sd_setImageWithURL:[NSURL URLWithString:[NSUserDefaultMemory defaultGetwithUnityKey:USERIMG]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"portraitImgV"]];
                    }
                    
                }
                [self.tableView reloadData];
            }
        }];
        
        self.headBackView.infoType = InforTypeOn_Line;
        [self.tableView reloadData];
    }else {
        self.headBackView.infoType = InforTypeOff_Line;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[ECUtil colorWithHexString:@"4a4a4a"], NSForegroundColorAttributeName, KFontNormalSize18, NSFontAttributeName,nil]];
}

- (void)setupSubViews {
    [self.view addSubview:self.headBackView];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headBackView;
}

#pragma mark action

#pragma mark HeadView Delegate
- (void)gotoLogin {
    LoginViewController *log = [[LoginViewController alloc] init];
    LoginNavigationController *na = [[LoginNavigationController alloc] initWithRootViewController:log];
    na.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:na animated:YES completion:nil];
}

- (void)changeInfoMessage {
    ChangePersonInfoViewController *change = [[ChangePersonInfoViewController alloc] init];
    change.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:change animated:YES];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return self.listArr.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (indexPath.section == 0) {
        CompleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompleteTableViewCell"];
        if ([self.resumecompleteness isEqualToString:@"100%"]) {
            cell.percentImgV.image = [UIImage imageNamed:@"persent4"];
        }else if ([self.resumecompleteness isEqualToString:@"60%"]){
            cell.percentImgV.image = [UIImage imageNamed:@"persent3"];
        }else if ([self.resumecompleteness isEqualToString:@"30%"]){
            cell.percentImgV.image = [UIImage imageNamed:@"persent2"];
        }else{
            cell.percentImgV.image = [UIImage imageNamed:@"persent1"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        cell.textLabel.text = self.listArr[indexPath.row][@"title"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = KFontNormalSize18;
        cell.textLabel.textColor = [ECUtil colorWithHexString:@"4a4a4a"];
        cell.imageView.image = [UIImage imageNamed:self.listArr[indexPath.row][@"img"]];
        UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 15 - 15, 17, 12, 16)];
        right.image = [UIImage imageNamed:@"rightjiantou"];
        [cell addSubview:right];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, cell.height + 2, KSCREEN_WIDTH - 30, 0.2)];
        line.backgroundColor = KColor_Line;
        [cell addSubview:line];
        return cell;
    }else {
        MyWeChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyWeChatTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 102;
    }else if (indexPath.section == 1) {
        return 44;
    }else {
        return 150;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([self loginStatus]) {
            MyResumeViewController *resume = [[MyResumeViewController alloc] init];
            resume.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:resume animated:YES];
        }else {
            LoginViewController *log = [[LoginViewController alloc] init];
            LoginNavigationController *na = [[LoginNavigationController alloc] initWithRootViewController:log];
            na.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:na animated:YES completion:nil];
        }
    }
    if (indexPath.section == 1) {
        if ([self loginStatus]) {
            UIViewController *vc = [[NSClassFromString(self.listArr[indexPath.row][@"vcname"]) alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            if (indexPath.row == 3) {
                YUXPWkWebViewController *hw = (YUXPWkWebViewController *)vc;
                hw.urls = @"http://114.116.230.97:8888/public/public.html";
                hw.titleStr = @"商务洽谈";
                [self.navigationController pushViewController:hw animated:YES];
            }else {
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else {
            LoginViewController *log = [[LoginViewController alloc] init];
            LoginNavigationController *na = [[LoginNavigationController alloc] initWithRootViewController:log];
            na.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:na animated:YES completion:nil];
        }
    }
    if (indexPath.section == 2) {
        
//        if ([self loginStatus]) {
//
//        }else {
//            LoginViewController *log = [[LoginViewController alloc] init];
//            LoginNavigationController *na = [[LoginNavigationController alloc] initWithRootViewController:log];
//            na.modalPresentationStyle = UIModalPresentationFullScreen;
//            [self presentViewController:na animated:YES completion:nil];
//        }
        
    }
    
}

#pragma mark getter

- (HeadBackView *)headBackView {
    if (_headBackView == nil) {
        CGFloat imgH = 150;//(KSCREEN_WIDTH * 280/750);
        _headBackView = [[HeadBackView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, imgH)];
        _headBackView.infoType = InforTypeOff_Line;
        _headBackView.delegate = self;
    }
    return _headBackView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[CompleteTableViewCell class] forCellReuseIdentifier:@"CompleteTableViewCell"];
        [_tableView registerClass:[MyWeChatTableViewCell class] forCellReuseIdentifier:@"MyWeChatTableViewCell"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@{@"img":@"wodebaoming",@"title":@"我的报名", @"vcname":@"PomeloLimitThreeTableViewController"},
                     @{@"img":@"wodeshoucang",@"title":@"我的收藏", @"vcname":@"MyCollectResignViewController"},
                     @{@"img":@"shezhi",@"title":@"设      置", @"vcname":@"PomeloSetViewController"},
                     @{@"img":@"shangwuqitan",@"title":@"商务洽谈", @"vcname":@"YUXPWkWebViewController"}];
    }
    return _listArr;
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
