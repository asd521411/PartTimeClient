//
//  PorgressHUD.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/15.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "HWPorgressHUD.h"

@implementation HWPorgressHUD

+ (void)HWHudShowStatus:(NSString *)status {
    [SVProgressHUD showImage:[UIImage imageNamed:@" "] status:status];
    [SVProgressHUD dismissWithDelay:1];
}

@end
