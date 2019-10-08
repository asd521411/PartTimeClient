//
//  NavigationBarView.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/7.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "NavigationBarView.h"
#import "Masonry.h"
#import "ECUtil.h"

@interface NavigationBarView ()

@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UIView *lineV;
@property (nonatomic, strong) UIImageView *searchImgV;
@property (nonatomic, strong) UILabel *searchLab;
@property (nonatomic, strong) UIButton *searchBtn;

@end


@implementation NavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ECUtil colorWithHexString:@"f2efef"];
        
        self.locationImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [self addSubview:self.locationImgV];
        
        self.locationNameLab = [[UILabel alloc] init];
        self.locationNameLab.textColor = kCOLOR_BLACK;
        self.locationNameLab.font = KFontNormalSize10;
        [self addSubview:self.locationNameLab];
        
        self.locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.locationBtn];
        [self.locationBtn addTarget:self action:@selector(locationBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lineV = [[UIView alloc] init];
        self.lineV.backgroundColor = kCOLOR_BLACK;
        [self addSubview:self.lineV];
        
        self.searchImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@" "]];
        [self addSubview:self.searchImgV];
        
        self.searchLab = [[UILabel alloc] init];
        self.searchLab.textColor = [ECUtil colorWithHexString:@"d3d1d1"];
        self.searchLab.font = KFontNormalSize10;
        self.searchLab.textAlignment = NSTextAlignmentLeft;
        self.searchLab.text = @"搜索出想要的职位";
        [self addSubview:self.searchLab];
        
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.searchBtn];
        [self.searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.locationImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(22);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.locationNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(12);
        make.right.mas_equalTo(self.lineV);
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self.lineV);
    }];
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(70);
        make.top.mas_equalTo(4);
        make.bottom.mas_offset(-4);
        make.width.mas_equalTo(KLineWidthMeasure05);
    }];
    
    [self.searchImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineV).mas_offset(94);
        make.top.mas_equalTo(5);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.searchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchImgV.mas_right).offset(20);
        make.top.mas_equalTo(2);
        make.bottom.mas_offset(-2);
        make.right.mas_equalTo(self);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineV);
        make.top.right.bottom.mas_equalTo(self);
    }];
    
}


- (void)locationBtn:(UIButton *)send {
    if (self.locationActionBlock) {
        self.locationActionBlock();
    }
}

- (void)searchBtn:(UIButton *)send {
    if (self.searchActionBlock) {
        self.searchActionBlock();
    }
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
