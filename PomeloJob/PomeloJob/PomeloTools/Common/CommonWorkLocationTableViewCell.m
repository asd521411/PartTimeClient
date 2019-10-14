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

@property (nonatomic, strong) UIImageView *componyImgV;
@property (nonatomic, strong) UILabel *componyLocationLab;
@property (nonatomic, strong) UILabel *componyScaleLab;

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
    //[self addSubview:self.componyImgV];
    [self addSubview:self.componyLocationLab];
    //[self addSubview:self.componyScaleLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self.componyImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(10);
//        make.bottom.mas_equalTo(-10);
//        make.width.mas_equalTo(self.height-20);
//    }];
    
    [self.componyLocationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(20);
    }];

//    [self.componyScaleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(55);
//        make.right.mas_equalTo(-30);
//        make.height.mas_equalTo(15);
//    }];
}

- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        [self.componyImgV sd_setImageWithURL:[NSURL URLWithString:commonModel.companyimg] placeholderImage:[UIImage imageNamed:@"icontext"]];
        self.componyLocationLab.text = commonModel.positionworkaddressinfo;
        if ([ECUtil isBlankString:commonModel.companyScale]) {
            commonModel.companyScale = @"0人";
        }
        self.componyScaleLab.text = [[NSString stringWithFormat:@"公司规模:"] stringByAppendingString:[NSString stringWithFormat:@"%@", commonModel.companyScale]];
    }
}


- (UIImageView *)componyImgV {
    if (!_componyImgV) {
        _componyImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icontext"]];
    }
    return _componyImgV;
}

- (UILabel *)componyLocationLab {
    if (!_componyLocationLab) {
        _componyLocationLab = [[UILabel alloc] init];
        _componyLocationLab.font = KFontNormalSize14;
        _componyLocationLab.textAlignment = NSTextAlignmentLeft;
        _componyLocationLab.textColor = [ECUtil colorWithHexString:@"7a7a7a"];
    }
    return _componyLocationLab;
}

- (UILabel *)componyScaleLab {
    if (!_componyScaleLab) {
        _componyScaleLab = [[UILabel alloc] init];
        _componyScaleLab.font = KFontNormalSize14;
        _componyScaleLab.textColor = [ECUtil colorWithHexString:@"7a7a7a"];
    }
    return _componyScaleLab;
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
