//
//  CPCheckBox.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPCheckBox.h"

@interface CPCheckBox ()

@property (nonatomic,strong) UIImageView *checkImage;

@end

@implementation CPCheckBox

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.checkImage];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage)];
        
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(UIImageView *)checkImage{
    if (!_checkImage) {
        _checkImage = [[UIImageView alloc]initWithFrame:self.bounds];
        _checkImage.image = [UIImage imageNamed:@"投递简历-未选中"];
        _checkImage.highlightedImage = [UIImage imageNamed:@"投递简历-选中"];
    }
    return _checkImage;
}

-(void)changeImage{
    
    _checkImage.highlighted = !_checkImage.highlighted;
    
}

-(BOOL)getSelectCheckBox{
    
    _checkBlock();
    
    return _checkImage.highlighted;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
