//
//  SavePhotoToAlbum.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/26.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "SavePhotoToAlbum.h"

@interface SavePhotoToAlbum ()

@property (nonatomic, strong) UIView *backV;
@property (nonatomic, strong) UIImageView *saveImgV;
@property (nonatomic, strong) UILabel *remindLab;

@end


@implementation SavePhotoToAlbum

+ (void)savePhotoToAlbum:(UIImage *)img {
    
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupSubViews];
//    }
//    return self;
//}

- (void)setupSubViews {
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    [win addSubview:self.backV];
    [self.backV addSubview:self.saveImgV];
}

- (void)backTapAction:(UIGestureRecognizer *)tap {
    self.backV.hidden = YES;
}

- (void)longPressAction:(UIGestureRecognizer *)press {
    if (press.state == UIGestureRecognizerStateBegan) {
        NSData *imageData = UIImageJPEGRepresentation(self.saveImgV.image, 0.1);
        UIImage *newImage = [UIImage imageWithData:imageData];
        UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [SVProgressHUD showWithStatus:@"保存成功！"];
    [SVProgressHUD dismissWithDelay:1];
}

- (UIView *)backV {
    if (_backV == nil) {
        _backV = [[UIView alloc] init];
        _backV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapAction:)];
        [_backV addGestureRecognizer:tap];
        
    }
    return _backV;
}

- (UIImageView *)saveImgV {
    if (_saveImgV == nil) {
        _saveImgV = [[UIImageView alloc] init];
        UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_saveImgV addGestureRecognizer:press];
        
    }
    return _saveImgV;
}

- (UILabel *)remindLab {
    if (_remindLab == nil) {
        _remindLab = [[UILabel alloc] init];
        _remindLab.text = @"长按保存图片";
        _remindLab.textAlignment = NSTextAlignmentLeft;
        _remindLab.font = kFontNormalSize(14);
    }
    return _remindLab;
}

@end
