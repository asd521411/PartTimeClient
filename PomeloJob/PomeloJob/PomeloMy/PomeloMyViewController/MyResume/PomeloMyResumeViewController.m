//
//  PomeloMyResumeViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloMyResumeViewController.h"
#import "PomeloIndividualResumeViewController.h"
#import "CommonDetailsViewController.h"
#import "ResumeModel.h"
#import "ResumeTableViewCell.h"
#import "CommonTableViewHeaderFooterView.h"

@interface PomeloMyResumeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, strong) UILabel *lab6;

@property (nonatomic, strong) UIView *lowerBackView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableHeadTitleV;

@property (nonatomic, strong) ResumeModel *resumeinfoModel;
@property (nonatomic, strong) ResumeModel *resume_companyModel;
@property (nonatomic, strong) ResumeModel *resume_huntinginfoModel;
@property (nonatomic, strong) ResumeModel *resume_schoolModel;

@property (nonatomic, strong) UIImageView *headImg;

@end

@implementation PomeloMyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的简历";

    [self setupSubViews];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    
    [super viewDidAppear:animated];
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

}

- (void)loadData {
    
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"userid":[ECUtil isBlankString:userid]?@"":userid, @"type":@"0"};
    
    [[HWAFNetworkManager shareManager] resume:para resumeInfo:^(BOOL success, id  _Nonnull request) {
        if (success) {
            self.resumeinfoModel = [ResumeModel mj_objectWithKeyValues:request[@"resumeinfo"]];
            self.resume_huntinginfoModel = [ResumeModel mj_objectWithKeyValues:request[@"resume_huntinginfo"]];
            self.resume_companyModel = [ResumeModel mj_objectWithKeyValues:request[@"resume_company"]];
            self.resume_schoolModel = [ResumeModel mj_objectWithKeyValues:request[@"resume_school"]];
            
            self.lab1.text = self.resumeinfoModel.resumename;
            NSString *ageStr = self.resumeinfoModel.resumebrithday;

            NSString *heiStr = @"xxxcm";
            if (![ECUtil isBlankString:self.resumeinfoModel.resumeheight]) {
                heiStr = self.resumeinfoModel.resumeheight;
            }
            NSString *styStr = @"xx学历";
            if (![ECUtil isBlankString:self.resumeinfoModel.resumeeducationname]) {
                styStr = self.resumeinfoModel.resumeeducationname;
                //self.lab2.text = [[[ageStr stringByAppendingString:@"|"] stringByAppendingString:@"|"] stringByAppendingString:@"|"];
            }
            if (![ECUtil isBlankString:self.resumeinfoModel.resumehuntingstatusname]) {
                self.lab3.text = self.resumeinfoModel.resumehuntingstatusname;
            }
            //if (![ECUtil isBlankString:self.resumeinfoModel.ret]) {
                self.lab4.text = [@"工作时间    " stringByAppendingString:@"2年"];
            //}
            if (![ECUtil isBlankString:self.resumeinfoModel.resumetel]) {
                self.lab5.text = [@"手  机  号    " stringByAppendingString:self.resumeinfoModel.resumetel];
            }
            if (![ECUtil isBlankString:self.resumeinfoModel.resumeemail]) {
                self.lab6.text = [@"邮        箱    " stringByAppendingString:self.resumeinfoModel.resumeemail];
            }

        }
        
    }];
}

- (void)setupSubViews {
    CGFloat backHeight = 300;
    CGFloat wid = 100;
    
    self.headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, backHeight)];
    self.headBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headBackView];
    //self.headBackView 
    
    
    CGFloat headW = KSCREEN_WIDTH - 300;
    
    self.headImg = [[UIImageView alloc] init];
    self.headImg.image = [UIImage imageNamed:@"touxiang"];
    self.headImg.layer.cornerRadius = wid / 2;
    self.headImg.layer.masksToBounds = YES;
    [self.headBackView addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(150);
        make.right.mas_equalTo(-150);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(headW);
    }];
    
    CGFloat height = 20;
    
    self.lab1 = [[UILabel alloc] init];
    self.lab1.font = KFontNormalSize18;
    self.lab1.text = @"姓名";
    self.lab1.textAlignment = NSTextAlignmentCenter;
    [self.headBackView addSubview:self.lab1];
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImg.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.headBackView);
        make.height.mas_equalTo(14);
    }];
    
    self.lab2 = [[UILabel alloc] init];
    self.lab2.textColor = KColor_212121;
    self.lab2.font = KFontNormalSize14;
    self.lab2.text = @"x岁 | xxxcm | 学历";
    self.lab2.textAlignment = NSTextAlignmentCenter;
    [self.headBackView addSubview:self.lab2];
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lab1.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.headBackView);
        make.height.mas_equalTo(14);
    }];
    
    self.lab3 = [[UILabel alloc] init];
    self.lab3.textColor = KColor_212121;
    self.lab3.font = KFontNormalSize14;
    self.lab3.text = @"入职时间";
    self.lab3.textAlignment = NSTextAlignmentCenter;
    [self.headBackView addSubview:self.lab3];
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lab2.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.headBackView);
        make.height.mas_equalTo(14);
    }];
    
    self.lowerBackView = [[UIView alloc] init];
    //self.lowerBackView.backgroundColor = [HWRandomColor randomColor];
    [self.headBackView addSubview:self.lowerBackView];
    [self.lowerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lab3.mas_bottom).offset(15);
        make.left.right.mas_equalTo(self.headBackView);
        make.bottom.mas_equalTo(self.headBackView.mas_bottom);
    }];
    
    self.lab4 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, 5, SCREENWIDTH - 30, height)];
    self.lab4.attributedText = [ECUtil mutableArrtibuteString:@"工作时间    " foregroundColor:[ECUtil colorWithHexString:@"212121"] fontName:KFontNormalSize18 attribut:@"x年" foregroundColor:[ECUtil colorWithHexString:@"212121"] fontName:KFontNormalSize14];
    self.lab4.textAlignment = NSTextAlignmentLeft;
    [self.lowerBackView addSubview:self.lab4];
    
    self.lab5 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.lab4.bottom + 10, SCREENWIDTH - 30, height)];
    self.lab5.attributedText = [ECUtil mutableArrtibuteString:@"手  机  号    " foregroundColor:[ECUtil colorWithHexString:@"212121"] fontName:KFontNormalSize18 attribut:@"1xxxxxxxxxx" foregroundColor:[ECUtil colorWithHexString:@"212121"] fontName:KFontNormalSize14];
    self.lab5.textAlignment = NSTextAlignmentLeft;
    [self.lowerBackView addSubview:self.lab5];
    
    self.lab6 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.lab5.bottom + 10, SCREENWIDTH - 30, height)];
    self.lab6.attributedText = [ECUtil mutableArrtibuteString:@"邮        箱    " foregroundColor:[ECUtil colorWithHexString:@"212121"] fontName:KFontNormalSize18 attribut:@"xxx@xxx.com" foregroundColor:[ECUtil colorWithHexString:@"212121"] fontName:KFontNormalSize14];
    self.lab6.textAlignment = NSTextAlignmentLeft;
    [self.lowerBackView addSubview:self.lab6];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.backgroundColor = [ECUtil colorWithHexString:@"e24e77"];
    editBtn.titleLabel.font = KFontNormalSize14;
    [editBtn setTitle:@"编辑简历" forState:UIControlStateNormal];
    [self.headBackView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lowerBackView.mas_top);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        make.right.mas_equalTo(self.headBackView);
    }];
    //不调用圆角渲染不上去，bounds为0，说明此时约束为转化成frame，也可以延迟0.1秒在渲染
    [editBtn.superview layoutIfNeeded];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:editBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = editBtn.bounds;
    layer.path = path.CGPath;
    editBtn.layer.mask = layer;
    [[editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PomeloIndividualResumeViewController *indi = [[PomeloIndividualResumeViewController alloc] init];
        [self.navigationController pushViewController:indi animated:YES];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.tableHeaderView = self.headBackView;
    [self.tableView registerClass:[CommonTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"CommonTableViewHeaderFooterView"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableHeadTitleV.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResumeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResumeTableViewCell"];
    if (!cell) {
        cell = [[ResumeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ResumeTableViewCell"];
    }
    if (indexPath.section == 0) {
        cell.payTitleLab.text = @"求值类型";
        cell.workContentTitleLab.text = @"求职区域";
        cell.workTimeTitleLab.text = @"求职职位";
        cell.workRequireTitleLab.text = @"期望薪资";

        cell.payLab.text = self.resume_huntinginfoModel.huntingpostname;
        cell.workContentLab.text = self.resume_huntinginfoModel.resumehuntingaddress;
        cell.workTimeLab.text = self.resume_huntinginfoModel.resumehuntingmoney;
        cell.workRequireLab.text = self.resume_huntinginfoModel.resumehuntingtype;
        return cell;
    }else if(indexPath.section == 1){
        cell.payTitleLab.text = @"公司名称";
        cell.workContentTitleLab.text = @"起止时间";
        cell.workTimeTitleLab.text = @"岗       位";
        cell.workRequireTitleLab.text = @"岗位职责";
        cell.otherWelfareTitleLab.text = @"工作内容";
        
        cell.payLab.text = self.resume_companyModel.resumeoldcompany;
//        cell.workContentLab.text = [[self.resume_companyModel.resumeoldcompangstarttime stringByAppendingString:@"~"] stringByAppendingString:self.resume_companyModel.resumescendtime];
        cell.workTimeLab.text = self.resume_companyModel.resumeoldcompany;
        cell.workRequireLab.text = self.resume_companyModel.resumeoldresponsibility;
        return cell;
    }else if (indexPath.section == 2) {
        cell.payTitleLab.text = @"学校名称";
        cell.workContentTitleLab.text = @"学     校";
        cell.workTimeTitleLab.text = @"专     业";
        cell.workRequireTitleLab.text = @"学     历";
        cell.otherWelfareTitleLab.text = @"起止时间";
        
        cell.payLab.text = self.resume_schoolModel.resumeschool;
        cell.workContentLab.text = self.resume_schoolModel.resumemajor;
        cell.workTimeLab.text = [[self.resume_schoolModel.resumescstarttime stringByAppendingString:@"~"] stringByAppendingString:self.resume_schoolModel.resumescendtime];
        cell.workRequireLab.text = self.resume_schoolModel.resumemajor;
        return cell;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CommonTableViewHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CommonTableViewHeaderFooterView"];
    head.titleLab.text = self.tableHeadTitleV[section][@"title"];
    __weak typeof(self) weakSelf = self;
    head.commonHeaderActionBlock = ^{
        UIViewController *vc = [[NSClassFromString(weakSelf.tableHeadTitleV[section][@"selector"]) alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return head;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        return 140;
    }
    
    if (indexPath.section == 2) {
        return 140;
    }
    
    return 120;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSArray *)tableHeadTitleV {
    if (!_tableHeadTitleV) {
        _tableHeadTitleV = @[@{@"title":@"求职意向", @"selector":@"PomeloJobIntentionViewController"},
                             @{@"title":@"工作经验", @"selector":@"PomeloWorkExperienceViewController"},
                             @{@"title":@"教育经历", @"selector":@"PomeloEducationExperienceViewController"}];
    }
    return _tableHeadTitleV;
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
