//
//  GJCommonWidgetHelper.h
//  HouseRent
//
//  Created by liruiqin on 13-10-24.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SingletonTemplate.h"

@interface GJCommonWidgetHelper : NSObject
DEFINE_SINGLETON_FOR_HEADER(GJCommonWidgetHelper)

-(UIView*)createBorderViewWithHeight:(CGFloat)height andColor:(UIColor*)color;
-(UIView*)createNormalBorderView;

@end

@interface UIImage(privateImage)

+ (UIImage *)imageNamed:(NSString *)name withCapWidth:(NSInteger)width withCapHeight:(NSInteger)height;

@end