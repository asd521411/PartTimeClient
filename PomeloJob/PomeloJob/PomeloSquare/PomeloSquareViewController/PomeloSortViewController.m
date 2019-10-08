//
//  PomeloSortViewController.m
//  AvengerAgent
//
//  Created by 草帽~小子 on 2018/9/25.
//  Copyright © 2018年 meiliwu. All rights reserved.
//

#import "PomeloSortViewController.h"
#import "PomeloLocationTableViewCell.h"
#import "ECUtil.h"
#import "ECStyle.h"

@interface PomeloSortViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableViewArr;
@property (nonatomic, assign) NSInteger selectInteger;

@end

@implementation PomeloSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self configSubView];
    
    // Do any additional setup after loading the view.
}

- (void)configSubView {
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 152)];
    back.backgroundColor = [ECUtil colorWithHexString:@"fafafa"];
    [self.view addSubview:back];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, back.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = YES;
    [back addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PomeloLocationTableViewCell class] forCellReuseIdentifier:@"PomeloLocationTableViewCell"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PomeloLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PomeloLocationTableViewCell"];
    cell.titleLab.text = self.tableViewArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentSelectItemTitle) {
        self.currentSelectItemTitle(self.tableViewArr[indexPath.row]);
    }
}

- (NSMutableArray *)tableViewArr {
    if (!_tableViewArr) {
        _tableViewArr = [[NSMutableArray alloc] initWithObjects:@"默认排序",@"最新发布",@"薪酬最高", nil];
    }
    return _tableViewArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
