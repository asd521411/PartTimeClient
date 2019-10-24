//
//  AppControl.m
//  chow
//
//  Created by wangyuliang on 14-9-19.
//  Copyright (c) 2014年 eallcn. All rights reserved.
//

#import "ECUtil.h"
//#import "EBAlert.h"
#import "ECStyle.h"
//#import "UIImage+Alpha.h"
//#import "NSDate-Utilities.h"
//#import "UIImage+ImageCompress.h"
//#import "NVDate.h"
//#import <SDWebImage/SDWebImageManager.h>
#import "ECDevice.h"
//#import <Photos/Photos.h>
//#import <AssetsLibrary/AssetsLibrary.h>

@implementation ECUtil

# pragma mark - 有效性检查
/**
 *  简单判断是否是电话号码（11位&数字）
 *
 *  @param num 字符串
 *
 *  @return 是否是电话号码
 */
+ (BOOL)checkInputPhoneNum:(NSString*)num
{
    if (num.length != 11)
    {
        //[EBAlert alertError:@"请输入正确的手机号码"];
        return NO;//!请输入正确的手机号码
    }
    NSString *compare = @"0123456789";
    NSString *temp;
    for (NSInteger i = 0; i < [num length]; i ++)
    {
        temp = [num substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [compare rangeOfString:temp];
        NSInteger location = range.location;
        if (location < 0)
        {
            //[EBAlert alertError:@"请输入正确的手机号码"];
            return NO;//!请输入正确的号码
        }
    }
    return YES;
}

+ (BOOL)checkoutIsMobile {
    NSString *mobileRegex = @"^[1][3456789][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", mobileRegex];
    return [predicate evaluateWithObject:self];
}


/**
 *  检验名字是否可用
 *
 *  @param name 用户名
 *
 *  @return 检验结果
 */
+ (BOOL)validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[\u4E00-\u9FA5]{1,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

/**
 *  判断是否是空字符串
 *
 *  @param string 字符串
 *
 *  @return 是否为空
 */
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]){
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

/**
 *  限制输入（最多两位小数，最多8位数字）
 *
 *  @param textField 见说明
 *  @param range     见说明
 *  @param string    见说明
 *  @param hasDot    见说明
 *
 *  @return 见说明
 *  将此方法置于 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 中使用
 */
+ (BOOL)textField:(UITextField *)textField evaluateNumberChargeInRange:(NSRange)range replacementString:(NSString *)string hasDot:(BOOL *)hasDot
{
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        *hasDot = NO;
    }
    if ([string length]>0)
    {
        if ((textField.text.length < 6 && !*hasDot) || ([textField.text rangeOfString:@"."].location < 6 && *hasDot)) {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single == '.')//数据格式正确
            {
                //首字母不能为0和小数点
                if([textField.text length]==0){
                    if(single == '.'){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                    if (single == '0') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return YES;
                    }
                }
                if (single=='.')
                {
                    //text中还没有小数点
                    if(!*hasDot)
                    {
                        *hasDot = YES;
                        return YES;
                    }else
                    {
                        //已经输入过小数点了
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                else
                {
                    if (*hasDot)//存在小数点
                    {
                        //判断小数点的位数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        NSInteger tt=range.location-ran.location;
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                    else
                    {
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                //            [self alertView:@"亲，您输入的格式不正确"];
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else if(textField.text.length == 6 && !*hasDot && [string characterAtIndex:0] == '.'){
            return YES;
        }else if((textField.text.length == 7 || textField.text.length == 8) && [textField.text rangeOfString:@"."].location == 6)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if (single >='0' && single<='9')//数据格式正确
            {
                NSRange ran=[textField.text rangeOfString:@"."];
                NSInteger tt=range.location-ran.location;
                if (tt <= 2){
                    return YES;
                }else{
                    return NO;
                }
            }
            else{//输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
            return NO;
        }
    }
    else
    {
        return YES;
    }
    return NO;
}



# pragma mark - 其他方法
/**
 *  计算文字尺寸
 *
 *  @param text 文字
 *  @param font 字号
 *  @param size 范围
 *
 *  @return 文字占用尺寸
 */
+ (CGSize)textSize:(NSString *)text font:(UIFont *)font bounding:(CGSize)size
{
    if (!(text && font) || [text isEqual:[NSNull null]]) {
        return CGSizeZero;
    }
    CGRect rect = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
    return CGRectIntegral(rect).size;
}

+ (CGFloat)widgetHeight:(UIView *)widget sizeMakeWidth:(CGFloat)wid {
    if ([widget isKindOfClass:[UILabel class]]) {
        UILabel *la = (UILabel *)widget;
        la.numberOfLines = 0;
    }
    CGSize fit = [widget sizeThatFits:CGSizeMake(wid, CGFLOAT_MAX)];
    return fit.height;
}

+ (NSInteger)textLength:(NSString *)text
{
    if (text == nil || [text isEqual:[NSNull null]]) {
        return 0;
    }
    return [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length;
}


/**
 *  数字转字符串
 *
 *  @param number 数字
 *
 *  @return 字符串
 */
+ (NSString *)formatFloat:(CGFloat)number
{
    NSNumberFormatter *formatter = [ECUtil numberFormatter];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:number]];
}

/**
 *  生成带“元”的字符串
 *
 *  @param number 钱数
 *
 *  @return 字符串
 */
+ (NSString *)formatMoney:(CGFloat)number
{
    return [NSString stringWithFormat:NSLocalizedString(@"md_result_yuan_fmt", nil), [ECUtil formatFloat:number]];
}

/**
 *  单行文字高度
 *
 *  @param font 字号
 *
 *  @return 高度
 */
+ (CGFloat)singleLineHeight:(UIFont *)font
{
    return [ECUtil textSize:@"A" font:font bounding:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
}

#pragma mark - 颜色相关
/**
 *  颜色转换 IOS中十六进制的颜色转换为UIColor
 *
 *  @param color 十六进制颜色码
 *
 *  @return 相对应的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


+ (NSNumberFormatter *)numberFormatter
{
    NSNumberFormatter *formatter;
    if (formatter == nil)
    {
        formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:2];
    }
    
    return formatter;
}

# pragma mark - 时间相关

/**
 *  格式化时间字符串转换
 *
 *  @param time 时间戳
 *
 *  @return 格式化时间
 */
+ (NSString *)formatTime:(NSInteger)time
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:date];
}

/**
 *  时间戳2字符串
 *
 *  @param seconds 时间戳
 *  @param format  时间格式
 *
 *  @return 格式化时间
 */
+ (NSString *)stringWithSeconds:(NSTimeInterval)seconds timeFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    static NSDateFormatter *formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    }
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

/**
 *  字符串2时间戳
 *
 *  @param string 字符串
 *  @param format 时间格式
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)secondsWithString:(NSString *)string timeFormat:(NSString *)format
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    }
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:string];
    return [date timeIntervalSince1970];
}

/**
 *  针对聊天页面生成的根据时间与当前时间对比得到字符串
 *
 *  @param time 时间戳
 *
 *  @return 相对的字符串
 */
//+ (NSString *)formatMessageTime:(NSInteger)time
//{
//    static NSDateFormatter *formatter = nil;
//    if (formatter == nil)
//    {
//        formatter = [[NSDateFormatter alloc] init];
//        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    }
//
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
//    if ([date isToday])
//    {
//        formatter.dateFormat = @"a hh:mm";
//    }
//    else if ([date isYesterday])
//    {
//        formatter.dateFormat = [NSString stringWithFormat:@"%@ a hh:mm", NSLocalizedString(@"Yesterday", nil)];
//    }
//    else if ([date daysBeforeDate:NSDate.date] < 7)
//    {
//        formatter.dateFormat = @"EEEE";
//        NSString *currentWeek = [formatter stringFromDate:NSDate.date];
//        if ([[formatter stringFromDate:date] isEqualToString:currentWeek]) {
//            formatter.dateFormat = @"yyyy-MM-dd a hh:mm:ss";
//        }
//        else{
//            formatter.dateFormat = @"EEEE a hh:mm";
//        }
//    }
//    else
//    {
//        formatter.dateFormat = @"yyyy-MM-dd a hh:mm:ss";
//    }
//
//    return [formatter stringFromDate:date];
//}

/**
 *  生成今天 昨天 明天 几天前 几天后的时间
 *
 *  @param time 时间戳
 *
 *  @return 带周的字符串
 */
//+ (NSString *)formatDayTime:(NSInteger)time
//{
//    static NSDateFormatter *formatter = nil;
//    if (formatter == nil)
//    {
//        formatter = [[NSDateFormatter alloc] init];
//        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    }
//
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
//    if ([date isToday])
//    {
//        formatter.dateFormat = @"今天";
//    }
//    else if ([date isYesterday])
//    {
//        formatter.dateFormat = @"昨天";
//    }
//    else if ([date isTomorrow]){
//        formatter.dateFormat = @"明天";
//    }
//    else if ([date daysBeforeDate:NSDate.date] > 0){
//        formatter.dateFormat = [NSString stringWithFormat:@"%ld天前",[date daysBeforeDate:NSDate.date]];
//    }
//    else
//    {
//        formatter.dateFormat = [NSString stringWithFormat:@"%ld天后",[date daysAfterDate:NSDate.date]];
//    }
//
//    return [formatter stringFromDate:date];
//}

/**
 *  生成带周的时间(如2015-08-20 周四 16：30)
 *
 *  @param time 时间戳
 *
 *  @return 带周的字符串
 */
//+ (NSString *)setWeekTime:(NSInteger)time
//{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NVDate *day = [[NVDate alloc] initUsingDate:date];
//    NSString *tempDate = [formatter stringFromDate:date];
//    NSString *midDate = [NSString stringWithFormat:@"%@ %@",tempDate,[day weekOfThisDay]];
//    formatter.dateFormat = @"HH:mm";
//
//    NSString *finalDate = [NSString stringWithFormat:@"%@ %@",midDate,[formatter stringFromDate:date]];
//    return finalDate;
//}

/**
 *  生成带周的时间(如8月20号 周四 16：30)
 *
 *  @param time 时间戳
 *
 *  @return 带周的字符串
 */
//+ (NSString *)setMessageWeekTime:(NSInteger)time
//{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"MM月dd日";
//    NVDate *day = [[NVDate alloc] initUsingDate:date];
//    NSString *tempDate = [formatter stringFromDate:date];
//    NSString *midDate = [NSString stringWithFormat:@"%@ %@",tempDate,[day weekOfThisDay]];
//    formatter.dateFormat = @"HH:mm";
//    
//    NSString *finalDate = [NSString stringWithFormat:@"%@ %@",midDate,[formatter stringFromDate:date]];
//    return finalDate;
// 
//
//}

# pragma mark - 图片相关操作
/**
 *  压缩图片
 *
 *  @param image 待压缩图片
 *
 *  @return 压缩后图片
 */
//+ (UIImage *)compressImage:(UIImage *)image
//{
//    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
//    CGFloat quality = imgData.length / (1024*1024*0.1);
//    if (quality > 1.0) {
//        quality = 1/quality;
//        image = [UIImage compressImage:image compressRatio:quality];
//    }
//    return image;
//}

/**
 *  颜色转图片
 *
 *  @param color 颜色
 *  @param rect  尺寸
 *
 *  @return 图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, (CGRect){CGPointZero,size});
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  图片倍数检查
 *
 *  @return 倍数
 */
+ (float)imagePixByDevice
{
    if ([ECDevice getDeviceType] == EDeviceType_6p) {
        return 3.0;
    }else{
        return 2.0;
    }
}

/**
 *  从bundle中获取图片
 *
 *  @param imgName    图片名称
 *  @param bundleName bundle名称
 *  @param isFix      是否是2x或3x
 *  @param imageType  图片扩展名
 *
 *  @return 图片
 */
+ (UIImage *)getImageName:(NSString *)imgName formBundle:(NSString *)bundleName isThreeFix:(BOOL)isFix imgType:(NSString *)imageType
{
    NSString *path = nil;
    if (isFix) {
        path = [[NSBundle mainBundle]
                    pathForResource:[NSString stringWithFormat:@"%@/%@@%ldx", bundleName, imgName,(long)[self imagePixByDevice]] ofType:imageType];
    }else{
        path = [[NSBundle mainBundle]
                pathForResource:[NSString stringWithFormat:@"%@/%@", bundleName, imgName] ofType:imageType];
    }
    return [UIImage imageWithContentsOfFile:path];
}

/**
 *  修正图片方向方法
 *
 *  @param aImage 未知方向的图片
 *
 *  @return 向上的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (void)saveImageToAlbum:(UIImage *)image
{
//    if ([ECDevice isIOS8]) {
//        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//            [PHAssetChangeRequest creationRequestForAssetFromImage:image];
//        } completionHandler:^(BOOL success, NSError * _Nullable error) {
//
//        }];
//    }
//    else {
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
//        [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
//        }];
//    }
}

+ (void)gradientLayer:(UIView *)v startPoint:(CGPoint)start endPoint:(CGPoint)end colorArr1:(UIColor *)color1 colorArr2:(UIColor *)color2 location1:(CGFloat)v1 location2:(CGFloat)v2{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = v.bounds;
    [v.layer addSublayer:gradient];
    gradient.startPoint = start;
    gradient.endPoint = end;
    gradient.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];
    //gradient.locations = @[@(v1), @(v2)];
}

+ (NSAttributedString *)mutableArrtibuteString:(NSString *)str1 foregroundColor:(UIColor *)color1 fontName:(UIFont *)font1 attribut:(NSString *)str2 foregroundColor:(UIColor *)color2 fontName:(UIFont *)font2{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str1 attributes:@{NSForegroundColorAttributeName:color1, NSFontAttributeName:font1}];
    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc] initWithString:str2 attributes:@{NSForegroundColorAttributeName:color2, NSFontAttributeName:font2}];
    [attributedStr appendAttributedString:attributedStr2];
    return attributedStr;
}

+ (NSString *)getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result;
}

+ (NSString *)getIDFA {
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}

@end
