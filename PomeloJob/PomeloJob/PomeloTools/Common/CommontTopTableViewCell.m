//
//  CommontTopTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/12.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommontTopTableViewCell.h"

@interface CommontTopTableViewCell ()

@property (nonatomic, strong) NSMutableArray *tagArr1;
@property (nonatomic, strong) NSMutableArray *tagArr2;

@property (nonatomic, strong) UIView *pasteBackV;
@property (nonatomic, strong) UILabel *pastetitleLab;
@property (nonatomic, strong) UILabel *connectNumber;
@property (nonatomic, strong) UIButton *pasteBtn;

@property (nonatomic, assign) BOOL show;

@end

@implementation CommontTopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.addressnameTitleLab];
    [self addSubview:self.princeLab];
    [self addSubview:self.positionStyleLab];
    [self addSubview:self.demandTitleLab];
    [self addSubview:self.pasteBackV];
    [self.pasteBackV addSubview:self.pastetitleLab];
    [self.pasteBackV addSubview:self.connectNumber];
    [self.pasteBackV addSubview:self.pasteBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.addressnameTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.right.mas_equalTo(self.princeLab.mas_left);
        make.height.mas_equalTo(18);
    }];
    
    [self.princeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressnameTitleLab.mas_right);
        make.top.mas_equalTo(self.addressnameTitleLab);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(18);
    }];
    
//    [self.positionStyleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(self.addressnameTitleLab.mas_bottom).offset(15);
//        make.right.mas_equalTo(self).offset(-15);
//        make.height.mas_equalTo(12);
//    }];
//    [self.positionStyleLab.superview layoutIfNeeded];
    
    [self.demandTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.princeLab.mas_bottom).offset(15);
        make.right.mas_equalTo(70);
        make.height.mas_equalTo(14);
    }];
    [self.demandTitleLab.superview layoutIfNeeded];
    
    CGFloat w = 15;
    if (self.tagArr2.count > 0) {
        for (NSInteger i = 0; i < self.tagArr2.count; i++) {
            NSString *strW = self.tagArr2[i];
            CGFloat wid = strW.length * 14;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w, self.demandTitleLab.bottom + 10, wid, 12)];
            lab.backgroundColor = [UIColor whiteColor];
            lab.textColor = KColorGradient_light;
            lab.font = KFontNormalSize12;
            lab.text = self.tagArr2[i];
            lab.layer.borderColor = KColorGradient_light.CGColor;
            lab.layer.borderWidth = KLineWidthMeasure05;
            lab.textAlignment = NSTextAlignmentCenter;
            [self addSubview:lab];
            w = w + wid + 15;
        }
    }
    
    [self.pasteBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-5);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(50);
    }];
    
    [self.pastetitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(self.pasteBackV);
    }];
    
    [self.connectNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pastetitleLab.mas_right).offset(10);
        make.centerY.mas_equalTo(self.pasteBackV);
    }];
    
    [self.pasteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.pasteBackV.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.pasteBackV);
        make.height.mas_equalTo(30);
        if (self.showConnect == YES) {
            make.width.mas_equalTo(50);
        }else {
            make.width.mas_equalTo(120);
        }
    }];
}

- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        self.addressnameTitleLab.text = commonModel.positionname;
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:commonModel.positonmoney attributes:@{NSForegroundColorAttributeName:[ECUtil colorWithHexString:@"ff4457"], NSFontAttributeName:KFontNormalSize16}];
        NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:@"/天" attributes:@{NSForegroundColorAttributeName:[ECUtil colorWithHexString:@"ff4457"], NSFontAttributeName:KFontNormalSize12}];
        [attributedStr appendAttributedString:attributedStr1];
        self.princeLab.attributedText = attributedStr;
        
        //tag1
//        self.tagArr1 = [[NSMutableArray alloc] init];
//        if (![ECUtil isBlankString:commonModel.positionworkaddressname]) {
//            [self.tagArr1 addObject:commonModel.positionworkaddressname];
//        }
//        if (![ECUtil isBlankString:commonModel.positionpaytypename]) {
//            [self.tagArr1 addObject:commonModel.positionpaytypename];
//        }
//        if (![ECUtil isBlankString:commonModel.positionworktime]) {
//            [self.tagArr1 addObject:commonModel.positionworktime];
//        }
//
//        NSString *string1 = @"";
//        NSString *str1 = @"•";
//        for (NSString *str in self.tagArr1) {
//            if (![ECUtil isBlankString:str]) {
//                string1 = [string1 stringByAppendingString: [str stringByAppendingString:str1]];
//            }
//        }
//        string1 = [string1 substringToIndex:string1.length-1];
//        self.positionStyleLab.text = string1;
        
        //tag2
        self.tagArr2 = [[NSMutableArray alloc] init];
        if (![ECUtil isBlankString:commonModel.positontime]) {
            [self.tagArr2 addObject:commonModel.positontime];
        }
        if (![ECUtil isBlankString:commonModel.positionsexreq]) {
            [self.tagArr2 addObject:commonModel.positionsexreq];
        }
//        if (![ECUtil isBlankString:commonModel.positiontypename]) {
//            [self.tagArr2 addObject:commonModel.positiontypename];
//        }
        
        if (![ECUtil isBlankString:commonModel.positionpaytypename]) {
            [self.tagArr2 addObject:commonModel.positionpaytypename];
        }
        
    
        if (self.showConnect == YES) {
            self.connectNumber.text = commonModel.positiontelnum;
            [self.pasteBtn setTitle:@"复制" forState:UIControlStateNormal];
        }else {
            [self.pasteBtn setTitle:@"点击查看联系方式" forState:UIControlStateNormal];
        }
        
        self.pastetitleLab.text = commonModel.positionteltype;
    }
}

- (void)pasteBtnAction:(UIButton *)send {
    if (self.pasteAction) {
        self.pasteAction(self.connectNumber.text);
    }
}

- (UILabel *)addressnameTitleLab {
    if (!_addressnameTitleLab) {
        _addressnameTitleLab = [[UILabel alloc] init];
        _addressnameTitleLab.textColor = KColor_212121;
        _addressnameTitleLab.font = KFontNormalSize18;
        _addressnameTitleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _addressnameTitleLab;
}

- (UILabel *)princeLab {
    if (!_princeLab) {
        _princeLab = [[UILabel alloc] init];
        _princeLab.textAlignment = NSTextAlignmentRight;
    }
    return _princeLab;
}

- (UILabel *)positionStyleLab {
    if (!_positionStyleLab) {
        _positionStyleLab = [[UILabel alloc] init];
        _positionStyleLab.textColor = KColor_B1AFAF;
        _positionStyleLab.font = KFontNormalSize12;
    }
    return _positionStyleLab;
}

- (UILabel *)demandTitleLab {
    if (!_demandTitleLab) {
        _demandTitleLab = [[UILabel alloc] init];
        _demandTitleLab.textColor = KColor_212121;
        _demandTitleLab.font = KFontNormalSize16;
        _demandTitleLab.text = @"招聘需求";
    }
    return _demandTitleLab;
}

//- (NSMutableArray *)tagArr1 {
//    if (!_tagArr1) {
//        _tagArr1 = [[NSMutableArray alloc] init];
//    }
//    return _tagArr1;
//}
//
//- (NSMutableArray *)tagArr2 {
//    if (!_tagArr2) {
//        _tagArr2 = [[NSMutableArray alloc] init];
//    }
//    return _tagArr2;
//}

- (UIView *)pasteBackV {
    if (!_pasteBackV) {
        _pasteBackV = [[UIView alloc] init];
        _pasteBackV.backgroundColor = [ECUtil colorWithHexString:@"f5f5f5"];
        _pasteBackV.layer.cornerRadius = 25;
        _pasteBackV.layer.masksToBounds = YES;
    }
    return _pasteBackV;
}

- (UILabel *)pastetitleLab {
    if (!_pastetitleLab) {
        _pastetitleLab = [[UILabel alloc] init];
        _pastetitleLab.textColor = [ECUtil colorWithHexString:@"676767"];
        _pastetitleLab.font = KFontNormalSize16;
    }
    return _pastetitleLab;
}

- (UILabel *)connectNumber {
    if (!_connectNumber) {
        _connectNumber = [[UILabel alloc] init];
        _connectNumber.font = KFontNormalSize16;
        _connectNumber.textAlignment = NSTextAlignmentLeft;
    }
    return _connectNumber;
}

- (UIButton *)pasteBtn {
    if (!_pasteBtn) {
        _pasteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_pasteBtn setTitle:@"复制" forState:UIControlStateNormal];
        _pasteBtn.backgroundColor = [ECUtil colorWithHexString:@"ff4457"];
        _pasteBtn.titleLabel.font = KFontNormalSize14;
        _pasteBtn.layer.cornerRadius = 15;
        _pasteBtn.layer.masksToBounds = YES;
        [_pasteBtn addTarget:self action:@selector(pasteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pasteBtn;
}

- (void)setShowConnect:(BOOL)showConnect {
    _showConnect = showConnect;
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
