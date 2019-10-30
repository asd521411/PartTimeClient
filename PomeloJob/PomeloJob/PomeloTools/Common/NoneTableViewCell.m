//
//  NoneTableViewCell.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/25.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "NoneTableViewCell.h"

@interface NoneTableViewCell ()


@end

@implementation NoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.showImgV];
    [self addSubview:self.remindLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.showImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(200);
        make.width.mas_equalTo(225);
        make.height.mas_equalTo(120);
    }];
    [self.remindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.showImgV.mas_bottom).offset(50);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(20);
    }];
}

- (UIImageView *)showImgV {
    if (_showImgV == nil) {
        _showImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nonebackimg"]];
    }
    return _showImgV;
}

- (UILabel *)remindLab {
    if (_remindLab == nil) {
        _remindLab = [[UILabel alloc] init];
        _remindLab.text = @"暂无相关信息";
        _remindLab.textColor = kColor_Main;
        _remindLab.font = kFontNormalSize(16);
        _remindLab.textAlignment = NSTextAlignmentCenter;
    }
    return _remindLab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
