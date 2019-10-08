//
//  TitleSelectItemControl.h
//  AvengerAgent
//
//  Created by 草帽~小子 on 2018/9/25.
//  Copyright © 2018年 meiliwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleSelectItemControl : UIControl

@property (nonatomic, copy) NSString *title;
@property (nonatomic) BOOL showSpliter;
@property (nonatomic) BOOL titleLeft;
@property (nonatomic) BOOL titleHighlight;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName selectImage:(NSString *)selectImage;

@end
