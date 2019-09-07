//
//  BaseTabBarController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomePageViewController.h"
#import "DiscoveryViewController.h"
#import "SquareViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *vcArr = [[NSMutableArray alloc] init];
    
    HomePageViewController *home = [[HomePageViewController alloc] init];
    DiscoveryViewController *dis = [[DiscoveryViewController alloc] init];
    SquareViewController *squ = [[SquareViewController alloc] init];
    MessageViewController *message = [[MessageViewController alloc] init];
    MyViewController *my = [[MyViewController alloc] init];
    
    [vcArr addObject:home];
    [vcArr addObject:dis];
    [vcArr addObject:squ];
    [vcArr addObject:message];
    [vcArr addObject:my];
    
    
    NSMutableArray *naArr = [[NSMutableArray alloc] init];
    NSArray *titleArr = @[@"首页", @"发现", @"广场", @"消息", @"我的"];
    for (NSInteger i = 0; i < 5; i++) {
        BaseNavigationController *na = [[BaseNavigationController alloc] initWithRootViewController:vcArr[i]];
        UITabBarItem *item = [[UITabBarItem alloc] init];
        item.title = titleArr[i];
        item.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //[item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor cyanColor], NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor cyanColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        na.tabBarItem = item;
        [naArr addObject:na];
    }
    
    
    [self setViewControllers:naArr];
    
    // Do any additional setup after loading the view.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
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
