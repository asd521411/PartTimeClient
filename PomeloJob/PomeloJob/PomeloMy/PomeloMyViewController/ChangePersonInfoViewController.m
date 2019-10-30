//
//  ChangePersonInfoViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ChangePersonInfoViewController.h"
#import "HeadBackView.h"
#import "ResumeInputViewController.h"
#import "MyNewResumeTableViewCell.h"
#import "UserInfoModel.h"
#import "UIButton+WebCache.h"

@interface ChangePersonInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, HeadBackViewDelegate>

@property (nonatomic, strong) HeadBackView *headBackView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *fillnicknameBtn;
@property (nonatomic, strong) UIView *datePickerBackV;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, strong) UserInfoModel *userInfoModel;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIImage *portraitImg;

@end

@implementation ChangePersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改个人信息";
    
    [self setupSubViews];
    
    [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
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
    
    //[self loadData];
}

- (void)loadData {
    
    NSString *userid = [NSString stringWithFormat:@"%@", [NSUserDefaultMemory defaultGetwithUnityKey:USERID]];
    NSDictionary *para = @{@"userid":userid};
    [[HWAFNetworkManager shareManager] userInfo:para selectuserinfo:^(BOOL success, id  _Nonnull request) {
        
        if (success) {
            if ([request[@"status"] integerValue] == 200) {
                self.userInfoModel = [UserInfoModel mj_objectWithKeyValues:request[@"userinfo"]];
                [self.fillnicknameBtn setTitle:self.userInfoModel.username forState:UIControlStateNormal];
                
                if ([ECUtil isBlankString:self.userInfoModel.userimg]) {
                    [self.headBackView.portraitImgV sd_setBackgroundImageWithURL:[NSURL URLWithString:self.userInfoModel.userimg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"portraitImgV"]];
                }else {
                    [self.headBackView.portraitImgV sd_setBackgroundImageWithURL:[NSURL URLWithString:self.userInfoModel.userimg] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                        self.portraitImg = image;
                    }];
                }
            }
            [self.tableView reloadData];
        }
    }];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)setupSubViews {
    [self.view addSubview:self.headBackView];
    [self.headBackView addSubview:self.fillnicknameBtn];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headBackView;
    [self.tableView addSubview:self.saveBtn];
    
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    [win addSubview:self.datePickerBackV];
    [self.datePickerBackV addSubview:self.cancelBtn];
    [self.datePickerBackV addSubview:self.sureBtn];
    [self.datePickerBackV addSubview:self.datePicker];
    self.datePickerBackV.hidden = YES;
}


#pragma mark action

- (void)fillnicknameBtnAction:(UIButton *)sender {
    ResumeInputViewController *input = [[ResumeInputViewController alloc] init];
    input.placeHolder = self.fillnicknameBtn.titleLabel.text;
    input.inputType = InputTypeWorkPosition;
    input.titleStr = @"修改昵称";
    input.placeHolder = self.fillnicknameBtn.titleLabel.text;
    __weak typeof(self) weakSelf = self;
    input.inputContentBlock = ^(NSString * _Nonnull content) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.fillnicknameBtn setTitle:content forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:input animated:YES];
}

- (void)cancelBtnAction:(UIButton *)sender {
    self.datePickerBackV.hidden = YES;
}

- (void)sureBtnAction:(UIButton *)sender {
    if (self.datePicker.hidden == NO) {
        if (self.section == 0) {
            if (self.row == 1) {
                self.userInfoModel.userbirthday = self.birthday;
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
}

- (void)saveBtnAction:(UIButton *)sender {
    [self postData];
}

- (void)postData {
    
    if ([self alreadyConformCondition] == NO) {
        return;
    }
    NSString *userid = [NSString stringWithFormat:@"%@", [NSUserDefaultMemory defaultGetwithUnityKey:USERID]];
    UIImage *image = self.portraitImg==nil?[UIImage imageNamed:@"portraitImgV"]:self.portraitImg;
    NSDictionary *para = @{@"userid":userid,
                           @"username":self.fillnicknameBtn.titleLabel.text,//简历中的姓名
                           @"usersex":self.userInfoModel.usersex,//简历中的性别
                           @"userbirthday":self.userInfoModel.userbirthday,//简历中的生日
    };
    [[HWAFNetworkManager shareManager] userInfo:para images:@[image] name:@"subimg" fileName:@"jpg" mimeType:@"JPEG" progress:^(NSProgress * _Nonnull progress) {
        
    } updateuserinfo:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            [SVProgressHUD showWithStatus:request[@"statusMessage"]];
            [SVProgressHUD dismissWithDelay:1];
            if ([request[@"status"] integerValue] == 200) {
                ////[NSUserDefaultMemory defaultSetMemory:dic[@"body"][@"userid"] unityKey:USERID];
                [NSUserDefaultMemory defaultSetMemory:dic[@"body"][@"userbirthday"] unityKey:USERBIRTHDAY];
                [NSUserDefaultMemory defaultSetMemory:dic[@"body"][@"username"] unityKey:USERNAME];
                [NSUserDefaultMemory defaultSetMemory:dic[@"body"][@"usersex"] unityKey:USERSEX];
                [NSUserDefaultMemory defaultSetMemory:dic[@"body"][@"userimg"] unityKey:USERIMG];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    }];
    
}

- (BOOL)alreadyConformCondition {
    if ([ECUtil isBlankString:self.fillnicknameBtn.titleLabel.text] ) {
        [SVProgressHUD showInfoWithStatus:@"请输入姓名"];
        [SVProgressHUD dismissWithDelay:1];
        return NO;
    }
    return YES;
}

#pragma mark custome delegate

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
        cell.mustSelect = NO;
        if (indexPath.row == 0) {
            cell.cellShowType = CellShowTypeSelect;
            if ([self.userInfoModel.usersex isEqualToString:@"男"]) {//默认显示
                cell.selectBtn2.selected = YES;
                cell.selectBtn1.selected = NO;
            }else {
                cell.selectBtn2.selected = NO;
                cell.selectBtn1.selected = YES;
            }
            [cell.selectBtn2 setTitle:@"男" forState:UIControlStateNormal];
            [cell.selectBtn1 setTitle:@"女" forState:UIControlStateNormal];
            __weak typeof(self) weakSelf = self;
            cell.cellBtnSelectBlock = ^(NSString * _Nonnull selectTitle) {
                weakSelf.userInfoModel.usersex = selectTitle;
            };
        }
        if (indexPath.row == 1) {
            cell.cellShowType = CellShowTypeCommon;
            cell.showLab.text = self.userInfoModel.userbirthday;
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
        }
    }
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
    return 0;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    self.portraitImg = info[@"UIImagePickerControllerOriginalImage"];
    [self.headBackView.portraitImgV setBackgroundImage:info[@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark getter

- (HeadBackView *)headBackView {
    if (_headBackView == nil) {
        CGFloat imgH = 140;//(KSCREEN_WIDTH * 300/750);
        _headBackView = [[HeadBackView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, imgH)];
        _headBackView.infoType = InforTypeShow;
        _headBackView.delegate = self;
    }
    return _headBackView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle tabbarExtensionHeight]) style:UITableViewStylePlain];
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
        _listArr = @[@{@"section":@"", @"row":@[@{@"title":@"性    别"},
                                                @{@"title":@"出生日期"}]}
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
        _saveBtn.frame = CGRectMake(30, 400, KSCREEN_WIDTH-60, 40);
        [_saveBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (UIButton *)fillnicknameBtn {
    if (_fillnicknameBtn == nil) {
        _fillnicknameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fillnicknameBtn.frame = CGRectMake(30, 100, KSCREEN_WIDTH-60, 20);
        [_fillnicknameBtn setTitle:@"请填写姓名" forState:UIControlStateNormal];
        _fillnicknameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_fillnicknameBtn setTitleColor:[ECUtil colorWithHexString:@"ffede1"] forState:UIControlStateNormal];
        [_fillnicknameBtn addTarget:self action:@selector(fillnicknameBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fillnicknameBtn;
}

- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-300, KSCREEN_WIDTH, 300)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        _datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [_datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        [_datePicker setMaximumDate:[NSDate date]];
        
//        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
//        NSDate *currentDate = [NSDate date];
//        NSDateComponents *comps = [[NSDateComponents alloc]init];
//        [comps setYear:-18];//设置最小时间为：当前时间前推十年
//        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//        [_datePicker setMinimumDate:minDate];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSDate *minDate = [fmt dateFromString:@"1930-1-1"];
        _datePicker.minimumDate = minDate;
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _datePicker;
}

- (UIView *)datePickerBackV {
    if (_datePickerBackV == nil) {
        _datePickerBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _datePickerBackV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return _datePickerBackV;
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

- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
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
