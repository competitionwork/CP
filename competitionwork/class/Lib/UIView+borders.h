//
//  UIView+borders.h
//  HouseRent
//
//  Created by liruiqin on 13-11-18.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJCommonWidgetHelper.h"

enum UIViewBorderPosition {
    UIViewBorderPositionTop = 0,
    UIViewBorderPositionBottom = 1,
    UIViewBorderPositionLeft = 2,
    UIViewBorderPositionRight = 3
};
@interface UIView (borders)

//-(void)setTopBorderWithColor:(UIColor*)color borderSize:(CGSize)size;
//-(void)setBottomBorderWithColor:(UIColor*)color borderSize:(CGSize)size;
//-(void)setLeftBorderWithColor:(UIColor*)color borderSize:(CGSize)size;
//-(void)setRightBorderWithColor:(UIColor*)color borderSize:(CGSize)size;
-(void)setBorderIn:(enum UIViewBorderPosition)position;
-(void)setBorderWithColor:(UIColor*)color borderSize:(CGSize)size in:(enum UIViewBorderPosition)position;

@end
