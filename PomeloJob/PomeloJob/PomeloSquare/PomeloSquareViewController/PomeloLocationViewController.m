//
//  PomeloLocationViewController.m
//  AvengerAgent
//
//  Created by 草帽~小子 on 2018/9/25.
//  Copyright © 2018年 meiliwu. All rights reserved.
//

#import "PomeloLocationViewController.h"
#import "PomeloLocationTableViewCell.h"
#import "ECUtil.h"
#import "ECStyle.h"
//#import "AppCache.h"
//#import "AppHttpClient.h"
//#import "EBAlert.h"
//#import "ECLoadingView.h"
//#import "RegionModel.h"

@interface PomeloLocationViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) NSMutableArray *dataArr1;
@property (nonatomic, strong) NSMutableArray *dataArr2;
@property (nonatomic, assign) NSInteger selectInteger1;
@property (nonatomic, assign) NSInteger selectInteger2;
@property (nonatomic, strong) NSMutableArray *regionArr;
@property (nonatomic, strong) NSMutableArray *subwayArr;

@end

@implementation PomeloLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic = @{@"北京":@[@"全北京", @"海淀区",@"朝阳区",@"西城区",@"东城区",@"大兴区",@"顺义区",@"丰台区",@"昌平区"],
                      @"安徽":@[@"全安徽", @"安徽1", @"安徽2"],
                      @"重庆":@[@"全重庆", @"重庆1",@"重庆2"]};
    
    self.dataArr1 = [[NSMutableArray alloc] initWithArray:dic.allKeys];
    NSArray *arr = [[NSMutableArray alloc] initWithArray:dic.allValues];
    self.dataArr2 = [[NSMutableArray alloc] initWithArray:arr[0]];
    
    [self configSubViews];
    
    [self loadData];
    
    
    // Do any additional setup after loading the view.
}

- (void)loadData {
    

}


- (void)configSubViews {
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.width / 2, 500 - 40) style:UITableViewStylePlain];
    self.tableView1.backgroundColor = [ECUtil colorWithHexString:@"fefefe"];
    self.tableView1.dataSource = self;
    self.tableView1.delegate = self;
    self.tableView1.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView1];
    [self.tableView1 registerClass:[PomeloLocationTableViewCell class] forCellReuseIdentifier:@"PomeloLocationTableViewCell"];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(self.tableView1.right, 40, self.view.width / 2, 500 - 40) style:UITableViewStylePlain];
    self.tableView2.backgroundColor = [ECUtil colorWithHexString:@"fafafa"];
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView2.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView2];
    [self.tableView2 registerClass:[PomeloLocationTableViewCell class] forCellReuseIdentifier:@"PomeloLocationTableViewCell"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView1.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView2.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tableView1 == tableView) {
        return self.dataArr1.count;
    }else if (self.tableView2 == tableView) {
        return self.dataArr2.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PomeloLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PomeloLocationTableViewCell"];
    
    if (self.tableView1 == tableView) {
//        if (self.selectInteger1 == indexPath.row) {
//            cell.titleLab.textColor = [ECUtil colorWithHexString:@"266835"];
//        }else {
//            cell.titleLab.textColor = [ECUtil colorWithHexString:@"333333"];
//        }
//        cell.backgroundColor = [ECUtil colorWithHexString:@"fefefe"];
        cell.titleLab.text = self.dataArr1[indexPath.row];
        
    }else if (self.tableView2 == tableView) {
//        if (self.selectInteger2 == indexPath.row) {
//            cell.titleLab.textColor = [ECUtil colorWithHexString:@"266835"];
//        }else {
//            cell.titleLab.textColor = [ECUtil colorWithHexString:@"333333"];
//        }
//        cell.backgroundColor = [ECUtil colorWithHexString:@"fafafa"];
        cell.titleLab.text = self.dataArr2[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView1 == tableView) {
        if (indexPath.row == 0) {
            if (self.currentSelectItemLevel1) {
                self.currentSelectItemLevel1(@"name");
            }
        }
    }else if (self.tableView2 == tableView) {
        if (self.currentSelectItemLevel2) {
            self.currentSelectItemLevel2(@"重庆");
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView1 == tableView) {
        PomeloLocationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.titleLab.textColor = [ECUtil colorWithHexString:@"333333"];

    }else if (self.tableView2 == tableView) {
        PomeloLocationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.titleLab.textColor = [ECUtil colorWithHexString:@"333333"];

    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}




- (NSMutableArray *)dataArr1 {
    if (!_dataArr1) {
        _dataArr1 = [[NSMutableArray alloc] init];
    }
    return _dataArr1;
}

- (NSMutableArray*)dataArr2 {
    if (!_dataArr2) {
        _dataArr2 = [[NSMutableArray alloc] init];
    }
    return _dataArr2;
}


- (NSMutableArray *)regionArr {
    if (!_regionArr) {
        _regionArr = [[NSMutableArray alloc] init];
    }
    return _regionArr;
}

- (NSMutableArray *)subwayArr {
    if (!_subwayArr) {
        _subwayArr = [[NSMutableArray alloc] init];
    }
    return _subwayArr;
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
