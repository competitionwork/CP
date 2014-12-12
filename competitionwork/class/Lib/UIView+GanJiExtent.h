//
//  UIView+GanJiExtent.h
//  HouseRent
//
//  Created by liruiqin on 13-11-26.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GanJiExtent)

+(UIView*)viewWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor;
-(void)rotaionByAngle:(CGFloat)angle;
-(void)rotaionByAngle:(CGFloat)angle animated:(BOOL)animated;

-(void)showView:(UIView *)targetView forEdgeInsets:(UIEdgeInsets)margin;

@end
