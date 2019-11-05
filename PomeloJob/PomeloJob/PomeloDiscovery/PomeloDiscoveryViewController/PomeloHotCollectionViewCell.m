//
//  PomeloHotCollectionViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloHotCollectionViewCell.h"
#import "UIView+HWUtilView.h"

@interface PomeloHotCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *workAddressLab;
@property (nonatomic, strong) UILabel *princeLab;

@property (nonatomic, strong) UIImageView *backImgV;
@property (nonatomic, strong) UIView *tagBackV;
@property (nonatomic, strong) NSMutableArray *tagArr2;

@end


@implementation PomeloHotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ECUtil colorWithHexString:@"f5f5f5"];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.backImgV];
    //[self.backImgV addSubview:self.tagBackV];
    [self.backImgV addSubview:self.titleLab];
    [self.backImgV addSubview:self.workAddressLab];
    [self.backImgV addSubview:self.princeLab];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.tagBackV removeFromSuperview];
    self.tagBackV = nil;
    self.tagBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 15, self.backImgV.width, 15)];
    [self.backImgV addSubview:self.tagBackV];
    
    CGFloat w = 15;
    if (self.tagArr2.count > 0) {
        for (NSInteger i = 0; i < self.tagArr2.count; i++) {
            NSString *strW = self.tagArr2[i];
            CGFloat wid = strW.length * 11;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(w, 0, wid, 14)];
            lab.backgroundColor = [UIColor whiteColor];
            lab.textColor = [ECUtil colorWithHexString:@"ce67eb"];
            lab.font = KFontNormalSize10;
            lab.text = self.tagArr2[i];
            lab.layer.borderColor = [ECUtil colorWithHexString:@"ce67eb"].CGColor;
            lab.layer.borderWidth = KLineWidthMeasure05;
            lab.textAlignment = NSTextAlignmentCenter;
            [self.tagBackV addSubview:lab];
            w = w + wid + 15;
        }
    }
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(40);
        make.right.mas_equalTo(-15);
    }];
    
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
        
        self.princeLab.attributedText = [ECUtil mutableArrtibuteString:commonModel.positonmoney foregroundColor:[ECUtil colorWithHexString:@"ff4457"] fontName:KFontNormalSize12 attribut:@"元/天" foregroundColor:[ECUtil colorWithHexString:@"ff4457"] fontName:KFontNormalSize12];
        
    }
}

- (UIImageView *)backImgV {
    if (!_backImgV) {
        _backImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yinyingbeijing"]];
        _backImgV.backgroundColor = [ECUtil colorWithHexString:@"f5f5f5"];
//        _backImgV.layer.cornerRadius = 2;
//        _backImgV.layer.masksToBounds = YES;
    }
    return _backImgV;
}

- (UILabel *)princeLab {
    if (!_princeLab) {
        _princeLab = [[UILabel alloc] init];
        _princeLab.font = KFontNormalSize14;
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
        _titleLab.font = KFontNormalSize14;
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

//- (UIView *)tagBackV {
//    if (!_tagBackV) {
//        _tagBackV = [[UIView alloc] init];
//        _tagBackV.backgroundColor = [HWRandomColor randomColor];
//    }
//    return _tagBackV;
//}

@end
