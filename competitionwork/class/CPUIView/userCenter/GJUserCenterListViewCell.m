//
//  GJUserCenterListViewCell.m
//  HouseRent
//
//  Created by liruiqin on 14-2-28.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJUserCenterListViewCell.h"
#import "GJCommonWidgetHelper.h"

@interface GJUserCenterListViewCell ()

@property(nonatomic) UIView *bottomBorder;

@property (nonatomic,strong) UIView *TopBorder;

@property (nonatomic,strong) UIView *downBorder;

@end
@implementation GJUserCenterListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bottomBorder];
        
        [self.contentView addSubview:self.TopBorder];
        
        [self.contentView addSubview:self.downBorder];
        
        self.selectedBackgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        self.selectedBackgroundView.backgroundColor=RGBCOLOR(229, 229, 229);
    }
    return self;
}

-(UIView *)bottomBorder
{
    if (!_bottomBorder) {
        _bottomBorder = [[GJCommonWidgetHelper sharedGJCommonWidgetHelper] createNormalBorderView];
        _bottomBorder.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_bottomBorder.po_frameBuilder setWidth:MainScreenWidth - 54];
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
}

-(void)setHiddenTopBorder:(BOOL)hiddenTopBorder{
    self.TopBorder.hidden = hiddenTopBorder;
}

-(void)setHiddenDownBorder:(BOOL)hiddenDownBorder{
    self.downBorder.hidden = hiddenDownBorder;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView bringSubviewToFront:self.bottomBorder];
    [self.contentView bringSubviewToFront:self.TopBorder];
    
    [[[self.bottomBorder.po_frameBuilder setHeight:0.5] alignToTopInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    
    [[[self.bottomBorder.po_frameBuilder setHeight:0.5] alignToBottomInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    
    [[[self.downBorder.po_frameBuilder setHeight:0.5] alignToBottomInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    [[[self.imageView.po_frameBuilder setSizeWithWidth:59 height:46] alignLeftInSuperviewWithInset:0] alignToTopInSuperviewWithInset:0];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.textLabel.po_frameBuilder alignLeftInSuperviewWithInset:54];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = RGBCOLOR(39, 39, 39);
    self.textLabel.highlightedTextColor = self.textLabel.textColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
