//
//  PomeloDiscoveryViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloDiscoveryViewController.h"
#import "HeadTapV.h"
#import "CommonViewController.h"
#import "MJRefresh.h"
#import "CommonModel.h"
#import "PomeloHotPositionTableViewCell.h"
#import "CommonTableViewHeaderFooterView.h"
#import "CommonDetailsViewController.h"
#import "PomeloFastPositionTableViewCell.h"
#import "CommonTableViewCell.h"
#import "DiscoveryRankTableViewCell.h"

@interface PomeloDiscoveryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionTitleArr;
@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *hotweekPosition;
@property (nonatomic, strong) NSMutableArray *fastPosition;
@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) NSMutableArray *hotPosition;
@property (nonatomic, assign) BOOL upOrDown;
@property (nonatomic, assign) NSInteger colorCount;

@end

@implementation PomeloDiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    [self tableViewRefresh];
   
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)tableViewRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDown = YES;
        [self loadData];
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        self.upOrDown = NO;
        [self loadData];
    }];
}

- (void)loadData {
    [[HWAFNetworkManager shareManager] discover:@{} defaultFound:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            if (self.upOrDown) {
                
                [self.sectionArr removeAllObjects];
                [self.hotPosition removeAllObjects];
                [self.hotweekPosition removeAllObjects];
                [self.fastPosition removeAllObjects];
                
                self.hotPosition = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"hotPosition"]];
                self.hotweekPosition = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"hotweekPosition"]];
                self.fastPosition = [CommonModel mj_objectArrayWithKeyValuesArray:dic[@"fastPosition"]];
                
                [self.sectionArr addObject:self.hotPosition];
                [self.sectionArr addObject:self.fastPosition];
                [self.sectionArr addObject:self.hotweekPosition];
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
                
            }else {
                
            }
        }
    }];
    [self.tableView.mj_header endRefreshing];
}

- (void)setupSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[CommonTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"CommonTableViewHeaderFooterView"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1 ;
    }else if (section == 1) {
        if (self.fastPosition.count > 3) {
            return 3;
        }else {
            return self.fastPosition.count;
        }
    }else if (section == 2) {
        return self.hotweekPosition.count;
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommonTableViewHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CommonTableViewHeaderFooterView"];
    head.titleLab.text = self.sectionTitleArr[section][@"title"];
    head.turnImgV.image = [UIImage imageNamed:self.sectionTitleArr[section][@"img"]];
    head.commonHeaderActionBlock = ^{
        CommonViewController *com = [[CommonViewController alloc] init];
        com.titleStr = self.sectionTitleArr[section][@"title"];
        [self.navigationController pushViewController:com animated:YES];
    };
    return head;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"无数据";
    if (indexPath.section == 0) {
        PomeloHotPositionTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"PomeloHotPositionTableViewCell"];
        if (!cell1) {
            cell1 = [[PomeloHotPositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PomeloHotPositionTableViewCell"];
        }
        cell1.cellArr = self.hotPosition;
        __weak typeof(self) weakSelf = self;
        cell1.collectionDidSelectItemBlock = ^(CommonModel * _Nonnull common, NSInteger integer) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
            detail.positionid = common.positionid;
            detail.clickStyleStr = @"热门岗位";
            detail.indexStr = [NSString stringWithFormat:@"%ld", (long)integer];
            [strongSelf.navigationController pushViewController:detail animated:YES];
        };
        return cell1;
    }else if (indexPath.section == 1) {
        PomeloFastPositionTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"PomeloFastPositionTableViewCell"];
        if (!cell2) {
            cell2 = [[PomeloFastPositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PomeloFastPositionTableViewCell"];
        }
        if (self.fastPosition.count > indexPath.row) {
            cell2.commonModel = self.fastPosition[indexPath.row];
            if (indexPath.row == 0) {
                cell2.backImgV.image = [UIImage imageNamed:self.colorArr[0]];
            }else if (indexPath.row == 1) {
                cell2.backImgV.image = [UIImage imageNamed:self.colorArr[1]];
            }else {
                cell2.backImgV.image = [UIImage imageNamed:self.colorArr[2]];
            }
        }
        return cell2;
    }else if (indexPath.section == 2) {
//        CommonTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
//        if (!cell3) {
//            cell3 = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonTableViewCell"];
//        }
//        if (self.hotweekPosition.count > indexPath.row) {
//            cell3.commonModel = self.hotweekPosition[indexPath.row];
//        }
        DiscoveryRankTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"DiscoveryRankTableViewCell"];
        if (!cell3) {
            cell3 = [[DiscoveryRankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DiscoveryRankTableViewCell"];
        }
        if (self.hotweekPosition.count > indexPath.row) {
            cell3.commonModel = self.hotweekPosition[indexPath.row];
            cell3.rankNum.text = [@"NO ." stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)indexPath.row+1]];
//            if (indexPath.row == 0) {
//                cell3.rankImgV.image = [UIImage imageNamed:@""];
//            }else if (indexPath.row == self.hotweekPosition.count - 1) {
//                cell3.rankImgV.image = [UIImage imageNamed:@""];
//            }else {
//                cell3.rankImgV.image = [UIImage imageNamed:@" "];
//            }
        }
        return cell3;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 130;
    }else if (indexPath.section == 1) {
        return 100;
    }else {
        return 80;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
    if (indexPath.section == 1) {
        CommonModel *model = self.fastPosition[indexPath.row];
        detail.positionid = model.positionid;
        detail.clickStyleStr = self.sectionTitleArr[indexPath.section][@"title"];
        detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    }else if (indexPath.section == 2) {
        CommonModel *model = self.hotweekPosition[indexPath.row];
        detail.positionid = model.positionid;
        detail.clickStyleStr = self.sectionTitleArr[indexPath.section][@"title"];
        detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSMutableArray *)sectionArr {
    if (!_sectionArr) {
        _sectionArr = [[NSMutableArray alloc] init];
    }
    return _sectionArr;
}

- (NSMutableArray *)hotPosition {
    if (!_hotPosition) {
        _hotPosition = [[NSMutableArray alloc] init];
    }
    return _hotPosition;
}

- (NSArray *)colorArr {
    if (!_colorArr) {
        _colorArr = @[@"faxiancell1", @"faxiancell2", @"faxiancell3"];
    }
    return _colorArr;
}

- (NSMutableArray *)hotweekPosition {
    if (!_hotweekPosition) {
        _hotweekPosition = [[NSMutableArray alloc] init];
    }
    return _hotweekPosition;
}

- (NSMutableArray *)fastPosition {
    if (!_fastPosition) {
        _fastPosition = [[NSMutableArray alloc] init];
    }
    return _fastPosition;
}

- (NSArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr = @[@{@"title":@"热门岗位", @"img":@"remengangwei"}, @{@"title":@"今日急聘", @"img":@"jinrijipin"}, @{@"title":@"本周热门", @"img":@"remengangwei"}];
    }
    return _sectionTitleArr;
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
