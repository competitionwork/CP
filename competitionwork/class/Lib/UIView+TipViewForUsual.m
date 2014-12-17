//
//  UIView+TipViewForUsual.m
//  competitionwork
//
//  Created by hjj on 14-12-12.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "UIView+TipViewForUsual.h"
#import "UIView+GanJiExtent.h"
#import "UIImageView+xiaolvAnimation.h"

#define kMaxTextLabelWidth 240


@implementation UIView (TipViewForUsual)


- (NSString *)currentTipText{
    
    UIView * view = [self viewWithTag:kTipViewTag];
    
    UILabel * label = (UILabel *)[view viewWithTag:2349];
    
    return label.text;
    
}

-(void)hideTipView
{
    if ([self viewWithTag:kTipViewTag]) {
        [[self viewWithTag:kTipViewTag] removeFromSuperview];
    }
}
-(void)showTip:(UIImage *)tipImage withText:(NSString *)text forEdgeInsets:(UIEdgeInsets)margin withTap:(TipViewType)type
{
    [self tipViewWithImage:tipImage text:text margin:margin withTap:type];
}
-(void)showTipView:(TipViewType)tipType withText:(NSString *)text forEdgeInsets:(UIEdgeInsets)margin
{
    NSString * imageName;
    switch (tipType){
        case TipViewLoading:
            
            imageName = @"小驴-加载中.png";
            break;
        case TipViewNoNetWork:
            
            imageName = @"小驴-无网络.png";
            break;
        case TipViewNoMessage:
            imageName = @"小驴-无消息.png";
            break;
        default:
            imageName = @"小驴-无消息.png";
            break;
    }
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    [self showTip:image withText:text forEdgeInsets:margin withTap:tipType];
}

-(UIView *)tipViewWithImage:(UIImage *)img text:(NSString *)text margin:(UIEdgeInsets)margin withTap:(TipViewType)Type
{
    UIView *tipview = [self viewWithTag:kTipViewTag];
    static int imageViewTag = 3453;
    static int labelViewTag = 2349;
    if (!tipview) {
        tipview = [[UIView alloc] initWithFrame:self.bounds];
        tipview.tag = kTipViewTag;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        if (Type == TipViewLoading) {
            imgView = [UIImageView loadViewAnimation];
            [imgView startAnimating];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        imgView.clipsToBounds = NO;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.width = kMaxTextLabelWidth;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = GJColor(76, 76, 76, 1);
        label.numberOfLines = 0;
        label.text = text;
        [label sizeToFit];
//        [tipview addSubview:imgView];
        [imgView addSubview:label];
        imgView.tag = imageViewTag;
        label.tag = labelViewTag;
        tipview.backgroundColor = [UIColor blackColor];
        tipview.alpha = 0.5;
        [label.po_frameBuilder alignToBottomInSuperviewWithInset:-label.height-5];
    }
    if (iPhone5) {
        [[[tipview viewWithTag:imageViewTag].po_frameBuilder centerInSuperview] moveWithOffsetY:-70];
    }
    else{
        [[[tipview viewWithTag:imageViewTag].po_frameBuilder centerInSuperview] moveWithOffsetY:-50];
    }
    [self showView:tipview forEdgeInsets:margin];
    DLog(@"-[tipview viewWithTag:labelViewTag].height / 2.0 %lf",-[tipview viewWithTag:labelViewTag].height / 2.0);
    [[[tipview viewWithTag:imageViewTag].po_frameBuilder centerInSuperview] moveWithOffsetY:-([tipview viewWithTag:labelViewTag].height+20)];
    [[tipview viewWithTag:labelViewTag].po_frameBuilder centerHorizontallyInSuperview];
    return tipview;
}
-(void)showTipView:(TipViewType)tipType withText:(NSString *)text withSubText:(NSString *)subText forEdgeInsets:(UIEdgeInsets)margin{
    NSString * imageName;
    switch (tipType){
        case TipViewLoading:
            imageName = @"小驴-加载中.png";
            break;
        case TipViewNoNetWork:
            imageName = @"小驴-无网络.png";
            break;
        case TipViewNoMessage:
            imageName = @"小驴-无消息.png";
            break;
        default:
            imageName = @"小驴-无消息.png";
            break;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIView *tipview = [self viewWithTag:kTipViewTag];
    static int imageViewTag = 3453;
    static int labelViewTag = 2349;
    static int subLabelViewTag = 2350;
    if (!tipview) {
        tipview = [[UIView alloc] initWithFrame:self.bounds];
        tipview.tag = kTipViewTag;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        if (tipType == TipViewLoading) {
            imgView = [UIImageView loadViewAnimation];
            [imgView startAnimating];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = GJColor(76, 76, 76, 1);
        label.textAlignment = NSTextAlignmentCenter;
        label.width = kMaxTextLabelWidth;
        label.numberOfLines = 0;
        label.text = text;
        [label sizeToFit];
        
        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        subLabel.backgroundColor = [UIColor clearColor];
        subLabel.textAlignment = NSTextAlignmentCenter;
        subLabel.width = kMaxTextLabelWidth;
        subLabel.font = [UIFont systemFontOfSize:12];
        subLabel.textColor = GJColor(153, 153, 153, 1);
        subLabel.numberOfLines = 0;
        subLabel.font = [UIFont systemFontOfSize:12];
        subLabel.text = subText;;
        [subLabel sizeToFit];
        
        [imgView addSubview:subLabel];
//        [tipview addSubview:imgView];
        [imgView addSubview:label];
        
        subLabel.tag = subLabelViewTag;
        imgView.tag = imageViewTag;
        label.tag = labelViewTag;
        tipview.backgroundColor = [UIColor blackColor];
        tipview.alpha = 0.5;
        [label.po_frameBuilder alignToBottomInSuperviewWithInset:-label.height-5];
        [label.po_frameBuilder centerHorizontallyInSuperview];
        [subLabel.po_frameBuilder centerHorizontallyInSuperview];
        [subLabel.po_frameBuilder alignToBottomInSuperviewWithInset:(-label.height-5-subLabel.height-5)];
    }
    
    
    [self showView:tipview forEdgeInsets:margin];
    if (iPhone5) {
        [[[tipview viewWithTag:imageViewTag].po_frameBuilder centerInSuperview] moveWithOffsetY:-70];
    }
    else{
        [[[tipview viewWithTag:imageViewTag].po_frameBuilder centerInSuperview] moveWithOffsetY:-50];
    }
    
    [self addSubview:tipview];
}

-(void)showTip:(UIImage *)tipImage withText:(NSString *)text forEdgeInsets:(UIEdgeInsets)margin withTag:(TipViewType)tag
{
    UIView *tipView = [self tipViewWithImage:tipImage text:text margin:margin withTap:tag];
    tipView.tag += tag;
    [self addSubview:tipView];
}


-(void)showTipView:(TipViewType)tipType withText:(NSString *)text forEdgeInsets:(UIEdgeInsets)margin withTag:(TipViewType)tag
{
    if ([[self viewWithTag:kTipViewTag] superview]) {
        [self bringSubviewToFront:[self viewWithTag:kTipViewTag]];
        return;
    }
    
    NSString * imageName;
    switch (tipType){
        case TipViewLoading:
            
            imageName = @"小驴-加载中.png";
            break;
        case TipViewNoNetWork:
            
            imageName = @"小驴-无网络.png";
            break;
        case TipViewNoMessage:
            imageName = @"小驴-无消息.png";
            break;
        default:
            imageName = @"小驴-无消息.png";
            break;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    [self showTip:image withText:text forEdgeInsets:margin withTag:tag];
}


-(void)hideTipViewWithTag:(NSUInteger)tag
{
    if ([self viewWithTag:kTipViewTag + tag]) {
        [[self viewWithTag:kTipViewTag + tag] removeFromSuperview];
    }
}



@end
