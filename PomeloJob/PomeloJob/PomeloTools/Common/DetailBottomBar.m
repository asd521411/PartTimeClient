//
//  DetailBottomBar.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/22.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "DetailBottomBar.h"

@interface DetailBottomBar ()

@property (nonatomic, strong) UIButton *leftCollectBtn;
@property (nonatomic, strong) UIButton *rightSignupBtn;

@end

@implementation DetailBottomBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.leftCollectBtn];
    [self addSubview:self.rightSignupBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.leftCollectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.width/2);
    }];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:self.leftCollectBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(self.width/2, self.width/2)];
    CAShapeLayer *lay1 = [CAShapeLayer layer];
    lay1.path = path1.CGPath;
    self.leftCollectBtn.layer.mask = lay1.mask;
    
    [self.rightSignupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.width/2);
    }];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:self.rightSignupBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.width/2, self.width/2)];
    CAShapeLayer *lay2 = [CAShapeLayer layer];
    lay2.path = path2.CGPath;
    self.rightSignupBtn.layer.mask = lay2.mask;
}

- (void)leftCollectBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(bottomBarcollect)]) {
        [self.delegate bottomBarcollect];
    }
}

- (void)rightSignupBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(bottomBarSignup)]) {
        [self.delegate bottomBarSignup];
    }
}

- (UIButton *)leftCollectBtn {
    if (_leftCollectBtn == nil) {
        _leftCollectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftCollectBtn setBackgroundColor:[UIColor colorWithRed:246/255.0 green:246/255.0 blue:146/255.0 alpha:1]];
        [_leftCollectBtn addTarget:self action:@selector(leftCollectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftCollectBtn;
}

- (UIButton *)rightSignupBtn {
    if (_rightSignupBtn == nil) {
        _rightSignupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightSignupBtn setBackgroundColor:kColor_Main];
        [_rightSignupBtn setTitle:@"立即报名" forState:UIControlStateNormal];
        [_rightSignupBtn addTarget:self action:@selector(rightSignupBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightSignupBtn;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
