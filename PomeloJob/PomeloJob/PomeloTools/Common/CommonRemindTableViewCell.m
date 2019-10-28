//
//  CommonRemindTableViewCell.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/25.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonRemindTableViewCell.h"

@interface CommonRemindTableViewCell ()


@end

@implementation CommonRemindTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = [HWRandomColor randomColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.workContentBackV = [[UIView alloc] init];
        self.workContentBackV.backgroundColor = [ECUtil colorWithHexString:@"f8f8f8"];
        self.workContentBackV.layer.cornerRadius = 3;
        self.workContentBackV.layer.masksToBounds = YES;
        [self addSubview:self.workContentBackV];
        
        self.workRequireLab = [[UILabel alloc] init];
        self.workRequireLab.font = KFontNormalSize14;
        self.workRequireLab.numberOfLines = 0;
        self.workRequireLab.textColor = kColor_Main;
        self.workRequireLab.text = @"凡是涉及到工作内容不符、收费、违法信息传播的工作，请您警惕并收集相关证据向我们举报";
        self.workRequireLab.textAlignment = NSTextAlignmentLeft;
        [self.workContentBackV addSubview:self.workRequireLab];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.workContentBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(self);
    }];
    
    [self.workRequireLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(self.workContentBackV).offset(10);
        make.right.mas_equalTo(self.workContentBackV).offset(-30);
        make.bottom.mas_equalTo(self.workContentBackV).offset(-10);
    }];
    
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
