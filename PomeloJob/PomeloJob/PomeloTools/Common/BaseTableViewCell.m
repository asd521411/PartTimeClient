//
//  BaseTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@property (nonatomic, strong) UILabel *backTitle;

@end



@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backTitle = [[UILabel alloc] init];
        self.backTitle.font = KFontNormalSize18;
        self.backTitle.textAlignment = NSTextAlignmentCenter;
        self.backTitle.text = @"无数据";
        [self addSubview:self.backTitle];
    }
    return self;
}

//- (void)setupSubViews {
//
//    [self addSubview:self.backTitle];
//}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.backTitle.frame = CGRectMake(0, 0, self.width, self.height);
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
