//
//  FindViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/17.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] init];
    [self.view addSubview:self.backScrollV];
    [self.backScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.text = @"用手机号找回密码";
    lab1.font = kFontBoldSize(18);
    lab1.textColor = [ECUtil colorWithHexString:@""];
    [self.view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.view).offset(-15);
    }];
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.text = @"请输入你的账号绑定的手机号s";
    lab2.font = kFontBoldSize(18);
    lab2.textColor = [ECUtil colorWithHexString:@""];
    [self.view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab1.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.font = kFontBoldSize(18);
    lab.textColor = [ECUtil colorWithHexString:@""];
    lab.text = @"+86    |";
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab1.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(lab1.mas_left);
        make.height.mas_equalTo(lab1.height);
    }];
    
    UITextField *textFd = [[UITextField alloc] init];
    textFd.placeholder = @"请输入手机号";
    textFd.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:textFd];
    [textFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab2.bottom).offset(50);
        make.left.mas_equalTo(lab.mas_right);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
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
