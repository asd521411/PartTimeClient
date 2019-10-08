//
//  PorgressHUD.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/15.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWPorgressHUD : NSObject

/**
 *  只显示文字1秒
 */
+ (void)HWHudShowStatus:(NSString *)status;

@end

NS_ASSUME_NONNULL_END
