//
//  PomeloRecordDefaultViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloRecordDefaultViewController.h"
#import "PomeloCommonTableViewController.h"
#import "PomeloLimitOneTableViewController.h"
#import "PomeloLimitTwoTableViewController.h"
#import "PomeloLimitThreeTableViewController.h"
#import "PomeloLimitFourTableViewController.h"
#import "PomeloLimitFiveTableViewController.h"
#import "MJRefresh.h"

@interface PomeloRecordDefaultViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) PomeloLimitOneTableViewController *tableViewController1;
@property (nonatomic, strong) PomeloLimitTwoTableViewController *tableViewController2;
@property (nonatomic, strong) PomeloLimitThreeTableViewController *tableViewController3;
@property (nonatomic, strong) PomeloLimitFourTableViewController *tableViewController4;
@property (nonatomic, strong) PomeloLimitFiveTableViewController *tableViewController5;

@property (nonatomic, strong) NSMutableArray *parametersArr;

@end

@implementation PomeloRecordDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)setupSubViews {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.items];
    self.segmentedControl.frame = CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, 40);
    self.segmentedControl.selectedSegmentIndex = self.typeInteger;
    [self.view addSubview:self.segmentedControl];
    self.segmentedControl.tintColor = [UIColor clearColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KFontNormalSize12,
                         NSFontAttributeName, KColor_212121, NSForegroundColorAttributeName, nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:KFontNormalSize14, NSFontAttributeName, KColorMain_FF4457, NSForegroundColorAttributeName, nil];
    [self.segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
   
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.bottom, SCREENWIDTH, SCREENHEIGHT - [ECStyle navigationbarHeight] - self.segmentedControl.height - [ECStyle tabbarExtensionHeight])];
    self.scrollView.backgroundColor = [HWRandomColor randomColor];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * self.items.count, SCREENHEIGHT - [ECStyle navigationbarHeight] - self.segmentedControl.height);
    
    self.tableViewController1 = [[PomeloLimitOneTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController1.view.frame = CGRectMake(0, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController1.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController1.view];
    
    self.tableViewController2 = [[PomeloLimitTwoTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController2.view.frame = CGRectMake(KSCREEN_WIDTH, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController2.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController2.view];
    
    self.tableViewController3 = [[PomeloLimitThreeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController3.view.frame = CGRectMake(KSCREEN_WIDTH * 2, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController3.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController3.view];
    
    self.tableViewController4 = [[PomeloLimitFourTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController4.view.frame = CGRectMake(KSCREEN_WIDTH * 3, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController3.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController4.view];

    self.tableViewController5 = [[PomeloLimitFiveTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController5.view.frame = CGRectMake(KSCREEN_WIDTH * 4, 0, SCREENWIDTH, self.scrollView.height);
    [self.tableViewController5.tableView.mj_header beginRefreshing];
    [self.scrollView addSubview:self.tableViewController5.view];
    
}

#pragma action

- (void)segmentedControlAction:(UISegmentedControl *)segment {
    
    self.scrollView.contentOffset = CGPointMake(SCREENWIDTH * segment.selectedSegmentIndex, 0);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollView == scrollView) {
        self.segmentedControl.selectedSegmentIndex = self.scrollView.contentOffset.x / SCREENWIDTH;
    }
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"====%f", self.scrollView.contentOffset.x);
//
//}

- (NSMutableArray *)parametersArr {
    if (!_parametersArr) {
        _parametersArr = [[NSMutableArray alloc] initWithObjects:@"看过我", @"我看过", @"已申请", @"待面试", @"收藏", nil];
    }
    return _parametersArr;
}

- (NSArray *)items {
    if (!_items) {
        _items = @[@"看过我", @"我看过", @"已申请", @"待面试", @"收藏"];;
    }
    return _items;
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
