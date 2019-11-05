//
//  PomeloFastPositionTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/19.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloFastPositionTableViewCell.h"
#import "UIView+HWUtilView.h"

@interface PomeloFastPositionTableViewCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *workAddressLab;
@property (nonatomic, strong) UILabel *princeLab;
@property (nonatomic, strong) UIView *tagBackV;
@property (nonatomic, strong) UIImageView *rightImgV;
@property (nonatomic, strong) NSMutableArray *tagArr2;

@end


@implementation PomeloFastPositionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.backImgV];
    [self.backImgV addSubview:self.titleLab];
    [self.backImgV addSubview:self.workAddressLab];
    [self.backImgV addSubview:self.princeLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.workAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15);
    }];
    
    [self.princeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.backImgV.mas_bottom).offset(-15);
    }];
    
    [self.tagBackV removeFromSuperview];
    self.tagBackV = nil;
    self.tagBackV = [[UIView alloc] init];
    [self.backImgV addSubview:self.tagBackV];
    [self.tagBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.princeLab.mas_right).offset(15);
        make.bottom.mas_equalTo(self.backImgV.mas_bottom).offset(-15);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(self).offset(-15);
    }];
    [self.tagBackV.superview layoutIfNeeded];
    
    CGFloat w = 0;
    if (self.tagArr2.count > 0) {
        for (NSInteger i = 0; i < self.tagArr2.count; i++) {
            NSString *strW = self.tagArr2[i];
            CGFloat wid = strW.length * 15;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w, 0, wid, 14)];
            lab.backgroundColor = [UIColor whiteColor];
            lab.textColor = [ECUtil colorWithHexString:@"a4a4a4"];
            lab.font = KFontNormalSize14;
            lab.text = self.tagArr2[i];
            lab.textAlignment = NSTextAlignmentCenter;
            [self.tagBackV addSubview:lab];
            w = w + wid + 15;
        }
    }
}

- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        
        [self.tagArr2 removeAllObjects];
        //标签
        if (![ECUtil isBlankString:commonModel.positontime]) {
            [self.tagArr2 addObject:commonModel.positontime];
        }
        if (![ECUtil isBlankString:commonModel.positionsexreq]) {
            [self.tagArr2 addObject:commonModel.positionsexreq];
        }
        if (![ECUtil isBlankString:commonModel.positionworktime]) {
            [self.tagArr2 addObject:commonModel.positionworktime];
        }
        
        self.titleLab.text = commonModel.positionname;
        self.workAddressLab.text = commonModel.positionworkaddressinfo;
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:commonModel.positonmoney attributes:@{NSForegroundColorAttributeName:[ECUtil colorWithHexString:@"ff4457"], NSFontAttributeName:KFontNormalSize16}];
        NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:@"元/天" attributes:@{NSForegroundColorAttributeName:[ECUtil colorWithHexString:@"ff4457"], NSFontAttributeName:KFontNormalSize14}];
        [attributedStr appendAttributedString:attributedStr1];
        self.princeLab.attributedText = attributedStr;
        
    }
}

- (UIImageView *)backImgV {
    if (!_backImgV) {
        _backImgV = [[UIImageView alloc] init];
    }
    return _backImgV;
}

- (UILabel *)princeLab {
    if (!_princeLab) {
        _princeLab = [[UILabel alloc] init];
        _princeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _princeLab;
}

- (UILabel *)workAddressLab {
    if (!_workAddressLab) {
        _workAddressLab = [[UILabel alloc] init];
        _workAddressLab.font = KFontNormalSize12;
        _workAddressLab.textAlignment = NSTextAlignmentLeft;
    }
    return _workAddressLab;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = KFontNormalSize16;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (NSMutableArray *)tagArr2 {
    if (!_tagArr2) {
        _tagArr2 = [[NSMutableArray alloc] init];
    }
    return _tagArr2;
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
