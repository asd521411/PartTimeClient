//
//  YNSuspendTopPausePageVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/7/14.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNSuspendTopPausePageVC.h"
#import "SDCycleScrollView.h"
#import "BaseTableViewVC.h"
#import "YNSuspendTopPauseBaseTableViewVC.h"
#import "MJRefresh.h"
#import "UIView+YNPageExtend.h"
#import "ImgTitleView.h"
#import "CommonDetailsViewController.h"
#import "CommonModel.h"
#import "CommonImgModel.h"
#import "UIButton+WebCache.h"
#import "CommonViewController.h"

#define kOpenRefreshHeaderViewHeight 0

//banner:202*99
#define kBannerWidth        (KSCREEN_WIDTH)
#define kBannerHeight       (kBannerWidth * 230 / 690)

//itemBackView高度: k
#define kItemViewWidth      ((KSCREEN_WIDTH - 46 - 65 * 3) / 4)
#define kItemViewHeight     kItemViewWidth
#define kItemBackViewHeight (kItemViewHeight + 30 + 10 + 12)

//adView的高度:345.0*67
#define kAdViewWidth        (KSCREEN_WIDTH - 15 * 3) / 2
#define kAdViewHeight       (kAdViewWidth * 210 / 330)

#define kHeadBackVHeight   (kBannerHeight + kItemBackViewHeight + kAdViewHeight)    //上半部headBackView的高度

@interface YNSuspendTopPausePageVC () <YNPageViewControllerDataSource, YNPageViewControllerDelegate, SDCycleScrollViewDelegate, ImgTitleViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *autoScrollView;
@property (nonatomic, strong) NSMutableArray *imgUrlArr;
@property (nonatomic, strong) NSMutableArray *adUrlArr;
@property (nonatomic, strong) NSMutableArray *adMutBtn;
@property (nonatomic, copy) NSArray *imagesURLs;
@property (nonatomic, strong) NSArray *positionTypeArr;

@end

@implementation YNSuspendTopPausePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //     [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Public Function

+ (instancetype)suspendTopPausePageVC {
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionTopPause;
    configration.headerViewCouldScale = YES;
    configration.showTabbar = NO;
    configration.showNavigation = YES;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = YES;
    configration.showBottomLine = NO;
    
    YNSuspendTopPausePageVC *vc = [YNSuspendTopPausePageVC pageViewControllerWithControllers:[self getArrayVCs]
                                                                                      titles:[self getArrayTitles]
                                                                                      config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    [vc loadData];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, kHeadBackVHeight)];
    //headerView.layer.contents = (id)[UIImage imageNamed:@"mine_header_bg"].CGImage;
    
    vc.autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, kBannerHeight) delegate:vc placeholderImage:[UIImage imageNamed:@" "]];
    vc.autoScrollView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:vc.autoScrollView];
    
    UIView *itemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, vc.autoScrollView.bottom, KSCREEN_WIDTH, kItemViewHeight + 30 + 10 + 12)];
    [headerView addSubview:itemBackView];
    
    for (NSInteger i = 0; i < vc.positionTypeArr.count; i++) {
        ImgTitleView *item = [[ImgTitleView alloc] initWithFrame:CGRectMake(23 + (i % 4) * (kItemViewWidth + 65), 15, kItemViewWidth, kItemViewHeight)];
        item.topImgV.image = [UIImage imageNamed:vc.positionTypeArr[i][@"img"]];
        item.titleLab.text = vc.positionTypeArr[i][@"title"];
        item.maskBtn.tag = 1000 + i;
        item.delegate = vc;
        [itemBackView addSubview:item];
    }
    
    NSArray *arrBtn = @[@{@"type":@"固定", @"index":@"1"},
                        @{@"type":@"固定", @"index":@"2"}];
    
    for (NSInteger i = 0; i < arrBtn.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+(i%2)*(kAdViewWidth+15), itemBackView.bottom, kAdViewWidth, kAdViewHeight);
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        [headerView addSubview:btn];
        btn.adjustsImageWhenHighlighted = NO;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
            CommonImgModel *model = vc.adUrlArr[i];
            detail.positionid = model.positionid;
            detail.clickStyleStr = arrBtn[i][@"type"];
            detail.indexStr = arrBtn[i][@"index"];
            [vc.navigationController pushViewController:detail animated:YES];
        }];
        [vc.adMutBtn addObject:btn];
    }
    
    vc.headerView = headerView;
    /// 指定默认选择index 页面
    vc.pageIndex = 0;
    
    __weak typeof(YNSuspendTopPausePageVC *) weakVC = vc;
    
    vc.bgScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakVC loadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
        
        NSInteger refreshPage = weakVC.pageIndex;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            /// 取到之前的页面进行刷新 pageIndex 是当前页面
            YNSuspendTopPauseBaseTableViewVC *vc2 = weakVC.controllersM[refreshPage];
            
            if (kOpenRefreshHeaderViewHeight) {
                weakVC.headerView.yn_height = 300;
                [weakVC.bgScrollView.mj_header endRefreshing];
                [weakVC reloadSuspendHeaderViewFrame];
            } else {
                [weakVC.bgScrollView.mj_header endRefreshing];
            }
            [vc2.tableView reloadData];
        });
    }];
    return vc;
}

+ (NSArray *)getArrayVCs {
    YNSuspendTopPauseBaseTableViewVC *firstVC = [[YNSuspendTopPauseBaseTableViewVC alloc] init];
    firstVC.cellTitle = @"推荐";
    
    YNSuspendTopPauseBaseTableViewVC *secondVC = [[YNSuspendTopPauseBaseTableViewVC alloc] init];
    secondVC.cellTitle = @"最新";
    
    return @[firstVC, secondVC];
    
}

+ (NSArray *)getArrayTitles {
    return @[@"推荐", @"最新"];
}

#pragma mark - Private Function

- (void)loadData {
    
    [[HWAFNetworkManager shareManager] commonAcquireImg:@{@"imgtype":@"首页"} firstImg:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        if (success) {
            self.imgUrlArr = [CommonImgModel mj_objectArrayWithKeyValuesArray:dic[@"img"]];
            self.adUrlArr = [CommonImgModel mj_objectArrayWithKeyValuesArray:dic[@"imgfixed"]];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (CommonImgModel *img in self.imgUrlArr) {
                [arr addObject:img.imgpath];
            }
            self.autoScrollView.imageURLStringsGroup = arr;
            __weak typeof(YNSuspendTopPausePageVC *) weakVC = self;
            for (int i = 0; i < weakVC.adMutBtn.count; i++) {
                UIButton *btn = weakVC.adMutBtn[i];
                CommonImgModel *img = self.adUrlArr[i];
                [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:img.imgpath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:[@"ad" stringByAppendingString:[NSString stringWithFormat:@"%d", i+1]]]];
            }
        }
    }];
}


#pragma mark ImgTitleDelegate
- (void)ImgTitleViewACtion:(NSInteger)index {
    CommonViewController *com = [[CommonViewController alloc] init];
    com.titleStr = self.positionTypeArr[index - 1000][@"title"];
    com.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:com animated:YES];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    UIViewController *vc = pageViewController.controllersM[index];
    return [(YNSuspendTopPauseBaseTableViewVC *)vc tableView];
}

#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
    CommonModel *model = self.imgUrlArr[index];
    detail.positionid = model.positionid;
    detail.clickStyleStr = @"轮播";
    detail.indexStr = [NSString stringWithFormat:@"%ld", (long)index];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - Getter and Setter
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

- (NSMutableArray *)adMutBtn {
    if (_adMutBtn == nil) {
        _adMutBtn = [[NSMutableArray alloc] init];
    }
    return _adMutBtn;
}

- (NSArray *)positionTypeArr {
    if (_positionTypeArr == nil) {
        _positionTypeArr = @[@{@"img":@"fujinjianzhi",@"title":@"附近兼职"},
                             @{@"img":@"gaoxinjianzhi",@"title":@"高薪兼职"},
                             @{@"img":@"dangrijiesuan",@"title":@"当日结算"},
                             @{@"img":@"xueshengjianzhi",@"title":@"学生兼职"}];
    }
    return _positionTypeArr;
}

@end


