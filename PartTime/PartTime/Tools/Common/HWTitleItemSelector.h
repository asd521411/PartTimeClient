//
//  HwTitleItemSelector.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HWTitleItemSelectorDelegate <NSObject>

- (void)hw_titleItemSelectorAction:(NSInteger)index;

@end


@interface HWTitleItemSelector : UIView

@property (nonatomic, strong) UIButton *topBtn;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *lineV;

@property (nonatomic, weak) id<HWTitleItemSelectorDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
