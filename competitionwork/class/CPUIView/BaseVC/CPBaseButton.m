//
//  CPBaseButton.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseButton.h"

@interface CPBaseButton()


@end

@implementation CPBaseButton



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

-(void)setStylesWithTitle:(NSString *)title{
    
    self.frame = CGRectMake(13, 22, MainScreenWidth - 26, 40);
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    UIImage *uprightBtn = [UIImage imageNamed:@"qr"];
    UIImage *huprightBtn = [UIImage imageNamed:@"qr"];
    [self setBackgroundImage:[uprightBtn stretchableImageWithLeftCapWidth:floorf(uprightBtn.size.width / 2) topCapHeight:uprightBtn.size.height / 2] forState:UIControlStateNormal];
    [self setBackgroundImage:[huprightBtn stretchableImageWithLeftCapWidth:floorf(huprightBtn.size.width / 2) topCapHeight:huprightBtn.size.height / 2] forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)action:(UIButton *)sender{
    
    _Block(sender);
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
