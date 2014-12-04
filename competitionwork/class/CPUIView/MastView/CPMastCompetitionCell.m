//
//  CPMastCompetitionCell.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPMastCompetitionCell.h"

@implementation CPMastCompetitionCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CPMastCompetitionCell" owner:self options:nil];
        self = nibs.firstObject;
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
