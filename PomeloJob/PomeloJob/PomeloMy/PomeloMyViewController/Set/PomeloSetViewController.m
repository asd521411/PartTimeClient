//
//  PomeloSetViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloSetViewController.h"

@interface PomeloSetViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) NSArray *nextArr;

@end

@implementation PomeloSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIButton *exit = [UIButton buttonWithType:UIButtonTypeCustom];
    exit.frame = CGRectMake(95,  self.tableView.height - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight] - 100, KSCREEN_WIDTH - 95 * 2, 44);
    exit.layer.cornerRadius = 22;
    exit.layer.masksToBounds = YES;
    [self.tableView addSubview:exit];
    [exit setTitle:@"退出登录" forState:UIControlStateNormal];
    [ECUtil gradientLayer:exit startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [exit addTarget:self action:@selector(exitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.listArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.listArr[indexPath.section][indexPath.row];
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = KFontNormalSize14;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
        }else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [ECUtil colorWithHexString:@"f8f8f8"];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[NSClassFromString(self.nextArr[indexPath.section][indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)exitBtnAction:(UIButton *)send {
    [NSUserDefaultMemory defaultSetMemory:@"" unityKey:USERID];
    if ([[UserInfoManager shareInstance] exit]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@[@"修改绑定手机",@"修改密码"],
                     @[@"通知提醒", @"隐藏简历", @"清除缓存"],
                     @[@"隐私协议"]
                     ];
    }
    return _listArr;
}

- (NSArray *)nextArr {
    if (!_nextArr) {
        _nextArr = @[
                     @[@"PomeloChangeBindingPNViewController", @"PomeloChangePasswordViewController"],
                     @[@"PomeloNotificationViewController", @" ", @" "],
                     @[@"PomeloPrivacyPolicyViewController"]];
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
