//
//  HomePageViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "HomePageViewController.h"
#import "CommonViewController.h"
#import "ImgTitleView.h"
#import "HWTitleItemSelector.h"
#import "CommonTableViewCell.h"
#import "SDCycleScrollView.h"
#import "ScrollWithImage.h"
#import "CommonTableViewController.h"
#import "MJRefresh.h"
#import "ReactiveCocoa.h"

#warning 登陆入口
#import "LoginViewController.h"




@interface HomePageViewController ()<ImgTitleViewDelegate, HWTitleItemSelectorDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, ScrollWithImageDelegate>

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, assign) CGFloat lastContentOffset;

@property (nonatomic, assign)CGFloat threshold;
// 记录scrollView.contentInset.top
@property (nonatomic, assign)CGFloat marginTop;

@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) SDCycleScrollView *sdCycleScrollView;
@property (nonatomic, strong) NSArray *imgUrlArr;


@property (nonatomic, strong) UIView *itemBackView;
@property (nonatomic, strong) UIView *adBackView;

@property (nonatomic, strong) UIView *selectTitleBackV;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIScrollView *scrollBackV;
@property (nonatomic, strong) UITableView *leftTableV;
@property (nonatomic, strong) UITableView *rightTableV;


@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CommonTableViewController *tableViewController1;

@end

// MARK: 整个滑动区域backScrollV，最新、推荐放到headBackView上，当上移到segmentedControl时backScrollV停止滑动，继续滑动触发上拉加载，所以backScrollV上移的距离为headBackView的高度减去segmentedControl的上边

#define kSegmentControlHeight   40
#define kHeadBackVHeight   SCREENHEIGHT / 2 + kSegmentControlHeight    //上半部headBackView的高度
#define kBackScrollVHeight   SCREENHEIGHT-[ECStyle navigationbarHeight]-[ECStyle toolbarHeight]+(kHeadBackVHeight- kSegmentControlHeight)//kBackScrollVHeight：backScrollV的总高度为屏幕高度减去[ECStyle navigationbarHeight]和[ECStyle toolbarHeight]，再加上上移的距离
#define kMovingOffset   kHeadBackVHeight - kSegmentControlHeight

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupSubViews];
    
    [self setupItemsSubViews];
    
    [self setupAdSubViews];
    
    [self setupListSubViews];
    
    [self pullDownRefreshOperation];
    [self pullUpRefreshOperation];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    CGFloat titW = 60;
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, SCREENHEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
    self.backScrollV.backgroundColor = [UIColor cyanColor];
    self.backScrollV.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT - [ECStyle navigationbarHeight] - [ECStyle tabbarExtensionHeight] + 500);
    self.backScrollV.scrollEnabled = YES;
    //self.backScrollV.pagingEnabled = YES;
    self.backScrollV.userInteractionEnabled = YES;
    //self.backScrollV.directionalLockEnabled = YES;
    self.backScrollV.delegate = self;
    [self.view addSubview:self.backScrollV];
    if (@available(iOS 11.0, *)) {
        //self.backScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT / 2 + kSegmentControlHeight)];
    self.headBackView.backgroundColor = [UIColor redColor];
    [self.backScrollV addSubview:self.headBackView];
    
    self.sdCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.headBackView.height / 2) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    self.sdCycleScrollView.autoScrollTimeInterval = 3.0;
    self.sdCycleScrollView.imageURLStringsGroup = self.imgUrlArr;
    [self.headBackView addSubview:self.sdCycleScrollView];
    
    ScrollWithImage *scr = [[ScrollWithImage alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.headBackView.height) withArray:self.imgUrlArr withTimer:3 withOtherArray:nil];
    //[self.headBackView addSubview:scr];
    
    self.selectTitleBackV = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackView.bottom, SCREENWIDTH, kSegmentControlHeight)];
    self.selectTitleBackV.backgroundColor = [HWRandomColor randomColor];
    //[self.backScrollV addSubview:self.selectTitleBackV];

}
// MARK: items

- (void)setupItemsSubViews {
    self.itemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT / 4, SCREENWIDTH, SCREENHEIGHT / 8)];
    self.itemBackView.backgroundColor = [HWRandomColor randomColor];
    [self.headBackView addSubview:self.itemBackView];
    
    NSArray *arr = @[@{@"img":@"",@"title":@"附近兼职"},
                     @{@"img":@"",@"title":@"高薪兼职"},
                     @{@"img":@"",@"title":@"当日结算"},
                     @{@"img":@"",@"title":@"学生兼职"}];
    
    CGFloat spa = 20;
    CGFloat width = (SCREENWIDTH - spa * 5) / 4;
    
    for (NSInteger i = 0; i < arr.count; i++) {
        ImgTitleView *item = [[ImgTitleView alloc] initWithFrame:CGRectMake(spa + (i % 4) * (width + spa), spa / 2, width, width)];
        item.backgroundColor = [HWRandomColor randomColor];
        item.topImgV.image = [UIImage imageNamed:@""];
        item.titleLab.text = arr[i][@"title"];
        item.maskBtn.tag = 1000 + i;
        item.delegate = self;
        [self.itemBackView addSubview:item];
    }
}
// MARK: 广告

- (void)setupAdSubViews {
    
    CGFloat space = 20;
    CGFloat wid = (SCREENWIDTH - 20 * 4) / 2;
    
    self.adBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.itemBackView.bottom, SCREENWIDTH, SCREENHEIGHT / 8)];
    self.adBackView.backgroundColor = [HWRandomColor randomColor];
    [self.headBackView addSubview:self.adBackView];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [HWRandomColor randomColor];
    btn1.frame = CGRectMake(space, space, wid, self.adBackView.height - space * 2);
    btn1.layer.cornerRadius = 5;
    btn1.layer.masksToBounds = YES;
    [self.adBackView addSubview:btn1];
    [btn1 setTitle:@"广告1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(adBtnLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [HWRandomColor randomColor];
    btn2.frame = CGRectMake(btn1.right + space, space, wid, self.adBackView.height - space * 2);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    [self.adBackView addSubview:btn2];
    [btn2 setTitle:@"广告2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(adBtnRightAction:) forControlEvents:UIControlEventTouchUpInside];
}

// MARK: 列表

- (void)setupListSubViews {
    
    CGFloat titW = 60;
    
    NSArray *arrSele = @[@"最新", @"推荐"];
    for (NSInteger i = 0; i < 2; i++) {
        HWTitleItemSelector *sele = [[HWTitleItemSelector alloc] initWithFrame:CGRectMake(20 + (20 + titW) * i, self.adBackView.bottom, titW, kSegmentControlHeight)];
        sele.backgroundColor = [HWRandomColor randomColor];
        [sele.topBtn setTitle:arrSele[i] forState:UIControlStateNormal];
        sele.topBtn.tag = 999 + i;
        sele.delegate = self;
        [self.headBackView addSubview:sele];
    }

    self.scrollBackV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headBackView.bottom, SCREENWIDTH, SCREENHEIGHT)];
    self.scrollBackV.contentSize = CGSizeMake(SCREENWIDTH * 2, SCREENHEIGHT - self.backScrollV.height);
    self.scrollBackV.delegate = self;
    [self.backScrollV addSubview:self.scrollBackV];

    self.leftTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.scrollBackV.height) style:UITableViewStylePlain];
    self.leftTableV.delegate = self;
    self.leftTableV.dataSource = self;
    [self.scrollBackV addSubview:self.leftTableV];
    [self.leftTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"leftTableV"];
//    self.leftTableV.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        //[self.leftTableV.mj_header endRefreshing];
//    }];
    

    self.rightTableV = [[UITableView alloc] initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, self.scrollBackV.height) style:UITableViewStylePlain];
    self.rightTableV.delegate = self;
    self.rightTableV.dataSource = self;
    [self.scrollBackV addSubview:self.rightTableV];
    [self.rightTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"rightTableV"];
    
    
//    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.items];
//    self.segmentedControl.frame = CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, 40);
//    //self.segmentedControl.selectedSegmentIndex = self.typeInteger;
//    [self.view addSubview:self.segmentedControl];
//    self.segmentedControl.tintColor = [UIColor clearColor];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],
//                             NSFontAttributeName,[HWRandomColor randomColor],NSForegroundColorAttributeName,nil];
//    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
//    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17],NSFontAttributeName,[HWRandomColor randomColor],NSForegroundColorAttributeName, nil];
//    [self.segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateSelected];
//    [self.segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
//
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.bottom, SCREENWIDTH, SCREENHEIGHT - [ECStyle navigationbarHeight] - self.segmentedControl.height - [ECStyle tabbarExtensionHeight])];
//    self.scrollView.backgroundColor = [HWRandomColor randomColor];
//    self.scrollView.delegate = self;
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.bounces = YES;
//    [self.view addSubview:self.scrollView];
//    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * self.items.count, SCREENHEIGHT - [ECStyle navigationbarHeight] - self.segmentedControl.height);
//
//    self.tableViewController1 = [[CommonTableViewController alloc] initWithStyle:UITableViewStylePlain];
//    self.tableViewController1.view.frame = CGRectMake(0, 0, SCREENWIDTH, self.scrollView.height);
//    [self.scrollView addSubview:self.tableViewController1.view];
}


- (void)pullDownRefreshOperation {
    self.backScrollV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];

}

- (void)pullUpRefreshOperation {
    self.backScrollV.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [self loadNewData];
    }];
}

- (void)loadNewData {
    [self.backScrollV.mj_header endRefreshing];
    
    [self.backScrollV.mj_footer endRefreshing];
}


#pragma mark delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

}


- (void)ImgTitleViewACtion:(NSInteger)index {
    CommonViewController *com = [[CommonViewController alloc] init];
    if (index == 1000) {
        com.titleStr = @"附近兼职";
    }else if(index == 1001) {
        com.titleStr = @"高薪兼职";
    }else if (index == 1002) {
        com.titleStr = @"当日结算";
    }else if (index == 1003) {
        com.titleStr = @"学生结算";
    }
    [self.navigationController pushViewController:com animated:YES];
}

- (void)adBtnLeftAction:(UIButton *)send {
    
}

- (void)adBtnRightAction:(UIButton *)send {
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    
}

- (void)hw_titleItemSelectorAction:(NSInteger)index {
    if (index == 999) {
        self.scrollBackV.contentOffset = CGPointMake(0, 0);
    }else if (index == 1000) {
        self.scrollBackV.contentOffset = CGPointMake(SCREENWIDTH, 0);
    }

}


- (void)segmentedControlAction:(UISegmentedControl *)segment {
    
    NSLog(@"-----%ld", (long)segment.selectedSegmentIndex);
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        
    }else if (self.segmentedControl.selectedSegmentIndex == 1) {
        
    }else if (self.segmentedControl.selectedSegmentIndex == 2) {
        
    }
    
    self.scrollView.contentOffset = CGPointMake(SCREENWIDTH * segment.selectedSegmentIndex, 0);
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.scrollView == scrollView) {
//        self.segmentedControl.selectedSegmentIndex = self.scrollView.contentOffset.x / SCREENWIDTH;
//    }
//}


#pragma mark UIScrollView delegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.backScrollV == scrollView) {
       
        CGFloat hight = scrollView.frame.size.height;
        CGFloat contentOffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
        CGFloat offset = contentOffset - self.lastContentOffset;
        self.lastContentOffset = contentOffset;
        
        if (offset > 0 && contentOffset > 0) {
            NSLog(@"上拉行为");
            if (scrollView.contentOffset.y >= kMovingOffset) {
                //scrollView.scrollEnabled = NO;
                
            }//else {
//                scrollView.scrollEnabled = YES;
//            }
        }
        if (offset < 0 && distanceFromBottom > hight) {
            NSLog(@"下拉行为");
            //scrollView.scrollEnabled = YES;
        }
        if (contentOffset == 0) {
            NSLog(@"滑动到顶部");
        }
        if (distanceFromBottom < hight) {
            NSLog(@"滑动到底部");
            
        }
        
    }

    
        
        
//        if (scrollView.contentOffset.y > 0) {
//            NSLog(@"aaa");
//            if (scrollView.contentOffset.y >= kMovingOffset) {
//                scrollView.scrollEnabled = NO;
//            }
//        }else {
//            scrollView.scrollEnabled = NO;
//        }

    
//    if (self.leftTableV == scrollView) {
//        CGFloat hight = scrollView.frame.size.height;
//        CGFloat contentOffset = scrollView.contentOffset.y;
//        CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
//        CGFloat offset = contentOffset - self.lastContentOffset;
//        self.lastContentOffset = contentOffset;
//        if (offset > 0 && contentOffset > 0) {
//            NSLog(@"上拉行为");
//            scrollView.scrollEnabled = YES;
//        }
//        if (offset < 0 && distanceFromBottom > hight) {
//            NSLog(@"下拉行为");
//            scrollView.scrollEnabled = NO;
//        }
//
//    }
    
    
//    if (self.scrollBackV.contentOffset.x == 0) {
//        //self.leftBtn.selected = YES;
//        //self.rightBtn.selected = NO;
//    }else if (self.scrollBackV.contentOffset.x == SCREENWIDTH){
//        //self.leftBtn.selected = NO;
//        //self.rightBtn.selected = YES;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.leftTableV == tableView) {
        return 3;
    }else if (self.rightTableV == tableView) {
        return 5;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell;
    //UITableViewCell *cell;
    if (self.leftTableV == tableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"leftTableV"];
        cell.tagImgV.image = [UIImage imageNamed:@""];
        cell.titleLab.text = @"大望路服务员收银员";
        cell.locationLab.text = @"朝阳";
        cell.accountStyleLab.text = @"月结";
        cell.princeLab.text = @"180/天";
        cell.tagLab.text = @"可长期";
 //       cell.textLabel.text = @"1";
        return cell;
    }else if (self.rightTableV == tableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"rightTableV"];
        cell.tagImgV.image = [UIImage imageNamed:@""];
        cell.titleLab.text = @"大望路服务员收银员";
        cell.locationLab.text = @"朝阳";
        cell.accountStyleLab.text = @"月结";
        cell.princeLab.text = @"180/天";
        cell.tagLab.text = @"可长期";
        //cell.textLabel.text = @"2";
        return cell;
    }else {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark getter

- (NSArray *)imgUrlArr {
    if (!_imgUrlArr) {
        _imgUrlArr = @[@"placeholder.jpg", @"placeholder.jpg", @"placeholder.jpg", @"placeholder.jpg"];
    }
    return _imgUrlArr;
}

- (NSArray *)items {
    if (!_items) {
        _items = @[@"推荐", @"最新"];;
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
