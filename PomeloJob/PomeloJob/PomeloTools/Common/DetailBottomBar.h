//
//  DetailBottomBar.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/22.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DetailBottomBarDelegate <NSObject>

- (void)bottomBarcollect;
- (void)bottomBarSignup;

@end


@interface DetailBottomBar : UIView

@property (nonatomic, weak) id<DetailBottomBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
