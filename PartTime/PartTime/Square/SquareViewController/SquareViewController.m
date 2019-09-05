//
//  SquareViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "SquareViewController.h"
#import "TitleSelectItemControl.h"
#import "LocationViewController.h"
#import "SortViewController.h"
#import "TypeSelectViewController.h"
#import "CommonTableViewCell.h"
#import "CommonViewController.h"
#import "FiltrateViewController.h"

@interface SquareViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIView *titleSelectItemBackView;
@property (nonatomic, strong) TitleSelectItemControl *titleSelect1;
@property (nonatomic, strong) TitleSelectItemControl *titleSelect2;
@property (nonatomic, strong) TitleSelectItemControl *titleSelect3;
@property (nonatomic, strong) TitleSelectItemControl *titleSelect4;
@property (nonatomic, strong) TitleSelectItemControl *titleSelect5;

@property (nonatomic, strong) UIView *blackBackGroundView1;
@property (nonatomic, strong) UIView *blackBackGroundView2;
@property (nonatomic, strong) UIView *blackBackGroundView3;
@property (nonatomic, strong) UIView *blackBackGroundView4;
@property (nonatomic, strong) UIView *blackBackGroundView5;

@property (nonatomic, strong) LocationViewController *locationViewController;
@property (nonatomic, strong) TypeSelectViewController *typeSelectViewController;
@property (nonatomic, strong) SortViewController *sortViewController;
@property (nonatomic, strong) FiltrateViewController *filtrateViewController;

@property (nonatomic, strong) UITableView *squareTableV;


@end

@implementation SquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self configTitleSelectItem];
    
    [self configListTableView];
    
    [self configSelectBackground];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, 300)];
    self.topBackView.backgroundColor = [HWRandomColor randomColor];
    [self.view addSubview:self.topBackView];
    
    CGFloat space = 10;
    CGFloat wid = (SCREENWIDTH - space * 8) / 4;
    
    NSArray *arr = @[@{@"img":@"", @"title":@"急招岗位"},
                     @{@"img":@"", @"title":@"急招岗位"},
                     @{@"img":@"", @"title":@"急招岗位"},
                     @{@"img":@"", @"title":@"急招岗位"},
                     @{@"img":@"", @"title":@"急招岗位"},
                     @{@"img":@"", @"title":@"急招岗位"},
                     @{@"img":@"", @"title":@"急招岗位"},
                     @{@"img":@"", @"title":@"急招岗位"}];
    
    for (int i = 0; i < 8; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(space + (wid + space * 2) * (i % 4), space + (wid + space * 2) *  (i / 4), wid, wid);
        [btn setBackgroundColor:[HWRandomColor randomColor]];
        btn.tag = 770 + i;
        [self.topBackView addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:arr[i][@"img"]] forState:UIControlStateNormal];
        [btn setTitle:arr[i][@"title"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(jobAcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)configTitleSelectItem {
    
    UIImage *sortImg = [UIImage imageNamed:@"btn_paixu_search"];
    double w = (self.view.width-30-sortImg.size.width-10) / 4;//三个
    double h = 40;
    
    self.titleSelectItemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topBackView.height - h, SCREENWIDTH, h)];
    [self.topBackView addSubview:self.titleSelectItemBackView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleSelectItemBackView.top - 50, SCREENWIDTH, 40)];
    lab.backgroundColor = [HWRandomColor randomColor];
    lab.textColor = BLACKCOLOR;
    lab.font = LARGEFont;
    lab.text = @"为您精选";
    lab.textAlignment = NSTextAlignmentCenter;
    [self.topBackView addSubview:lab];
    
    _titleSelect1 = [[TitleSelectItemControl alloc] initWithFrame:CGRectMake(20, 0, w, h) title:self.titleArray[0] imageName:@"btn_close_search" selectImage:@"btn_open_search"];
    [_titleSelect1 addTarget:self action:@selector(titleSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    //_titleSelect1.backgroundColor = [UIColor orangeColor];
    [self.titleSelectItemBackView addSubview:_titleSelect1];
    
    _titleSelect2 = [[TitleSelectItemControl alloc] initWithFrame:CGRectMake(_titleSelect1.right, 0, w, h) title:self.titleArray[1] imageName:@"btn_close_search" selectImage:@"btn_open_search"];
    [_titleSelect2 addTarget:self action:@selector(titleSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleSelectItemBackView addSubview:_titleSelect2];
    
    _titleSelect3 = [[TitleSelectItemControl alloc] initWithFrame:CGRectMake(_titleSelect2.right, 0, w, h) title:self.titleArray[2] imageName:@"btn_close_search" selectImage:@"btn_open_search"];
    [_titleSelect3 addTarget:self action:@selector(titleSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleSelectItemBackView addSubview:_titleSelect3];
    //_titleSelect3.showSpliter = NO;
    
    _titleSelect4 = [[TitleSelectItemControl alloc] initWithFrame:CGRectMake(_titleSelect3.right, 0, w, h) title:self.titleArray[3] imageName:@"btn_close_search" selectImage:@"btn_open_search"];
    [_titleSelect4 addTarget:self action:@selector(titleSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleSelectItemBackView addSubview:_titleSelect4];
    _titleSelect4.showSpliter = NO;
    
//    _titleSelect5 = [[TitleSelectItemControl alloc] initWithFrame:CGRectMake(_titleSelect4.right, 0, w, h) title:self.titleArray[4] imageName:@"btn_paixu_search" selectImage:@"btn_paixu_search"];
//    [_titleSelect5 addTarget:self action:@selector(titleSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.titleSelectItemBackView addSubview:_titleSelect5];
//    _titleSelect5.titleLeft = YES;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleSelectItemBackView.height - 0.5, self.view.width, 0.5)];
    line.backgroundColor = [ECUtil colorWithHexString:@"e5e5e5"];
    [self.titleSelectItemBackView addSubview:line];
    
}

- (void)configSelectBackground {
    
    // MARK: 区域
    self.blackBackGroundView1 = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], self.view.width, self.view.height - 44)];
    self.blackBackGroundView1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView1.hidden = YES;
    [self.view addSubview:self.blackBackGroundView1];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView1tap:)];
    tap1.delegate = self;
    [self.blackBackGroundView1 addGestureRecognizer:tap1];
    
    self.locationViewController = [[LocationViewController alloc] init];
    self.locationViewController.view.frame = CGRectMake(0, 0, SCREENWIDTH, 500);
    [self addChildViewController:self.locationViewController];
    [self.blackBackGroundView1 addSubview:self.locationViewController.view];
    
    // MARK: 类型
    self.blackBackGroundView2 = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], self.view.width, self.view.height - 44)];
    self.blackBackGroundView2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView2.hidden = YES;
    [self.view addSubview:self.blackBackGroundView2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView2tap:)];
    tap2.delegate = self;
    [self.blackBackGroundView2 addGestureRecognizer:tap2];
    
    self.typeSelectViewController = [[TypeSelectViewController alloc] init];
    self.typeSelectViewController.view.frame = CGRectMake(0, 0, SCREENWIDTH, 500);
    [self addChildViewController:self.typeSelectViewController];
    [self.blackBackGroundView2 addSubview:self.typeSelectViewController.view];
    
    
    // MARK: 排序
    self.blackBackGroundView3 = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], self.view.width, self.view.height - 40)];
    self.blackBackGroundView3.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView3.hidden = YES;
    [self.view addSubview:self.blackBackGroundView3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView3tap:)];
    [self.blackBackGroundView3 addGestureRecognizer:tap3];
    
    self.sortViewController = [[SortViewController alloc] init];
    //self.sortViewController.view.frame = CGRectMake(0, 0, SCREENWIDTH, 200);
    [self addChildViewController:self.sortViewController];
    [self.blackBackGroundView3 addSubview:self.sortViewController.view];
    self.sortViewController.currentSelectItemTitle = ^(NSString *title) {
        
    };
    
    
    // MARK: 筛选

    self.blackBackGroundView4 = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], self.view.width, self.view.height - 44)];
    self.blackBackGroundView4.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView4.hidden = YES;
    [self.view addSubview:self.blackBackGroundView4];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView4tap:)];
    [self.blackBackGroundView4 addGestureRecognizer:tap4];
    
    self.filtrateViewController = [[FiltrateViewController alloc] init];
    [self addChildViewController:self.filtrateViewController];
    [self.blackBackGroundView4 addSubview:self.filtrateViewController.view];
    
    
}

- (void)configListTableView {
    self.squareTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.squareTableV.delegate = self;
    self.squareTableV.dataSource = self;
    [self.view addSubview:self.squareTableV];
    self.squareTableV.tableHeaderView = self.topBackView;
    [self.squareTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
    
}




#pragma mark - target action
- (void)jobAcion:(UIButton *)send {
    if (send.tag == 770) {
        NSLog(@"=====%ld", send.tag);
    }else if (send.tag == 771) {
        NSLog(@"=====%ld", send.tag);
    }else if (send.tag == 772) {
        NSLog(@"=====%ld", send.tag);
    }else if (send.tag == 773) {
        NSLog(@"=====%ld", send.tag);
    }else if (send.tag == 774) {
        NSLog(@"=====%ld", send.tag);
    }else if (send.tag == 775) {
        NSLog(@"=====%ld", send.tag);
    }else if (send.tag == 776) {
        NSLog(@"=====%ld", send.tag);
    }else if (send.tag == 777) {
        
    }
}


- (void)titleSelectBtn:(UIControl *)sender {
    //通知释放键盘
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"registerFirstResponse" object:nil];
    
    BOOL selected = !sender.selected;
    
    self.titleSelect1.selected = NO;
    self.titleSelect2.selected = NO;
    self.titleSelect3.selected = NO;
    self.titleSelect4.selected = NO;
    self.titleSelect5.selected = NO;
    
    self.blackBackGroundView1.hidden = YES;
    self.blackBackGroundView2.hidden = YES;
    self.blackBackGroundView3.hidden = YES;
    self.blackBackGroundView4.hidden = YES;
    self.blackBackGroundView5.hidden = YES;
    
    sender.selected = selected;
    
    if (sender == _titleSelect1) {
        self.blackBackGroundView1.hidden = !selected;
    } else if (sender == _titleSelect2) {
        
        self.blackBackGroundView2.hidden = !selected;
    } else if (sender == _titleSelect3) {
        
        self.blackBackGroundView3.hidden = !selected;
    } else if (sender == _titleSelect4) {
        
        self.blackBackGroundView4.hidden = !selected;
    }else if (sender == _titleSelect5) {
        self.blackBackGroundView5.hidden = !selected;
    }
}

- (void)blackBackGroundView1tap:(UITapGestureRecognizer *)tap {
    self.titleSelect1.selected = NO;
    self.blackBackGroundView1.hidden = YES;
}

- (void)blackBackGroundView2tap:(UITapGestureRecognizer *)tap {
    self.titleSelect2.selected = NO;
    self.blackBackGroundView2.hidden = YES;
}

- (void)blackBackGroundView3tap:(UITapGestureRecognizer *)tap {
    self.titleSelect3.selected = NO;
    self.blackBackGroundView3.hidden = YES;
}

- (void)blackBackGroundView4tap:(UITapGestureRecognizer *)tap {
    self.titleSelect4.selected = NO;
    self.blackBackGroundView4.hidden = YES;
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"registerFirstResponse" object:nil];
}

#pragma mark System Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.squareTableV == tableView) {
        return 10;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    cell.tagImgV.image = [UIImage imageNamed:@""];
    cell.titleLab.text = @"大望路服务员收银员";
    cell.locationLab.text = @"朝阳";
    cell.accountStyleLab.text = @"月结";
    cell.princeLab.text = @"180/天";
    cell.tagLab.text = @"可长期";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.squareTableV == tableView) {
        return 100;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonViewController *com = [[CommonViewController alloc] init];
    [self.navigationController pushViewController:com animated:YES];
}







- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.locationViewController.view]) {
        return NO;
    }
    if ([touch.view isDescendantOfView:self.typeSelectViewController.view]) {
        return NO;
    }
//    if ([touch.view isDescendantOfView:self.filtrateViewController.view]) {
//        return NO;
//    }
    return YES;
}



- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"区域", @"类型", @"排序", @"筛选"];
    }
    return _titleArray;
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
