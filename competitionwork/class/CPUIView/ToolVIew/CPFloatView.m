//
//  CPFloatView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-8.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPFloatView.h"

static const float floatViewAnimationDuration = 0.5;

@implementation CPFloatView

-(id)initWithFrame:(CGRect)frame withMessage:(NSString*)message
{
    self = [self initWithFrame:frame];
    if (self)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0,184 , self.frame.size.height)];
        label.text = message;
        label.backgroundColor = [UIColor clearColor];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [self addSubview:label];
        [label.po_frameBuilder centerInSuperview];
        UIImage *bgImg = [UIImage imageNamed:@"tip-bg.png"];
        self.image = [bgImg stretchableImageWithLeftCapWidth:floorf(bgImg.size.width/2) topCapHeight:floorf(bgImg.size.height/2)];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)showInView:(UIView *)baseView {
    [baseView addSubview:self];
    self.alpha = 0.0;
    [UIView animateWithDuration:floatViewAnimationDuration animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self performSelector:@selector(removeSelf) withObject:nil afterDelay:1.5];
    }
    return self;
}

-(void)removeSelf
{
    [UIView animateWithDuration:floatViewAnimationDuration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}




@end
