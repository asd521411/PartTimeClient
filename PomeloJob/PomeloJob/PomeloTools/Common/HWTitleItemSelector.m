//
//  HwTitleItemSelector.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "HwTitleItemSelector.h"

@implementation HWTitleItemSelector

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height * 4 / 5)];
//        self.titleLab.backgroundColor = [HWRandomColor randomColor];
//        [self addSubview:self.titleLab];
        
        self.topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.topBtn.frame = CGRectMake(0, 0, self.width, self.height * 4 / 5);
        self.topBtn.backgroundColor = [HWRandomColor randomColor];
        //[self.topBtn setTitle:title forState:UIControlStateNormal];
        self.topBtn.titleLabel.font = NORMALFont;
        [self addSubview:self.topBtn];
        [self.topBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLab.bottom, self.width, self.height / 5)];
        //self.lineV.backgroundColor = [HWRandomColor randomColor];
        [self addSubview:self.lineV];
    }
    return self;
}


- (void)topBtnAction:(UIButton *)send {
//    if (send.selected) {
//        self.lineV.backgroundColor = [UIColor whiteColor];
//    }else {
//        self.lineV.backgroundColor = [UIColor orangeColor];
//    }
//
//    send.selected = !send.selected;
    if ([self.delegate respondsToSelector:@selector(hw_titleItemSelectorAction:)]) {
        [self.delegate hw_titleItemSelectorAction:send.tag];
    }
}


//- (void)setTitleLab:(UILabel *)titleLab {
////    if (<#condition#>) {
////        <#statements#>
////    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
