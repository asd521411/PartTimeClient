//
//  SortViewController.m
//  AvengerAgent
//
//  Created by 草帽~小子 on 2018/9/25.
//  Copyright © 2018年 meiliwu. All rights reserved.
//

#import "SortViewController.h"
#import "LocationTableViewCell.h"
#import "ECUtil.h"
#import "ECStyle.h"

@interface SortViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableViewArr;
@property (nonatomic, assign) NSInteger selectInteger;

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    
    [self configSubView];
    
    // Do any additional setup after loading the view.
}

- (void)configSubView {
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, 200)];
    back.backgroundColor = [ECUtil colorWithHexString:@"fafafa"];
    [self.view addSubview:back];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, back.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = YES;
    [back addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LocationTableViewCell class] forCellReuseIdentifier:@"LocationTableViewCell"];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationTableViewCell"];
    cell.titleLab.text = self.tableViewArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView == tableView) {
        if (self.currentSelectItemTitle) {
            self.currentSelectItemTitle(self.tableViewArr[indexPath.row]);
        }
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
