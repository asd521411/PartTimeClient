//
//  ModificationControl.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ModificationControl.h"

@interface ModificationControl ()

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *leftImgV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *rightImgV;

@end

@implementation ModificationControl

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.nameLab];
    [self addSubview:self.leftImgV];
    [self addSubview:self.titleLab];
    [self addSubview:self.rightImgV];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    [self.leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImgV.mas_right).offset(10);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(20);
    }];
}

- (void)setNameStr:(NSString *)nameStr{
    if (_nameStr != nameStr) {
        NSLog(@"============%@", nameStr);
        self.nameLab.text = nameStr;
    }
}

- (UIImageView *)headImgV {
    if (_headImgV == nil) {
        _headImgV = [[UIImageView alloc] init];
    }
    return _headImgV;
}

- (UILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = kFontNormalSize(18);
        _nameLab.textColor = [UIColor whiteColor];
        _nameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLab;
}

- (UIImageView *)leftImgV {
    if (_leftImgV == nil) {
        _leftImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiugaixinxileft"]];
    }
    return _leftImgV;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = kFontNormalSize(16);
        _titleLab.text = @"修改个人信息";
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIImageView *)rightImgV {
    if (_rightImgV == nil) {
        _rightImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiugaixinxiright"]];
    }
    return _rightImgV;
}

@end
