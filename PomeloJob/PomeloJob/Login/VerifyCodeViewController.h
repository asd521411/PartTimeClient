//
//  VerifyCodeViewController.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/22.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, InputCodeType) {
    InputCodeTypePassword,
    
};

@interface VerifyCodeViewController : BaseViewController

@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, assign) InputCodeType inputCodeType;

@end

NS_ASSUME_NONNULL_END
