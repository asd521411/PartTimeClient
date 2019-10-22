//
//  CompleteTableViewCell.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CompleteTableViewCell.h"

@interface CompleteTableViewCell ()

@property (nonatomic, strong) UIImageView *backImgV;
@property (nonatomic, strong) UIImageView *percentImgV;
@property (nonatomic, strong) UILabel *explainLab;
@property (nonatomic, strong) UILabel *rightAwayLab;

@end

@implementation CompleteTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.backImgV];
    [self addSubview:self.percentImgV];
    [self addSubview:self.explainLab];
    [self addSubview:self.rightAwayLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.bottom.right.mas_equalTo(self);
    }];
    
    [self.explainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(45);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    
    [self.rightAwayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(80);
    }];
    self.rightAwayLab.layer.cornerRadius = 11;
    
    [self.percentImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(self.height-20);
    }];
}

- (void)setUserInfoModel:(UserInfoModel *)userInfoModel {
    if (_userInfoModel != userInfoModel) {
        
    }
}

- (UIImageView *)backImgV {
    if (_backImgV == nil) {
        _backImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"completebackImg"]];
        _backImgV.userInteractionEnabled = YES;
    }
    return _backImgV;
}

- (UIImageView *)percentImgV {
    if (_percentImgV == nil) {
        _percentImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"resumepercent0"]];
    }
    return _percentImgV;
}

- (UILabel *)explainLab {
    if (_explainLab == nil) {
        _explainLab = [[UILabel alloc] init];
        _explainLab.text = @"我的简历\n完善简历提高录取率";
        _explainLab.font = kFontNormalSize(16);
        _explainLab.numberOfLines = 2;
        _explainLab.textColor = [ECUtil colorWithHexString:@"ffaa38"];
    }
    return _explainLab;
}

- (UILabel *)rightAwayLab {
    if (_rightAwayLab == nil) {
        _rightAwayLab = [[UILabel alloc] init];
        _rightAwayLab.font = kFontNormalSize(14);
        _rightAwayLab.textColor = [ECUtil colorWithHexString:@"ffaa38"];
        _rightAwayLab.layer.borderColor = [ECUtil colorWithHexString:@"ffaa38"].CGColor;
        _rightAwayLab.layer.borderWidth = 1;
        _rightAwayLab.layer.masksToBounds = YES;
        _rightAwayLab.text = @"立即完善";
        _rightAwayLab.textAlignment = NSTextAlignmentCenter;
    }
    return _rightAwayLab;
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
