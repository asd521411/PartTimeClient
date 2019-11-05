//
//  DiscoveryRankTableViewCell.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/2.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "DiscoveryRankTableViewCell.h"

@interface DiscoveryRankTableViewCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *workAddressLab;
@property (nonatomic, strong) UILabel *princeLab;

@property (nonatomic, strong) UIImageView *backImgV;
@property (nonatomic, strong) UIView *tag1BackV;
@property (nonatomic, strong) NSMutableArray *tagArr1;
@property (nonatomic, strong) UIView *tag2BackV;
@property (nonatomic, strong) NSMutableArray *tagArr2;

@end

@implementation DiscoveryRankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.backImgV];
    //[self.backImgV addSubview:self.tagBackV];
    [self addSubview:self.rankNum];
    [self addSubview:self.rankImgV];
    [self.backImgV addSubview:self.titleLab];
    [self.backImgV addSubview:self.workAddressLab];
    [self.backImgV addSubview:self.princeLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.rankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.rankImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.width.height.mas_equalTo(15);
        make.top.mas_equalTo(self.rankNum.mas_top);
    }];
    
    [self.backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(90);
        make.right.mas_equalTo(self);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-90);
        make.height.mas_equalTo(18);

    }];
    [self.titleLab.superview layoutIfNeeded];
    
    [self.tag1BackV removeFromSuperview];
    self.tag1BackV = nil;
    self.tag1BackV = [[UIView alloc] init];
    [self.backImgV addSubview:self.tag1BackV];
    
    CGFloat w = 0;
    if (self.tagArr1.count > 0) {
        for (NSInteger i = 0; i < self.tagArr1.count; i++) {
            NSString *strW = self.tagArr1[i];
            CGFloat wid = strW.length * 17;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w, 0, wid, 18)];
            lab.textColor = [ECUtil colorWithHexString:@"d7d7d7"];
            lab.font = KFontNormalSize16;
            lab.text = self.tagArr1[i];
            lab.textAlignment = NSTextAlignmentLeft;
            [self.tag1BackV addSubview:lab];
            w = w + wid + 5;
        }
    }
    
    self.tag1BackV.frame = CGRectMake(self.backImgV.width - w - 15, self.titleLab.top, w, 18);
    
    [self.tag2BackV removeFromSuperview];
    self.tag2BackV = nil;
    self.tag2BackV = [[UIView alloc] initWithFrame:CGRectMake(15, self.titleLab.bottom + 15, self.backImgV.width - w - 15, 15)];
    [self.backImgV addSubview:self.tag2BackV];
    
    CGFloat wi = 0;
    if (self.tagArr2.count > 0) {
        for (NSInteger i = 0; i < self.tagArr2.count; i++) {
            NSString *strW = self.tagArr2[i];
            CGFloat wid = strW.length * 13;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(wi, 0, wid, 14)];
            lab.backgroundColor = [UIColor whiteColor];
            lab.textColor = [ECUtil colorWithHexString:@"ce67eb"];
            lab.font = KFontNormalSize12;
            lab.text = self.tagArr2[i];
            lab.layer.borderColor = [ECUtil colorWithHexString:@"ce67eb"].CGColor;
            lab.layer.borderWidth = KLineWidthMeasure05;
            lab.textAlignment = NSTextAlignmentCenter;
            [self.tag2BackV addSubview:lab];
            wi = wi + wid + 15;
        }
    }
    
    [self.workAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15);
    }];
    
    [self.princeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);
    }];
}

- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        
        self.tagArr1 = [[NSMutableArray alloc] init];
        if (![ECUtil isBlankString:commonModel.positionworkaddressname]) {
            [self.tagArr1 addObject:commonModel.positionworkaddressname];
        }
        if (![ECUtil isBlankString:commonModel.positionpaytypename]) {
            [self.tagArr1 addObject:commonModel.positionpaytypename];
        }
        if (![ECUtil isBlankString:commonModel.positionworktime]) {
            [self.tagArr1 addObject:commonModel.positionworktime];
        }
        
        
        [self.tagArr2 removeAllObjects];
        //标签
        if (![ECUtil isBlankString:commonModel.positontime]) {
            [self.tagArr2 addObject:commonModel.positontime];
        }
        if (![ECUtil isBlankString:commonModel.positionsexreq]) {
            [self.tagArr2 addObject:commonModel.positionsexreq];
        }
        if (![ECUtil isBlankString:commonModel.positiontypename]) {
            [self.tagArr2 addObject:commonModel.positiontypename];
        }
        
        self.titleLab.text = commonModel.positionname;
        self.workAddressLab.text = commonModel.positionworkaddressinfo;
        
        self.princeLab.attributedText = [ECUtil mutableArrtibuteString:commonModel.positonmoney foregroundColor:[ECUtil colorWithHexString:@"ff4457"] fontName:KFontNormalSize16 attribut:@"元/天" foregroundColor:[ECUtil colorWithHexString:@"ff4457"] fontName:KFontNormalSize16];
    }
}

- (UILabel *)rankNum {
    if (!_rankNum) {
        _rankNum = [[UILabel alloc] init];
        _rankNum.textColor = [ECUtil colorWithHexString:@"ff4457"];
        _rankNum.font = KFontNormalSize14;
        _rankNum.textAlignment = NSTextAlignmentLeft;
        _rankNum.text = @"NO .";
    }
    return _rankNum;
}

- (UIImageView *)rankImgV {
    if (!_rankImgV) {
        _rankImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rankimg"]];
    }
    return _rankImgV;
}

- (UIImageView *)backImgV {
    if (!_backImgV) {
        _backImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yinyingbeijing"]];
        _backImgV.backgroundColor = [UIColor whiteColor];
    }
    return _backImgV;
}

- (UILabel *)princeLab {
    if (!_princeLab) {
        _princeLab = [[UILabel alloc] init];
        _princeLab.font = KFontNormalSize16;
        _princeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _princeLab;
}

- (UILabel *)workAddressLab {
    if (!_workAddressLab) {
        _workAddressLab = [[UILabel alloc] init];
        _workAddressLab.font = KFontNormalSize10;
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

- (NSMutableArray *)tagArr1 {
    if (!_tagArr1) {
        _tagArr1 = [[NSMutableArray alloc] init];
    }
    return _tagArr1;
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
