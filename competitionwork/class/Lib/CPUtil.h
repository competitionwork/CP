//
//  CPUtil.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPUtil : NSObject
//判断字符串是否为纯数字 是则认为未加密
+ (BOOL)isPureNumandCharacters:(NSString *)text;
//判断字符串是否为  "数字 - ,"   是则认为未加密
+ (BOOL)isPurePhonesCharacters:(NSString *)text;

+ (NSString *)trim:(NSString *)str;

+ (NSString *)trim:(NSString *)str
            string:(NSString *)str1;

+ (NSString *)trim:(NSString *)str
           strings:(NSSet *)values;

/**
 *  将时间戳返回成时间字符串
 *
 *  @param time 时间戳字符串
 *
 *  @return 时间字符串
 */
+ (NSString *)timeToNow:(int)time;

// 发布结果页面-title
+ (UILabel *)customLableWithTextColor:(UIColor *)color andTextFont:(UIFont *)textFont;
//分割线
+ (UIImageView *)lineImageViewWithFrame:(CGRect)rect;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *) createImageWithColor: (UIColor *) color;

+(void)mobEvent:(NSString*)eventId label:(NSString*)label;

// LanRenZhaoFang add
+ (UIView *)gjLoadingViewWithRect:(CGRect)rect andTipMessage:(NSString *)tipMessage;
+ (NSString*)getClipedImageURLStringWithUrl:(NSString*)urlString imageWidth:(NSInteger)width imageHeight:(NSInteger)height;


/**
 通过文件名缩放图片
 */
+ (UIImage *)getScaledImageWithName:(NSString *)imageName width:(CGFloat)width;

/**
 通过data缩放图片
 */
+ (UIImage *)getScaledImageWithData:(NSData *)data width:(CGFloat)width;

/**
 通过指定原图片缩放图片
 */
+ (UIImage *)getScaledImageWithImage:(UIImage *)image width:(CGFloat)width;

/**
 虚线描画
 */

+ (UIView *)dashViewWithWidth:(CGFloat)width;

/**
 获取列表右侧灰色箭头图片
 */
+ (UIImage *)getRightGrayArrowImage;

/**
 房产100%个人房源组图
 */
+ (UIView *)personalHouseViewWithFrame:(CGRect)rect;



/**
 *  绿色按钮
 */
+ (UIImage *)getGreenButton;

/**
 *  绿色按钮点击态
 */
+ (UIImage *)getGreenButtonTouched;

/**
 *  浅绿色按钮
 */
+ (UIImage *)getEasyGreenButton;


/**
 *  浅绿色按钮点击态
 */
+ (UIImage *)getEasyGreenButtonTouched;


/**
 *  橘色按钮
 */

+ (UIImage *)getOrangeButton;

/**
 *  橘色按钮点击
 */

+ (UIImage *)getOrangeButtonTouched;

/**
 
 圆角蒙层
 */
+ (UIImage *)circleGrayLayer;

/**
 直角蒙层
 */
+ (UIImage *)rectangleGrayLayer;

/**
 * 获得"新"icon  返回autorelease对象
 */
+ (UIImageView *)getNewIcon;

+ (NSString *)pathForDocumentWithFilename:(NSString*)filename ;

@end


@interface NSNumber (GJString)
- (NSUInteger)length;
@end