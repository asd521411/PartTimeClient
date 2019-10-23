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
#import "ResumeModel.h"

@interface MyResumeViewController ()<UITableViewDelegate, UITableViewDataSource, HeadBackViewDelegate>

@property (nonatomic, strong) HeadBackView *headBackView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *fillnicknameBtn;
@property (nonatomic, strong) NSMutableDictionary *paraMutDic;
@property (nonatomic, strong) ResumeModel *resumeModel;

@end

@implementation MyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的简历";
    
    [self loadData];
    
    [self setupSubViews];
    
    
    // Do any additional setup after loading the view.
}

- (void)loadData {
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"userid":userid};
    [[HWAFNetworkManager shareManager] resume:para selectResumeInfo:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = request[@"body"];
        NSLog(@"--------%@", request);
        if (success) {
            self.resumeModel = [ResumeModel mj_objectWithKeyValues:dic];
            NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        }
    }];
    
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
    
    __weak typeof(self) weakSelf = self;
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否保存简历？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
//        //修改title
//        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"是否保存简历？"];
//        //设置颜色
//        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:kColor_Main range:NSMakeRange(0, alertControllerStr.length)];
//        //设置大小
//        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, alertControllerStr.length)];
//        //替换title
//        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }];
        //[action1 setValue:kColor_Main forKey:@"titleTextColor"];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //[action2 setValue:kColor_Main forKey:@"titleTextColor"];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [strongSelf presentViewController:alert animated:YES completion:nil];
        
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
    [self.headBackView addSubview:self.fillnicknameBtn];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headBackView;
    [self.view addSubview:self.saveBtn];
}

#pragma mark action

- (void)fillnicknameBtnAction:(UIButton *)sender {
    ResumeInputViewController *input = [[ResumeInputViewController alloc] init];
    input.placeHolder = self.fillnicknameBtn.titleLabel.text;
    input.inputType = InputTypeWorkPosition;
    __weak typeof(self) weakSelf = self;
    input.inputContentBlock = ^(NSString * _Nonnull content) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.fillnicknameBtn.titleLabel.text = content;
    };
    [self.navigationController pushViewController:input animated:YES];
}

- (void)saveBtnAction:(UIButton *)sender {
    
    
    NSDictionary *para = @{@"userid":@"",
                           @"imgfie":@"",//上传图片
                           @"resumename":@"",//简历中的姓名
                           @"resumesex":@"",//简历中的性别
                           @"resumebirthday":@"",//简历中的生日
                           @"resumeidentity":@"",//简历中的身份
                           @"resumeeducation":@"",//简历中的学历
                           @"resumeworkexperience":@"",//简历中的工作经验
                           @"resumejobstatus":@"",//简历中的求职状态
                           @"jobposition":@"",//工作职位
                           @"starttime":@"",//工作开始时间
                           @"endtime":@"",//工作结束时间
                           @"jobduties":@"",//工作职责
                           @"schoolname":@"",//学校经历
                           @"major":@"",//专业
                           @"edustartdate":@"",//入学年份
    };
    
    [SVProgressHUD showWithStatus:@""];
    [[HWAFNetworkManager shareManager] resume:para updateResume:^(BOOL success, id  _Nonnull request) {
        if (success) {
            [SVProgressHUD dismiss];
            
        }
        
    }];
}

#pragma mark custom delegate

- (void)sdportraitImgV {
    
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
    cell.showLab.text = self.listArr[indexPath.section][@"row"][indexPath.row][@"showtitle"];
    //cell.showLab.text =
    if (indexPath.section == 0) {
        cell.mustSelect = YES;
        
    }else {
        cell.mustSelect = NO;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5) {
            cell.cellShowType = CellShowTypeSelect;
        }else {
            cell.cellShowType = CellShowTypeCommon;
        }
    }else {
        cell.cellShowType = CellShowTypeCommon;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ((indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 1) || (indexPath.section)) {
//    ResumeInputViewController *input = [[ResumeInputViewController alloc] init];
//            //input.placeHolder = self.fillnicknameBtn.titleLabel.text;
//            input.inputType = InputTypeWorkPosition;
//            __weak typeof(self) weakSelf = self;
//            input.inputContentBlock = ^(NSString * _Nonnull content) {
//                __strong typeof(weakSelf) strongSelf = weakSelf;
//    //            NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row  inSection:indexPath.section];
//    //            MyNewResumeTableViewCell *cell = [strongSelf.tableView cellForRowAtIndexPath:index];
//    //            NSLog(@"ss=s=s=s=s%@", content);
//    //            cell.showLab.text = content;
//    //            [strongSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
//
//            };
//            [weakSelf.navigationController pushViewController:input animated:YES];
//    }else {
//
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, KSCREEN_WIDTH, 20)];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    self.saveBtn.frame = CGRectMake(30, 40, KSCREEN_WIDTH-60, 40);
    [v addSubview:self.saveBtn];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.listArr.count-1) {
        return 100;
    }
    return 0;
}

#pragma mark getter

- (HeadBackView *)headBackView {
    if (_headBackView == nil) {
         CGFloat imgH = (KSCREEN_WIDTH * 300/750);
        _headBackView = [[HeadBackView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, imgH)];
        _headBackView.infoType = InforTypeShow;
        _headBackView.delegate = self;
    }
    return _headBackView;
}

- (UIButton *)fillnicknameBtn {
    if (_fillnicknameBtn == nil) {
        _fillnicknameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fillnicknameBtn.frame = CGRectMake(30, self.headBackView.height - 40, KSCREEN_WIDTH-60, 20);
        [_fillnicknameBtn setTitle:@"请填写姓名" forState:UIControlStateNormal];
        _fillnicknameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_fillnicknameBtn setTitleColor:[ECUtil colorWithHexString:@"ffede1"] forState:UIControlStateNormal];
        [_fillnicknameBtn addTarget:self action:@selector(fillnicknameBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fillnicknameBtn;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle tabbarExtensionHeight]) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
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
        _listArr = @[@{@"section":@"基本信息", @"row":@[@{@"title":@"性   别", @"showtitle":[ECUtil isBlankString:self.resumeModel.resumename]?@"":self.resumeModel.resumename},
                                                    @{@"title":@"出生日期", @"showtitle":[ECUtil isBlankString:self.resumeModel.resumebirthday]?@"":self.resumeModel.resumebirthday},
                                                    @{@"title":@"身份类型", @"showtitle":[ECUtil isBlankString:self.resumeModel.resumeidentity]?@"":self.resumeModel.resumeidentity},
                                                    @{@"title":@"最高学历", @"showtitle":[ECUtil isBlankString:self.resumeModel.resumeeducation]?@"":self.resumeModel.resumeeducation},
                                                    @{@"title":@"工作年限", @"showtitle":[ECUtil isBlankString:self.resumeModel.resumeworkexperience]?@"":self.resumeModel.resumeworkexperience},
                                                    @{@"title":@"求职状态", @"showtitle":[ECUtil isBlankString:self.resumeModel.resumejobstatus]?@"":self.resumeModel.resumejobstatus}]},
                     @{@"section":@"教育经历", @"row":@[@{@"title":@"学校名称", @"showtitle":[ECUtil isBlankString:self.resumeModel.schoolname]?@"":self.resumeModel.schoolname},
                                                    @{@"title":@"所学专业", @"showtitle":[ECUtil isBlankString:self.resumeModel.major]?@"":self.resumeModel.major},
                                                    @{@"title":@"入学年份", @"showtitle":[ECUtil isBlankString:self.resumeModel.edustartdate]?@"":self.resumeModel.edustartdate}]},
                     @{@"section":@"工作经验", @"row":@[@{@"title":@"工作职位", @"showtitle":[ECUtil isBlankString:self.resumeModel.jobduties]?@"":self.resumeModel.jobduties},
                                                    @{@"title":@"开始时间", @"showtitle":[ECUtil isBlankString:self.resumeModel.starttime]?@"":self.resumeModel.starttime},
                                                    @{@"title":@"结束时间", @"showtitle":[ECUtil isBlankString:self.resumeModel.endtime]?@"":self.resumeModel.endtime},
                                                    @{@"title":@"工作内容", @"showtitle":[ECUtil isBlankString:self.resumeModel.jobposition]?@"":self.resumeModel.jobposition}]}
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
        //_saveBtn.frame = CGRectMake(30, 40, KSCREEN_WIDTH-60, 40);
        [_saveBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

//- (NSMutableDictionary *)paraMutDic {
//    if (_paraMutDic == nil) {
//        _paraMutDic = [NSMutableDictionary dictionaryWithObjects:<#(nonnull NSArray *)#> forKeys:<#(nonnull NSArray<id<NSCopying>> *)#>];
//    }
//    return _paraMutDic;
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
