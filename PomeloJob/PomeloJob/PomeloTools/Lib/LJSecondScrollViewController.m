//
//  LJSecondScrollViewController.m
//  LJDemo
//
//  Created by lj on 2017/5/5.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJSecondScrollViewController.h"
#import "LJDynamicItem.h"
#import "MJRefresh.h"
#import "ImgTitleView.h"
#import "NavigationBarView.h"
#import "ReactiveCocoa.h"
#import "PomeloCommonTableViewController.h"
#import "CommonTableViewCell.h"
#import "CommonModel.h"
#import "CommonDetailsViewController.h"
#import "CommonImgModel.h"
#import "MJExtension.h"
#import "SDCycleScrollView.h"
#import "UIButton+WebCache.h"


/*f(x, d, c) = (x * d * c) / (d + c * x)
 where,
 x – distance from the edge
 c – constant (UIScrollView uses 0.55)
 d – dimension, either width or height*/

static CGFloat rubberBandDistance(CGFloat offset, CGFloat dimension) {
    
    const CGFloat constant = 0.55f;
    CGFloat result = (constant * fabs(offset) * dimension) / (dimension + constant * fabs(offset));
    // The algorithm expects a positive offset, so we have to negate the result if the offset was negative.
    return offset < 0.0f ? -result : result;
}

@interface LJSecondScrollViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, ImgTitleViewDelegate, UIScrollViewDelegate, SDCycleScrollViewDelegate> {
    CGFloat currentScorllY;
    
    NSMutableArray *tableArray;
    
    __block BOOL isVertical;//是否是垂直
    
    UIPanGestureRecognizer *pan;
}

@property (nonatomic, strong) NavigationBarView  *navigationBarView;

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *headBackView;

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) NSMutableArray *imgUrlArr;
@property (nonatomic, strong) NSMutableArray *adUrlArr;
@property (nonatomic, strong) NSArray *positionTypeArr;

@property (nonatomic, strong) UIView *itemBackView;
@property (nonatomic, strong) UIButton *aDbtn1;
@property (nonatomic, strong) UIButton *aDbtn2;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) PomeloCommonTableViewController *tableViewController1;

// MARK:subTableView

@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, strong) NSArray *subTableViewArr;
@property (nonatomic, strong) NSMutableArray *listMutArr;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

// MARK: subScrollView

@property (nonatomic, strong) UIScrollView *subScrollView;
@property (nonatomic, strong) NSArray *subScrollViewArr;


//弹性和惯性动画
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, weak) UIDynamicItemBehavior *decelerationBehavior;
@property (nonatomic, strong) LJDynamicItem *dynamicItem;
@property (nonatomic, weak) UIAttachmentBehavior *springBehavior;

@end


//banner:202*99
#define kBannerWidth        (KSCREEN_WIDTH - 30)
#define kBannerHeight       (kBannerWidth * 230 / 690)

//itemBackView高度: k
#define kItemViewWidth      ((KSCREEN_WIDTH - 46 - 65 * 3) / 4)
#define kItemViewHeight     kItemViewWidth
#define kItemBackViewHeight (kItemViewHeight + 30 + 10 + 12)

//adView的高度:345.0*67
#define KAdViewWidth        (KSCREEN_WIDTH - 15 * 3) / 2
#define KAdViewHeight       (KAdViewWidth * 210 / 330)

#define kSegmentControlHeight   20
//有图片，根据图片伸缩计算headBackView高度
#define kHeadBackVHeight   (kBannerHeight + kItemBackViewHeight + KAdViewHeight + kSegmentControlHeight + 30)    //上半部headBackView的高度

//偏移到kSegmentControlHeight上边
#define maxOffsetY  (kHeadBackVHeight - kSegmentControlHeight - 30)

@implementation LJSecondScrollViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCombinationViews];
    
    [self setupHeadViews];
    
    [self loadData];
}

- (void)addrefresh {
    self.mainScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBarView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationBarView.hidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.animator removeAllBehaviors];
}

- (void)loadData {
    
    [[HWAFNetworkManager shareManager] commonAcquireImg:@{@"imgtype":@"首页"} firstImg:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            
//            [self.imgUrlArr removeAllObjects];
//            [self.adUrlArr removeAllObjects];
//            self.bannerView.imageURLStringsGroup = nil;
            
            self.imgUrlArr = [CommonImgModel mj_objectArrayWithKeyValuesArray:dic[@"img"]];
            self.adUrlArr = [CommonImgModel mj_objectArrayWithKeyValuesArray:dic[@"imgfixed"]];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (CommonImgModel *img in self.imgUrlArr) {
                [arr addObject:img.imgpath];
            }
            self.bannerView.imageURLStringsGroup = arr;
            CommonImgModel *img1 = self.adUrlArr[0];
            CommonImgModel *img2 = self.adUrlArr[1];
            [self.aDbtn1 sd_setBackgroundImageWithURL:[NSURL URLWithString:img1.imgpath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ad1"]];
            [self.aDbtn2 sd_setBackgroundImageWithURL:[NSURL URLWithString:img2.imgpath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ad2"]];
        }
    }];
    
}

- (void)setupNavigationBarV {
    self.navigationBarView = [[NavigationBarView alloc] init];
    self.navigationBarView.locationNameLab.text = @"北京";
    [self.navigationController.navigationBar addSubview:self.navigationBarView];
    [self.navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.navigationController.navigationBar);
    }];
}

- (void)setupCombinationViews {
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.subScrollView];
    self.mainScrollView.contentSize = CGSizeMake(KSCREEN_WIDTH, maxOffsetY + self.subScrollView.height);
    [self.mainScrollView addSubview:self.headBackView];
    
    pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.dynamicItem = [[LJDynamicItem alloc] init];
}

- (void)setupHeadViews {
    
    self.headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kHeadBackVHeight)];
    [self.mainScrollView addSubview:self.headBackView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackView.bottom - KLineWidthMeasure05, self.headBackView.width, KLineWidthMeasure05)];
    line.backgroundColor = KColor_Line;
    [self.headBackView addSubview:line];
    
    self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(15, 0, KSCREEN_WIDTH - 30, kBannerHeight) delegate:self placeholderImage:[UIImage imageNamed:@" "]];
    self.bannerView.backgroundColor = [UIColor whiteColor];
    self.bannerView.layer.cornerRadius = 10;
    self.bannerView.layer.masksToBounds = YES;
    self.bannerView.autoScrollTimeInterval = 3.0;
    [self.headBackView addSubview:self.bannerView];
    
    self.itemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bannerView.bottom, KSCREEN_WIDTH, kItemViewHeight + 30 + 10 + 12)];
    [self.headBackView addSubview:self.itemBackView];
    
    for (NSInteger i = 0; i < self.positionTypeArr.count; i++) {
        ImgTitleView *item = [[ImgTitleView alloc] initWithFrame:CGRectMake(23 + (i % 4) * (kItemViewWidth + 65), 15, kItemViewWidth, kItemViewHeight)];
        item.topImgV.image = [UIImage imageNamed:self.positionTypeArr[i][@"img"]];
        item.titleLab.text = self.positionTypeArr[i][@"title"];
        item.maskBtn.tag = 1000 + i;
        item.delegate = self;
        [self.itemBackView addSubview:item];
    }
    
    self.aDbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.aDbtn1.frame = CGRectMake(15, self.itemBackView.bottom, KAdViewWidth, KAdViewHeight);
    self.aDbtn1.layer.cornerRadius = 2;
    self.aDbtn1.layer.masksToBounds = YES;
    [self.headBackView addSubview:self.aDbtn1];
    self.aDbtn1.adjustsImageWhenHighlighted = NO;
    
    [[self.aDbtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
        CommonImgModel *model = self.adUrlArr[0];
        detail.positionid = model.positionid;
        detail.clickStyleStr = @"固定";
        detail.indexStr = @"1";
        [self.navigationController pushViewController:detail animated:YES];
    }];
    
    self.aDbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.aDbtn2.frame = CGRectMake(self.aDbtn1.right + 15, self.aDbtn1.top, self.aDbtn1.width, self.aDbtn1.height);
    self.aDbtn2.layer.cornerRadius = 5;
    self.aDbtn2.layer.masksToBounds = YES;
    [self.headBackView addSubview:self.aDbtn2];
    self.aDbtn2.adjustsImageWhenHighlighted = NO;
    
    [[self.aDbtn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
        CommonImgModel *model = self.adUrlArr[1];
        detail.positionid = model.positionid;
        detail.clickStyleStr = @"固定";
        detail.indexStr = @"2";
        [self.navigationController pushViewController:detail animated:YES];
    }];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.subScrollViewArr];
    self.segmentedControl.frame = CGRectMake(15, self.aDbtn2.bottom + 15, 90, kSegmentControlHeight);
    [self.headBackView addSubview:self.segmentedControl];
    self.segmentedControl.tintColor = [UIColor clearColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],
                         NSFontAttributeName, [ECUtil colorWithHexString:@"928f8f"],NSForegroundColorAttributeName,nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18],NSFontAttributeName,kCOLOR_BLACK,NSForegroundColorAttributeName, nil];
    [self.segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
 
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView  == tableArray[0]) {
        if (self.listMutArr[0] != nil) {
            NSArray *arr =  self.listMutArr[0];
            if (arr.count > 0) {
                return arr.count;
            }else {
                return 0;
            }
        }else {
            return 0;
        }
    }
    if (tableView == tableArray[1]) {
        if (self.listMutArr[1] != nil) {
            NSArray *arr =  self.listMutArr[1];
            if (arr.count > 0) {
                return arr.count;
            }else {
                return 0;
            }
        }else {
            return 0;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    if (cell == nil) {
        cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonTableViewCell"];
        if (tableView == tableArray[0]) {
            cell.commonModel = self.listMutArr[0][indexPath.row];
        }
        if (tableView == tableArray[1]) {
            cell.commonModel = self.listMutArr[1][indexPath.row];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
    if (tableView == tableArray[0]) {
        CommonModel *model = self.listMutArr[0][indexPath.row];
        detail.clickStyleStr = @"推荐";
        detail.positionid = model.positionid;
    }
    if (tableView == tableArray[1]) {
        CommonModel *model = self.listMutArr[1][indexPath.row];
        detail.clickStyleStr = @"最新";
        detail.positionid = model.positionid;
    }
    detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.subScrollView == scrollView) {
        self.segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x / self.subScrollView.width;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.subScrollView) {
        CGFloat a = self.subScrollView.contentOffset.x/self.subScrollView.frame.size.width;
        self.subTableView = [tableArray objectAtIndex:a];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat currentY = [recognizer translationInView:self.view].y;
        CGFloat currentX = [recognizer translationInView:self.view].x;
        
        if (currentY == 0.0) {
            return YES;
        } else {
            if (fabs(currentX)/currentY >= 5.0) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    return NO;
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            currentScorllY = self.mainScrollView.contentOffset.y;
            CGFloat currentY = [recognizer translationInView:self.view].y;
            CGFloat currentX = [recognizer translationInView:self.view].x;
            
            if (currentY == 0.0) {
                isVertical = NO;
            } else {
                if (fabs(currentX)/currentY >= 5.0) {
                    isVertical = NO;
                } else {
                    isVertical = YES;
                }
            }
            [self.animator removeAllBehaviors];
            break;
        case UIGestureRecognizerStateChanged:
        {
            //locationInView:获取到的是手指点击屏幕实时的坐标点；
            //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
            
            if (isVertical) {
                //往上滑为负数，往下滑为正数
                CGFloat currentY = [recognizer translationInView:self.view].y;
                [self controlScrollForVertical:currentY AndState:UIGestureRecognizerStateChanged];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (isVertical) {
                self.dynamicItem.center = self.view.bounds.origin;
                //velocity是在手势结束的时候获取的竖直方向的手势速度
                CGPoint velocity = [recognizer velocityInView:self.view];
                UIDynamicItemBehavior *inertialBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicItem]];
                [inertialBehavior addLinearVelocity:CGPointMake(0, velocity.y) forItem:self.dynamicItem];
                // 通过尝试取2.0比较像系统的效果
                inertialBehavior.resistance = 2.0;
                __block CGPoint lastCenter = CGPointZero;
                __weak typeof(self) weakSelf = self;
                inertialBehavior.action = ^{
                    if (self->isVertical) {
                        //得到每次移动的距离
                        CGFloat currentY = weakSelf.dynamicItem.center.y - lastCenter.y;
                        [weakSelf controlScrollForVertical:currentY AndState:UIGestureRecognizerStateEnded];
                    }
                    lastCenter = weakSelf.dynamicItem.center;
                };
                [self.animator addBehavior:inertialBehavior];
                self.decelerationBehavior = inertialBehavior;
            }
        }
            break;
        default:
            break;
    }
    //保证每次只是移动的距离，不是从头一直移动的距离
    [recognizer setTranslation:CGPointZero inView:self.view];
}

//控制上下滚动的方法
- (void)controlScrollForVertical:(CGFloat)detal AndState:(UIGestureRecognizerState)state {
    //判断是主ScrollView滚动还是子ScrollView滚动,detal为手指移动的距离
    if (self.mainScrollView.contentOffset.y >= maxOffsetY) {
        
        CGFloat offsetY = self.subTableView.contentOffset.y - detal;
        if (offsetY < 0) {
            //当子ScrollView的contentOffset小于0之后就不再移动子ScrollView，而要移动主ScrollView
            offsetY = 0;
            self.mainScrollView.contentOffset = CGPointMake(self.mainScrollView.frame.origin.x, self.mainScrollView.contentOffset.y - detal);
        } else if (offsetY > (self.subTableView.contentSize.height - self.subTableView.frame.size.height)) {
            //当子ScrollView的contentOffset大于tableView的可移动距离时
            
            offsetY = self.subTableView.contentOffset.y - rubberBandDistance(detal, KSCREEN_HEIGHT);
        }
        self.subTableView.contentOffset = CGPointMake(0, offsetY);
    } else {
        CGFloat mainOffsetY = self.mainScrollView.contentOffset.y - detal;
        if (mainOffsetY < 0) {
            mainOffsetY = self.mainScrollView.contentOffset.y - rubberBandDistance(detal, KSCREEN_HEIGHT);
            
        } else if (mainOffsetY > maxOffsetY) {
            mainOffsetY = maxOffsetY;
        }
        self.mainScrollView.contentOffset = CGPointMake(self.mainScrollView.frame.origin.x, mainOffsetY);
        
        if (mainOffsetY == 0) {
            for (UITableView *tableView in tableArray) {
                tableView.contentOffset = CGPointMake(0, 0);
            }
        }
    }
    
    BOOL outsideFrame = [self outsideFrame];
    if (outsideFrame &&
        (self.decelerationBehavior && !self.springBehavior)) {
        CGPoint target = CGPointZero;
        BOOL isMian = NO;
        if (self.mainScrollView.contentOffset.y < 0) {
            self.dynamicItem.center = self.mainScrollView.contentOffset;
            target = CGPointZero;
            isMian = YES;
        } else if (self.subTableView.contentOffset.y > (self.subTableView.contentSize.height - self.subTableView.frame.size.height)) {
            self.dynamicItem.center = self.subTableView.contentOffset;
            
            target.x = self.subTableView.contentOffset.x;
            target.y = self.subTableView.contentSize.height > self.subTableView.frame.size.height ? self.subTableView.contentSize.height - self.subTableView.frame.size.height: 0;
            isMian = NO;
        }
        [self.animator removeBehavior:self.decelerationBehavior];
        __weak typeof(self) weakSelf = self;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.dynamicItem attachedToAnchor:target];
        springBehavior.length = 0;
        springBehavior.damping = 1;
        springBehavior.frequency = 2;
        springBehavior.action = ^{
            if (isMian) {
                weakSelf.mainScrollView.contentOffset = weakSelf.dynamicItem.center;
                if (weakSelf.mainScrollView.contentOffset.y == 0) {
                    for (UITableView *tableView in self->tableArray) {
                        tableView.contentOffset = CGPointMake(0, 0);
                    }
                }
            } else {
                weakSelf.subTableView.contentOffset = self.dynamicItem.center;
                if (weakSelf.subTableView.mj_footer.refreshing) {
                    weakSelf.subTableView.contentOffset = CGPointMake(weakSelf.subTableView.contentOffset.x, weakSelf.subTableView.contentOffset.y + 44);
                }
            }
        };
        [self.animator addBehavior:springBehavior];
        self.springBehavior = springBehavior;
    }
}

//判断是否超出ViewFrame边界
- (BOOL)outsideFrame {
    if (self.mainScrollView.contentOffset.y < 0) {
        return YES;
    }
    if (self.subTableView.contentSize.height > self.subTableView.frame.size.height) {
        if (self.subTableView.contentOffset.y > (self.subTableView.contentSize.height - self.subTableView.frame.size.height)) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if (self.subTableView.contentOffset.y > 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

#pragma mark delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
    CommonModel *model = self.imgUrlArr[index];
    detail.positionid = model.positionid;
    detail.clickStyleStr = @"轮播";
    detail.indexStr = [NSString stringWithFormat:@"%ld", (long)index];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)ImgTitleViewACtion:(NSInteger)index {
    CommonViewController *com = [[CommonViewController alloc] init];
    com.titleStr = self.positionTypeArr[index - 1000][@"title"];
    [self.navigationController pushViewController:com animated:YES];
}

- (void)segmentedControlAction:(UISegmentedControl *)segment {
    self.subScrollView.contentOffset = CGPointMake(self.segmentedControl.selectedSegmentIndex * KSCREEN_WIDTH, 0);
}

#pragma mark getter

- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle tabbarExtensionHeight])];
        _mainScrollView.delegate = self;
        _mainScrollView.scrollEnabled = NO;
    }
    return _mainScrollView;
}

- (UIScrollView *)subScrollView {
    if (_subScrollView == nil) {
        _subScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, maxOffsetY + [ECStyle navigationbarHeight] - 14, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight])];
        _subScrollView.contentSize = CGSizeMake(KSCREEN_WIDTH * self.subScrollViewArr.count, _subScrollView.height);
        _subScrollView.pagingEnabled = YES;
        _subScrollView.scrollEnabled = YES;
        _subScrollView.delegate = self;
        tableArray = [NSMutableArray array];
        
        self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, _subScrollView.height) style:UITableViewStylePlain];
        self.tableView1.delegate = self;
        self.tableView1.dataSource = self;
        self.tableView1.scrollEnabled = NO;
        
        for (int i = 0; i < self.subScrollViewArr.count; i++) {
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i * KSCREEN_WIDTH, 0, KSCREEN_WIDTH, _subScrollView.height - 100)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.scrollEnabled = NO;
            //tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
                //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSDictionary *para1 = @{@"positionStatus":self.subScrollViewArr[i]};
                    [[HWAFNetworkManager shareManager] position:para1 postion:^(BOOL success, id  _Nonnull request) {
                        NSArray *resultArr = request;
                        if (success) {
                            //[self.listMutArr removeObjectAtIndex:i];
                            [self.listMutArr[i] removeAllObjects];
                            self.listMutArr[i] = [CommonModel mj_objectArrayWithKeyValuesArray:resultArr];
                            [tableView reloadData];
                            //[tableView.mj_footer  endRefreshing];
                        }
                    }];
                //});
            //}];
            //[tableView.mj_footer beginRefreshing];
            [_subScrollView addSubview:tableView];
            [tableArray addObject:tableView];
            [tableView.mj_footer endRefreshing];
        }
        self.subTableView = tableArray.firstObject;
    }
    return _subScrollView;
}

- (NSMutableArray *)imgUrlArr {
    if (!_imgUrlArr) {
        _imgUrlArr = [[NSMutableArray alloc] init];
    }
    return _imgUrlArr;
}

- (NSMutableArray *)adUrlArr {
    if (!_adUrlArr) {
        _adUrlArr = [[NSMutableArray alloc] init];
    }
    return _adUrlArr;
}

- (NSArray *)subScrollViewArr {
    if (!_subScrollViewArr) {
        _subScrollViewArr = @[@"推荐", @"最新"];
    }
    return _subScrollViewArr;
}

- (NSArray *)positionTypeArr {
    if (!_positionTypeArr) {
        _positionTypeArr = @[@{@"img":@"fujinjianzhi",@"title":@"附近兼职"},
                             @{@"img":@"gaoxinjianzhi",@"title":@"高薪兼职"},
                             @{@"img":@"dangrijiesuan",@"title":@"当日结算"},
                             @{@"img":@"xueshengjianzhi",@"title":@"学生兼职"}];
    }
    return _positionTypeArr;
}

- (NSMutableArray *)listMutArr {
    if (!_listMutArr) {
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        NSMutableArray *arr2 = [[NSMutableArray alloc] init];
        //self.listMutArr = [[NSMutableArray alloc] initWithObjects:@[],@[], nil];
        //_listMutArr = [[NSMutableArray alloc] initWithObjects:@[],@[], nil];
        _listMutArr = [[NSMutableArray alloc] init];
        [_listMutArr addObject:arr1];
        [_listMutArr addObject:arr2];
    }
    return _listMutArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
