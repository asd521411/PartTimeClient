//
//  SavePhotoToAlbum.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/26.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapHiddenBack)(void);

//typedef void(^<#name#>)(<#arguments#>);

@interface SavePhotoToAlbum : UIView

@property (nonatomic, copy) TapHiddenBack tapHiddenBack;

@end

NS_ASSUME_NONNULL_END
