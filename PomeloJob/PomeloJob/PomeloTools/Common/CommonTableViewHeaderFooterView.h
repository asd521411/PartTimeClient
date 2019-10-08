//
//  CommonTableViewHeaderFooterView.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CommonHeaderActionBlock)(void);

@interface CommonTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *turnImgV;

@property (nonatomic, copy) CommonHeaderActionBlock commonHeaderActionBlock;

@end

NS_ASSUME_NONNULL_END
