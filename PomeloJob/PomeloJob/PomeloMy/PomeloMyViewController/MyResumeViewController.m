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
#import "UIButton+WebCache.h"

@interface MyResumeViewController ()<UITableViewDelegate, UITableViewDataSource, HeadBackViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) HeadBackView *headBackView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIImage *portraitImg;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *fillnicknameBtn;
@property (nonatomic, strong) NSMutableDictionary *paraMutDic;
@property (nonatomic, strong) ResumeModel *baseinfoModel;
@property (nonatomic, strong) ResumeModel *educationexperienceModel;
@property (nonatomic, strong) ResumeModel *workexperiencesModel;
@property (nonatomic, strong) UIView *datePickerBackV;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerViewRowsArr;
@property (nonatomic, strong) NSArray *educationBackgroundArr;//最高学历
@property (nonatomic, strong) NSArray *workYears;//工作年限
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;

//时间
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *edustartdate;
@property (nonatomic, copy) NSString *starttime;
@property (nonatomic, copy) NSString *endtime;
//UIPickerView
@property (nonatomic, copy) NSString *education;
@property (nonatomic, copy) NSString *workexperience;//工作年限

@property (nonatomic, copy) NSString *jobposition;
@property (nonatomic, copy) NSString *jobduties;
@property (nonatomic, copy) NSString *schoolname;
@property (nonatomic, copy) NSString *major;

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
        if (success) {
            self.baseinfoModel = [ResumeModel mj_objectWithKeyValues:request[@"baseinfo"]];
            self.educationexperienceModel = [ResumeModel mj_objectWithKeyValues:request[@"educationexperience"]];
            self.workexperiencesModel = [ResumeModel mj_objectWithKeyValues:request[@"workexperiences"]];
            
            //基本信息
            
            if ([ECUtil isBlankString:self.baseinfoModel.resumeimg]) {
                [self.headBackView.portraitImgV sd_setBackgroundImageWithURL:[NSURL URLWithString:self.baseinfoModel.resumeimg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"portraitImgV"]];
            }else {
                [self.headBackView.portraitImgV sd_setBackgroundImageWithURL:[NSURL URLWithString:self.baseinfoModel.resumeimg] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                    self.portraitImg = image;
                }];
            }
            
            if ([ECUtil isBlankString:self.baseinfoModel.resumename]) {
                [self.fillnicknameBtn setTitle:@"请填写姓名" forState:UIControlStateNormal];
            }else {
                [self.fillnicknameBtn setTitle:self.baseinfoModel.resumename forState:UIControlStateNormal];
            }
            
            if ([ECUtil isBlankString:self.baseinfoModel.resumesex]) {
                self.baseinfoModel.resumesex = @"女";//默认给男性
            }
            if ([ECUtil isBlankString:self.baseinfoModel.resumebirthday]) {//出生日期
                self.baseinfoModel.resumebirthday = @"";
            }
            if ([ECUtil isBlankString:self.baseinfoModel.resumeidentity]) {
                self.baseinfoModel.resumeidentity = @"非学生";
            }
            if ([ECUtil isBlankString:self.baseinfoModel.resumejobstatus]) {
                self.baseinfoModel.resumejobstatus = @"不找工作";
            }
            
            if ([ECUtil isBlankString:self.baseinfoModel.resumeeducation]) {//最高学历
                self.baseinfoModel.resumeeducation = @"";
            }

            if ([ECUtil isBlankString:self.baseinfoModel.resumeworkexperience]) {//工作年限
                self.baseinfoModel.resumeworkexperience = @"";
            }
            
            //教育经历
            
            self.educationexperienceModel.schoolname = [ECUtil isBlankString:self.educationexperienceModel.schoolname]?@"":self.educationexperienceModel.schoolname;
            
            self.educationexperienceModel.major = [ECUtil isBlankString:self.educationexperienceModel.major]?@"":self.educationexperienceModel.major;
            
            self.educationexperienceModel.edustartdate = [ECUtil isBlankString:self.educationexperienceModel.edustartdate]?@"":self.educationexperienceModel.edustartdate;
            //工作经验
            
            self.workexperiencesModel.jobposition = [ECUtil isBlankString:self.workexperiencesModel.jobposition]?@"":self.workexperiencesModel.jobposition;
            self.workexperiencesModel.starttime = [ECUtil isBlankString:self.workexperiencesModel.starttime]?@"":self.workexperiencesModel.starttime;
            self.workexperiencesModel.endtime = [ECUtil isBlankString:self.workexperiencesModel.endtime]?@"":self.workexperiencesModel.endtime;
            self.workexperiencesModel.jobduties = [ECUtil isBlankString:self.workexperiencesModel.jobduties]?@"":self.workexperiencesModel.jobduties;
            
            [self.tableView reloadData];
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
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
            [self postData];
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
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}

- (void)setupSubViews {
    [self.view addSubview:self.headBackView];
    [self.headBackView addSubview:self.fillnicknameBtn];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headBackView;
    [self.view addSubview:self.saveBtn];
    
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    [win addSubview:self.datePickerBackV];
    [self.datePickerBackV addSubview:self.cancelBtn];
    [self.datePickerBackV addSubview:self.sureBtn];
    [self.datePickerBackV addSubview:self.datePicker];
    self.datePicker.hidden = YES;
    [self.datePickerBackV addSubview:self.pickerView];
    self.pickerView.hidden = YES;
    self.datePickerBackV.hidden = YES;
}

#pragma mark action

- (void)fillnicknameBtnAction:(UIButton *)sender {
    ResumeInputViewController *input = [[ResumeInputViewController alloc] init];
    input.placeHolder = self.fillnicknameBtn.titleLabel.text;
    input.inputType = InputTypeWorkPosition;
    input.titleStr = @"姓名";
    __weak typeof(self) weakSelf = self;
    input.inputContentBlock = ^(NSString * _Nonnull content) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.fillnicknameBtn setTitle:content forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:input animated:YES];
}

- (void)saveBtnAction:(UIButton *)sender {
    [self postData];
}

- (void)postData {
    
    if ([self alreadyConformCondition] == NO) {
        return;
    }
    
    NSValue *value = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSString *userid = [NSString stringWithFormat:@"%@", value];
    UIImage *image = self.portraitImg==nil?[UIImage imageNamed:@"portraitImgV"]:self.portraitImg;
    NSDictionary *para = @{@"userid":userid,
                           //@"imgfile":imageData,//上传图片
                           @"resumename":self.fillnicknameBtn.titleLabel.text,//简历中的姓名
                           @"resumesex":self.baseinfoModel.resumesex,//简历中的性别
                           @"resumebirthday":self.baseinfoModel.resumebirthday,//简历中的生日
                           @"resumeidentity":self.baseinfoModel.resumeidentity,//简历中的身份
                           @"resumeeducation":self.baseinfoModel.resumeeducation,//简历中的学历
                           @"resumeworkexperience":self.baseinfoModel.resumeworkexperience,//简历中的工作经验
                           @"resumejobstatus":self.baseinfoModel.resumejobstatus,//简历中的求职状态
                           //非必传
                           @"schoolname":[ECUtil isBlankString:self.educationexperienceModel.schoolname]?@"":self.educationexperienceModel.schoolname,//学校名称
                           @"major":[ECUtil isBlankString:self.educationexperienceModel.major]?@"":self.educationexperienceModel.major,//专业
                           @"edustartdate":[ECUtil isBlankString:self.educationexperienceModel.edustartdate]?@"":self.educationexperienceModel.edustartdate,//入学年份
                           @"jobposition":[ECUtil isBlankString:self.workexperiencesModel.jobposition]?@"":self.workexperiencesModel.jobposition,//工作职位
                           @"starttime":[ECUtil isBlankString:self.workexperiencesModel.starttime]?@"":self.workexperiencesModel.starttime,//工作开始时间
                           @"endtime":[ECUtil isBlankString:self.workexperiencesModel.endtime]?@"":self.workexperiencesModel.endtime,//工作结束时间
                           @"jobduties":[ECUtil isBlankString:self.workexperiencesModel.jobduties]?@"":self.workexperiencesModel.jobduties,//工作职责
                           
    };
    [[HWAFNetworkManager shareManager] resume:para images:@[image] name:@"imgfile" fileName:@"jpg" mimeType:@"jpeg" progress:^(NSProgress * _Nonnull progress) {
    } updateResume:^(BOOL success, id  _Nonnull request) {
        if (success) {
            [SVProgressHUD showWithStatus:request[@"statusMessage"]];
            [SVProgressHUD dismissWithDelay:1];
            if ([request[@"status"] integerValue] == 200) {
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([request[@"stauts"] integerValue] == 400) {
                
            }
        }
    }];
}

- (BOOL)alreadyConformCondition {
    if ([ECUtil isBlankString:self.fillnicknameBtn.titleLabel.text] || [self.fillnicknameBtn.titleLabel.text isEqualToString:@"请输入姓名"]) {
        [SVProgressHUD showInfoWithStatus:@"请输入姓名"];
        [SVProgressHUD dismissWithDelay:1];
        return NO;
    }
    if ([ECUtil isBlankString:self.baseinfoModel.resumesex]) {
        [SVProgressHUD showInfoWithStatus:@"请选择性别"];
        [SVProgressHUD dismissWithDelay:1];
        return NO;
    }
    if ([ECUtil isBlankString:self.baseinfoModel.resumebirthday]) {
        [SVProgressHUD showInfoWithStatus:@"请选择出生日期"];
        [SVProgressHUD dismissWithDelay:1];
        return NO;
    }
    if ([ECUtil isBlankString:self.baseinfoModel.resumeidentity]) {
        [SVProgressHUD showInfoWithStatus:@"请选择身份类型"];
        [SVProgressHUD dismissWithDelay:1];
        return NO;
    }
    if ([ECUtil isBlankString:self.baseinfoModel.resumeeducation]) {
        [SVProgressHUD showInfoWithStatus:@"请选择最高学历"];
        [SVProgressHUD dismissWithDelay:1];
        return NO;
    }
    if ([ECUtil isBlankString:self.baseinfoModel.resumeworkexperience]) {//工作年限
        [SVProgressHUD showInfoWithStatus:@"请选择工作年限"];
        [SVProgressHUD dismissWithDelay:1];
        return NO;
    }
    if ([ECUtil isBlankString:self.baseinfoModel.resumejobstatus]) {
        [SVProgressHUD showInfoWithStatus:@"请选择求职状态"];
        [SVProgressHUD dismissWithDelay:1];
        return NO;
    }
    return YES;
}

- (void)cancelBtnAction:(UIButton *)sender {
    self.datePickerBackV.hidden = YES;
}

- (void)sureBtnAction:(UIButton *)sender {
    if (self.datePicker.hidden == NO && self.pickerView.hidden == YES) {
        if (self.section == 0) {
            if (self.row == 1) {
                self.baseinfoModel.resumebirthday = self.birthday;
            }
        }else if (self.section == 1) {
            if (self.row == 2) {
                self.educationexperienceModel.edustartdate = self.edustartdate;
            }
        }else if (self.section == 2) {
            if (self.row == 1) {
                self.workexperiencesModel.starttime = self.starttime;
            }
            if (self.row == 2) {
                self.workexperiencesModel.endtime = self.endtime;
            }
        }
    }else if (self.datePicker.hidden == YES && self.pickerView.hidden == NO){
        if (self.section == 0) {
            if (self.row == 3) {
                self.baseinfoModel.resumeeducation = self.education;
             }
            if (self.row == 4) {
                self.baseinfoModel.resumeworkexperience = self.workexperience;
            }
        }
    }
    //刷新cell
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.row  inSection:self.section];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    self.datePickerBackV.hidden = YES;
}

- (void)dateChange:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    if (self.section == 0) {
        if (self.row == 1) {
            self.birthday = dateStr;
        }
    }
    if (self.section == 1) {
        if (self.row == 2) {
            self.edustartdate = dateStr;
        }
    }
    
    if (self.section == 2) {
        if (self.row == 1) {
            self.starttime = dateStr;
        }
        if (self.row == 2) {
            self.endtime = dateStr;
        }
    }
    
}

#pragma mark custom delegate

- (void)sdportraitImgV {
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *actionPhotoLIbrary=[UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *actionPhotoAlbum=[UIAlertAction actionWithTitle:@"打开图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:actionCamera];
    
    [alertController addAction:actionPhotoAlbum];
    
    [alertController addAction:actionPhotoLIbrary];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    if (indexPath.section == 0) {
        cell.mustSelect = YES;//必填标志
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5) {
            cell.cellShowType = CellShowTypeSelect;//左右按钮
        }else {
            cell.cellShowType = CellShowTypeCommon;
        }
    }else {
        cell.mustSelect = NO;
        cell.cellShowType = CellShowTypeCommon;
    }
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            if ([self.baseinfoModel.resumesex isEqualToString:@"男"]) {//默认显示
                cell.selectBtn2.selected = YES;
                cell.selectBtn1.selected = NO;
            }else {
                cell.selectBtn2.selected = NO;
                cell.selectBtn1.selected = YES;
            }
            [cell.selectBtn2 setTitle:@"男" forState:UIControlStateNormal];
            [cell.selectBtn1 setTitle:@"女" forState:UIControlStateNormal];
            
            cell.cellBtnSelectBlock = ^(NSString * _Nonnull selectTitle) {
                weakSelf.baseinfoModel.resumesex = selectTitle;
            };
        }else if (indexPath.row == 1) {
            cell.showLab.text = self.baseinfoModel.resumebirthday;
        }else if (indexPath.row == 2) {
            if ([self.baseinfoModel.resumeidentity isEqualToString:@"学生"]) {
                cell.selectBtn2.selected = YES;
                cell.selectBtn1.selected = NO;
            }else {
                cell.selectBtn2.selected = NO;
                cell.selectBtn1.selected = YES;
            }
            [cell.selectBtn2 setTitle:@"学生" forState:UIControlStateNormal];
            [cell.selectBtn1 setTitle:@"非学生" forState:UIControlStateNormal];
            cell.cellBtnSelectBlock = ^(NSString * _Nonnull selectTitle) {
                weakSelf.baseinfoModel.resumeidentity = selectTitle;
            };
        }else if (indexPath.row == 3) {
            cell.showLab.text = self.baseinfoModel.resumeeducation;
        }else if (indexPath.row == 4) {
            cell.showLab.text = self.baseinfoModel.resumeworkexperience;//=========================有问题
        }else if (indexPath.row == 5) {
            if ([self.baseinfoModel.resumejobstatus isEqualToString:@"积极找工作"]) {
                cell.selectBtn2.selected = YES;
                cell.selectBtn1.selected = NO;
            }else {
                cell.selectBtn2.selected = NO;
                cell.selectBtn1.selected = YES;
            }
            [cell.selectBtn2 setTitle:@"积极找工作" forState:UIControlStateNormal];
            [cell.selectBtn1 setTitle:@"不找工作" forState:UIControlStateNormal];
            cell.cellBtnSelectBlock = ^(NSString * _Nonnull selectTitle) {
                weakSelf.baseinfoModel.resumejobstatus = selectTitle;
            };
        }
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            cell.showLab.text = self.educationexperienceModel.schoolname;
        }else if (indexPath.row == 1) {
            cell.showLab.text = self.educationexperienceModel.major;
        }else if (indexPath.row == 2) {
            cell.showLab.text = self.educationexperienceModel.edustartdate;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.showLab.text = self.workexperiencesModel.jobposition;
        }else if (indexPath.row == 1) {
            cell.showLab.text = self.workexperiencesModel.starttime;
        }else if (indexPath.row == 2) {
            cell.showLab.text = self.workexperiencesModel.endtime;
        }else if (indexPath.row == 3) {
            cell.showLab.text = self.workexperiencesModel.jobduties;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.section = indexPath.section;
    self.row = indexPath.row;
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            self.datePickerBackV.hidden = NO;
            self.datePicker.hidden = NO;
            self.pickerView.hidden = YES;
        }
        if (indexPath.row == 3) {
            self.datePickerBackV.hidden = NO;
            self.datePicker.hidden = YES;
            self.pickerView.hidden = NO;
            self.pickerViewRowsArr = nil;
            self.pickerViewRowsArr = [NSArray arrayWithArray:self.educationBackgroundArr];
            [self.pickerView reloadAllComponents];
        }
        if (indexPath.row == 4) {
            self.datePickerBackV.hidden = NO;
            self.datePicker.hidden = YES;
            self.pickerView.hidden = NO;
            self.pickerViewRowsArr = nil;
            self.pickerViewRowsArr = [NSArray arrayWithArray:self.workYears];
            [self.pickerView reloadAllComponents];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0 ) {
            [self reloadCurrentCell];
        }
        if (indexPath.row == 1) {
            [self reloadCurrentCell];
        }
        if (indexPath.row == 2) {
            self.datePickerBackV.hidden = NO;
            self.datePicker.hidden = NO;
            self.pickerView.hidden = YES;
        }
        
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self reloadCurrentCell];
        }
        if (indexPath.row == 1) {
            self.datePickerBackV.hidden = NO;
            self.datePicker.hidden = NO;
            self.pickerView.hidden = YES;
        }
        if (indexPath.row == 2) {
            self.datePickerBackV.hidden = NO;
            self.datePicker.hidden = NO;
            self.pickerView.hidden = YES;
        }
        if (indexPath.row == 3) {
            [self reloadCurrentCell];
        }
    }
}

- (void)reloadCurrentCell {
    ResumeInputViewController *input = [[ResumeInputViewController alloc] init];
    if (self.section == 1) {
        input.inputType = InputTypeWorkPosition;
        if (self.row == 0) {
            input.placeHolder = self.educationexperienceModel.schoolname;
        }
        if (self.row == 1) {
            input.placeHolder = self.educationexperienceModel.major;
        }
    }
    if (self.section == 2) {
        if (self.row == 0) {
            input.inputType = InputTypeWorkPosition;
            input.placeHolder = self.workexperiencesModel.jobposition;
        }
        if (self.row == 3) {
            input.inputType = InputTypeWorkPosition;
            input.placeHolder = self.workexperiencesModel.jobduties;
        }
        if (self.row == 3) {
            input.inputType = InputTypeWorkContent;
        }
    }
    input.titleStr = self.listArr[self.section][@"row"][self.row][@"title"];
    __weak typeof(self) weakSelf = self;
    input.inputContentBlock = ^(NSString * _Nonnull content) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.section == 1) {
            if (strongSelf.row == 0) {
                strongSelf.educationexperienceModel.schoolname = content;
            }
            if (strongSelf.row == 1) {
                strongSelf.educationexperienceModel.major = content;
            }
        }
        
        if (strongSelf.section == 2) {
            if (strongSelf.row == 0) {
                strongSelf.workexperiencesModel.jobposition = content;
            }
            if (strongSelf.row == 3) {
                strongSelf.workexperiencesModel.jobduties = content;
            }
        }
        NSIndexPath *index = [NSIndexPath indexPathForRow:strongSelf.row  inSection:strongSelf.section];
        [strongSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [weakSelf.navigationController pushViewController:input animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 80, 20)];
    lab.font = kFontBoldSize(18);
    lab.text = self.listArr[section][@"section"];
    lab.textColor = [ECUtil colorWithHexString:@"2f2f2f"];
    lab.textAlignment = NSTextAlignmentLeft;
    [v addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab.right, lab.bottom-16, 100, 16)];
    lab1.textColor = [ECUtil colorWithHexString:@"9b9b9b"];
    lab1.font = kFontNormalSize(14);
    lab1.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:@"(*必填)"];
    [attribut addAttributes:@{NSForegroundColorAttributeName:kColor_Main, NSFontAttributeName:kFontNormalSize(12)} range:NSMakeRange(1, 1)];
    lab1.attributedText = attribut;
    if (section == 0) {
        [v addSubview:lab1];
    }
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

#pragma mark UIPickerView delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerViewRowsArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerViewRowsArr[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return KSCREEN_WIDTH;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.section == 0) {
        if (self.row == 3) {
            self.education = self.pickerViewRowsArr[row];
        }
        if (self.row == 4) {
            self.workexperience = self.pickerViewRowsArr[row];
        }
    }
}

#pragma mark
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    self.portraitImg = info[@"UIImagePickerControllerOriginalImage"];
    [self.headBackView.portraitImgV setBackgroundImage:info[@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark getter

- (HeadBackView *)headBackView {
    if (_headBackView == nil) {
        CGFloat imgH = 140;//(KSCREEN_WIDTH * 280/750);
        _headBackView = [[HeadBackView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, imgH)];
        _headBackView.infoType = InforTypeShow;
        _headBackView.delegate = self;
    }
    return _headBackView;
}

- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

- (UIButton *)fillnicknameBtn {
    if (_fillnicknameBtn == nil) {
        _fillnicknameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fillnicknameBtn.frame = CGRectMake(30, 100, KSCREEN_WIDTH-60, 20);
        //[_fillnicknameBtn setTitle:@"请填写姓名上岛咖啡时间沙漏" forState:UIControlStateNormal];
        //_fillnicknameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
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
        _listArr = @[@{@"section":@"基本信息", @"row":@[@{@"title":@"性   别", @"showtitle":[ECUtil isBlankString:self.baseinfoModel.resumename]?@"":self.baseinfoModel.resumename},
                                                    @{@"title":@"出生日期", @"showtitle":[ECUtil isBlankString:self.baseinfoModel.resumebirthday]?@"":self.baseinfoModel.resumebirthday},
                                                    @{@"title":@"身份类型", @"showtitle":[ECUtil isBlankString:self.baseinfoModel.resumeidentity]?@"":self.baseinfoModel.resumeidentity},
                                                    @{@"title":@"最高学历", @"showtitle":[ECUtil isBlankString:self.baseinfoModel.resumeeducation]?@"":self.baseinfoModel.resumeeducation},
                                                    @{@"title":@"工作年限", @"showtitle":[ECUtil isBlankString:self.baseinfoModel.resumeworkexperience]?@"":self.baseinfoModel.resumeworkexperience},
                                                    @{@"title":@"求职状态", @"showtitle":[ECUtil isBlankString:self.baseinfoModel.resumejobstatus]?@"":self.baseinfoModel.resumejobstatus}]},
                     @{@"section":@"教育经历", @"row":@[@{@"title":@"学校名称", @"showtitle":[ECUtil isBlankString:self.educationexperienceModel.schoolname]?@"":self.educationexperienceModel.schoolname},
                                                    @{@"title":@"所学专业", @"showtitle":[ECUtil isBlankString:self.educationexperienceModel.major]?@"":self.educationexperienceModel.major},
                                                    @{@"title":@"入学年份", @"showtitle":[ECUtil isBlankString:self.educationexperienceModel.edustartdate]?@"":self.educationexperienceModel.edustartdate}]},
                     @{@"section":@"工作经验", @"row":@[@{@"title":@"工作职位", @"showtitle":[ECUtil isBlankString:self.workexperiencesModel.jobduties]?@"":self.workexperiencesModel.jobduties},
                                                    @{@"title":@"开始时间", @"showtitle":[ECUtil isBlankString:self.workexperiencesModel.starttime]?@"":self.workexperiencesModel.starttime},
                                                    @{@"title":@"结束时间", @"showtitle":[ECUtil isBlankString:self.workexperiencesModel.endtime]?@"":self.workexperiencesModel.endtime},
                                                    @{@"title":@"工作内容", @"showtitle":[ECUtil isBlankString:self.workexperiencesModel.jobposition]?@"":self.workexperiencesModel.jobposition}]}
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

- (UIView *)datePickerBackV {
    if (_datePickerBackV == nil) {
        _datePickerBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _datePickerBackV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return _datePickerBackV;
}

- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-300, KSCREEN_WIDTH, 300)];
        _datePicker.backgroundColor = [UIColor whiteColor];
         
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        _datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [_datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        [_datePicker setMaximumDate:[NSDate date]];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSDate *minDate = [fmt dateFromString:@"1930-1-1"];
        _datePicker.minimumDate = minDate;
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _datePicker;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.frame = CGRectMake(0, KSCREEN_HEIGHT-300-40, KSCREEN_WIDTH/2, 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[ECUtil colorWithHexString:@"2f2f2f"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (_sureBtn == nil) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = [UIColor whiteColor];
        _sureBtn.frame = CGRectMake(KSCREEN_WIDTH/2, KSCREEN_HEIGHT-300-40, KSCREEN_WIDTH/2, 40);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[ECUtil colorWithHexString:@"2f2f2f"] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-300, KSCREEN_WIDTH, 300)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (NSArray *)pickerViewRowsArr {
    if (_pickerViewRowsArr == nil) {
        _pickerViewRowsArr = [NSArray array];
    }
    return _pickerViewRowsArr;
}

- (NSArray *)educationBackgroundArr {
    if (_educationBackgroundArr == nil) {
        _educationBackgroundArr = @[@"初中以下",
                                    @"初中",
                                    @"中专",
                                    @"高中",
                                    @"专科",
                                    @"本科",
                                    @"研究生",
                                    @"硕士",
                                    @"博士及以上",];
    }
    return _educationBackgroundArr;
}

- (NSArray *)workYears {
    if (_workYears == nil) {
        _workYears = @[@"无工作经验",@"0-1年", @"1-3年",@"3-5年",@"5-10年", @"10年以上"];
    }
    return _workYears;
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
