//
//  CommonViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonTableViewCell.h"
#import "CommonDetailsViewController.h"
#import "CommonModel.h"

@interface CommonViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *commonTableV;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) BOOL upOrDown;

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    
    [self setupSubViews];
    [self tableViewRefresh];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDictionary *para = @{@"adtype":self.titleStr,
                           @"adindex":@"0",//0 表示当前选择类型
                           @"phonecard":[ECUtil getIDFA]};
    [[HWAFNetworkManager shareManager] clickOperation:para advertismentclick:^(BOOL success, id  _Nonnull request) {
        if (success) {
        }
    }];
    
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
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.commonTableV.mj_header endRefreshing];
    [self.commonTableV.mj_footer endRefreshing];
}

- (void)setupSubViews {
    self.commonTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.commonTableV.delegate = self;
    self.commonTableV.dataSource = self;
    self.commonTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.commonTableV];
    [self.commonTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
    
//    if (@available(iOS 11.0, *)) {
//        self.commonTableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
}

- (void)tableViewRefresh {
    self.commonTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDown = YES;
        [self loadData];
    }];
    [self.commonTableV.mj_header beginRefreshing];
    
    self.commonTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.upOrDown = NO;
        [self loadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listArr.count == 0) {
        return 1;
    }
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArr.count > 0) {
        CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
        cell.commonModel = self.listArr[indexPath.row];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.textLabel.text = @"无数据";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
    CommonModel *model = self.listArr[indexPath.row];
    detail.positionid = model.positionid;
    detail.clickStyleStr = self.titleStr;
    detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];//点击数记录是从1开始，0表示当前整个类型
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)loadData {
    NSDictionary *para = @{@"positionStatus":self.titleStr};
    [[HWAFNetworkManager shareManager] position:para postion:^(BOOL success, id  _Nonnull request) {
        NSArray *arr = request;
        if (success) {
            if (self.upOrDown == YES) {
                [self.listArr removeAllObjects];
                self.listArr = [CommonModel mj_objectArrayWithKeyValuesArray:arr];
                [self.commonTableV reloadData];
            }else {
                
            }
            [self.commonTableV.mj_header endRefreshing];
            [self.commonTableV.mj_footer endRefreshing];
        }
        [self.commonTableV.mj_header endRefreshing];
        [self.commonTableV.mj_footer endRefreshing];
    }];
}

- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
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
