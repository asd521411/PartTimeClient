//
//  YNSuspendTopPauseBaseTableViewVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/7/14.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNSuspendTopPauseBaseTableViewVC.h"
#import "MJRefresh.h"
#import "BaseViewController.h"
#import "UIViewController+YNPageExtend.h"
#import "YNPageTableView.h"
#import "CommonTableViewCell.h"
#import "CommonDetailsViewController.h"

#define kCellHeight 80

@interface YNSuspendTopPauseBaseTableViewVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL upOrDown;

@end

@implementation YNSuspendTopPauseBaseTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"reloadData" object:nil];
    
    [self.tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"id"];
    [self.view addSubview:self.tableView];
    
    _dataArray = @[].mutableCopy;
    
    [self loadData];
    
    [self addTableViewRefresh];
}

- (void)reloadData:(NSNotificationCenter *)info {
    [self loadData];
}

- (void)loadData {
    //加载数据
    self.upOrDown = YES;
    self.page = 1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *para1 = @{@"positionStatus":self.cellTitle, @"page":@(self.page)};
        [[HWAFNetworkManager shareManager] position:para1 postion:^(BOOL success, id  _Nonnull request) {
            NSArray *resultArr = request[@"resultList"];
            if (success) {
                [self.dataArray removeAllObjects];
                self.dataArray = [CommonModel mj_objectArrayWithKeyValuesArray:resultArr];
                [self.tableView reloadData];
            }
        }];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)addTableViewRefresh {
    __weak typeof (self) weakSelf = self;
    // 这里加 footer 刷新
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.upOrDown == YES) {
                self.page = 2;
            }
            NSDictionary *para1 = @{@"positionStatus":self.cellTitle, @"page":@(self.page)};
            [[HWAFNetworkManager shareManager] position:para1 postion:^(BOOL success, id  _Nonnull request) {
                NSArray *resultArr = request[@"resultList"];
                if (success) {
                    if (resultArr.count > 0) {
                        NSArray *arr = [CommonModel mj_objectArrayWithKeyValuesArray:resultArr];;
                        [weakSelf.dataArray addObjectsFromArray:arr];
                        weakSelf.page++;
                        weakSelf.upOrDown = NO;
                    }else {
//                        [SVProgressHUD showWithStatus:@"无更多数据"];
//                        [SVProgressHUD dismissWithDelay:1];
                    }
                }else {
                    
                }
            }];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        });
    }];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        return kCellHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (indexPath.row < self.dataArray.count) {
        cell.commonModel = self.dataArray[indexPath.row];
        return cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
    CommonModel *model = self.dataArray[indexPath.row];
    detail.clickStyleStr = self.cellTitle;
    detail.positionid = model.positionid;
    detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[YNPageTableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
