//
//  PomeloGuidancePageViewController.m
//  chowRent
//
//  Created by 草帽~小子 on 2018/6/30.
//  Copyright © 2018年 eallcn. All rights reserved.
//

#import "PomeloGuidancePageViewController.h"
#import "ECDevice.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "PomeloLoginViewController.h"
#import "PomeloVerifyLoginViewController.h"
#import "PomeloLoginViewController.h"

@interface PomeloGuidancePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *scrollArr;
@property (nonatomic, strong) UIImageView *scrollImg;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation PomeloGuidancePageViewController

- (NSArray *)scrollArr {
    if (_scrollArr == nil) {
//        if ([ECDevice getDeviceType] == 0) {//4
//            _scrollArr = [[NSArray alloc] initWithObjects:@"yindaoP4-1",@"yindaoP4-2",@"yindaoP4-3",@"yindaoP4-4", nil];
//        }else if ([ECDevice getDeviceType] == 1) {//5
//            _scrollArr = [[NSArray alloc] initWithObjects:@"yindaoP5-1",@"yindaoP5-2",@"yindaoP5-3",@"yindaoP5-4" ,nil];
//        }else if([ECDevice getDeviceType] == 2){//6和8一样大
//            _scrollArr = [[NSArray alloc] initWithObjects:@"yindaoP8-1",@"yindaoP8-2",@"yindaoP8-3",@"yindaoP8-4", nil];
//        }else if ([ECDevice getDeviceType] == 3) {//6p
//            _scrollArr = [[NSArray alloc] initWithObjects:@"yindaoP8P-1",@"yindaoP8P-2",@"yindaoP8P-3",@"yindaoP8P-4", nil];
//        }else if ([ECDevice getDeviceType] == 4) {//x
//            _scrollArr = [[NSArray alloc] initWithObjects:@"yindaoPx-1",@"yindaoPx-2",@"yindaoPx-3",@"yindaoPx-4", nil];
//        }else {
//            _scrollArr = [[NSArray alloc] initWithObjects:@"guidance1",@"guidance2",@"guidance3",@"guidance4", nil];
//        }
        _scrollArr = [[NSArray alloc] initWithObjects:@"guidance1",@"guidance2",@"guidance3", nil];
    }
    return _scrollArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    // Do any additional setup after loading the view.
}


- (UIScrollView *)scrollView {
    
    CGFloat spa = 40;
    CGFloat hei = 40;
    CGFloat wid = (KSCREEN_WIDTH - spa * 5 ) / 2;
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        for (int i = 0; i < self.scrollArr.count; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
            img.backgroundColor = kColor_Main;
            img.image = [UIImage imageNamed:self.scrollArr[i]];
            img.userInteractionEnabled = YES;
            [_scrollView addSubview:img];
            
            if (i == self.scrollArr.count - 1) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = kColor_Main;
                btn.frame = CGRectMake(spa, self.view.frame.size.height - 120, wid, hei);
                btn.layer.cornerRadius = 5;
                btn.layer.masksToBounds = YES;
                btn.tag = 111;
                //[img addSubview:btn];
                [btn setTitle:@"注   册" forState:UIControlStateNormal];
                [ECUtil gradientLayer:btn startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
                [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.backgroundColor = kColor_Main;
                btn1.frame = CGRectMake(95, KSCREEN_HEIGHT - 100 - hei, KSCREEN_WIDTH - 95 * 2, hei);
                btn1.layer.cornerRadius = 20;
                btn1.layer.masksToBounds = YES;
                btn1.tag = 222;
                [img addSubview:btn1];
                [btn1 setTitle:@"立即体验" forState:UIControlStateNormal];
                //[ECUtil gradientLayer:btn1 startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
                [btn1 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }
        
        _scrollView.contentSize = CGSizeMake(self.scrollArr.count * self.view.frame.size.width, self.view.frame.size.height);
    }
    
    return _scrollView;
}


- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - 100, self.view.frame.size.width, 40)];
        //_pageControl.backgroundColor = [UIColor purpleColor];
        _pageControl.numberOfPages = _scrollArr.count;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = kColor_Main;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [_pageControl addTarget:self action:@selector(pageControlTurn:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}


- (void)pageControlTurn:(UIPageControl *)page {
    _scrollView.contentOffset = CGPointMake(page.currentPage * _scrollView.frame.size.width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = _scrollView.contentOffset.x / _scrollView.frame.size.width;
}

- (void)btn:(UIButton *)button {
    
//    BaseTabBarController *base = [[BaseTabBarController alloc] init];
//    UIWindow *win = [UIApplication sharedApplication].keyWindow;
//    win.rootViewController = base;
//    [win makeKeyAndVisible];
//    base.selectedIndex = 4;
//    BaseNavigationController *na = base.viewControllers[4];
    
//    if (button.tag == 111) {
//        PomeloLoginViewController *login = [[PomeloLoginViewController alloc] init];
//        [na pushViewController:login animated:YES];
//        PomeloVerifyLoginViewController *vc = [[PomeloVerifyLoginViewController alloc] init];
//        vc.entranceType = RegisterStyle;
//        [na pushViewController:vc animated:YES];
//    }
    if (button.tag == 222) {
        BaseTabBarController *base = [[BaseTabBarController alloc] init];
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        win.rootViewController = base;
        [win makeKeyAndVisible];
        base.selectedIndex = 0;
//        BaseNavigationController *na = base.viewControllers[0];
//        
//        PomeloLoginViewController *log = [[PomeloLoginViewController alloc] init];
//        [na pushViewController:log animated:YES];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:FIRSTLAUNCHRECORD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
