//
//  SetViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) NSArray *nextArr;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIButton *exit = [UIButton buttonWithType:UIButtonTypeCustom];
    exit.frame = CGRectMake(SCREENWIDTH / 3, 500, SCREENWIDTH / 3, 50);
    exit.backgroundColor = [HWRandomColor randomColor];
    exit.layer.cornerRadius = 5;
    exit.layer.masksToBounds = YES;
    [self.tableView addSubview:exit];
    [exit setTitle:@"退出登录" forState:UIControlStateNormal];
    [exit addTarget:self action:@selector(exitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 2;
//    }else if (section == 1) {
//        return 3;
//    }else {
//        return 1;
//    }
    NSArray *arr = self.listArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.listArr[indexPath.section][indexPath.row];
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            //cell
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
    v.backgroundColor = LIGHTGRAYCOLOR;
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
                     @[@"ChangeBindingPNViewController", @"ChangePasswordViewController"],
                     @[@"NotificationViewController", @" ", @" "],
                     @[@"PrivacyPolicyViewController"]];
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
