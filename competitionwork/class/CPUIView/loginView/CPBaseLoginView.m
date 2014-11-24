//
//  CPBaseLoginView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-23.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseLoginView.h"

@interface CPBaseLoginView ()

@property (nonatomic, strong) UIImageView * image;

@property (nonatomic, strong) NSString * pleceHolde;

@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, assign) CPTEXEVIEMODEL model;

@property (nonatomic, strong) CPBaseLoginViewModel * entity;

@end

@implementation CPBaseLoginView

-(instancetype)initWithFrame:(CGRect)frame andEntity:(CPBaseLoginViewModel*)entity withModel:(CPTEXEVIEMODEL) model {
    
    if (self= [super initWithFrame:frame]) {
        self.image.image = entity.image;
        self.pleceHolde = entity.pleceHolde;
        self.model = model;
        
        self.image.image = [UIImage imageNamed:@"tabbar_home_selected"];
        self.textField.placeholder = @"xxxxx";
        
        [self addSubview:self.image];
        
        [self addSubview:self.textField];
        
    }
    return self;
}

-(UITextField *)textField{
    if (!_textField) {
        
        _textField = [[UITextField alloc]init];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        
    }
    return _textField;
}

-(UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
    }
    return _image;
}

-(void)layoutSubviews{
    
    [[[self.image.po_frameBuilder alignRightInSuperviewWithInset:8]setWidth:30]setHeight:30];
    
    [[[self.textField.po_frameBuilder alignRightOfView:self.image offset:3]setHeight:44]setWidth:(self.width-self.image.width)];
    
    
    
    if (self.model == CPTEXEVIEWONE) {
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation CPBaseLoginViewModel



@end

