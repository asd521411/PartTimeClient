//
//  NavigationBarView.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/7.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LocationActionBlock)(void);
typedef void(^SearchActionBlock)(void);

@interface NavigationBarView : UIView

@property (nonatomic, strong) UIImageView *locationImgV;
@property (nonatomic, strong) UILabel *locationNameLab;

@property (nonatomic, copy) LocationActionBlock  locationActionBlock;
@property (nonatomic, copy) SearchActionBlock  searchActionBlock;

@end

NS_ASSUME_NONNULL_END
