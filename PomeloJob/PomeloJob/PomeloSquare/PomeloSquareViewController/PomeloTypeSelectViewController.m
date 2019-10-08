//
//  PomeloTypeSelectViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloTypeSelectViewController.h"
#import "SelectBtnView.h"

@interface PomeloTypeSelectViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *hotArr;
@property (nonatomic, strong) NSArray *easyArr;
@property (nonatomic, strong) NSArray *playArr;
@property (nonatomic, strong) NSArray *labourArr;
@property (nonatomic, strong) NSArray *otherArr;

@property (nonatomic, strong) NSMutableArray *indexArr;

@property (nonatomic, strong) UIButton *investBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@end


@implementation PomeloTypeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupSubViews];
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight])];
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [self.view addSubview:self.backScrollV];
    
    CGFloat space = 10;
    CGFloat height = 40;
    SelectBtnView *select1 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, space, SCREENWIDTH - space * 2, height + space * 2 + self.hotArr.count / 4 * (height + space)) titleString:self.titleArr[0] itemStyle:self.hotArr];
    [self.backScrollV addSubview:select1];
    select1.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    SelectBtnView *select2 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, select1.bottom, SCREENWIDTH - space * 2, height + space * 2 + self.easyArr.count / 4 * (height + space)) titleString:self.titleArr[1] itemStyle:self.easyArr];
    [self.backScrollV addSubview:select2];
    select2.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    SelectBtnView *select3 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, select2.bottom, SCREENWIDTH - space * 2, height + space * 2 + self.playArr.count / 4 * (height + space)) titleString:self.titleArr[2] itemStyle:self.playArr];
    [self.backScrollV addSubview:select3];
    select3.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    SelectBtnView *select4 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, select3.bottom, SCREENWIDTH - space * 2, height + space * 2 + self.labourArr.count / 4 * (height + space)) titleString:self.titleArr[3] itemStyle:self.labourArr];
    [self.backScrollV addSubview:select4];
    select4.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    SelectBtnView *select5 = [[SelectBtnView alloc] initWithFrame:CGRectMake(space, select4.bottom, SCREENWIDTH - space * 2, height + space * 2 + self.otherArr.count / 4 * (height + space)) titleString:self.titleArr[4] itemStyle:self.otherArr];
    [self.backScrollV addSubview:select4];
    select5.selectBtnActionBlock = ^(NSString * _Nonnull btnTitle) {
        if (self.typeSelectBlock) {
            self.typeSelectBlock(btnTitle);
        }
    };
    
    CGFloat wid = (KSCREEN_WIDTH - KSpaceDistance15 * 2) / 2;
    
    __weak typeof(self) weakSelf = self;
    
    self.investBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backScrollV addSubview:self.investBtn];
    [self.investBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(wid);
        make.height.mas_equalTo(44);
    }];
    [self.investBtn setTitleColor:[ECUtil colorWithHexString:@"cccaca"] forState:UIControlStateNormal];
    [self.investBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.investBtn setBackgroundColor:[ECUtil colorWithHexString:@"f8f8f8"]];
    [self.investBtn setTitle:@"重 置" forState:UIControlStateNormal];
    [self.investBtn.superview layoutIfNeeded];
    UIBezierPath *pa1 = [UIBezierPath bezierPathWithRoundedRect:self.investBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(22, 22)];
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.frame = self.investBtn.bounds;
    layer1.path = pa1.CGPath;
    self.investBtn.layer.mask = layer1;
    [[self.investBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.investBtn.selected = YES;
        strongSelf.sureBtn.selected = NO;
        [strongSelf.investBtn setBackgroundColor:KColorGradient_light];
        [strongSelf.sureBtn setBackgroundColor:[ECUtil colorWithHexString:@"f8f8f8"]];
        
        if (strongSelf.typeSelectBlock) {
            strongSelf.typeSelectBlock(@"");
        }
    }];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backScrollV addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.investBtn.mas_right);
        make.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(wid);
        make.height.mas_equalTo(44);
    }];
    [self.sureBtn setTitleColor:[ECUtil colorWithHexString:@"cccaca"] forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.sureBtn setBackgroundColor:KColorGradient_light];
    self.sureBtn.selected = YES;
    [self.sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [self.sureBtn.superview layoutIfNeeded];
    UIBezierPath *pa2 = [UIBezierPath bezierPathWithRoundedRect:self.investBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(22, 22)];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.frame = self.sureBtn.bounds;
    layer2.path = pa2.CGPath;
    self.sureBtn.layer.mask = layer2;
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.investBtn.selected = NO;
        strongSelf.sureBtn.selected = YES;
        [strongSelf.investBtn setBackgroundColor:[ECUtil colorWithHexString:@"f8f8f8"]];
        [strongSelf.sureBtn setBackgroundColor:KColorGradient_light];
        
        if (strongSelf.typeSelectBlock) {
            strongSelf.typeSelectBlock(@"");
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

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
        _playArr = @[@"模特", @"模特", @"模特", @"模特"];
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
