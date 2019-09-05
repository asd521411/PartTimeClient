//
//  LocationTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "LocationTableViewCell.h"

@implementation LocationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.textColor = [ECUtil colorWithHexString:@"333333"];
        self.titleLab.font = [UIFont systemFontOfSize:14];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLab.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
    
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
