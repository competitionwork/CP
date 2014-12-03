//
//  GJChooseButton.m
//  HouseRent
//
//  Created by liruiqin on 13-12-12.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJChooseButton.h"

@implementation GJChooseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setStyles
{
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self setTitleColor:[UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    UIImage *hBGImg = [UIImage imageNamed:@"单条点击"];
    
    
    
    [self setBackgroundImage:[hBGImg stretchableImageWithLeftCapWidth:7 topCapHeight:26] forState:UIControlStateHighlighted];
    
    UIImageView* accView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-20, self.bounds.size.height/2, 10, 10)];
    accView.tag = 9001;
    accView.image = [UIImage imageNamed:@"向下展开"];
    accView.highlightedImage = [UIImage imageNamed:@"向下展开"];
    [self addSubview:accView];
    accView.hidden = YES;
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    UIImageView* accView =(UIImageView*)[self viewWithTag:9001];
    [accView setHighlighted:highlighted];
}

@end
