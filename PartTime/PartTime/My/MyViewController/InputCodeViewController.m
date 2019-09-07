//
//  InputCodeViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "InputCodeViewController.h"
#import "ReactiveCocoa.h"
@interface InputCodeViewController ()

@end

@implementation InputCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输入验证码";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREENWIDTH / 3, 200, SCREENWIDTH / 3, 50);
    btn.backgroundColor = [HWRandomColor randomColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
//    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        InputCodeViewController *input = [[InputCodeViewController alloc] init];
//        [weakSelf.navigationController pushViewController:input animated:YES];
//    }];
    
    
    // Do any additional setup after loading the view.
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
