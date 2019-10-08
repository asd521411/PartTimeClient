//
//  UIView+HWUtilView.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/15.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HWUtilView)

/**
 *  View.layer.maskToBounce 不能设置为NO
 *  性能优化
 */
+ (void)HWShadowDraw:(UIView *)aim shadowColor:(UIColor *)color shadowOffset:(CGSize)size shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
