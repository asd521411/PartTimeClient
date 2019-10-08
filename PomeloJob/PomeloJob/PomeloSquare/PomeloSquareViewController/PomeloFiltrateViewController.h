//
//  PomeloFiltrateViewController.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^currentSelectItemTitle)(NSString *title);

@interface PomeloFiltrateViewController : BaseViewController

@property (nonatomic, copy) currentSelectItemTitle currentSelectItemTitle;

@end

NS_ASSUME_NONNULL_END
