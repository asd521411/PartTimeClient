//
//  CommonWorkLocationTableViewCell.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/7.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonWorkLocationTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CommonWorkLocationTableViewCell ()

@end


@implementation CommonWorkLocationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.componyLocationLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.componyLocationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(20);
    }];
}

- (UILabel *)componyLocationLab {
    if (!_componyLocationLab) {
        _componyLocationLab = [[UILabel alloc] init];
        _componyLocationLab.font = KFontNormalSize16;
        _componyLocationLab.textAlignment = NSTextAlignmentLeft;
        _componyLocationLab.textColor = [ECUtil colorWithHexString:@"7a7a7a"];
    }
    return _componyLocationLab;
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
