//
//  ResumeTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/17.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "ResumeTableViewCell.h"

#define leftSpace 50

@interface ResumeTableViewCell ()

@property (nonatomic, strong) NSMutableArray *stringHeight;


@end

@implementation ResumeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.payLab = [[UILabel alloc] init];
        self.payLab.font = KFontNormalSize14;
        self.payLab.numberOfLines = 0;
        [self addSubview:self.payLab];
        
        self.workContentLab = [[UILabel alloc] init];
        self.workContentLab.font = KFontNormalSize14;
        self.workContentLab.numberOfLines = 0;
        [self addSubview:self.workContentLab];
        
        self.workTimeLab = [[UILabel alloc] init];
        self.workTimeLab.font = KFontNormalSize14;
        self.workTimeLab.numberOfLines = 0;
        [self addSubview:self.workTimeLab];
        
        self.workRequireLab = [[UILabel alloc] init];
        self.workRequireLab.font = KFontNormalSize14;
        self.workRequireLab.numberOfLines = 0;
        [self addSubview:self.workRequireLab];
        
        self.otherWelfareLab = [[UILabel alloc] init];
        self.otherWelfareLab.font = KFontNormalSize14;
        self.otherWelfareLab.numberOfLines = 0;
        [self addSubview:self.otherWelfareLab];
        
        // MARK: left
        
        self.payTitleLab = [[UILabel alloc] init];
        //self.payTitleLab.backgroundColor = [HWRandomColor randomColor];
        self.payTitleLab.font = KFontNormalSize14;
        self.payTitleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.payTitleLab];
        
        self.workContentTitleLab = [[UILabel alloc] init];
        //self.workContentTitleLab.backgroundColor = [HWRandomColor randomColor];
        self.workContentTitleLab.font = KFontNormalSize14;
        self.workContentTitleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.workContentTitleLab];
        
        self.workTimeTitleLab = [[UILabel alloc] init];
        //self.workTimeTitleLab.backgroundColor = [HWRandomColor randomColor];
        self.workTimeTitleLab.font = KFontNormalSize14;
        self.workTimeTitleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.workTimeTitleLab];
        
        self.workTimeTitleLab = [[UILabel alloc] init];
        //self.workTimeTitleLab.backgroundColor = [HWRandomColor randomColor];
        self.workTimeTitleLab.font = KFontNormalSize14;
        self.workTimeTitleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.workTimeTitleLab];
        
        self.workRequireTitleLab = [[UILabel alloc] init];
        //self.workRequireTitleLab.backgroundColor = [HWRandomColor randomColor];
        self.workRequireTitleLab.font = KFontNormalSize14;
        self.workRequireTitleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.workRequireTitleLab];
        
        self.otherWelfareTitleLab = [[UILabel alloc] init];
        //self.otherWelfareTitleLab.backgroundColor = [HWRandomColor randomColor];
        self.otherWelfareTitleLab.font = KFontNormalSize14;
        self.otherWelfareTitleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.otherWelfareTitleLab];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.payLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(10);
    }];
    
    [self.payTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.payLab.mas_left).offset(-10);
        make.top.mas_equalTo(self.payLab);
        make.width.mas_equalTo(75);
    }];
    
    
//    NSNumber *num = self.stringHeight[0];
//
//    CGSize size = [ECUtil textSize:self.workContentLab.text font:KFontNormalSize10 bounding:CGSizeMake(KSCREEN_WIDTH - KSpaceDistance15 * 2, CGFLOAT_MAX)];
    
    [self.workContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(self.payLab.mas_bottom).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(10);
    }];
    [self.workContentTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.workContentLab.mas_left).offset(-10);
        make.top.mas_equalTo(self.workContentLab);
        make.width.mas_equalTo(75);
    }];
    
    
    [self.workTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(self.workContentLab.mas_bottom).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(10);
    }];
    [self.workTimeTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.workTimeLab.mas_left).offset(-10);
        make.top.mas_equalTo(self.workTimeLab);
        make.width.mas_equalTo(75);
    }];

    
    [self.workRequireLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(self.workTimeLab.mas_bottom).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(10);
    }];
    [self.workRequireTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.workRequireLab.mas_left).offset(-10);
        make.top.mas_equalTo(self.workRequireLab);
        make.width.mas_equalTo(75);
    }];

    
    [self.otherWelfareLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(self.workRequireLab.mas_bottom).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(10);
    }];
    [self.otherWelfareTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.otherWelfareLab.mas_left).offset(-10);
        make.top.mas_equalTo(self.otherWelfareLab);
        make.width.mas_equalTo(75);
    }];

}

//- (void)setResumeModel:(ResumeModel *)resumeModel {
//    if (_resumeModel != resumeModel) {
//        self.payLab.text = commonModel.positionname;
//        self.workContentLab.text = commonModel.positioninfo;
//        self.workTimeLab.text = commonModel.positionworktime;
//        self.workRequireLab.text = commonModel.positionworkaddressinfo;
//        self.otherWelfareLab.text = commonDetailsModel.otherWelfare;
//        
//        [self.stringHeight addObject:[NSNumber numberWithFloat:commonModel.cellHeight]];
//        
//        self.payTitleLab.text = commonDetailsModel.payLeft;
//        self.workContentTitleLab.text = commonDetailsModel.workContentLeft;
//        self.workTimeTitleLab.text = commonDetailsModel.workTimeLeft;
//        self.workRequireTitleLab.text = commonDetailsModel.workRequireLeft;
//        self.otherWelfareTitleLab.text = commonDetailsModel.otherWelfareLeft
//    }
//}



- (NSMutableArray *)stringHeight {
    if (!_stringHeight) {
        _stringHeight = [[NSMutableArray alloc] init];
    }
    return _stringHeight;
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
