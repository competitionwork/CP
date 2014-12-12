//
//  UIView+TipViewForUsual.h
//  competitionwork
//
//  Created by hjj on 14-12-12.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTipViewTag 100000345


typedef enum {
    TipViewLoading = 0,
    TipViewNoNetWork = 1,
    TipViewNoMessage =2,
}TipViewType;

@interface UIView (TipViewForUsual)

//-(void)showTip:(UIImage *)tipImage withText:(NSString *)text forEdgeInsets:(UIEdgeInsets)margin;
-(void)showTipView:(TipViewType)tipType withText:(NSString *)text forEdgeInsets:(UIEdgeInsets)margin;
-(void)hideTipView;
-(void)showTipView:(TipViewType)tipType withText:(NSString *)text withSubText:(NSString *)subText forEdgeInsets:(UIEdgeInsets)margin;
- (NSString *)currentTipText;


/*
 暂时先增加，不影响老的
 */
-(void)showTip:(UIImage *)tipImage withText:(NSString *)text forEdgeInsets:(UIEdgeInsets)margin withTag:(TipViewType)tag;
-(void)showTipView:(TipViewType)tipType withText:(NSString *)text forEdgeInsets:(UIEdgeInsets)margin withTag:(TipViewType)tag;
-(void)hideTipViewWithTag:(NSUInteger)tag;

@end
