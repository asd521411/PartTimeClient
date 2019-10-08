//
//  PomeloFiltrateViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloFiltrateViewController.h"
#import "PomeloLocationTableViewCell.h"


@interface PomeloFiltrateViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableViewArr;
@property (nonatomic, assign) NSInteger selectInteger;

@end

@implementation PomeloFiltrateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
