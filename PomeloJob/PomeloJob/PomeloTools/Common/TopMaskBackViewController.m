//
//  TopMaskBackViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/10.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "TopMaskBackViewController.h"

@interface TopMaskBackViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, copy) NSString *ageStr;

@end

@implementation TopMaskBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    [self setupSubViews];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    CGFloat wid = KSCREEN_WIDTH - 60;
    CGFloat hei = wid * 259 / 319;
    
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 112, wid, hei)];
    backImgV.image = [UIImage imageNamed:@"pastebackimg"];
    backImgV.userInteractionEnabled = YES;
    [self.view addSubview:backImgV];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, backImgV.width, backImgV.height - 100) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [backImgV addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(backImgV.left, backImgV.bottom + 30, backImgV.width / 2 - 40, 44);
    btn1.backgroundColor = [UIColor colorWithRed:70/255.0 green:222/255.0 blue:160/255.0 alpha:1];
    [self.view addSubview:btn1];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.topMaskBackViewBlock) {
            strongSelf.topMaskBackViewBlock(@"取 消");
        }
    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(backImgV.right - (backImgV.width / 2 - 40), backImgV.bottom + 30, backImgV.width / 2 - 40, 44);
    btn2.backgroundColor = [UIColor colorWithRed:70/255.0 green:222/255.0 blue:160/255.0 alpha:1];
    [self.view addSubview:btn2];
    [btn2 setTitle:@"确 认" forState:UIControlStateNormal];
    
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.topMaskBackViewBlock) {
            strongSelf.topMaskBackViewBlock(self.ageStr);
        }
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.listArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.ageStr = self.listArr[indexPath.row];
}

- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
        for (int i = 18; i < 60; i++) {
            NSString *str = [[NSString stringWithFormat:@"%d", i] stringByAppendingString:@"岁"];
            [_listArr addObject:str];
        }
    }
    return _listArr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
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
