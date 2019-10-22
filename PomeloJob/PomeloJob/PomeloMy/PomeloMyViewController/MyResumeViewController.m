//
//  MyResumeViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "MyResumeViewController.h"
#import "HeadBackView.h"
#import "MyNewResumeTableViewCell.h"
#import "ResumeInputViewController.h"

@interface MyResumeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HeadBackView *headBackView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation MyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:kColor_Main];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)setupSubViews {
    [self.view addSubview:self.headBackView];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headBackView;
    [self.view addSubview:self.saveBtn];
}

#pragma mark action

- (void)saveBtnAction:(UIButton *)sender {
    
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.listArr[section][@"row"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyNewResumeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyNewResumeTableViewCell"];
    cell.titleLab.text = self.listArr[indexPath.section][@"row"][indexPath.row][@"title"];
    cell.showLab.text = self.listArr[indexPath.section][@"row"][indexPath.row][@"title"];
    if (indexPath.section == 0) {
        cell.mustSelect = YES;
    }else {
        cell.mustSelect = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ResumeInputViewController *input = [[ResumeInputViewController alloc] init];
    input.inputType = InputTypeWorkPosition;
    [self.navigationController pushViewController:input animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 11, KSCREEN_WIDTH, 20)];
    lab.font = kFontBoldSize(18);
    lab.text = self.listArr[section][@"section"];
    lab.textColor = [ECUtil colorWithHexString:@"2f2f2f"];
    lab.textAlignment = NSTextAlignmentLeft;
    [v addSubview:lab];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

#pragma mark getter

- (HeadBackView *)headBackView {
    if (_headBackView == nil) {
         CGFloat imgH = (KSCREEN_WIDTH * 300/750);
        _headBackView = [[HeadBackView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, imgH)];
        _headBackView.infoType = InforTypeShow;
        //_headBackView.delegate = self;
    }
    return _headBackView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle tabbarExtensionHeight] - 100) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[MyNewResumeTableViewCell class] forCellReuseIdentifier:@"MyNewResumeTableViewCell"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@{@"section":@"基本信息", @"row":@[@{@"title":@"性   别"},
                                                       @{@"title":@"出生日期"},
                                                       @{@"title":@"身份类型"},
                                                       @{@"title":@"最高学历"},
                                                       @{@"title":@"工作年限"},
                                                       @{@"title":@"求职状态"}]},
                     @{@"section":@"教育经历", @"row":@[@{@"title":@"学校名称"},
                                                       @{@"title":@"所学专业"},
                                                       @{@"title":@"入学年份"}]},
                     @{@"section":@"工作经验", @"row":@[@{@"title":@"工作职位"},
                                                       @{@"title":@"开始时间"},
                                                       @{@"title":@"结束时间"},
                                                       @{@"title":@"工作内容"}]}
        ];
    }
    return _listArr;
}

- (UIButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.backgroundColor = kColor_Main;
        _saveBtn.layer.cornerRadius = 2;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.frame = CGRectMake(30, self.tableView.bottom+40, KSCREEN_WIDTH-60, 40);
        [_saveBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
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
