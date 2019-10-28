//
//  MyResignViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "MyCollectResignViewController.h"
#import "CollectionTableViewCell.h"
#import "CommonTableViewCell.h"
#import "NoneTableViewCell.h"

@interface MyCollectResignViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) BOOL upOrDown;

@end

@implementation MyCollectResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    
    [self setupSubViews];
    
    [self tableViewRefresh];
    [self.tableView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[ECUtil colorWithHexString:@"4a4a4a"],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
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
    [self.tableView.mj_header endRefreshing];
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
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
    NSDictionary *para = @{@"userid":[ECUtil isBlankString:userid]?@"":userid, @"relationtype":@"收藏"};
    [[HWAFNetworkManager shareManager] userLimitPositionRequest:para userPosition:^(BOOL success, id  _Nonnull request) {
        NSLog(@"===============%@", request);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listArr.count > 0) {
        return self.listArr.count;
    }else {
        return 1;
    }
    //return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArr.count > 0) {
        return 80;
    }else {
        return self.tableView.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     if (self.listArr.count > 0) {
           CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
           cell.commonModel = self.listArr[indexPath.row];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", self.listArr[indexPath.row]];
           return cell;
       }else {
           NoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoneTableViewCell"];
           if (!cell) {
               cell = [[NoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoneTableViewCell"];
           }
           return cell;
       }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CommonModel *model = self.listArr[indexPath.row];
        NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
        NSDictionary *para = @{@"userid":userid?@"":userid,@"positionid":model.positionid, @"relationtype":@"已收藏"};
        [[HWAFNetworkManager shareManager] position:para deleteuserposition:^(BOOL success, id  _Nonnull request) {
            if (success) {
                [SVProgressHUD showInfoWithStatus:request[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                if ([request[@"status"] integerValue] == 200) {
                    [self.listArr removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];
                }
            }
        }];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

//-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//    }];
//    rowAction.backgroundColor = kColor_Main;
//    NSArray *arr = @[rowAction];
//    return arr;
//}

//结束编辑左滑删除

//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"======左滑结束");
////    [self.listArr removeObjectAtIndex:indexPath.row];
////
////    [self.tableView reloadData];
//}

//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
//     if (@available(iOS 11.0, *)) {
//            UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"订单提醒" message:@"确定要删除该订单吗?" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    //                [self.dataArr removeObjectAtIndex:indexPath.section];
//    //                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//
//                    [self.listArr removeObjectAtIndex:indexPath.row];
//                    [self.tableView reloadData];
//
//                    completionHandler(YES);
//
//                }];
//
//            }];
//        }
//    return de
//}

//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
//    //删除
//
//}
                                      
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-[ECStyle navigationbarHeight]-[ECStyle tabbarExtensionHeight]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[CollectionTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
    }
    return _tableView;
}

- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
//        for (int i = 0; i < 20; i++) {
//            [_listArr addObject:[NSString stringWithFormat:@"%d", i]];
//        }
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
