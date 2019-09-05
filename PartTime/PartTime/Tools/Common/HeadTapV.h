//
//  HeadTapV.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HeadTapVAction)(NSInteger index);

@interface HeadTapV : UIView

@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, copy) HeadTapVAction  headTapVAction;

@end

NS_ASSUME_NONNULL_END
