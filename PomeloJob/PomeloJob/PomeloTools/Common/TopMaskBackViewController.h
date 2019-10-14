//
//  TopMaskBackViewController.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/10.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TopMaskBackViewBlock)(NSString *age);

@interface TopMaskBackViewController : BaseViewController

@property (nonatomic, copy) TopMaskBackViewBlock topMaskBackViewBlock;

@end

NS_ASSUME_NONNULL_END
