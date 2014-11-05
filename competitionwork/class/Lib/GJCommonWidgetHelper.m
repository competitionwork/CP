//
//  GJCommonWidgetHelper.m
//  HouseRent
//
//  Created by liruiqin on 13-10-24.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJCommonWidgetHelper.h"

@implementation GJCommonWidgetHelper
DEFINE_SINGLETON_FOR_CLASS(GJCommonWidgetHelper)

-(UIView *)createNormalBorderView
{
    return [self createBorderViewWithHeight:0.5 andColor:RGBCOLOR(204, 204, 204)];
}
-(UIView *)createBorderViewWithHeight:(CGFloat)height andColor:(UIColor *)color
{
    UIView *border=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
    border.backgroundColor=color;
    return border;
}

@end


@implementation UIImage(privateImage)

+ (UIImage *)imageNamed:(NSString *)name withCapWidth:(NSInteger)width withCapHeight:(NSInteger)height {
    return [[UIImage imageNamed:name] stretchableImageWithLeftCapWidth:width topCapHeight:height];
}

@end