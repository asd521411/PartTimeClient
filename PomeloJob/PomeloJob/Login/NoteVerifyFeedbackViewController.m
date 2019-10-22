//
//  NoteVerifyFeedbackViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/17.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "NoteVerifyFeedbackViewController.h"

@interface NoteVerifyFeedbackViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UITableView *tableV;

@end

@implementation NoteVerifyFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"为什么收不到短信？";
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
//    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
//    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
//    [self.view addSubview:self.backScrollV];
//
//    UILabel *lab = [UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
//
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, KSCREEN_WIDTH, 40);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
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
