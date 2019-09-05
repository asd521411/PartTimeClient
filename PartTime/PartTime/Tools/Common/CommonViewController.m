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

@interface CommonViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *commonTableV;
@property (nonatomic, strong) NSArray *listArr;

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.commonTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.commonTableV.delegate = self;
    self.commonTableV.dataSource = self;
    [self.view addSubview:self.commonTableV];
    [self.commonTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    cell.tagImgV.image = [UIImage imageNamed:@""];
    cell.titleLab.text = @"大望路服务员收银员";
    cell.locationLab.text = @"朝阳";
    cell.accountStyleLab.text = @"月结";
    cell.princeLab.text = @"180/天";
    cell.tagLab.text = @"可长期";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

//- (NSArray *)listArr {
//    if (!_listArr) {
//        _listArr = [NSArray alloc] initWithObjects:<#(nonnull id), ...#>, nil;
//    }
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
