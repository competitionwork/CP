//
//  GJFilterBarItem.m
//  HouseRent
//
//  Created by liruiqin on 13-12-3.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJFilterBarItem.h"

@interface GJFilterBarItem ()


@end
@implementation GJFilterBarItem

-(id)initWithDefaultStyle
{
    self = [super initWithFrame:CGRectMake(0, 0, 40, 40)];
    if (self) {
        self.textButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.textButton.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.textButton];
        self.textButton.frame=self.bounds;
        self.textButton.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    return self;

}

@end
