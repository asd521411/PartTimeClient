//
//  PomeloPersonalInfoViewController.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/9.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PersonalInfoBlock)(NSString *nickname, NSString * personSignature, NSArray *tagArr);

@interface PomeloPersonalInfoViewController : BaseViewController

@property (nonatomic, copy) PersonalInfoBlock  personalInfoBlock;

@end

NS_ASSUME_NONNULL_END
