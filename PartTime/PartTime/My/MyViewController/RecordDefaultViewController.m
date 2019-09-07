//
//  RecordDefaultViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "RecordDefaultViewController.h"
#import "CommonTableViewController.h"

@interface RecordDefaultViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CommonTableViewController *tableViewController1;


@end

@implementation RecordDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.items];
    self.segmentedControl.frame = CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, 40);
    self.segmentedControl.selectedSegmentIndex = self.typeInteger;
    [self.view addSubview:self.segmentedControl];
    self.segmentedControl.tintColor = [UIColor clearColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],
                         NSFontAttributeName,[HWRandomColor randomColor],NSForegroundColorAttributeName,nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17],NSFontAttributeName,[HWRandomColor randomColor],NSForegroundColorAttributeName, nil];
    [self.segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
   
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.bottom, SCREENWIDTH, SCREENHEIGHT - [ECStyle navigationbarHeight] - self.segmentedControl.height - [ECStyle tabbarExtensionHeight])];
    self.scrollView.backgroundColor = [HWRandomColor randomColor];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * self.items.count, SCREENHEIGHT - [ECStyle navigationbarHeight] - self.segmentedControl.height);
    
    self.tableViewController1 = [[CommonTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController1.view.frame = CGRectMake(0, 0, SCREENWIDTH, self.scrollView.height);
    [self.scrollView addSubview:self.tableViewController1.view];
    
}


#pragma action

- (void)segmentedControlAction:(UISegmentedControl *)segment {
    
    NSLog(@"-----%ld", (long)segment.selectedSegmentIndex);
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        
    }else if (self.segmentedControl.selectedSegmentIndex == 1) {
        
    }else if (self.segmentedControl.selectedSegmentIndex == 2) {
        
    }
    
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
