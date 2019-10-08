//
//  HWRandomColor.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "HWRandomColor.h"

@implementation HWRandomColor

+ (UIColor *)randomColor {
    CGFloat r = arc4random() % 255 / 255.0f;
    CGFloat g = arc4random() % 255 / 255.0f;
    CGFloat b = arc4random() % 255 / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
