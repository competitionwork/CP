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

@property (nonatomic,strong) UIImageView *checkBackImage;

@end

@implementation CPCheckBox

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.checkBackImage];
        
        [self addSubview:self.checkImage];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage)];
        
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(UIImageView *)checkImage{
    if (!_checkImage) {
        _checkImage = [[UIImageView alloc]initWithFrame:self.bounds];
        _checkImage.image = [UIImage imageNamed:@""];
        _checkImage.highlightedImage = [UIImage imageNamed:@"圆角矩形-6"];
    }
    return _checkImage;
}

-(UIImageView *)checkBackImage{
    if (!_checkBackImage) {
        _checkBackImage = [[UIImageView alloc]initWithFrame:self.bounds];
        _checkBackImage.image = [UIImage imageNamed:@"k"];
    }
    return _checkBackImage;
}

-(void)changeImage{
    
    _checkImage.highlighted = !_checkImage.highlighted;
    
}

-(BOOL)getSelectCheckBox{
    
    if (self.checkBlock) {
        
        _checkBlock();

    }
    
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
