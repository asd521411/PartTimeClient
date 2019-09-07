//
//  MyResumeViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "MyResumeViewController.h"

@interface MyResumeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UIView *lowerBackView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的简历";
    
    [self setupSubViews];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    CGFloat backHeight = SCREENHEIGHT * 4 / 10;
    CGFloat space = 10;
    
    CGFloat wid = 100;
    
    self.headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, backHeight)];
    self.headBackView.backgroundColor = [HWRandomColor randomColor];
    [self.view addSubview:self.headBackView];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - wid) / 2, space, wid, wid)];
    headImg.backgroundColor = [HWRandomColor randomColor];
    headImg.layer.cornerRadius = wid / 2;
    headImg.layer.masksToBounds = YES;
    [self.headBackView addSubview:headImg];
    
    CGFloat height = 20;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, headImg.bottom + space, SCREENWIDTH, height)];
    lab1.textColor = BLACKCOLOR;
    lab1.font = LARGEFont;
    lab1.text = @"孔乙己";
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.headBackView addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, lab1.bottom + space, SCREENWIDTH, height)];
    lab2.textColor = BLACKCOLOR;
    lab2.font = NORMALFont;
    lab2.text = @"24岁 | 183cm | 本科";
    lab2.textAlignment = NSTextAlignmentCenter;
    [self.headBackView addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(0, lab2.bottom + space, SCREENWIDTH, height)];
    lab3.textColor = BLACKCOLOR;
    lab3.font = NORMALFont;
    lab3.text = @"随时到岗";
    lab3.textAlignment = NSTextAlignmentCenter;
    [self.headBackView addSubview:lab3];
    
    
    self.lowerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackView.height - backHeight / 3, SCREENWIDTH, backHeight / 3)];
    self.lowerBackView.backgroundColor = [HWRandomColor randomColor];
    [self.headBackView addSubview:self.lowerBackView];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(space, 0, SCREENWIDTH - space * 2, height)];
    lab4.textColor = BLACKCOLOR;
    lab4.font = LARGEFont;
    lab4.text = @"工作时间  2年";
    lab4.textAlignment = NSTextAlignmentLeft;
    [self.lowerBackView addSubview:lab4];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab4.bottom, SCREENWIDTH - space * 2, height)];
    lab5.textColor = BLACKCOLOR;
    lab5.font = SMALLFont;
    lab5.text = @"手机号   18345067097";
    lab5.textAlignment = NSTextAlignmentLeft;
    [self.lowerBackView addSubview:lab5];
    
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab5.bottom, SCREENWIDTH - space * 3, height)];
    lab6.backgroundColor = [HWRandomColor randomColor];
    lab6.textColor = BLACKCOLOR;
    lab6.font = SMALLFont;
    lab6.text = @"邮箱    zhaohongweicoder@163.com";
    lab6.textAlignment = NSTextAlignmentLeft;
    [self.lowerBackView addSubview:lab6];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headBackView.bottom, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [HWRandomColor randomColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //self.tableView
    
    
    
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
