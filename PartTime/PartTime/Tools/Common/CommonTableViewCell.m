//
//  CommonTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.tagImgV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.tagImgV];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.textColor = DARKGRAYCOLOR;
        self.titleLab.font = LARGEFont;
        [self.contentView addSubview:self.titleLab];
        
        self.locationLab = [[UILabel alloc] init];
        self.locationLab.textColor = DARKGRAYCOLOR;
        self.locationLab.font = NORMALFont;
        [self.contentView addSubview:self.locationLab];
        
        self.accountStyleLab = [[UILabel alloc] init];
        self.accountStyleLab.textColor = DARKGRAYCOLOR;
        self.accountStyleLab.font = NORMALFont;
        [self.contentView addSubview:self.accountStyleLab];
        
        self.princeLab = [[UILabel alloc] init];
        self.princeLab.textColor = DARKGRAYCOLOR;
        self.princeLab.font = LARGEFont;
        [self.contentView addSubview:self.princeLab];
        
        self.tagLab = [[UILabel alloc] init];
        self.tagLab.textColor = DARKGRAYCOLOR;
        self.tagLab.font = SMALLFont;
        [self.contentView addSubview:self.tagLab];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tagImgV.frame = CGRectMake(20, 0, 40, 40);
    self.titleLab.frame = CGRectMake(self.tagImgV.right + 10, 0, self.width / 2, 20);
    self.locationLab.frame = CGRectMake(self.tagImgV.right + 10, self.titleLab.bottom + 10, 32, 15);
    self.accountStyleLab.frame = CGRectMake(self.locationLab.right, self.titleLab.bottom + 10, 32, 15);
    self.princeLab.frame = CGRectMake(self.contentView.right - 100, self.contentView.height / 2 - 10, 100, 20);
    self.tagLab.frame = CGRectMake(self.tagImgV.right + 10, self.locationLab.bottom + 10, 40, 30);
    
}

//- (void)setCommonModel:(CommonModel *)commonModel {
//    //[self.tagImgV sd_setImageWithURL:[NSURL URLWithString:commonModel.tagImgVStr] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageAllowInvalidSSLCertificates];
//    
//    
//}












- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
