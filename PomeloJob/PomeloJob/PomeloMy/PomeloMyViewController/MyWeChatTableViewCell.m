//
//  MyWeChatTableViewCell.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/22.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "MyWeChatTableViewCell.h"

@interface MyWeChatTableViewCell ()

@property (nonatomic, strong) UIImageView *wechatImgV;
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation MyWeChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.wechatImgV];
    [self addSubview:self.titleLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.wechatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(40);
        make.centerX.mas_equalTo(self);
        make.width.height.mas_equalTo(88);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.wechatImgV.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
    }];
}

- (UIImageView *)wechatImgV {
    if (_wechatImgV == nil) {
        _wechatImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechatimg"]];
        _wechatImgV.backgroundColor = [HWRandomColor randomColor];
    }
    return _wechatImgV;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"商务洽谈请微信扫码";
        _titleLab.font = kFontNormalSize(12);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
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
