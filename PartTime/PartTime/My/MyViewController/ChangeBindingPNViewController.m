//
//  ChangePhNumViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ChangeBindingPNViewController.h"
#import "ReactiveCocoa.h"
#import "InputCodeViewController.h"

@interface ChangeBindingPNViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChangeBindingPNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改绑定手机";
    
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
    lab.text = @"更改手机号后，下次登陆请使用新绑定手机号登陆，当前手机号182****7499";
    lab.textAlignment = NSTextAlignmentLeft;
    lab.numberOfLines = 2;
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.tableView addSubview:lab];
    
    CGFloat space = 50;
    CGFloat hei = 40;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab.bottom + 100, 50, hei)];
    lab1.textColor = BLACKCOLOR;
    lab1.font = LARGEFont;
    lab1.text = @"+86";
    [self.tableView addSubview:lab1];
    
    UITextField *textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab.bottom + 100, SCREENWIDTH / 2, hei)];
    textFd1.placeholder = @"请输入手机号";
    [self.tableView addSubview:textFd1];
    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    textFd1.layer.borderWidth = LineWidthNormal05;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREENWIDTH / 3, textFd1.bottom + 100, SCREENWIDTH / 3, 50);
    btn.backgroundColor = [HWRandomColor randomColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [self.tableView addSubview:btn];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        InputCodeViewController *input = [[InputCodeViewController alloc] init];
        [weakSelf.navigationController pushViewController:input animated:YES];
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
