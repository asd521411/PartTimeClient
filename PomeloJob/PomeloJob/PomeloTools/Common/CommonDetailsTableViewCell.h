//
//  CommonDetailsTableViewCell.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/9.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CommonDetailsModel.h"

#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonDetailsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *payLab;
@property (nonatomic, strong) UITextView *workContentLab;
@property (nonatomic, strong) UILabel *workTimeLab;
@property (nonatomic, strong) UILabel *workRequireLab;
@property (nonatomic, strong) UILabel *otherWelfareLab;

@property (nonatomic, strong) UILabel *payTitleLab;
@property (nonatomic, strong) UILabel *workContentTitleLab;
@property (nonatomic, strong) UILabel *workTimeTitleLab;
@property (nonatomic, strong) UILabel *workRequireTitleLab;
@property (nonatomic, strong) UILabel *otherWelfareTitleLab;

//@property (nonatomic, strong) CommonDetailsModel *commonDetailsModel;
@property (nonatomic, strong) CommonModel *commonModel;

@property (nonatomic, strong) UIView *workContentBackV;

@property (nonatomic, copy) NSString *contentStr;

@end

NS_ASSUME_NONNULL_END
