//
//  MyNewResumeTableViewCell.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/21.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "MyNewResumeTableViewCell.h"

@interface MyNewResumeTableViewCell ()

@property (nonatomic, strong) UIImageView *tagImgV;
//@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *rightImgV;

@end


@implementation MyNewResumeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.titleLab];
    [self addSubview:self.tagImgV];
    [self addSubview:self.showLab];
    [self addSubview:self.rightImgV];
    [self addSubview:self.selectBtn1];
    [self addSubview:self.selectBtn2];
}

- (void)setMustSelect:(BOOL)mustSelect {
    self.tagImgV.hidden = !mustSelect;
}

- (void)selectBtn1Action:(UIButton *)sender {
    self.selectBtn1.selected = !self.selectBtn2.selected;
}

- (void)selectBtn2Action:(UIButton *)sender {
    self.selectBtn2.selected = !self.selectBtn1.selected;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(100);
    }];
    
    [self.tagImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.titleLab.mas_left);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(5);
    }];
    
    [self.showLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
    }];

    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(16);
    }];
    
    [self.selectBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.selectBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.selectBtn1.mas_left);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [ECUtil colorWithHexString:@"e5e5e4"];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(KSCREEN_WIDTH-30);
        make.bottom.mas_equalTo(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = kFontNormalSize(16);
        _titleLab.textColor = [ECUtil colorWithHexString:@"2f2f2f"];
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UIImageView *)tagImgV {
    if (_tagImgV == nil) {
        _tagImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"biaoji"]];
    }
    return _tagImgV;
}

- (UILabel *)showLab {
    if (_showLab == nil) {
        _showLab = [[UILabel alloc] init];
        _showLab.font = kFontNormalSize(14);
        _showLab.textAlignment = NSTextAlignmentLeft;
        _showLab.textColor = [ECUtil colorWithHexString:@"2f2f2f"];
    }
    return _showLab;
}

- (UIImageView *)rightImgV {
    if (_rightImgV == nil) {
        _rightImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightjiantou"]];
    }
    return _rightImgV;
}

- (UIButton *)selectBtn1 {
    if (_selectBtn1 == nil) {
        _selectBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn1 setBackgroundImage:[UIImage imageNamed:@"tagnormalimg"] forState:UIControlStateNormal];
        [_selectBtn1 setBackgroundImage:[UIImage imageNamed:@"tagselectimg"] forState:UIControlStateSelected];
        [_selectBtn1 addTarget:self action:@selector(selectBtn1Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn1;
}

- (UIButton *)selectBtn2 {
    if (_selectBtn2 == nil) {
        _selectBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn2 setBackgroundImage:[UIImage imageNamed:@"tagnormalimg"] forState:UIControlStateNormal];
        [_selectBtn2 setBackgroundImage:[UIImage imageNamed:@"tagselectimg"] forState:UIControlStateSelected];
        [_selectBtn2 addTarget:self action:@selector(selectBtn2Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn2;
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
