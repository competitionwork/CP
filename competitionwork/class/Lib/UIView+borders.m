//
//  UIView+borders.m
//  HouseRent
//
//  Created by liruiqin on 13-11-18.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "UIView+borders.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UIView (borders)

-(void)setBorderIn:(enum UIViewBorderPosition)position
{
    static NSInteger *baseTag=2365;
    UIView *border=[self viewWithTag:baseTag+position];
    [border removeFromSuperview];
    border=nil;
    border=[[GJCommonWidgetHelper sharedGJCommonWidgetHelper] createNormalBorderView];
    [border.po_frameBuilder setWidth:self.frame.size.width];
    [self addSubview:border];
    switch (position) {
        case UIViewBorderPositionTop:
        {
            [[border.po_frameBuilder alignToTopInSuperviewWithInset:0] centerHorizontallyInSuperview];
        }
            break;
        case UIViewBorderPositionLeft:
        {
            border.transform=CGAffineTransformMakeRotation(90 *M_PI / 180.0);CGAffineTransformMakeRotation(90 *M_PI / 180.0);
            [[border.po_frameBuilder alignLeftInSuperviewWithInset:0] centerVerticallyInSuperview];
        }
            break;
        case UIViewBorderPositionBottom:
        {
            [[border.po_frameBuilder alignToBottomInSuperviewWithInset:0] centerHorizontallyInSuperview];
        }
            break;
        case UIViewBorderPositionRight:
        {
            border.transform=CGAffineTransformMakeRotation(90 *M_PI / 180.0);CGAffineTransformMakeRotation(90 *M_PI / 180.0);
            [[border.po_frameBuilder alignRightInSuperviewWithInset:0] centerVerticallyInSuperview];
        }
            break;
        default:
            break;
    }
    border.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|
                             UIViewAutoresizingFlexibleTopMargin|
                           UIViewAutoresizingFlexibleRightMargin|
                          UIViewAutoresizingFlexibleBottomMargin;
    double delayInSeconds = 0.00001;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self bringSubviewToFront:border];
    });
}
-(void)setBorderWithColor:(UIColor*)color borderSize:(CGSize)size in:(enum UIViewBorderPosition)position;
{
    static NSInteger *baseTag=2365;
    UIView *border=[self viewWithTag:baseTag+position];
    [border removeFromSuperview];
    border=nil;
    border=[[GJCommonWidgetHelper sharedGJCommonWidgetHelper] createBorderViewWithHeight:size.height andColor:color];
    [border.po_frameBuilder setWidth:size.width];
    [self addSubview:border];
    switch (position) {
        case UIViewBorderPositionTop:
        {
            [[border.po_frameBuilder alignToTopInSuperviewWithInset:0] centerHorizontallyInSuperview];
        }
            break;
        case UIViewBorderPositionLeft:
        {
            border.transform=CGAffineTransformMakeRotation(90 *M_PI / 180.0);CGAffineTransformMakeRotation(90 *M_PI / 180.0);
            [[border.po_frameBuilder alignLeftInSuperviewWithInset:0] centerVerticallyInSuperview];
        }
            break;
        case UIViewBorderPositionBottom:
        {
            [[border.po_frameBuilder alignToBottomInSuperviewWithInset:0] centerHorizontallyInSuperview];
        }
            break;
        case UIViewBorderPositionRight:
        {
            border.transform=CGAffineTransformMakeRotation(90 *M_PI / 180.0);CGAffineTransformMakeRotation(90 *M_PI / 180.0);
            [[border.po_frameBuilder alignRightInSuperviewWithInset:0] centerVerticallyInSuperview];
        }
            break;
        default:
            break;
    }
}

@end
