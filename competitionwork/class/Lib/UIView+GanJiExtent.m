//
//  UIView+GanJiExtent.m
//  HouseRent
//
//  Created by liruiqin on 13-11-26.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "UIView+GanJiExtent.h"


@implementation UIView (GanJiExtent)

+(UIView *)viewWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)backgroundColor
{
    UIView *v=[[self alloc] initWithFrame:frame];
    v.backgroundColor=backgroundColor;
    return v;
}

-(void)rotaionByAngle:(CGFloat)angle
{
    [self rotaionByAngle:angle animated:YES];
}
-(void)rotaionByAngle:(CGFloat)angle animated:(BOOL)animated
{
    CGFloat duration = animated ? 0.4 : 0;
    CGAffineTransform rotate = CGAffineTransformMakeRotation(angle / 180.0 * M_PI);
    [UIView beginAnimations:@"rotate" context:nil ];
    //动画时常
    [UIView setAnimationDuration:duration];
    //获取transform的值
    [self setTransform:rotate];
    //关闭动画
    [UIView commitAnimations];
}

-(void)showView:(UIView *)targetView forEdgeInsets:(UIEdgeInsets)margin;
{
    targetView.frame = self.bounds;
    targetView.width = targetView.width - margin.left - margin.right;
    targetView.height = targetView.height - margin.top - margin.bottom;
    [targetView.po_frameBuilder setY:margin.top];
    [targetView.po_frameBuilder setX:margin.left];
    self.backgroundColor = MainBackColor;
    [self addSubview:targetView];
    
}


@end
