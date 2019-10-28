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
        //self.backgroundColor = [HWRandomColor randomColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        self.payLab = [[UILabel alloc] init];
//        self.payLab.font = KFontNormalSize14;
//        self.payLab.numberOfLines = 0;
//        //[self addSubview:self.payLab];
        
        self.workContentLab = [[UITextView alloc] init];
        self.workContentLab.scrollEnabled = NO;
        self.workContentLab.textColor = [ECUtil colorWithHexString:@"7a7a7a"];
        [self addSubview:self.workContentLab];
        
        self.workContentBackV = [[UIView alloc] init];
        self.workContentBackV.backgroundColor = [ECUtil colorWithHexString:@"f8f8f8"];
        self.workContentBackV.layer.cornerRadius = 3;
        self.workContentBackV.layer.masksToBounds = YES;
        [self addSubview:self.workContentBackV];
        
        self.workRequireLab = [[UILabel alloc] init];
        self.workRequireLab.font = KFontNormalSize16;
        self.workRequireLab.numberOfLines = 0;
        self.workRequireLab.textColor = kColor_Main;
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
        make.height.mas_equalTo(self.height);
    }];
    
//    self.rtLab.text = self.conStr;
//    CGSize size = [self.rtLab optimumSize];
    
//    [self.rtLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(15);
//        make.right.mas_equalTo(self).offset(-15);
//        make.height.mas_equalTo(size.height + 30);
//    }];
    
    
    [self.workContentBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        //make.top.mas_equalTo(self.workContentLab.mas_bottom);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(self);
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
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[commonModel.positioninfo dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        self.workContentLab.attributedText = attributedString;
        
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
        
//        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        self.workContentLab.attributedText = [self setAttributedString:contentStr font:nil lineSpacing:5];
    }
}

- (NSMutableArray *)stringHeight {
    if (!_stringHeight) {
        _stringHeight = [[NSMutableArray alloc] init];
    }
    return _stringHeight;
}

/**
 html 富文本设置

 @param str html 未处理的字符串
 @param font 设置字体
 @param lineSpacing 设置行高
 @return 默认不将 \n替换<br/> 返回处理好的富文本
 */
-(NSMutableAttributedString *)setAttributedString:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    //如果有换行，把\n替换成<br/>
    //如果有需要把换行加上
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    //设置HTML图片的宽度
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //设置富文本字的大小
//    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [htmlString length])];
    
    return htmlString;

}



/**
 计算html字符串高度

 @param str html 未处理的字符串
 @param font 字体设置
 @param lineSpacing 行高设置
 @param width 容器宽度设置
 @return 富文本高度
 */
+(CGFloat )getHTMLHeightByStr:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width
{
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
//    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [htmlString length])];
    
    CGSize contextSize = [htmlString boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return contextSize.height ;
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
