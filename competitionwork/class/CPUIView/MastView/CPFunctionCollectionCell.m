//
//  CPFunctionCollectionCell.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPFunctionCollectionCell.h"

@implementation CPFunctionCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray * arrays = [[NSBundle mainBundle]loadNibNamed:@"CPFunctionCollectionCell" owner:self
                                                      options:nil];
        self = arrays.firstObject;
        
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.cornerRadius = 35;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
