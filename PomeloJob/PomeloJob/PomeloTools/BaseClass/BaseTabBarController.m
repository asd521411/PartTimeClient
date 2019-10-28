//
//  BaseTabBarController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//o

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "LJSecondScrollViewController.h"
#import "YNSuspendTopPausePageVC.h"
#import "PomeloDiscoveryViewController.h"
#import "PomeloSquareViewController.h"
#import "PomeloMessageViewController.h"
#import "PomeloMyViewController.h"
#import "MyViewController.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *vcArr = [[NSMutableArray alloc] init];
    //LJSecondScrollViewController *lj = [[LJSecondScrollViewController alloc] init];
    YNSuspendTopPausePageVC *yn = [YNSuspendTopPausePageVC suspendTopPausePageVC];
    
    PomeloDiscoveryViewController *dis = [[PomeloDiscoveryViewController alloc] init];
    PomeloSquareViewController *squ = [[PomeloSquareViewController alloc] init];
    PomeloMessageViewController *message = [[PomeloMessageViewController alloc] init];
    //PomeloMyViewController *my = [[PomeloMyViewController alloc] init];
    MyViewController *my = [[MyViewController alloc] init];
    
    [vcArr addObject:yn];
    [vcArr addObject:dis];
    [vcArr addObject:squ];
    [vcArr addObject:message];
    [vcArr addObject:my];
    
    NSMutableArray *naArr = [[NSMutableArray alloc] init];
    NSArray *titleArr = @[@{@"img":@"shouye", @"imgsele":@"shouyesele", @"title":@"首页"},
                          @{@"img":@"faxian", @"imgsele":@"faxiansele",@"title":@"发现"},
                          @{@"img":@"guangchang", @"imgsele":@"guangchangsele",@"title":@"广场"},
                          @{@"img":@"xiaoxi", @"imgsele":@"xiaoxisele",@"title":@"消息"},
                          @{@"img":@"wode", @"imgsele":@"wodesele",@"title":@"我的"}];
    for (NSInteger i = 0; i < titleArr.count; i++) {
        BaseNavigationController *na = [[BaseNavigationController alloc] initWithRootViewController:vcArr[i]];
        
        UITabBarItem *item = [[UITabBarItem alloc] init];
        item.title = titleArr[i][@"title"];
        item.image = [[UIImage imageNamed:titleArr[i][@"img"]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:titleArr[i][@"imgsele"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //[item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor cyanColor], NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColor_Main, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        na.tabBarItem = item;
        [naArr addObject:na];
    }
    
    [self setViewControllers:naArr];
    
    // Do any additional setup after loading the view.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    tabBar.tintColor = kColor_Main;
    NSDictionary *para = @{@"adtype":item.title,
                           @"adindex":@"0",//0 表示当前选择类型
                           @"phonecard":[ECUtil getIDFA]};
    [[HWAFNetworkManager shareManager] clickOperation:para advertismentclick:^(BOOL success, id  _Nonnull request) {
        if (success) {
        }
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
