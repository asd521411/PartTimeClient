//
//  DiscoveryViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "HeadTapV.h"
#import "CommonViewController.h"
#import "MJRefresh.h"

@interface DiscoveryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
   
    // Do any additional setup after loading the view.
}

- (void)loadData {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        
    }];
    
}

- (void)setupSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 3;
    }else if (section == 2) {
        return 5;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"游戏兼职赚钱，足不出户，结算靠谱";
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NSArray *arr = @[@{@"title":@"热门岗位"}, @{@"title":@"今日急聘"}, @{@"title":@"本周热门"}];
    
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        HeadTapV *tap = [[HeadTapV alloc] init];
        tap.leftLab.text = arr[i][@"title"];
        [mutArr addObject:tap];
        tap.rightBtn.tag = 888 + i;
        tap.headTapVAction = ^(NSInteger index) {
        };
    }
    
    if (section == 0) {
        return mutArr[0];
    }else if (section == 1) {
        return mutArr[1];
    }else if (section == 2) {
        return mutArr[2];
    }else {
        return mutArr[0];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    }else if (indexPath.section == 1) {
        return 100;
    }else {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonViewController *com = [[CommonViewController alloc] init];
    [self.navigationController pushViewController:com animated:YES];
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