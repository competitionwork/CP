//
//  CPUtil.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUtil.h"

@implementation CPUtil

+ (BOOL)isPureNumandCharacters:(NSString *)_text
{
    //#ifdef TEST
    //    return [self isPurePhonesCharacters:_text];
    //#endif
    NSString *string = _text;
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

//uicolor to uiimage
+ (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+ (BOOL)isPurePhonesCharacters:(NSString *)_text
{
    NSString *string = _text;
    
    NSMutableCharacterSet *mset = [[NSMutableCharacterSet alloc] init] ;
    NSCharacterSet *set = [NSCharacterSet decimalDigitCharacterSet];
    [mset formUnionWithCharacterSet:set];
    [mset addCharactersInString:@"-,"];
    string = [string stringByTrimmingCharactersInSet:mset];
    if(string.length > 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (NSString *)trim:(NSString *)str {
    NSSet *set = [NSSet setWithObjects:@" ", @"　" ,nil];
    return [CPUtil trim:str strings:set];
}

+ (NSString *)trim:(NSString *)str
            string:(NSString *)str1 {
    if (str && [str length]>0) {
        while ([str hasPrefix:str1]) {
            str = [str substringFromIndex:str1.length];
        }
        while ([str hasSuffix:str1]) {
            str = [str substringToIndex:str.length-str1.length];
        }
        return str;
    }
    return @"";
}

+ (NSString *)trim:(NSString *)str
           strings:(NSSet *)values {
    if (str && [str length]>0) {
        NSString *temp;
        while (str.length > 0) {
            temp = [str substringToIndex:1];
            if (![values containsObject:temp]) {
                break;
            }
            str = [str substringFromIndex:1];
        }
        while (str.length > 0) {
            temp = [str substringFromIndex:str.length-1];
            if (![values containsObject:temp]) {
                break;
            }
            str = [str substringToIndex:str.length-1];
        }
        return str;
    }
    return @"";
}

+ (NSString *)timeToNow:(int)time
{
    int timeInterval = [[NSDate date] timeIntervalSince1970] - time;
    if (timeInterval <= 0)
        return @"1分钟前";
    if (timeInterval > 60*60*24*3)
    {
        NSDate* talkDate = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:MM"];
        NSString* dateStr = [dateFormatter stringFromDate:talkDate];
        return dateStr;
    }
    else if (timeInterval > 60*60*24)
    {
        return [NSString stringWithFormat:@"%d天前", timeInterval/(60*60*24)+1];
    }
    else if (timeInterval > 60*60)
    {
        return [NSString stringWithFormat:@"%d小时前", timeInterval/(60*60)+1];
    }
    else if(timeInterval < 0){
        return @"刚刚";
    }
    else
    {
        return [NSString stringWithFormat:@"%d分钟前", timeInterval/60+1];
    }
}

+ (UILabel *)customLableWithTextColor:(UIColor *)color andTextFont:(UIFont *)textFont{
    UILabel * lab = [[UILabel alloc]init];
    lab.textColor = color;
    lab.font = textFont;
    return lab;
}

+ (UIImageView *)lineImageViewWithFrame:(CGRect)rect{
    UIImageView * imageV = [[UIImageView alloc]init] ;
    imageV.backgroundColor = kCellButtomLineColor;
    
    imageV.frame = rect;
    return imageV;
}


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, MainScreenWidth, 44);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(void)mobEvent:(NSString*)eventId label:(NSString*)label
{
//    [MobClick event:eventId label:label];
}

/*
 * rect is all view frame rect
 * LanRenZhaoFang add
 */
+ (UIView *)gjLoadingViewWithRect:(CGRect)rect andTipMessage:(NSString *)tipMessage
{
    UIView *loadingView = [[UIView alloc] initWithFrame:rect];
    loadingView.backgroundColor = [UIColor whiteColor];
    loadingView.tag = LOADING_VIEW_TAG;
    
    UIImage *bottomImage = [UIImage imageNamed:@"loading底部"];
    
    UIView *bjView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 137, 137)];
    bjView.backgroundColor = [UIColor whiteColor];
    bjView.layer.cornerRadius = 10.0f;
    bjView.layer.masksToBounds = YES;
    [loadingView addSubview:bjView];
    
    [bjView.po_frameBuilder centerHorizontallyInSuperview];
    [bjView.po_frameBuilder centerVerticallyInSuperview];
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bottomImage.size.width, bottomImage.size.height)];
    bottomImageView.image = bottomImage;
    [loadingView addSubview:bottomImageView];
    
    [bottomImageView.po_frameBuilder centerHorizontallyInSuperview];
    [bottomImageView.po_frameBuilder centerVerticallyInSuperview];
    
    //旋转动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000*100000;
    
    [bottomImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    UIImage *iconImage = [UIImage imageNamed:@"loading图标"];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconImage.size.width, iconImage.size.height)];
    iconImageView.image = iconImage;
    [loadingView addSubview:iconImageView];
    
    [iconImageView.po_frameBuilder centerHorizontallyInSuperview];
    [iconImageView.po_frameBuilder centerVerticallyInSuperview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 15)];
    label.tag = 999999;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = GrayColor;
    label.text = nil;
    if (tipMessage.length)
    {
        label.text = [tipMessage stringByAppendingString:@"..."];
    }
    [loadingView addSubview:label];
    
    [label.po_frameBuilder alignToBottomOfView:iconImageView offset:10];
    [label.po_frameBuilder centerHorizontallyInSuperview];
    
    return loadingView ;
}

// LanRenZhaoFang add
+ (NSString*)getClipedImageURLStringWithUrl:(NSString*)urlString imageWidth:(NSInteger)width imageHeight:(NSInteger)height
{
    if (nil == urlString)
    {
        return nil;
    }
    
    NSArray *stringComponentArray = [urlString componentsSeparatedByString:@"_"];
    if (stringComponentArray.count < 3)
    {
        return urlString;
    }
    
    NSString *urlStringRet = [NSString stringWithFormat:@"%@_%ld-%ldc_%@", stringComponentArray[0], (long)width, (long)height, stringComponentArray[2]];
    
    return urlStringRet;
}



// TODO:图片加载优化
+ (UIImage *)getScaledImageWithName:(NSString *)imageName width:(CGFloat)width
{
    if (imageName == nil) return nil;
    
    UIImage *sourceImg = [UIImage imageNamed:imageName];
    return [self getScaledImageWithImage:sourceImg width:width];
}

+ (UIImage *)getScaledImageWithData:(NSData *)data width:(CGFloat)width
{
    if ([data length] == 0) return nil;
    
    UIImage *sourceImg = [UIImage imageWithData:data];
    return [self getScaledImageWithImage:sourceImg width:width];
}

+ (UIImage *)getScaledImageWithImage:(UIImage *)image width:(CGFloat)width
{
    if (image == nil) return nil;
    
    CGSize size = image.size;
    CGFloat scaled = width / size.width;
    
    UIImage *scaledImg = [self originImage:image scaleToSize:CGSizeMake(width, size.height * scaled)];
    return scaledImg;
}

+ (UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

#pragma mark - get common image
+ (UIImage *)getRightGrayArrowImage
{
    return [UIImage imageNamed:@"右箭头-icon-灰"];
}

+ (UIView *)personalHouseViewWithFrame:(CGRect)rect
{
    UIView *aView = [[UIView alloc] initWithFrame:rect];
    aView.backgroundColor = [UIColor clearColor];
    
    UIImageView *leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"标示-icon-100%房源"]];
    
    [aView addSubview:leftIcon];
    [leftIcon.po_frameBuilder centerVerticallyInSuperview];
    
    CGSize size = rect.size;
    CGFloat rightZoneWidth = size.width - leftIcon.width - 5;//左移5，任意值
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"无中介费",
                           @"小编点评",
                           @"真实待租",
                           @"人工认证",
                           nil];
    
    NSArray *imageNameArray = [NSArray arrayWithObjects: @"详情页-icon-100％无中介费",
                               @"详情页-icon-100%小编点评",
                               @"详情页-icon-100%真实待租",
                               @"详情页-icon-100%人工认证",
                               nil];
    
    NSMutableArray *subViews = [[NSMutableArray alloc] init];
    CGSize aSubViewSize = CGSizeZero;
    for (int i = 0; i < [titleArray count]; i++) {
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageNameArray objectAtIndex:i]]];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = [titleArray objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:11];
        [label sizeToFit];
        label.center = icon.center;
        [label.po_frameBuilder alignRightOfView:icon offset:5 + icon.width];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(label.frame), CGRectGetHeight(icon.frame))];
        bgView.backgroundColor = [UIColor clearColor];
        
        [bgView addSubview:icon];
        [bgView addSubview:label];
        
        [subViews addObject:bgView];
        
        
        if (bgView.width > aSubViewSize.width) {
            aSubViewSize = bgView.size;
        }
    }
    
    CGFloat offsetX = (rightZoneWidth - aSubViewSize.width * 2) / 2;
    CGFloat offsetY = 1;
    
    int num = 0;
    for (int row = 0; row < 2; row++) {
        for (int col = 0; col < 2; col++) {
            UIView *subView = [subViews objectAtIndex:num];
            subView.frame = CGRectMake(CGRectGetMaxX(leftIcon.frame) + offsetX + (offsetX + aSubViewSize.width) * col, (leftIcon.center.y - offsetY/ 2 - subView.height) + (offsetY + aSubViewSize.height) * row, subView.size.width, subView.size.height);
            [aView addSubview:subView];
            ++num;
        }
    }
//#define LOADING_VIEW_TAG 9527
    
    return aView;
}


+ (UIView *)dashViewWithWidth:(CGFloat)width
{
    UIImage *dashImage = [UIImage imageNamed:@"虚线"];
    CGFloat totalWidth = 0;
    UIView *dashView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, dashImage.size.height)];
    dashView.backgroundColor = [UIColor clearColor];
    dashView.clipsToBounds = YES;
    while (totalWidth < width) {
        UIImageView *aDash = [[UIImageView alloc] initWithFrame:CGRectMake(totalWidth, 0, dashImage.size.width, dashImage.size.height)];
        aDash.image = dashImage;
        [dashView addSubview:aDash];
        totalWidth += dashImage.size.width;
    }
    
    return dashView;
}

+ (UIImage *)getGreenButton{
    
    UIImage *image =  [UIImage imageNamed:@"按钮-绿"];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}
+ (UIImage *)getGreenButtonTouched{
    
    UIImage *image =  [UIImage imageNamed:@"按钮-绿-点击"];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

+ (UIImage *)getEasyGreenButton{
    
    UIImage *image =  [UIImage imageNamed:@"按钮-浅绿"];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

+ (UIImage *)getEasyGreenButtonTouched{
    
    UIImage *image =  [UIImage imageNamed:@"按钮-浅绿-点击"];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}
+ (UIImage *)circleGrayLayer
{
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    UIImage *tapImg = [[UIImage imageNamed:@"sub_small_background"] resizableImageWithCapInsets:insets];
    return tapImg;
}

+ (UIImage *)rectangleGrayLayer
{
    return [UIImage imageNamed:@"10%透明点击态蒙层"];
    /*
     UIView *bgView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)] autorelease]; //20*20任意值
     bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
     UIGraphicsBeginImageContext(bgView.bounds.size);
     [bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
     UIImage *tapImg = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     return tapImg;
     */
}

+ (UIImage *)getOrangeButton{
    
    UIImage *image =  [UIImage imageNamed:@"按钮-橙"];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

+ (UIImage *)getOrangeButtonTouched{
    UIImage *image =  [UIImage imageNamed:@"按钮-橙-点击"];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

+ (UIImageView *)getNewIcon{
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"提示-BG"]];
    icon.bounds = CGRectMake(0, 0, 18, 18);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"新";
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [icon addSubview:titleLabel];
    return icon ;
    
}

+ (NSString *)pathForDocumentWithFilename:(NSString*)filename {
    NSString *documentsDirectory = [CPUtil getDocumentDirectory];
    NSString * dataFilePathX = [documentsDirectory stringByAppendingPathComponent:filename];
    return dataFilePathX;
}

+ (NSString*)getDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingFormat:@"/1.0"];
    
    BOOL pathIsDirectory;
    NSFileManager* defaultManager = [NSFileManager defaultManager];
    if (FALSE == [defaultManager fileExistsAtPath:path isDirectory:&pathIsDirectory] || !pathIsDirectory)
        [defaultManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    
    return path;
}

+ (NSString*)URLEncode:(NSString*)str
{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[str mutableCopy] , NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"),kCFStringEncodingUTF8)) ;
}
@end


@implementation NSNumber (GJString)
- (NSUInteger)length {
    DLog(@"----ERROR: This object's type is NSNumber, not NSString... PLS check... ");
    return 0;
}
@end