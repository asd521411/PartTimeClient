//
//  CommonTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "UIImageView+WebCache.h"

#define topSpace 6

@interface CommonTableViewCell ()

@property (nonatomic, strong) UIImageView *tagImgV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *styleIconImgV;
@property (nonatomic, strong) UIImageView *locationImgV;
@property (nonatomic, strong) UILabel *locationLab;
@property (nonatomic, strong) UILabel *accountStyleLab;
@property (nonatomic, strong) UILabel *princeLab;
@property (nonatomic, strong) UILabel *tagLab;
@property (nonatomic, strong) UIView *line;

@end


@implementation CommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.tagImgV = [[UIImageView alloc] init];
        //self.tagImgV.image = [UIImage imageNamed:@"icontext"];
        [self addSubview:self.tagImgV];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.textColor = [ECUtil colorWithHexString:@"212121"];
        self.titleLab.font = KFontNormalSize18;
        [self addSubview:self.titleLab];
        
        self.styleIconImgV = [[UIImageView alloc] init];
        [self addSubview:self.styleIconImgV];
        
        self.locationImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dituicon"]];
        [self addSubview:self.locationImgV];
        
        self.locationLab = [[UILabel alloc] init];
        self.locationLab.textColor = [ECUtil colorWithHexString:@"666666"];
        self.locationLab.font = KFontNormalSize14;
        [self addSubview:self.locationLab];
        
        self.accountStyleLab = [[UILabel alloc] init];
        self.accountStyleLab.textColor = [ECUtil colorWithHexString:@"ff4457"];
        self.accountStyleLab.font = KFontNormalSize12;
        self.accountStyleLab.layer.borderWidth = KLineWidthMeasure05;
        self.accountStyleLab.layer.borderColor = [ECUtil colorWithHexString:@"ff4457"].CGColor;
        [self addSubview:self.accountStyleLab];
    
        self.princeLab = [[UILabel alloc] init];
        self.princeLab.font = KFontNormalSize16;
        [self addSubview:self.princeLab];
        
        self.tagLab = [[UILabel alloc] init];
        self.tagLab.textColor = [ECUtil colorWithHexString:@"a9a9a9"];
        self.tagLab.font = KFontNormalSize14;
        [self addSubview:self.tagLab];
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = KColor_Line;
        [self addSubview:self.line];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.tagImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.top.mas_equalTo(self).offset(10);
        make.width.height.mas_equalTo(34);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagImgV.mas_right).offset(15);
        make.top.mas_equalTo(self).offset(10);
    }];
    
    [self.styleIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(15);
        make.centerY.mas_equalTo(self.titleLab);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.locationImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(18);
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationImgV.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15);
    }];
    
    [self.accountStyleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(10);
    }];
    [self.princeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.accountStyleLab.mas_bottom).offset(10);
    }];
    
    [self.tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationLab.mas_right).offset(15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(KLineWidthMeasure05);
    }];
    
}

- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        self.titleLab.text = commonModel.positionname;
        [self.styleIconImgV sd_setImageWithURL:[NSURL URLWithString:commonModel.positionicon] placeholderImage:[UIImage imageNamed:@" "]];
        self.locationLab.text = commonModel.positionworkaddressname;
        self.accountStyleLab.text = commonModel.positionpaytypename;
        [self.tagImgV sd_setImageWithURL:[NSURL URLWithString:commonModel.positiontypeimg] placeholderImage:[UIImage imageNamed:@"icontext"]];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:commonModel.positonmoney attributes:@{NSForegroundColorAttributeName:[ECUtil colorWithHexString:@"ff4457"], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
        NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:@"/天" attributes:@{NSForegroundColorAttributeName:[ECUtil colorWithHexString:@"ff4457"], NSFontAttributeName:KFontNormalSize14}];
        [attributedStr appendAttributedString:attributedStr1];
        self.princeLab.attributedText = attributedStr;
        
        NSString *str = commonModel.positontime;
        if (![ECUtil isBlankString:commonModel.positionpaytypename]) {
            str = [[str stringByAppendingString:@" | "] stringByAppendingString:commonModel.positionpaytypename];
        }
        self.tagLab.text = str;
    }
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
