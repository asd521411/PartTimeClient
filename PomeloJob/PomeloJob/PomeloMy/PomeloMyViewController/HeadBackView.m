//
//  HeadBackView.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "HeadBackView.h"
#import "ModificationControl.h"

@interface HeadBackView ()

@property (nonatomic, strong) UIImageView *backImgV;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIImageView *portraitImgV;
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
        make.bottom.mas_equalTo(-30);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo((KSCREEN_WIDTH-120)/2);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    [self.portraitImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(self).offset(20);
        make.width.height.mas_equalTo(80);
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
                NSDictionary *info = [NSUserDefaultMemory defaultGetwithUnityKey:USERINFO];
                NSLog(@"ssssss=======%@-----%@", info);
                //self.modificationControl.nameStr = info.name;
                //self.portraitImgV 
            }break;
            case InforTypeShow:{
                self.modificationControl.hidden = YES;
                self.loginBtn.hidden = YES;
                self.portraitImgV.hidden = NO;
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

- (UIImageView *)portraitImgV {
    if (_portraitImgV == nil) {
        _portraitImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"portraitImgV"]];
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
