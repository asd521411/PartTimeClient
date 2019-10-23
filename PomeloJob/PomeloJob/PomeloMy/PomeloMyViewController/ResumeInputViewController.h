//
//  ResumeInputViewController.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, InputType) {
    InputTypeWorkContent,
    InputTypeWorkPosition
};

typedef void(^InputContentBlock)(NSString *content);

@interface ResumeInputViewController : BaseViewController

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, assign) InputType inputType;

@property (nonatomic, copy) InputContentBlock inputContentBlock;

@end

NS_ASSUME_NONNULL_END
