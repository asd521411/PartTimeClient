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
        self.topImgV.image = [UIImage imageNamed:@""];
        self.topImgV.backgroundColor = [HWRandomColor randomColor];
        [self addSubview:self.topImgV];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.backgroundColor = [HWRandomColor randomColor];
        self.titleLab.textColor = [UIColor darkGrayColor];
        self.titleLab.font = SMALLFont;
        //self.titleLab.userInteractionEnabled = YES;
        [self addSubview:self.titleLab];
        
        self.maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.maskBtn];
        [self.maskBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topImgV.frame = CGRectMake(0, 0, self.width, self.height * 4 / 5 - 10);
    self.titleLab.frame = CGRectMake(0, self.topImgV.bottom + 5, self.width, self.height / 5);
    self.maskBtn.frame = CGRectMake(0, 0, self.width, self.height);

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
