//
//  UIView+Dimension.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Dimension)

@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat centerX;

- (void)changeTopByAdding:(NSNumber *)number;

@end

NS_ASSUME_NONNULL_END
