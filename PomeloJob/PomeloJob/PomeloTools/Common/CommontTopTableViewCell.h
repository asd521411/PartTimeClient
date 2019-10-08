//
//  CommontTopTableViewCell.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/12.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PasteAction)(NSString *num);

@interface CommontTopTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *addressnameTitleLab;
@property (nonatomic, strong) UILabel *princeLab;
@property (nonatomic, strong) UILabel *positionStyleLab;
@property (nonatomic, strong) UILabel *demandTitleLab;
@property (nonatomic, strong) UILabel *tagLab;

@property (nonatomic, strong) CommonModel *commonModel;
@property (nonatomic, copy) PasteAction pasteAction;

@end

NS_ASSUME_NONNULL_END
