//
//  PomeloMessageViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloMessageViewController.h"

@interface PomeloMessageViewController ()

@end

@implementation PomeloMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    
//    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight] + 10, KSCREEN_WIDTH, 30)];
//    back.backgroundColor = KColor_Line;
//    [self.view addSubview:back];
//    
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KSCREEN_WIDTH / 2, 30)];
//    lab.text = @"系统消息";
//    lab.textColor = KColorGradient_light;
//    lab.textAlignment = NSTextAlignmentLeft;
//    lab.font = kFontNormalSize(18);
//    [back addSubview:lab];
//    
//    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(15, back.bottom + 10, KSCREEN_WIDTH / 2, 40)];
//    lab1.text = @"最近沟通";
//    lab1.textAlignment = NSTextAlignmentLeft;
//    lab1.font = KFontNormalSize14;
//    [self.view addSubview:lab1];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 225, 120)];
    backImg.center = self.view.center;
    backImg.image = [UIImage imageNamed:@"messagedefault"];
    [self.view addSubview:backImg];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, backImg.bottom+15, KSCREEN_WIDTH-30, 20)];
    lab.text = @"还没收到消息";
    lab.textColor = kColor_Main;
    lab.font = kFontNormalSize(16);
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
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
