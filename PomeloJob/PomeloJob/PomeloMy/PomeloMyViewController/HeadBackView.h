//
//  HeadBackView.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, InforType) {
    InforTypeOff_Line,
    InforTypeOn_Line,
    InforTypeShow
};

@protocol HeadBackViewDelegate <NSObject>

- (void)gotoLogin;
- (void)changeInfoMessage;

@end


@interface HeadBackView : UIView

@property (nonatomic, assign) InforType infoType;

@property (nonatomic, weak) id<HeadBackViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
