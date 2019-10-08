//
//  UIView+HWUtilView.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/15.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "UIView+HWUtilView.h"

@implementation UIView (HWUtilView)

+ (void)HWShadowDraw:(UIView *)aim shadowColor:(UIColor *)color shadowOffset:(CGSize)size shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius{
    aim.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    aim.layer.shadowOffset = size;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    aim.layer.shadowOpacity = opacity;//阴影透明度，默认0
    aim.layer.shadowRadius = radius;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width     = aim.bounds.size.width;
    float height    = aim.bounds.size.height;
    float x         = aim.bounds.origin.x;
    float y         = aim.bounds.origin.y;
    
    //float addWH     = 10;
    
    CGPoint topLeft         = aim.bounds.origin;
    CGPoint topMiddle       = CGPointMake(x+(width/2),y);
    CGPoint topRight        = CGPointMake(x+width,y);
    CGPoint rightMiddle     = CGPointMake(x+width,y+(height/2));
    CGPoint bottomRight     = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle    = CGPointMake(x+(width/2),y+height);
    CGPoint bottomLeft      = CGPointMake(x,y+height);
    CGPoint leftMiddle      = CGPointMake(x,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    //设置阴影路径
    aim.layer.shadowPath = path.CGPath;
}

@end
