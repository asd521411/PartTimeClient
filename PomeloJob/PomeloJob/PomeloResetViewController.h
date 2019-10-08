//
//  PomeloResetViewController.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/5.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface PomeloResetViewController : BaseViewController

@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, assign) EntranceType entranceType;

@end

NS_ASSUME_NONNULL_END
