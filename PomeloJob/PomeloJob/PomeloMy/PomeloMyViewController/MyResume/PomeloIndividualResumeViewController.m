//
//  PomeloIndividualResumeViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/16.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloIndividualResumeViewController.h"
#import "PomeloResumeImproveTableViewController.h"

@interface PomeloIndividualResumeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIButton *headPortrait;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) UITextField *textFd1;
@property (nonatomic, strong) UITextField *textFd2;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;

@property (nonatomic, strong) UITextField *textFd3;
@property (nonatomic, strong) UILabel *textFd4;
@property (nonatomic, strong) UITextField *textFd5;
@property (nonatomic, strong) UITextField *textFd6;
@property (nonatomic, strong) UITextField *textFd7;
@property (nonatomic, strong) UITextField *textFd8;
@property (nonatomic, strong) UITextField *textFd9;
@property (nonatomic, strong) UILabel *textFd10;

@property (nonatomic, strong) UIView *pickBackV;
@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, strong) NSArray *pickeDataSource;

@property (nonatomic, copy) NSString *resumeeducation;
@property (nonatomic, copy) NSString *resumehuntingstatusid;

@end

@implementation PomeloIndividualResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人简历";
    
    [self setupSubViews];
    
    //[self setupPickerView];
    
    // Do any additional setup after loading the view.
}

//- (void)setupPickerView {
//    self.pickBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
//    self.pickBackV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//
//    UIWindow *win = [UIApplication sharedApplication].delegate.window;
//    [win addSubview:self.pickBackV];
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTapAction:)];
//    [self.pickBackV addGestureRecognizer:tap];
//
//    [self.pickBackV addSubview:self.pickView];
//}


- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
    self.backScrollV.scrollEnabled = YES;
    self.backScrollV.bounces = YES;
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT * 3 / 2);
    [self.view addSubview:self.backScrollV];
    UITapGestureRecognizer *resign = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponser:)];
    [self.backScrollV addGestureRecognizer:resign];
    
    CGFloat hei = 40;
    
    self.headPortrait = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headPortrait.frame = CGRectMake((KSCREEN_WIDTH - 100) / 2, 20, 100, 100);
    [self.backScrollV addSubview:self.headPortrait];
    [self.headPortrait setBackgroundImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[self.headPortrait rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf selectedImageForIcon];
    }];
    
    // MARK: 姓名

    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, self.headPortrait.bottom + 50, 80, hei)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize14;
    lab1.text = @"姓      名";
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab1];

    self.textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd1.placeholder = @"请输入姓名";
    self.textFd1.textColor = KColor_C8C8C8;
    self.textFd1.font = KFontNormalSize10;
    //self.textFd1.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd1];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];

    // MARK: 性别

    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab1.bottom + KSpaceDistance15, 80, hei)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize14;
    lab2.text = @"性      别";
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab2];

    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1.frame = CGRectMake(KSCREEN_WIDTH - 100, lab2.top, 15, 15);
    [self.backScrollV addSubview:self.btn1];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"sexselectno"] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"sexselectyes"] forState:UIControlStateSelected];
    self.btn1.selected = YES;
    [[self.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.btn1.selected = self.btn2.selected;
        self.btn2.selected = !self.btn2.selected;
    }];

    UILabel *lab21 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 85, lab2.top, 15, 15)];
    [self.backScrollV addSubview:lab21];
    lab21.textColor = KColor_212121;
    lab21.font = KFontNormalSize14;
    lab21.text = @"男";
    lab21.textAlignment = NSTextAlignmentLeft;

    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2.frame = CGRectMake(KSCREEN_WIDTH - 70, lab2.top, 15, 15);
    [self.backScrollV addSubview:self.btn2];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"sexselectno"] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"sexselectyes"] forState:UIControlStateSelected];
    [[self.btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.btn2.selected = self.btn1.selected;
        self.btn1.selected = !self.btn1.selected;
    }];

    UILabel *lab22 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 55, lab2.top, 15, 15)];
    [self.backScrollV addSubview:lab22];
    lab22.textColor = KColor_212121;
    lab22.font = KFontNormalSize14;
    lab22.text = @"女";
    lab22.textAlignment = NSTextAlignmentLeft;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line2.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line2];

    // MARK: 身高

    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab2.bottom + KSpaceDistance15, 80, hei)];
    lab3.textColor = KColor_212121;
    lab3.font = KFontNormalSize14;
    lab3.text = @"身      高";
    lab3.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab3];

    self.textFd3 = [[UITextField alloc] initWithFrame:CGRectMake(lab3.right, lab3.top, KSCREEN_WIDTH - lab3.width - KSpaceDistance15 * 2, hei)];
    self.textFd3.placeholder = @"请输入身高";
    self.textFd3.textColor = KColor_C8C8C8;
    self.textFd3.font = KFontNormalSize10;
    self.textFd3.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd3];

    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab3.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line3.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line3];
    
    // MARK: 学历

    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab3.bottom + KSpaceDistance15 , 80, hei)];
    lab4.textColor = KColor_212121;
    lab4.font = KFontNormalSize14;
    lab4.text = @"学      历";
    lab4.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab4];
    
    self.textFd4 = [[UILabel alloc] initWithFrame:CGRectMake(lab1.right, lab4.top, KSCREEN_WIDTH - lab4.width - KSpaceDistance15 * 2 - 10, hei)];
    self.textFd4.textColor = KColor_C8C8C8;
    self.textFd4.font = KFontNormalSize10;
    self.textFd4.text = @"请输入学历";
    self.textFd4.textAlignment = NSTextAlignmentLeft;
    self.textFd4.userInteractionEnabled = YES;
    [self.backScrollV addSubview:self.textFd4];
    UITapGestureRecognizer *tap44 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(turnRightAction:)];
    [self.textFd4 addGestureRecognizer:tap44];
    
    UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake(self.textFd4.width - 10, 10, 10, 20)];
    img4.image = [UIImage imageNamed:@"rightjiantou"];
    [self.textFd4 addSubview:img4];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab4.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line4.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line4];
    
    // MARK: 出生年份

    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab4.bottom + KSpaceDistance15 , 80, hei)];
    lab5.textColor = KColor_212121;
    lab5.font = KFontNormalSize14;
    lab5.text = @"出生年份";
    lab5.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab5];

    self.textFd5 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab5.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd5.placeholder = @"请输入出生年份";
    self.textFd5.textColor = KColor_C8C8C8;
    self.textFd5.font = KFontNormalSize10;
    self.textFd5.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd5];
    
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab5.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line5.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line5];

    // MARK: 工作时间

    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab5.bottom + KSpaceDistance15, 80, hei)];
    lab6.textColor = KColor_212121;
    lab6.font = KFontNormalSize14;
    lab6.text = @"工作时间";
    lab6.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab6];

    self.textFd6 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab6.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd6.placeholder = @"请输入工作时间";
    self.textFd6.textColor = KColor_C8C8C8;
    self.textFd6.font = KFontNormalSize10;
    self.textFd6.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd6];
    
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab6.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line6.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line6];

    // MARK: 手机号

    UILabel *lab7 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab6.bottom + KSpaceDistance15, 80, hei)];
    lab7.textColor = KColor_212121;
    lab7.font = KFontNormalSize14;
    lab7.text = @"手 机 号";
    lab7.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab7];

    self.textFd7 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab7.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd7.placeholder = @"请输入手机号";
    self.textFd7.textColor = KColor_C8C8C8;
    self.textFd7.font = KFontNormalSize10;
    self.textFd7.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd7];
    
    UIView *line7 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab7.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line7.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line7];

    // MARK: 现在住址

    UILabel *lab8 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab7.bottom + KSpaceDistance15, 80, hei)];
    lab8.textColor = KColor_212121;
    lab8.font = KFontNormalSize14;
    lab8.text = @"邮     箱";
    lab8.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab8];

    self.textFd8 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab8.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd8.placeholder = @"请输入邮箱";
    self.textFd8.textColor = KColor_C8C8C8;
    self.textFd8.font = KFontNormalSize10;
    //textFd8.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd8];
    
    UIView *line8 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab8.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line8.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line8];
    
    // MARK: 户籍地址

    UILabel *lab9 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab8.bottom + KSpaceDistance15, 80, hei)];
    lab9.textColor = KColor_212121;
    lab9.font = KFontNormalSize14;
    lab9.text = @"户籍地址";
    lab9.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab9];

    self.textFd9 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab9.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2, hei)];
    self.textFd9.placeholder = @"请输入户籍所在地";
    self.textFd9.textColor = KColor_C8C8C8;
    self.textFd9.font = KFontNormalSize10;
    //textFd9.keyboardType = UIKeyboardTypeNumberPad;
    [self.backScrollV addSubview:self.textFd9];
    
    UIView *line9 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab9.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line9.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line9];
    
    // MARK: 求职状态

    UILabel *lab10 = [[UILabel alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab9.bottom + KSpaceDistance15, 80, hei)];
    lab10.textColor = KColor_212121;
    lab10.font = KFontNormalSize14;
    lab10.text = @"求职状态";
    lab10.textAlignment = NSTextAlignmentLeft;
    [self.backScrollV addSubview:lab10];

    
    self.textFd10 = [[UILabel alloc] initWithFrame:CGRectMake(lab1.right, lab10.top, KSCREEN_WIDTH - lab1.width - KSpaceDistance15 * 2 - 10, hei)];
    self.textFd10.textColor = KColor_C8C8C8;
    self.textFd10.font = KFontNormalSize10;
    self.textFd10.text = @"请输入求职状态";
    self.textFd10.textAlignment = NSTextAlignmentLeft;
    self.textFd10.userInteractionEnabled = YES;
    [self.backScrollV addSubview:self.textFd10];
    UITapGestureRecognizer *tap10 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(turnRightAction:)];
    [self.textFd10 addGestureRecognizer:tap10];
    
    UIImageView *img10 = [[UIImageView alloc] initWithFrame:CGRectMake(self.textFd10.width - 10, 10, 10, 20)];
    img10.image = [UIImage imageNamed:@"rightjiantou"];
    [self.textFd10 addSubview:img10];
    
    UIView *line10 = [[UIView alloc] initWithFrame:CGRectMake(KSpaceDistance15, lab10.bottom, KSCREEN_WIDTH - KSpaceDistance15 * 2, KLineWidthMeasure05)];
    line10.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line10];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(95,  self.textFd10.bottom + 50, KSCREEN_WIDTH - 95 * 2, 40);
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"确     认" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    login.adjustsImageWhenHighlighted = NO;
    [ECUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        
        if ([ECUtil isBlankString:strongSelf.textFd1.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入姓名！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        
        if ([ECUtil isBlankString:strongSelf.textFd3.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入身高！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        
        if ([ECUtil isBlankString:strongSelf.textFd4.text] || [strongSelf.textFd4.text isEqualToString:@"请输入学历"]) {
            [SVProgressHUD showErrorWithStatus:@"请输入学历！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        if ([ECUtil isBlankString:strongSelf.textFd5.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入出生年份！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        if ([ECUtil isBlankString:strongSelf.textFd10.text] || [strongSelf.textFd10.text isEqualToString:@"请输入求职状态"]) {
            [SVProgressHUD showErrorWithStatus:@"请输入求职状态！"];
            [SVProgressHUD dismissWithDelay:1];
            return ;
        }
        NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
        
        NSDictionary *para = @{@"userid":![ECUtil isBlankString:userid]?userid:@"",
                               @"resumename":![ECUtil isBlankString:strongSelf.textFd1.text]?strongSelf.textFd1.text:@"",
                               @"resumesex":strongSelf.btn1.selected==YES?@"男":@"女",
                               @"resumeheight":![ECUtil isBlankString:strongSelf.textFd3.text]?strongSelf.textFd3.text:@"",
                               @"resumeeducationname":![ECUtil isBlankString:strongSelf.resumeeducation]?strongSelf.resumeeducation:@"",
                               @"resumebrithday":![ECUtil isBlankString:strongSelf.textFd5.text]?strongSelf.textFd5.text:@"",
                               @"resumeworkstarttime":@"2016",
                               @"resumeworkendtime":@"2017",
                               @"resumetel":![ECUtil isBlankString:strongSelf.textFd7.text]?strongSelf.textFd7.text:@"",
                               @"resumeemail":![ECUtil isBlankString:strongSelf.textFd8.text]?strongSelf.textFd8.text:@"",
                               //@"resumewaddress":![ECUtil isBlankString:strongSelf.textFd8.text]?strongSelf.textFd8.text:@"",
                               @"resumehometown":![ECUtil isBlankString:strongSelf.textFd9.text]?strongSelf.textFd9.text:@"",
                               @"resumehuntingstatusname":![ECUtil isBlankString:strongSelf.textFd10.text]?strongSelf.textFd10.text:@"",
                               };
        [[HWAFNetworkManager shareManager] resumeInfo:para resumeInfo:^(BOOL success, id  _Nonnull request) {
            if (success) {
                [SVProgressHUD showWithStatus:request[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }];
    
}

-(void)selectedImageForIcon {
    
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [self.headPortrait setBackgroundImage:info[@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return 1;
//}
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    return self.pickeDataSource.count;
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return self.pickeDataSource[row];
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    self.pickBackV.hidden = YES;
//}
//
//- (void)maskTapAction:(UITapGestureRecognizer *)tap {
//    self.pickBackV.hidden = YES;
//}

- (void)turnRightAction:(UIGestureRecognizer *)tap {
    
    PomeloResumeImproveTableViewController *improve = [[PomeloResumeImproveTableViewController alloc] init];
    
    if (self.textFd4 == tap.view) {
        improve.resumeImproveType = ResumeImproveType_EducationBackground;
    }
    
    if (self.textFd10 == tap.view) {
        improve.resumeImproveType = ResumeImproveType_StatusOfJobSeeking;
    }
    
    __weak typeof(self) weakSelf = self;
    improve.improveSelectonBlock = ^(ResumeImproveType improveType, NSString * _Nonnull type) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (improveType == ResumeImproveType_EducationBackground) {
            strongSelf.textFd4.text = type;
            strongSelf.resumeeducation = type;
        }
        if (improveType == ResumeImproveType_StatusOfJobSeeking) {
            strongSelf.textFd10.text = type;
            strongSelf.resumehuntingstatusid = type;
        }
    };
    
    [self.navigationController pushViewController:improve animated:YES];
}

- (void)resignResponser:(UITapGestureRecognizer *)tap {
    for (UIView *v in self.backScrollV.subviews) {
        if ([v isKindOfClass:[UITextField class]]) {
            UITextField *tx = (UITextField *)v;
            [tx resignFirstResponder];
        }
    }
    
}

#pragma mark gettr

- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}


- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 0, KSCREEN_WIDTH - 50 * 2, 400)];
        _pickView.backgroundColor = [UIColor whiteColor];
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}

- (NSArray *)pickeDataSource {
    if (!_pickeDataSource) {
        _pickeDataSource = @[@"初中以下",
                             @"初中",
                             @"中专",
                             @"高中",
                             @"专科",
                             @"本科",
                             @"研究生",
                             @"硕士",
                             @"博士",
                             @"博士后",
                             ];
    }
    return _pickeDataSource;
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
