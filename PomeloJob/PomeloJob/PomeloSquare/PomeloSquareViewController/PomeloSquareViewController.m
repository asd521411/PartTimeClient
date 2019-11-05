//
//  PomeloSquareViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloSquareViewController.h"
#import "TitleSelectItemControl.h"
#import "PomeloLocationViewController.h"
#import "PomeloSortViewController.h"
#import "PomeloTypeSelectViewController.h"
#import "CommonTableViewCell.h"
#import "CommonViewController.h"
#import "PomeloFiltrateViewController.h"
#import "ImgTitleView.h"
#import "CommonDetailsViewController.h"
#import "SquareStyleModel.h"
#import "UIImageView+WebCache.h"

@interface PomeloSquareViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, ImgTitleViewDelegate>

@property (nonatomic, strong) NSArray *styleArr;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) NSArray *itemArr;
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

@property (nonatomic, strong) PomeloLocationViewController *locationViewController;
@property (nonatomic, strong) PomeloTypeSelectViewController *typeSelectViewController;
@property (nonatomic, strong) PomeloSortViewController *sortViewController;
@property (nonatomic, strong) PomeloFiltrateViewController *filtrateViewController;

@property (nonatomic, strong) UITableView *squareTableV;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) BOOL upOrDown;
@property (nonatomic, assign) NSInteger page;


@end

@implementation PomeloSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"广场";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self loadStyle];
    
    [self setupSubViews];
    
    [self configSelectBackground];
    
    [self tableViewRefresh];
    
    [self.squareTableV.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.squareTableV.mj_header endRefreshing];
    [self.squareTableV.mj_footer endRefreshing];
}

- (void)loadStyle {
    NSDictionary *para = @{};
    [[HWAFNetworkManager shareManager] positionRequest:para getStyle:^(BOOL success, id  _Nonnull request) {
        NSDictionary *dic = (NSDictionary *)request;
        NSArray *arr = dic[@"body"];
        if (success) {
            self.itemArr = [SquareStyleModel mj_objectArrayWithKeyValuesArray:arr];
            CGFloat width = ((KSCREEN_WIDTH - 46 - 65 * 3) / 4);
            for (NSInteger i = 0; i < self.itemArr.count; i++) {
                ImgTitleView *item = [[ImgTitleView alloc] initWithFrame:CGRectMake(23 + (i % 4) * (width + 65), 15 + (i/4) * (width + 10 + 12 + 15), width, width)];
                SquareStyleModel *model = self.itemArr[i];
                [item.topImgV sd_setImageWithURL:[NSURL URLWithString:model.squareimg] placeholderImage:[UIImage imageNamed:@" "]];
                item.titleLab.text = model.squarename;
                item.maskBtn.tag = 1000 + i;
                item.delegate = self;
                //        item.layer.cornerRadius = 2;
                //        item.layer.masksToBounds = YES;
                [self.topBackView addSubview:item];
            }
            
        }
    }];
}

- (void)tableViewRefresh {
    self.squareTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.upOrDown = YES;
        self.page = 1;
        [self loadData];
    }];
    
    self.squareTableV.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.upOrDown = NO;
        [self loadData];
    }];
    
}

- (void)loadData {
    
    NSDictionary *para = @{@"page":@(self.page)};
    [[HWAFNetworkManager shareManager] position:para postion:^(BOOL success, id  _Nonnull request) {
        NSArray *arr = request[@"resultList"];
        if (success) {
            if (self.upOrDown) {
                [self.listArr removeAllObjects];
                self.listArr = [CommonModel mj_objectArrayWithKeyValuesArray:arr];
            }else {
                NSArray *ar = [CommonModel mj_objectArrayWithKeyValuesArray:arr];
                [self.listArr addObjectsFromArray:ar];
                if (ar.count > 0) {
                    self.page++;
                }
            }
        }
        [self.squareTableV.mj_header endRefreshing];
        [self.squareTableV.mj_footer endRefreshing];
        [self.squareTableV reloadData];
    }];
}

- (void)setupSubViews {
    
    CGFloat width = ((KSCREEN_WIDTH - 46 - 65 * 3) / 4);
    
    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 15 + (width + 37) * 2 + 80)];
    [self.view addSubview:self.topBackView];
    
    [self configTitleSelectItem];
    
    self.squareTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight]) style:UITableViewStylePlain];
    self.squareTableV.delegate = self;
    self.squareTableV.dataSource = self;
    self.squareTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.squareTableV];
    self.squareTableV.tableHeaderView = self.topBackView;
    [self.squareTableV registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
}

- (void)configTitleSelectItem {

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topBackView.height - 80, KSCREEN_WIDTH, 40)];
    lab.backgroundColor = [UIColor colorWithRed:0xef/255.0 green:0xef/255.0 blue:0xef/255.0 alpha:1];
    lab.textColor = KColor_212121;
    lab.font = KFontNormalSize14;
    lab.text = @"为您精选";
    lab.textAlignment = NSTextAlignmentCenter;
    [self.topBackView addSubview:lab];
    
    UIImageView *hotImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hot"]];
    hotImgV.frame = CGRectMake(70, 10, 20, 20);
    [lab addSubview:hotImgV];
    
    UIImage *sortImg = [UIImage imageNamed:@"btn_paixu_search"];
    double w = (self.view.width-30-sortImg.size.width-10) / 4;//三个
    double h = 40;
    
    self.titleSelectItemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topBackView.height - h, SCREENWIDTH, h)];
    [self.topBackView addSubview:self.titleSelectItemBackView];
    
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
    
    self.locationViewController = [[PomeloLocationViewController alloc] init];
    self.locationViewController.view.frame = CGRectMake(0, 0, SCREENWIDTH, 500);
    [self addChildViewController:self.locationViewController];
    [self.blackBackGroundView1 addSubview:self.locationViewController.view];
    
    __weak typeof(self) weakSelf = self;
    self.locationViewController.currentSelectItemLevel1 = ^(NSString *titleName1) {
        
        
        weakSelf.titleSelect1.selected = NO;
        weakSelf.blackBackGroundView1.hidden = YES;
        [weakSelf.squareTableV.mj_header beginRefreshing];
    };
    
    // MARK: 类型
    self.blackBackGroundView2 = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], self.view.width, self.view.height - 44)];
    self.blackBackGroundView2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView2.hidden = YES;
    [self.view addSubview:self.blackBackGroundView2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView2tap:)];
    tap2.delegate = self;
    [self.blackBackGroundView2 addGestureRecognizer:tap2];
    
    self.typeSelectViewController = [[PomeloTypeSelectViewController alloc] init];
    self.typeSelectViewController.view.frame = CGRectMake(0, 0, SCREENWIDTH, 500);
    [self addChildViewController:self.typeSelectViewController];
    [self.blackBackGroundView2 addSubview:self.typeSelectViewController.view];
    self.typeSelectViewController.typeSelectBlock = ^(NSString * _Nonnull str) {
        
        
        
        
        weakSelf.titleSelect2.selected = NO;
        weakSelf.blackBackGroundView2.hidden = YES;
        [weakSelf.squareTableV.mj_header beginRefreshing];
    };
    
    
    // MARK: 排序
    self.blackBackGroundView3 = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], self.view.width, self.view.height - 44)];
    self.blackBackGroundView3.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView3.hidden = YES;
    [self.view addSubview:self.blackBackGroundView3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView3tap:)];
    tap3.delegate = self;
    [self.blackBackGroundView3 addGestureRecognizer:tap3];
    
    self.sortViewController = [[PomeloSortViewController alloc] init];
    self.sortViewController.view.frame = CGRectMake(0, 0, SCREENWIDTH, 44 * 3);
    [self addChildViewController:self.sortViewController];
    [self.blackBackGroundView3 addSubview:self.sortViewController.view];
    self.sortViewController.currentSelectItemTitle = ^(NSString *title) {
        
        
        
        
        
        weakSelf.titleSelect3.selected = NO;
        weakSelf.blackBackGroundView3.hidden = YES;
        [weakSelf.squareTableV.mj_header beginRefreshing];
    };
    
    // MARK: 筛选

    self.blackBackGroundView4 = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], self.view.width, self.view.height - 44)];
    self.blackBackGroundView4.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.blackBackGroundView4.hidden = YES;
    [self.view addSubview:self.blackBackGroundView4];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackGroundView4tap:)];
    tap4.delegate = self;
    [self.blackBackGroundView4 addGestureRecognizer:tap4];
    
    self.filtrateViewController = [[PomeloFiltrateViewController alloc] init];
    self.filtrateViewController.view.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 44 * 3);
    [self addChildViewController:self.filtrateViewController];
    [self.blackBackGroundView4 addSubview:self.filtrateViewController.view];
    self.filtrateViewController.currentSelectItemTitle = ^(NSString * _Nonnull title) {
        
        
        
        
        
        weakSelf.titleSelect4.selected = NO;
        weakSelf.blackBackGroundView4.hidden = YES;
        [weakSelf.squareTableV.mj_header beginRefreshing];
    };
    
}


#pragma mark - target action
- (void)jobAcion:(UIButton *)send {
    
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
    
//    if (self.titleSelect1.selected || self.titleSelect2.selected || self.titleSelect3.selected || self.titleSelect4.selected || self.titleSelect5.selected) {
//        self.squareTableV.scrollEnabled = NO;
//        NSLog(@"00=====%d", self.squareTableV.scrollEnabled);
//    }else {
//        self.squareTableV.scrollEnabled = YES;
//        NSLog(@"11=====%d", self.squareTableV.scrollEnabled);
//    }
//
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
        return self.listArr.count;
    }
    return 0;
}

#pragma delegate
- (void)ImgTitleViewACtion:(NSInteger)index{
    CommonViewController *com = [[CommonViewController alloc] init];
    SquareStyleModel *model = self.itemArr[index-1000];
    com.titleStr = model.squarename;
    [self.navigationController pushViewController:com animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    if (self.listArr.count > indexPath.row) {
        cell.commonModel = self.listArr[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.squareTableV == tableView) {
        return 80;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonDetailsViewController *detail = [[CommonDetailsViewController alloc] init];
    CommonModel *model = self.listArr[indexPath.row];
    detail.positionid = model.positionid;
    detail.clickStyleStr = @"广场";
    detail.indexStr = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.locationViewController.view]) {
        return NO;
    }
    if ([touch.view isDescendantOfView:self.typeSelectViewController.view]) {
        return NO;
    }
    if ([touch.view isDescendantOfView:self.sortViewController.view]) {
        return NO;
    }
    if ([touch.view isDescendantOfView:self.filtrateViewController.view]) {
        return NO;
    }
    return YES;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"区域", @"类型", @"排序", @"筛选"];
    }
    return _titleArray;
}

- (NSArray *)itemArr {
    if (!_itemArr) {
        _itemArr = [[NSArray alloc] init];
        
    }
    return _itemArr;
}

- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
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
