//
//  CommonDetailsTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/9.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "CommonDetailsTableViewCell.h"
#import "RTLabel.h"

#define leftSpace 50

@interface CommonDetailsTableViewCell ()

@property (nonatomic, strong) NSMutableArray *stringHeight;
@property (nonatomic, assign) CGFloat hei;

@property (nonatomic, copy) NSString *conStr;
@property (nonatomic, strong) RTLabel *rtLab;

@end


@implementation CommonDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        self.payLab = [[UILabel alloc] init];
//        self.payLab.font = KFontNormalSize14;
//        self.payLab.numberOfLines = 0;
//        //[self addSubview:self.payLab];
        
        self.workContentLab = [[UILabel alloc] init];
        self.workContentLab.font = KFontNormalSize14;
        self.workContentLab.numberOfLines = 0;
        self.workContentLab.textColor = [ECUtil colorWithHexString:@"7a7a7a"];
        [self addSubview:self.workContentLab];
//
//        self.rtLab = [[RTLabel alloc] init];
//        [self addSubview:self.rtLab];
        
        self.workContentBackV = [[UIView alloc] init];
        self.workContentBackV.backgroundColor = [ECUtil colorWithHexString:@"f8f8f8"];
        self.workContentBackV.layer.cornerRadius = 3;
        self.workContentBackV.layer.masksToBounds = YES;
        [self addSubview:self.workContentBackV];
        
        self.workRequireLab = [[UILabel alloc] init];
        self.workRequireLab.font = KFontNormalSize12;
        self.workRequireLab.numberOfLines = 0;
        self.workRequireLab.textColor = [ECUtil colorWithHexString:@"ff4457"];
        self.workRequireLab.text = @"凡是涉及到工作内容不符、收费、违法信息传播的工作，请您警惕并收集相关证据向我们举报";
        self.workContentLab.textAlignment = NSTextAlignmentLeft;
        [self.workContentBackV addSubview:self.workRequireLab];
        
//        self.otherWelfareLab = [[UILabel alloc] init];
//        self.otherWelfareLab.font = KFontNormalSize14;
//        self.otherWelfareLab.numberOfLines = 0;
//        [self addSubview:self.otherWelfareLab];
        
        // MARK: left
        
//        self.payTitleLab = [[UILabel alloc] init];
//        self.payTitleLab.backgroundColor = [HWRandomColor randomColor];
//        self.payTitleLab.font = KFontNormalSize10;
//        self.payTitleLab.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.payTitleLab];
//
//        self.workContentTitleLab = [[UILabel alloc] init];
//        self.workContentTitleLab.backgroundColor = [HWRandomColor randomColor];
//        self.workContentTitleLab.font = KFontNormalSize10;
//        self.workContentTitleLab.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.workContentTitleLab];
//
//        self.workTimeTitleLab = [[UILabel alloc] init];
//        self.workTimeTitleLab.backgroundColor = [HWRandomColor randomColor];
//        self.workTimeTitleLab.font = KFontNormalSize10;
//        self.workTimeTitleLab.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.workTimeTitleLab];
//
//        self.workTimeTitleLab = [[UILabel alloc] init];
//        self.workTimeTitleLab.backgroundColor = [HWRandomColor randomColor];
//        self.workTimeTitleLab.font = KFontNormalSize12;
//        self.workTimeTitleLab.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.workTimeTitleLab];
//
//        self.otherWelfareTitleLab = [[UILabel alloc] init];
//        self.otherWelfareTitleLab.backgroundColor = [HWRandomColor randomColor];
//        self.otherWelfareTitleLab.font = KFontNormalSize10;
//        self.otherWelfareTitleLab.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.otherWelfareTitleLab];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    [self.payLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(15);
//        make.right.mas_equalTo(self).offset(-15);
//        make.height.mas_equalTo(self.stringHeight[0]);
//    }];
//    [self.payTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.payLab.mas_left).offset(-10);
//        make.top.mas_equalTo(self.payLab);
//        make.width.mas_equalTo(50);
//    }];
    
    //
//    NSNumber *num = self.stringHeight[0];
    
    [self.workContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(self.hei);
    }];
    
//    self.rtLab.text = self.conStr;
//    CGSize size = [self.rtLab optimumSize];
    
//    [self.rtLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(15);
//        make.right.mas_equalTo(self).offset(-15);
//        make.height.mas_equalTo(size.height + 30);
//    }];
    
    
    [self.workContentBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.workContentLab.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
//    [self.workContentTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.workContentLab.mas_left).offset(-10);
//        make.top.mas_equalTo(self.workContentLab);
//        make.width.mas_equalTo(50);
//    }];
    
    //
//    [self.workTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(self.workContentLab.mas_bottom).offset(15);
//        make.right.mas_equalTo(self).offset(-15);
//        make.height.mas_equalTo(self.stringHeight[2]);
//    }];
//    [self.workTimeTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.workTimeTitleLab.mas_left).offset(-10);
//        make.top.mas_equalTo(self.workTimeLab);
//        make.width.mas_equalTo(50);
//    }];
    
    [self.workRequireLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(self.workContentBackV).offset(10);
        make.right.mas_equalTo(self.workContentBackV).offset(-50);
        make.bottom.mas_equalTo(self.workContentBackV).offset(-10);
    }];
//    [self.workRequireTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.workRequireLab.mas_left).offset(-10);
//        make.top.mas_equalTo(self.workRequireLab);
//        make.width.mas_equalTo(50);
//    }];
    
    //
//    [self.otherWelfareLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(self.workRequireLab.mas_bottom).offset(15);
//        make.right.mas_equalTo(self).offset(-15);
//        make.height.mas_equalTo(self.stringHeight[4]);
//    }];
//    [self.otherWelfareTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.otherWelfareLab.mas_left).offset(-10);
//        make.top.mas_equalTo(self.otherWelfareLab);
//        make.width.mas_equalTo(50);
//    }];
    
}

- (void)setCommonModel:(CommonModel *)commonModel {
    if (_commonModel != commonModel) {
        
//        self.payLab.text = commonModel.positionname;
        //self.workContentLab.text = commonModel.positioninfo;
        
//        self.workTimeLab.text = commonModel.positionworktime;
//        self.workRequireLab.text = commonModel.positionworkaddressinfo;
//        self.otherWelfareLab.text = commonDetailsModel.otherWelfare;

//        [self.stringHeight addObject:[NSNumber numberWithFloat:commonModel.cellHeight]];
        
//        self.payTitleLab.text = commonDetailsModel.payLeft;
//        self.workContentTitleLab.text = commonDetailsModel.workContentLeft;
//        self.workTimeTitleLab.text = commonDetailsModel.workTimeLeft;
//        self.workRequireTitleLab.text = commonDetailsModel.workRequireLeft;
//        self.otherWelfareTitleLab.text = commonDetailsModel.otherWelfareLeft;
    }
}

- (void)setContentStr:(NSString *)contentStr {
    if (_contentStr != contentStr) {
        _contentStr = contentStr;
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(self.width - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        //CGSize size = [ECUtil textSize:attributedString.string font:KFontNormalSize14 bounding:CGSizeMake(KSCREEN_WIDTH - 30, CGFLOAT_MAX)];
        self.hei = rect.size.height;
    }
}

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
