//
//  ImgTitleView.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ImgTitleView.h"
#import "Masonry.h"

@implementation ImgTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.topImgV = [[UIImageView alloc] init];
        [self addSubview:self.topImgV];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.font = KFontNormalSize12;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLab];
        
        self.maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.maskBtn];
        [self.maskBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.topImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(12);
        make.centerX.mas_equalTo(self.topImgV.mas_centerX);
        make.top.mas_equalTo(self.topImgV.mas_bottom).offset(10);
    }];
    [self.maskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.topImgV.mas_top);
        make.bottom.mas_equalTo(self.titleLab.mas_bottom);
    }];

}

- (void)btnAction:(UIButton *)send {
    if (self.imgTitleViewBlock) {
        self.imgTitleViewBlock(send.tag);
    }
    
    if ([self.delegate respondsToSelector:@selector(ImgTitleViewACtion:)]) {
        [self.delegate ImgTitleViewACtion:send.tag];
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
