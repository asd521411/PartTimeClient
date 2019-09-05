//
// Created by 何 义 on 14-2-28.
// Copyright (c) 2014 eall. All rights reserved.
//


#import <Foundation/Foundation.h>

extern CGFloat const ECLineSpace;
extern CGFloat const ECParagraphSpace;
extern CGFloat const ECBorderSpace;
extern CGFloat const ECContentPageSpace;
extern CGFloat const ECViewSpace;
extern CGFloat const ECNavigationbarHeight;

extern CGFloat const ECViewBackgroundAlpha;

extern NSInteger const ECTextViewMaxInput;

extern NSInteger const ECLineTag;

@interface ECStyle : NSObject

// 获取设备的宽和高
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (CGFloat)statusbarHeight;
+ (CGFloat)navigationbarHeight;
+ (CGFloat)toolbarHeight;
+ (CGFloat)tabbarExtensionHeight;

+ (CGFloat)activityIndicatorSize;
+ (CGFloat)loadingOffsetYInListView;
+ (CGFloat)emptyOffsetYInListView;
+ (CGFloat)failOffsetYInListView;
+ (CGFloat)separatorLineHeight;
+ (CGFloat)separatorLeftMargin;
+ (CGFloat)buttonCornerRadius;
+ (CGFloat)buttonBorderWidth;
+ (CGFloat)viewPagerCursorHeight;
+ (CGFloat)viewPagerHeight;
+ (CGRect)fullScrTableFrame:(BOOL)inTab;
+ (CGRect)viewPagerFrame;
+ (CGRect)viewReminderFrame;

//主色调
+ (UIColor *)redThemeColor;
+ (UIColor *)greenThemeColor;

//字体颜色
+ (UIColor *)blackTextColor;//内容字体颜色
+ (UIColor *)darkGrayTextColor;//深灰色字体颜色
+ (UIColor *)grayTextColor;//灰色字体颜色
+ (UIColor *)lightGrayTextColor;//浅灰色字体颜色
+ (UIColor *)whiteTextColor;

//分割线颜色
+ (UIColor *)grayLineColor;
+ (UIColor *)darkGrayLineColor;//带模糊背景的分割线颜色

//背景颜色
+ (UIColor *)backGroundColor;
+ (UIColor *)lightBackGroundColor;//浅色背景

//颜色
///0x266835
+ (UIColor *)color1;
/**
 0x333333
 */
+ (UIColor *)color2;
/**
 0x666666
 */
+ (UIColor *)color3;

/**
 0x999999
 */
+ (UIColor *)color4;

//字体
+ (UIFont *)normalFont;
+ (UIFont *)smallerFont;
+ (UIFont *)largerFont;
+ (UIFont *)larger2Font;
+ (UIFont *)largerBoldFont;
+ (UIFont *)larger2BoldFont;

//字体高度
+ (CGFloat)normalFontHeight;
+ (CGFloat)largeFontHeight;
+ (CGFloat)large2FontHeight;
+ (CGFloat)smallFontHeight;
+ (CGFloat)largeBoldFontHeight;
+ (CGFloat)large2BoldFontHeight;

@end
