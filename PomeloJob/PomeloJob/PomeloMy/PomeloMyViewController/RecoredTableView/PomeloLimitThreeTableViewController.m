//
//  PomeloLimitThreeTableViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/12.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloLimitThreeTableViewController.h"
#import "CommonTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "CommonDetailsViewController.h"
#import "NoneTableViewCell.h"

@interface PomeloLimitThreeTableViewController ()

@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) BOOL upOrDown;

@end

@implementation PomeloLimitThreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的报名";
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
    
    [self tableViewRefresh];
    
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark - Table view data source


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    __weak typeof(self) weakSelf = self;
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView.mj_header endRefreshing];
}

- (void)tableViewRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDown = YES;
        [self loadData];
    }];
    
//    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//        self.upOrDown = NO;
//        [self loadData];
//    }];
}


- (void)loadData {
    
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"userid":[ECUtil isBlankString:userid]?@"":userid, @"relationtype":@"已报名"};
    [[HWAFNetworkManager shareManager] userLimitPositionRequest:para userPosition:^(BOOL success, id  _Nonnull request) {
        if (success) {
            NSArray *dicArr = request;
            if (self.upOrDown) {
                [self.listArr removeAllObjects];
                self.listArr = [CommonModel mj_objectArrayWithKeyValuesArray:dicArr];
            }else {
                self.listArr = [CommonModel mj_objectArrayWithKeyValuesArray:dicArr];
            }
            [self.tableView reloadData];
        }
    }];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listArr.count > 0) {
        return self.listArr.count;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArr.count > 0) {
        CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
        cell.commonModel = self.listArr[indexPath.row];
        return cell;
    }else {
        NoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoneTableViewCell"];
        if (!cell) {
            cell = [[NoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoneTableViewCell"];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArr.count > 0) {
        return 80;
    }else {
        return KSCREEN_HEIGHT;
    }
}

- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
