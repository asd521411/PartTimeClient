//
//  MyNewResumeTableViewCell.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyNewResumeTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL mustSelect;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *showLab;

@property (nonatomic, strong) UIButton *selectBtn1;
@property (nonatomic, strong) UIButton *selectBtn2;

@end

NS_ASSUME_NONNULL_END
