//
//  TypeSelectViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "TypeSelectViewController.h"
#import "RHFiltrateView.h"
#import "SelectBtnView.h"

@interface TypeSelectViewController ()<RHFiltrateViewDelegate>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *hotArr;
@property (nonatomic, strong) NSArray *easyArr;
@property (nonatomic, strong) NSArray *playArr;
@property (nonatomic, strong) NSArray *labourArr;
@property (nonatomic, strong) NSArray *otherArr;


@property (nonatomic, strong) RHFiltrateView * filtrate;
@property (nonatomic, strong) NSMutableArray *indexArr;
@property (nonatomic, strong) UIScrollView *scorllView;

@property (nonatomic, strong) UIButton *investBtn;

@end


@implementation TypeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupSubViews];
}

- (void)setupSubViews {
    
    CGFloat space = 10;
    CGFloat height = 40;
    SelectBtnView *select1 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, space, SCREENWIDTH - space * 2, height + space * 2 + self.hotArr.count / 4 * (height + space)) titleString:self.titleArr[0] itemStyle:self.hotArr];
    [self.view addSubview:select1];
    select1.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        NSLog(@"=====%@", btnTitle);
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    SelectBtnView *select2 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, select1.bottom, SCREENWIDTH - space * 2, height + space * 2 + self.easyArr.count / 4 * (height + space)) titleString:self.titleArr[1] itemStyle:self.easyArr];
    [self.view addSubview:select2];
    select2.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        NSLog(@"=====%@", btnTitle);
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    SelectBtnView *select3 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, select2.bottom, SCREENWIDTH - space * 2, height + space * 2 + self.playArr.count / 4 * (height + space)) titleString:self.titleArr[2] itemStyle:self.playArr];
    [self.view addSubview:select3];
    select3.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        NSLog(@"=====%@", btnTitle);
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    SelectBtnView *select4 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, select3.bottom, SCREENWIDTH - space * 2, height + space * 2 + self.labourArr.count / 4 * (height + space)) titleString:self.titleArr[3] itemStyle:self.labourArr];
    [self.view addSubview:select4];
    select4.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        NSLog(@"=====%@", btnTitle);
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    SelectBtnView *select5 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, select4.bottom, SCREENWIDTH - space * 2, height + space * 2 + self.otherArr.count / 4 * (height + space)) titleString:self.titleArr[4] itemStyle:self.otherArr];
    [self.view addSubview:select4];
    select5.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        NSLog(@"=====%@", btnTitle);
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
}

/**
 添加筛选条件
 */
- (void)addFiltrateBtn {
    
    NSArray *arrTitle = @[@"出借期限", @"预期年化收益", @"产品类型"];
    NSArray *arr1 = @[@"全部", @"3个月以内", @"3至6个月", @"6个月以上"];
    NSArray *arr2 = @[@"全部", @"6%以下", @"6%至8%", @"8%至10%", @"10%至12%", @"12%以上"];
    //NSArray *arr3 = @[@"全部", @"红宝理", @"预付宝", @"优企宝", @"小包贷"];
    NSArray *arr3 = @[@"全部", @"智造类", @"消费类", @"惠农类", @"电商类"];
    self.filtrate = [[RHFiltrateView alloc] initWithTitles:arrTitle items:@[arr1, arr2, arr3]];
    
    self.filtrate.frame = self.view.bounds;
    self.filtrate.delegate = self;
    
    [self.scorllView addSubview:self.filtrate];
    
}

- (void)addInvestBtn {
//    self.investBtn = [UIButton buttonWithType:<#(UIButtonType)#>];
//    [self.investBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [self.investBtn addTarget:self action:@selector(investBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.scorllView addSubview:self.investBtn];
}

/**
 点击确定
 */
- (void)investBtnClick {
    
//    if ([_filTime isEqualToString:@"0"] || _filTime == 0) {
//        _filTime = @"0";
//    }
//    if ([_filPercent isEqualToString:@"0"] || _filPercent == 0) {
//        _filPercent = @"0";
//    }
//    if ([_filType isEqualToString:@"0"] || _filType == 0) {
//        _filType = @"0";
//    }
//
    //post后让出借列表刷新
//    [self.delgate didClickFilttrateTermCount:_filTime InterestRange:_filPercent ProjType:_filType];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    NSArray *tempArr = @[_filTime, _filPercent, _filType];
//    filtrate.selectArr = tempArr;
//
}


#pragma mark - filetrate delegate
- (void)filtrateView:(RHFiltrateView *)filtrateView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        _filTime = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
//    }
//
//    if (indexPath.section == 1) {
//        _filPercent = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
//    }
//
//    if (indexPath.section == 2) {
//        _filType = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
//    }
    
    
}

- (UIScrollView *)scorllView {
    if (_scorllView == nil) {
        _scorllView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scorllView.backgroundColor = [UIColor clearColor];
        
//        if (IS_IPHONE5) {
//            _scorllView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+80);
//            
//        } else {
//            _scorllView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
//        }
//        
        [self.view addSubview:_scorllView];
    }
    return _scorllView;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"热门兼职", @"简单易做", @"演出表演", @"劳动赚钱", @"其它"];
    }
    return _titleArr;
}

- (NSArray *)hotArr {
    if (!_hotArr) {
        _hotArr = @[@"促销", @"销售", @"市场调研", @"模特"];
    }
    return _hotArr;
}

- (NSArray *)easyArr {
    if (!_easyArr) {
        _easyArr = @[@"派发传单", @"销售", @"市场调研", @"模特"];
    }
    return _easyArr;
}

- (NSArray *)playArr {
    if (!_playArr) {
        _playArr = @[@"模特", @"模特", @"n模特", @"n模特"];
    }
    return _playArr;
}

- (NSArray *)labourArr {
    if (!_labourArr) {
        _labourArr = @[@"服务员", @"服务员", @"服务员", @"服务员"];
    }
    return _labourArr;
}

- (NSArray *)otherArr {
    if (!_otherArr) {
        _otherArr = @[@"其它"];
    }
    return _otherArr;
}








@end
