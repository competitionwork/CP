//
//  CPBaseCell.m
//  competitionwork
//
//  Created by hjj on 14-12-11.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseCell.h"
#import "GJCommonWidgetHelper.h"

@interface CPBaseCell ()

@property (nonatomic, strong) UIView* bottomBorder;

@property (nonatomic,strong) UIView *TopBorder;

@property (nonatomic,strong) UIView *downBorder;


@end

@implementation CPBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.bottomBorder];
        
        [self addSubview:self.TopBorder];
        
        [self addSubview:self.downBorder];
    }
    return self;
}

-(void)awakeFromNib{
    
    [self addSubview:self.bottomBorder];
    
    [self addSubview:self.TopBorder];
    
    [self addSubview:self.downBorder];
}


-(UIView *)bottomBorder{
    
    if (!_bottomBorder) {
        _bottomBorder = [[GJCommonWidgetHelper sharedGJCommonWidgetHelper]createNormalBorderView];
        _bottomBorder.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin;
        [_bottomBorder.po_frameBuilder setWidth:MainScreenWidth - 8];
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

-(void)setHiddenBottomBorder:(BOOL)hiddenBottomBorder
{
    self.bottomBorder.hidden = hiddenBottomBorder;
    self.downBorder.hidden = !hiddenBottomBorder;

}

-(void)setHiddenTopBorder:(BOOL)hiddenTopBorder{
    self.TopBorder.hidden = hiddenTopBorder;

}

-(void)setHiddenDownBorder:(BOOL)hiddenDownBorder{
    self.downBorder.hidden = hiddenDownBorder;
    self.bottomBorder.hidden = !hiddenDownBorder;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView bringSubviewToFront:self.bottomBorder];
    [self.contentView bringSubviewToFront:self.TopBorder];
    [self.contentView bringSubviewToFront:self.downBorder];

    
    [[[self.TopBorder.po_frameBuilder setHeight:0.5] alignToTopInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    
    [[[self.bottomBorder.po_frameBuilder setHeight:0.5] alignToBottomInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    
    [[[self.downBorder.po_frameBuilder setHeight:0.5] alignToBottomInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    
  
}


@end
