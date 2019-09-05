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

#warning 登陆入口
#import "LoginViewController.h"

@interface HomePageViewController ()<ImgTitleViewDelegate, HWTitleItemSelectorDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UIView *itemBackView;
@property (nonatomic, strong) UIView *adBackView;

@property (nonatomic, strong) UIView *selectTitleBackV;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIScrollView *scrollBackV;
@property (nonatomic, strong) UITableView *leftTableV;
@property (nonatomic, strong) UITableView *rightTableV;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    
    CGFloat scrH = 800;
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.backScrollV.backgroundColor = [UIColor cyanColor];
    self.backScrollV.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + scrH);
    self.backScrollV.scrollEnabled = YES;
    //self.backScrollV.pagingEnabled = YES;
    self.backScrollV.userInteractionEnabled = YES;
    self.backScrollV.showsHorizontalScrollIndicator = YES;
    self.backScrollV.directionalLockEnabled = YES;
    [self.view addSubview:self.backScrollV];
    
    self.headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT / 2)];
    self.headBackView.backgroundColor = [UIColor redColor];
    [self.backScrollV addSubview:self.headBackView];
    
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
    
    CGFloat titW = 60;
    CGFloat titH = 50;
    self.selectTitleBackV = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackView.bottom, SCREENWIDTH, titH)];
    self.selectTitleBackV.backgroundColor = [HWRandomColor randomColor];
    [self.backScrollV addSubview:self.selectTitleBackV];
    
    for (NSInteger i = 0; i < 2; i++) {
        HWTitleItemSelector *sele = [[HWTitleItemSelector alloc] initWithFrame:CGRectMake(20 + (20 + titW) * i, 0, titW, titH)];
        sele.backgroundColor = [HWRandomColor randomColor];
        sele.topBtn.tag = 999 + i;
        sele.delegate = self;
        [self.selectTitleBackV addSubview:sele];
    }
    
    self.scrollBackV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.selectTitleBackV.bottom, SCREENWIDTH, scrH)];
    self.scrollBackV.contentSize = CGSizeMake(SCREENWIDTH * 2, scrH);
    self.scrollBackV.delegate = self;
    [self.backScrollV addSubview:self.scrollBackV];
    
    self.leftTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, scrH) style:UITableViewStylePlain];
    self.leftTableV.delegate = self;
    self.leftTableV.dataSource = self;
    self.leftTableV.scrollEnabled = NO;
    [self.scrollBackV addSubview:self.leftTableV];
    [self.leftTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"leftTableV"];

    self.rightTableV = [[UITableView alloc] initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, scrH) style:UITableViewStylePlain];
    self.rightTableV.delegate = self;
    self.rightTableV.dataSource = self;
    self.rightTableV.scrollEnabled = NO;
    [self.scrollBackV addSubview:self.rightTableV];
    [self.rightTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"rightTableV"];

    //self.scrollBackV
    
}


#pragma mark delegate

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
    NSLog(@"left");
}

- (void)adBtnRightAction:(UIButton *)send {
    NSLog(@"right");
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    
    
}

- (void)hw_titleItemSelectorAction:(NSInteger)index {
    NSLog(@"----%ld", index);
    if (index == 999) {
        self.scrollBackV.contentOffset = CGPointMake(0, 0);
    }else if (index == 1000) {
        self.scrollBackV.contentOffset = CGPointMake(SCREENWIDTH, 0);
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollBackV.contentOffset.x == 0) {
        //self.leftBtn.selected = YES;
        //self.rightBtn.selected = NO;
    }else if (self.scrollBackV.contentOffset.x == SCREENWIDTH){
        //self.leftBtn.selected = NO;
        //self.rightBtn.selected = YES;
    }
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








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
