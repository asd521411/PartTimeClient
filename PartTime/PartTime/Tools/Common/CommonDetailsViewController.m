//
//  CommonDetailsViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonDetailsViewController.h"
#import "ReactiveCocoa.h"

@interface CommonDetailsViewController ()

@property (nonatomic, strong) UIView *headBackView;

@property (nonatomic, strong) UIScrollView *scrollBackV;
@property (nonatomic, strong) UIView *topBackV;
@property (nonatomic, strong) UIView *bottomBackV;

@end

@implementation CommonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    [self setupItems];
    
    [self setupConnectViews];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)setupSubViews {
    
    self.headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, 200)];
    self.headBackView.backgroundColor = [HWRandomColor randomColor];
    [self.view addSubview:self.headBackView];
    
    
    self.scrollBackV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.scrollBackV.backgroundColor = [UIColor orangeColor];
    self.scrollBackV.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT * 2);
    //[self.view addSubview:self.scrollBackV];
    
    
    self.topBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    self.topBackV.backgroundColor = [HWRandomColor randomColor];
    [self.headBackView addSubview:self.topBackV];
    
    NSArray *arr1 = @[@"大望路服务员收银员", @"180/天"];
    NSArray *arr2 = @[@"丰台", @"日记", @"可长期"];
    NSString *str = @"招聘需求";
    NSArray *arr3 = @[@"月结", @"招3人", @"只招女生"];
    
    CGFloat space = 50;
    CGFloat height = 20;
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(LeftSpaceWidth, 0, SCREENWIDTH - space, height)];
    lab1.backgroundColor = [HWRandomColor randomColor];
    lab1.textColor = BLACKCOLOR;
    lab1.font = LARGEFont;
    lab1.text = arr1[0];
    [self.topBackV addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab1.bottom + height, SCREENWIDTH - space, height)];
    lab2.backgroundColor = [HWRandomColor randomColor];
    lab2.textColor = BLACKCOLOR;
    lab2.font = LARGEFont;
    lab2.text = arr1[1];
    [self.topBackV addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab2.bottom + height, SCREENWIDTH - space, height)];
    lab3.backgroundColor = [HWRandomColor randomColor];
    lab3.textColor = BLACKCOLOR;
    lab3.font = LARGEFont;
    NSString *text = [arr2 componentsJoinedByString:@"  "];
    lab3.text = text;
    [self.topBackV addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(space, self.topBackV.bottom + height, SCREENWIDTH - space, height)];
    lab4.backgroundColor = [HWRandomColor randomColor];
    lab4.textColor = BLACKCOLOR;
    lab4.font = LARGEFont;
    NSString *text1 = str;
    lab4.text = text1;
    [self.topBackV addSubview:lab4];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab4.bottom + height, SCREENWIDTH - space, height)];
    lab5.backgroundColor = [HWRandomColor randomColor];
    lab5.textColor = BLACKCOLOR;
    lab5.font = LARGEFont;
    NSString *text2 = [arr3 componentsJoinedByString:@"  "];
    lab5.text = text2;
    [self.topBackV addSubview:lab5];
}

- (void)setupItems {
    NSArray *arr1 = @[@"薪资福利", @"工作内容", @"上班时间", @"工作要求", @"其它福利"];
    NSArray *arr2 = @[@"底薪4000+提成（试用期一个月）", @"负责点餐，服务客人", @"10：00、月休4天", @"只招女生，18 ~ 40 岁", @"包食宿（不住宿有房补）"];
    
    UIView *itemV =  [self itemViewTitle:@"职位详情" contentSheetTitle:arr1 contentDescriptionString:arr2];
    CGFloat h = 0;
    for (int i = 0; i < 2; i++) {
        for (NSString *str in arr2) {
         h += ([self widgetHeightForString:str] + 10);
        }
        NSLog(@"======%f", h);
        itemV.frame = CGRectMake(0, self.topBackV.bottom + h * i, SCREENWIDTH, h);
        //区域间隔
        //h += i * 20;
        [self.scrollBackV addSubview:itemV];
    }
    self.scrollBackV.contentSize = CGSizeMake(SCREENWIDTH, self.topBackV.height + h);
}

- (void)setupConnectViews {
    
    CGFloat height = 50;
    
    self.bottomBackV = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - height, SCREENWIDTH, height)];
    self.bottomBackV.backgroundColor = [HWRandomColor randomColor];
    [self.view addSubview:self.bottomBackV];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, SCREENWIDTH / 3, height);
    btn1.backgroundColor = [HWRandomColor randomColor];
    [btn1 setTitle:@"电话咨询" forState:UIControlStateNormal];
    [btn1 setTintColor:[UIColor whiteColor]];
    [self.bottomBackV addSubview:btn1];
    
    [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(btn1.right, 0, SCREENWIDTH / 3, height);
    btn2.backgroundColor = [HWRandomColor randomColor];
    [btn2 setTitle:@"沟通" forState:UIControlStateNormal];
    [btn2 setTintColor:[UIColor whiteColor]];
    [self.bottomBackV addSubview:btn2];
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(btn2.right, 0, SCREENWIDTH / 3, height);
    btn3.backgroundColor = [HWRandomColor randomColor];
    [btn3 setTitle:@"立即报名" forState:UIControlStateNormal];
    [btn3 setTintColor:[UIColor whiteColor]];
    [self.bottomBackV addSubview:btn3];
    [[btn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    
    
}


- (UIView *)itemViewTitle:(NSString *)title contentSheetTitle:(NSArray *)sheetArr contentDescriptionString:(NSArray *)description {
    
    UIView *item = [[UIView alloc] init];
    item.backgroundColor = [UIColor whiteColor];
    
    CGFloat spa = 20;
    
    UILabel *tit = [[UILabel alloc] initWithFrame:CGRectMake(spa, spa, SCREENWIDTH - spa * 2, spa)];
    tit.backgroundColor = [HWRandomColor randomColor];
    tit.textColor = BLACKCOLOR;
    tit.font = LARGEFont;
    tit.text = title;
    [item addSubview:tit];
    
    CGFloat h = 0;
    UILabel *lab;
    if (sheetArr.count == description.count) {
        for (int i = 0; i < sheetArr.count; i++) {
            
            h = ([self widgetHeightForString:description[i]] + 10);
            
            lab = [[UILabel alloc] initWithFrame:CGRectMake(spa, tit.bottom + lab.height + 10, SCREENWIDTH - spa * 3, h)];
            lab.backgroundColor = [HWRandomColor randomColor];
            lab.textColor = GRAYCOLOR;
            lab.font = SMALLFont;
            lab.text = sheetArr[i];
            [item addSubview:lab];
            h += h;
        }
    }
    return item;
}

- (CGFloat)widgetHeightForString:(NSString *)text {
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:SMALLFont} context:nil];
    
//    if (!(text && font) || [text isEqual:[NSNull null]]) {
//        return CGSizeZero;
//    }
   
    return CGRectIntegral(rect).size.height;
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
