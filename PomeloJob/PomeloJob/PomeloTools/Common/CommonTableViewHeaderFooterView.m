//
//  CommonTableViewHeaderFooterView.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonTableViewHeaderFooterView.h"

@interface CommonTableViewHeaderFooterView ()

@property (nonatomic, strong) UIButton *turnBtn;
@property (nonatomic, strong) UIImageView *typeimgV;
@end

@implementation CommonTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.titleLab];
    [self addSubview:self.turnImgV];
    [self addSubview:self.turnBtn];
}

- (void)turnBtnAction:(UIButton *)send {
    if (self.commonHeaderActionBlock) {
        self.commonHeaderActionBlock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self);
    }];
    [self.turnImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.turnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.height.mas_equalTo(self);
        make.width.mas_equalTo(self);
    }];

}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = KFontNormalSize18;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UIImageView *)turnImgV {
    if (!_turnImgV) {
        _turnImgV = [[UIImageView alloc] init];
        //_turnImgV.image = [UIImage imageNamed:@"rightjiantou"];
        
    }
    return _turnImgV;
}

- (UIButton *)turnBtn {
    if (!_turnBtn) {
        _turnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_turnBtn addTarget:self action:@selector(turnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
