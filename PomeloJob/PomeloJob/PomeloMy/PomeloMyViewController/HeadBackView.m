//
//  HeadBackView.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "HeadBackView.h"
#import "ModificationControl.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface HeadBackView ()

@property (nonatomic, strong) UIImageView *backImgV;
@property (nonatomic, strong) UIButton *loginBtn;

//@property (nonatomic, strong) UILabel *<#mark#>;
@property (nonatomic, strong) ModificationControl *modificationControl;

@end

@implementation HeadBackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.backImgV];
    [self addSubview:self.loginBtn];
    [self addSubview:self.portraitImgV];
    [self addSubview:self.modificationControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo((KSCREEN_WIDTH-120)/2);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    [self.modificationControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(115);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(150);
        make.bottom.mas_equalTo(self.portraitImgV.mas_bottom);
    }];
}

#pragma mark action

- (void)loginBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(gotoLogin)]) {
        [self.delegate gotoLogin];
    }
}

- (void)modificationControlAction {
    if ([self.delegate respondsToSelector:@selector(changeInfoMessage)]) {
        [self.delegate changeInfoMessage];
    }
}

- (void)portraitImgV:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(sdportraitImgV)]) {
        [self.delegate sdportraitImgV];
    }
}

- (void)setInfoType:(InforType)infoType {
//    if (_infoType != infoType) {
        switch (infoType) {
            case InforTypeOff_Line:{
                self.modificationControl.hidden = YES;
                self.loginBtn.hidden = NO;
                self.portraitImgV.hidden = YES;
            }break;
            case InforTypeOn_Line:{
                self.portraitImgV.hidden = NO;
                self.modificationControl.hidden = NO;
                self.loginBtn.hidden = YES;
                NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO];
                self.modificationControl.nameStr = dic[@"name"];
                [self.portraitImgV sd_setBackgroundImageWithURL:[NSURL URLWithString:dic[@"userimg"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"portraitImgV"]];
                [self.portraitImgV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(20);
                    make.left.mas_equalTo(self).offset(20);
                    make.width.height.mas_equalTo(80);
                }];
            }break;
            case InforTypeShow:{
                self.modificationControl.hidden = YES;
                self.loginBtn.hidden = YES;
                self.portraitImgV.hidden = NO;
                [self.portraitImgV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(20);
                    make.centerX.mas_equalTo(self);
                    make.width.height.mas_equalTo(80);
                }];
            }break;
            default:
                break;
        }
    //}
}

#pragma mark getter

- (UIImageView *)backImgV {
    if (_backImgV == nil) {
        _backImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mybackImgV"]];
        _backImgV.userInteractionEnabled = YES;
    }
    return _backImgV;
}

- (UIButton *)portraitImgV {
    if (_portraitImgV == nil) {
        _portraitImgV = [UIButton buttonWithType:UIButtonTypeCustom];
        [_portraitImgV setBackgroundImage:[UIImage imageNamed:@"portraitImgV"] forState:UIControlStateNormal];
        [_portraitImgV addTarget:self action:@selector(portraitImgV:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _portraitImgV;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginimg"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (ModificationControl *)modificationControl {
    if (_modificationControl == nil) {
        _modificationControl = [[ModificationControl alloc] init];
        _modificationControl.nameStr = @"昵称";
        [_modificationControl addTarget:self action:@selector(modificationControlAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modificationControl;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
