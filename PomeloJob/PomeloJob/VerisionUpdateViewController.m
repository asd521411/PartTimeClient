//
//  VerisionUpdateViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/29.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "VerisionUpdateViewController.h"

@interface VerisionUpdateViewController ()

@end

@implementation VerisionUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNewFeature];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSLog(@"viewappeat");
}

- (void)addNewFeature{
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    back.backgroundColor = [UIColor whiteColor];
    //[self.window addSubview:back];
    
    [self.view addSubview:back];
    
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banbengengxin"]];
    img.frame = CGRectMake((KSCREEN_WIDTH-215)/2, 100, 215, 220);
    img.userInteractionEnabled = YES;
    [back addSubview:img];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, img.width, 20)];
    lab.text = @"版本更新了！";
    lab.textColor = kColor_Main;
    lab.textAlignment = NSTextAlignmentCenter;
    [img addSubview:lab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = kColor_Main;
    btn.frame = CGRectMake((img.width-115)/2, lab.bottom+20, 115, 30);
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"版本更新了！" forState:UIControlStateNormal];
    [img addSubview:btn];
    __weak typeof(self) weakSelf = self;
    
    [btn addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)update:(UIButton *)sender {
    
    [self openItuns];
    
}

-(void)openItuns{
    NSURL*url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8",@"1481210769"]];
    //NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", @"1481210769"]];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen){   //打开微信
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                NSLog(@"哈哈哈哈哈哈哈哈哈");
            }];
        });
    }else {
    }
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
