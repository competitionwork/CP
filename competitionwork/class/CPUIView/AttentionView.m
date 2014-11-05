//
//  AttentionView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-6.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "AttentionView.h"
@interface AttentionView ()

@property (nonatomic) NSDictionary *content;

@property (nonatomic) UIButton *AttentionButton;


@end


@implementation AttentionView
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        self.AttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.AttentionButton];
        self.AttentionButton.frame = self.bounds;
        [[self.AttentionButton.po_frameBuilder setWidth:63.5] setX:0.5];
        [self.AttentionButton setImage:[UIImage imageNamed:@"列表页-电话"] forState:UIControlStateNormal];
        [self.AttentionButton setImage:[UIImage imageNamed:@"列表页-电话-点击"] forState:UIControlStateHighlighted];
        self.AttentionButton.backgroundColor = [UIColor blackColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
