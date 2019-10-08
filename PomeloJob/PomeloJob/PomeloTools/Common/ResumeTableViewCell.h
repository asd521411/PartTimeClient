//
//  ResumeTableViewCell.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/17.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResumeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResumeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *payLab;
@property (nonatomic, strong) UILabel *workContentLab;
@property (nonatomic, strong) UILabel *workTimeLab;
@property (nonatomic, strong) UILabel *workRequireLab;
@property (nonatomic, strong) UILabel *otherWelfareLab;

@property (nonatomic, strong) UILabel *payTitleLab;
@property (nonatomic, strong) UILabel *workContentTitleLab;
@property (nonatomic, strong) UILabel *workTimeTitleLab;
@property (nonatomic, strong) UILabel *workRequireTitleLab;
@property (nonatomic, strong) UILabel *otherWelfareTitleLab;

@property (nonatomic, strong) ResumeModel *resumeModel;

@end

NS_ASSUME_NONNULL_END
