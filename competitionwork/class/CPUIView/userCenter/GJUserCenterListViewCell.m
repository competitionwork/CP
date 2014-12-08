//
//  GJUserCenterListViewCell.m
//  HouseRent
//
//  Created by liruiqin on 14-2-28.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJUserCenterListViewCell.h"
#import "GJCommonWidgetHelper.h"
#import "CPUtil.h"

@interface GJUserCenterListViewCell ()

@property(nonatomic) UIView *bottomBorder;

@property (nonatomic,strong) UIView *TopBorder;

@property (nonatomic,strong) UIView *downBorder;

@property (nonatomic,strong) UIImageView *arrowImage;

@end
@implementation GJUserCenterListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bottomBorder];
        
        [self.contentView addSubview:self.TopBorder];
        
        [self.contentView addSubview:self.downBorder];
        
        [self.contentView addSubview:self.arrowImage];
        
        [self.contentView addSubview:self.leftImageView];
        
        [self.contentView addSubview:self.titleLabel];
        
        self.selectedBackgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
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

-(UIImageView *)arrowImage{
    if (!_arrowImage) {
        UIImage * arrow = [CPUtil getRightGrayArrowImage];
        _arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, arrow.size.width, arrow.size.height)];
        _arrowImage.image = arrow;
    }
    return _arrowImage;
}

-(UIImageView *)leftImageView{
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
//        _leftImageView.contentMode = UIViewContentModeCenter;
        
    }
    return _leftImageView;
    
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = RGBCOLOR(39, 39, 39);
        _titleLabel.highlightedTextColor = _titleLabel.textColor;
    }
    return _titleLabel;
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
    
    [[[self.TopBorder.po_frameBuilder setHeight:0.5] alignToTopInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    
    [[[self.bottomBorder.po_frameBuilder setHeight:0.5] alignToBottomInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    
    [[[self.downBorder.po_frameBuilder setHeight:0.5] alignToBottomInSuperviewWithInset:0] alignRightInSuperviewWithInset:0];
    
    [[[[self.leftImageView.po_frameBuilder setSizeWithWidth:30 height:29] alignLeftInSuperviewWithInset:8] alignToTopInSuperviewWithInset:0]centerVerticallyInSuperview];
    
    [[[[self.titleLabel.po_frameBuilder setHeight:24] setWidth:150] alignLeftInSuperviewWithInset:54]centerVerticallyInSuperview];

    
    [[self.arrowImage.po_frameBuilder alignRightInSuperviewWithInset:20]centerVerticallyInSuperview];
}

+ (CGFloat)heightForRow{
    return 60;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}



@end
