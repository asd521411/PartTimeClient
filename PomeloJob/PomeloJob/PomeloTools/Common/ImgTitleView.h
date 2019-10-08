//
//  ImgTitleView.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImgTitleViewDelegate <NSObject>

- (void)ImgTitleViewACtion:(NSInteger)index;

@end


typedef void(^ImgTitleViewBlock)(NSInteger index);

@interface ImgTitleView : UIView

@property (nonatomic, strong) UIImageView *topImgV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *maskBtn;

@property (nonatomic, copy) ImgTitleViewBlock imgTitleViewBlock;

@property (nonatomic, weak) id<ImgTitleViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
