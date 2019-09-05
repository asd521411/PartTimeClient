//
//  HeadTapV.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "HeadTapV.h"

@implementation HeadTapV

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.leftLab = [[UILabel alloc] init];
        self.leftLab.textColor = DARKGRAYCOLOR;
        self.leftLab.font = LARGEFont;
        [self addSubview:self.leftLab];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [HWRandomColor randomColor];
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:self.rightBtn];
        [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftLab.frame = CGRectMake(20, 0, self.width / 2, self.height);
    self.rightBtn.frame = CGRectMake(self.right - 100, 0, self.height, self.height);
    
}

- (void)rightBtn:(UIButton *)send {
    if (self.headTapVAction) {
        self.headTapVAction(send.tag);
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
