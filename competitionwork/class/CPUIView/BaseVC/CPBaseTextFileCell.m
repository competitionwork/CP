//
//  CPBaseTextFileCell.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseTextFileCell.h"
#import "GJCommonWidgetHelper.h"

@interface CPBaseTextFileCell ()

@property (nonatomic, strong) UIImageView * image;

@property (nonatomic, strong) NSString * pleceHolde;

@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, assign) CPTEXEVIEMODEL model;

@property (nonatomic, strong) CPBaseLabelCellModel * entity;

@property (nonatomic, strong) UIImageView * backImage;

@property (nonatomic,strong) UIView *TopBorder;

@property (nonatomic,strong) UIView *downBorder;



@end
@implementation CPBaseTextFileCell

-(instancetype)initWithFrame:(CGRect)frame andEntity:(CPBaseLabelCellModel*)entity withModel:(CPTEXEVIEMODEL) model {
    
    if (self= [super initWithFrame:frame]) {
        self.image.image = entity.image;
        self.pleceHolde = entity.pleceHolde;
        self.model = model;
        self.backgroundColor = [UIColor clearColor];
        self.image.image = entity.image;
        [self.image sizeToFit];
        
        self.textField.placeholder = entity.pleceHolde?entity.pleceHolde:@"";
        
//        [self addSubview:self.backImage];
        
        [self addSubview:self.bottomBorder];
        
        [self addSubview:self.TopBorder];
        
        [self addSubview:self.downBorder];
        
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


-(UIView *)TopBorder{
    if (!_TopBorder) {
        
        _TopBorder = [[GJCommonWidgetHelper sharedGJCommonWidgetHelper] createNormalBorderView];
        _TopBorder.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_TopBorder.po_frameBuilder setWidth:MainScreenWidth];
        _TopBorder.hidden = YES;
    }
    return _TopBorder;
}

-(UIView *)downBorder{
    if (!_downBorder) {
        
        _downBorder = [[GJCommonWidgetHelper sharedGJCommonWidgetHelper] createNormalBorderView];
        _downBorder.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_downBorder.po_frameBuilder setWidth:MainScreenWidth];
        _downBorder.hidden = YES;
    }
    return _downBorder;
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

-(void)setTextFontMunber:(int)number{
    self.textField.font = [UIFont systemFontOfSize:number];
}

-(UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _image;
}

-(void)setHiddenBottomBorder:(BOOL)hiddenBottomBorder
{
    self.bottomBorder.hidden = hiddenBottomBorder;
}

-(void)setHiddenTopBorder:(BOOL)hiddenTopBorder{
    self.TopBorder.hidden = hiddenTopBorder;
}

-(void)setHiddenDownBorder:(BOOL)hiddenDownBorder{
    self.downBorder.hidden = hiddenDownBorder;
}

-(void)layoutSubviews{
    
    [[[[self.image.po_frameBuilder alignLeftInSuperviewWithInset:8]setWidth:24]setHeight:21] centerVerticallyInSuperview];
    
    [[[[self.textField.po_frameBuilder alignRightOfView:self.image offset:3]setHeight:44]setWidth:(self.width-self.image.width)] centerVerticallyInSuperview];
    
    switch (_model) {
        case CPTEXEVIEWUP:
            [_bottomBorder.po_frameBuilder setHeight:0.5];
            [[_bottomBorder.po_frameBuilder alignToBottomInSuperviewWithInset:0]alignRightInSuperviewWithInset:0];
            self.backImage.image = [self getBackgroundImage:_model];
            self.TopBorder.hidden = NO;
            [[[self.TopBorder.po_frameBuilder setHeight:0.5] alignToTopInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
            
            break;
        case CPTEXEVIEWMIN:
            [_bottomBorder.po_frameBuilder setHeight:0.5];
            [[_bottomBorder.po_frameBuilder alignToBottomInSuperviewWithInset:0]alignRightInSuperviewWithInset:0];
            self.backImage.image = [self getBackgroundImage:_model];
            self.TopBorder.hidden = YES;
            self.downBorder.hidden = YES;
            
            break;
        case CPTEXEVIEWDOWN:
            
            self.backImage.image = [self getBackgroundImage:_model];
            self.bottomBorder.hidden = YES;
            self.TopBorder.hidden = YES;
            self.downBorder.hidden = NO;
            [[[self.downBorder.po_frameBuilder setHeight:0.5] alignToBottomInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];

            break;
        case CPTEXEVIEWONE:
            
            self.backImage.image = [self getBackgroundImage:_model];
            self.bottomBorder.hidden = YES;
            self.TopBorder.hidden = NO;
            [[[self.TopBorder.po_frameBuilder setHeight:0.5] alignToTopInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
            
            self.downBorder.hidden = NO;
            [[[self.downBorder.po_frameBuilder setHeight:0.5] alignToBottomInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
            
            break;
        case CPTEXEVIEWEMPTY:
            break;
        default:
            break;
    }
    
}

-(UIImage*)getBackgroundImage:(CPTEXEVIEMODEL)model{
    
//    UIImage * backGroundImage = [UIImage imageNamed:@"登陆注册输入框"];
    UIImage * backGroundImage = [UIImage imageNamed:@""];

    return [backGroundImage stretchableImageWithLeftCapWidth:backGroundImage.size.width/2 topCapHeight:backGroundImage.size.height/2];
    
}

-(NSString *)textString{
    return self.textField.text;
}


@end


@implementation CPBaseLabelCellModel



@end