//
//  SelectBtnView.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "SelectBtnView.h"

@implementation SelectBtnView

#define kSpace 10
#define kWidth (SCREENWIDTH - kSpace * 2 * 3 - kSpace * 2) / 4
#define kHeight 40

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString *)title itemStyle:(NSArray *)itemArr {
    self = [self initWithFrame:frame];
    if (self) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, kHeight)];
        lab.backgroundColor = [HWRandomColor randomColor];
        lab.textColor = BLACKCOLOR;
        lab.font = LARGEFont;
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = title;
        lab.userInteractionEnabled = NO;
        [self addSubview:lab];
        
        for (NSInteger i = 0; i < itemArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((i % 4) * (kWidth + kSpace * 2), lab.bottom + kSpace + (i / 4) * (kHeight + kSpace), kWidth, kHeight);
            btn.backgroundColor = [HWRandomColor randomColor];
            btn.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
            btn.layer.borderWidth = LineWidthNormal05;
            btn.layer.cornerRadius = 2;
            btn.layer.masksToBounds = YES;
            [self addSubview:btn];
            [btn setTitle:itemArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)btnAction:(UIButton *)send {
    if (self.selectBtnActionBlock) {
        self.selectBtnActionBlock(send.titleLabel.text);
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
