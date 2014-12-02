//
//  CPBaseLoginView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-23.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseLoginView.h"
#import "GJCommonWidgetHelper.h"

@interface CPBaseLoginView ()

@property (nonatomic, strong) UIImageView * image;

@property (nonatomic, strong) NSString * pleceHolde;

@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, assign) CPTEXEVIEMODEL model;

@property (nonatomic, strong) CPBaseLoginViewModel * entity;

@property (nonatomic, strong) UIView* bottomBorder;

@property (nonatomic, strong) UIImageView * backImage;

@end

@implementation CPBaseLoginView

-(instancetype)initWithFrame:(CGRect)frame andEntity:(CPBaseLoginViewModel*)entity withModel:(CPTEXEVIEMODEL) model {
    
    if (self= [super initWithFrame:frame]) {
        self.image.image = entity.image;
        self.pleceHolde = entity.pleceHolde;
        self.model = model;
        self.backgroundColor = [UIColor clearColor];
        self.image.image = entity.image?entity.image:[UIImage imageNamed:@"tabbar_home_selected"];
        self.textField.placeholder = entity.pleceHolde?entity.pleceHolde:@"xxxxx";
        
        [self addSubview:self.backImage];
        
        [self addSubview:self.bottomBorder];
        
        [self addSubview:self.image];
        
        [self addSubview:self.textField];
        
    }
    return self;
}

-(UIView *)bottomBorder{
    
    if (!_bottomBorder) {
        _bottomBorder = [[GJCommonWidgetHelper sharedGJCommonWidgetHelper]createNormalBorderView];
        _bottomBorder.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin;
        [_bottomBorder.po_frameBuilder setWidth:self.size.width];
    }
    return _bottomBorder;
}

-(UIImageView *)backImage{
    if (!_backImage) {
        _backImage = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _backImage;
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
    
    [[[self.image.po_frameBuilder alignLeftInSuperviewWithInset:8]setWidth:30]setHeight:30];
    
    [[[self.textField.po_frameBuilder alignRightOfView:self.image offset:3]setHeight:44]setWidth:(self.width-self.image.width)];
    
    switch (_model) {
        case CPTEXEVIEWUP:
            [_bottomBorder.po_frameBuilder setHeight:0.5];
            [[_bottomBorder.po_frameBuilder alignToBottomInSuperviewWithInset:0]alignRightInSuperviewWithInset:0];
            self.backImage.image = [self getBackgroundImage:_model];
            break;
        case CPTEXEVIEWMIN:
            [_bottomBorder.po_frameBuilder setHeight:0.5];
            [[_bottomBorder.po_frameBuilder alignToBottomInSuperviewWithInset:0]alignRightInSuperviewWithInset:0];
            self.backImage.image = [self getBackgroundImage:_model];

            break;
        case CPTEXEVIEWDOWN:
            
            self.backImage.image = [self getBackgroundImage:_model];

            break;
        case CPTEXEVIEWONE:
            
            self.backImage.image = [self getBackgroundImage:_model];

            break;
        default:
            break;
    }
    
}

-(UIImage*)getBackgroundImage:(CPTEXEVIEMODEL)model{
    
    UIImage * backGroundImage = [UIImage imageNamed:@"登陆注册输入框"];
    
    return [backGroundImage stretchableImageWithLeftCapWidth:backGroundImage.size.width/2 topCapHeight:backGroundImage.size.height/2];
    
}

-(NSString *)textString{
    return self.textField.text;
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

