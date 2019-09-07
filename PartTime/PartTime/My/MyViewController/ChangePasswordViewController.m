//
//  ChangePasswordViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ReactiveCocoa.h"
#import "LoginViewController.h"

@interface ChangePasswordViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREENWIDTH - 40, 50)];
    lab.backgroundColor = [HWRandomColor randomColor];
    lab.textColor = DARKGRAYCOLOR;
    lab.font = LARGEFont;
    lab.text = @"*更改密码后将回到登陆界面重新登陆";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 2;
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.tableView addSubview:lab];
    
    CGFloat space = 50;
    CGFloat hei = 40;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab.bottom + 50, 100, hei)];
    lab1.textColor = BLACKCOLOR;
    lab1.font = LARGEFont;
    lab1.text = @"原始密码";
    [self.tableView addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab.bottom + 50, SCREENWIDTH / 2, hei)];
    textFd1.placeholder = @"请输入原始密码";
    [self.tableView addSubview:textFd1];
    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    textFd1.layer.borderWidth = LineWidthNormal05;
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab1.bottom + 50, 100, hei)];
    lab2.textColor = BLACKCOLOR;
    lab2.font = LARGEFont;
    lab2.text = @"新密码";
    [self.tableView addSubview:lab2];
    
    UITextField *textFd2 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.bottom + 50, SCREENWIDTH / 2, hei)];
    textFd2.placeholder = @"请输入新密码";
    [self.tableView addSubview:textFd2];
    textFd2.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    textFd2.layer.borderWidth = LineWidthNormal05;
    
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab2.bottom + 50, 100, hei)];
    lab3.textColor = BLACKCOLOR;
    lab3.font = LARGEFont;
    lab3.text = @"确认密码";
    [self.tableView addSubview:lab3];
    
    UITextField *textFd3 = [[UITextField alloc] initWithFrame:CGRectMake(lab3.right, lab2.bottom + 50, SCREENWIDTH / 2, hei)];
    textFd3.placeholder = @"请再次输入确认";
    [self.tableView addSubview:textFd3];
    textFd3.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    textFd3.layer.borderWidth = LineWidthNormal05;
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(lab3.right, lab3.bottom + 50, SCREENWIDTH - 40, 50)];
    lab4.backgroundColor = [HWRandomColor randomColor];
    lab4.textColor = DARKGRAYCOLOR;
    lab4.font = LARGEFont;
    lab4.text = @"*密码不得少于6位的数字，字符组合";
    lab4.textAlignment = NSTextAlignmentCenter;
    lab4.numberOfLines = 2;
    lab4.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.tableView addSubview:lab4];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREENWIDTH / 3, textFd3.bottom + 100, SCREENWIDTH / 3, 50);
    btn.backgroundColor = [HWRandomColor randomColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [self.tableView addSubview:btn];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [weakSelf.navigationController pushViewController:login animated:YES];
    }];
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
