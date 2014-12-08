//
//  CPPersonalTableViewCell.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#define kLeftZoneWidth              80
#define kOffsetX_RightZone          14 // 左区域相对于左区域maxX的偏移值


#import "CPPersonalTableViewCell.h"
#import "CPUtil.h"
#import "GJChooseButton.h"
#import "GJCommonWidgetHelper.h"

@interface CPPersonalTableViewCell ()

@property (nonatomic,strong) GJChooseButton *chooseBtn ;

@property(nonatomic) UIView *bottomBorder;

@property (nonatomic,strong) UIView *TopBorder;

@property (nonatomic,strong) UIView *downBorder;


@end

@implementation CPPersonalTableViewCell
/*
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.width = MainScreenWidth;
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * backImage = [[UIImageView alloc]initWithFrame:self.bounds];
        UIImage * bimage = [UIImage imageNamed:@"登陆注册输入框"];
        backImage.image = [bimage stretchableImageWithLeftCapWidth:bimage.size.width/2 topCapHeight:bimage.size.height/2];
        [self.contentView addSubview:backImage];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, kLeftZoneWidth, 43)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithRed:85 / 255.0 green:187 / 255.0 blue:34 / 255.0 alpha:1.0];
        self.detailTextLabel.textColor = self.detailTextLabel.highlightedTextColor = [UIColor colorWithRed:0x33 / 255.0 green:0x33 / 255. blue:0x33 / 255. alpha:1.0];
        _titleLabel.tag = 112120;
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        _textInput = [[UILabel alloc]initWithFrame:CGRectMake(kLeftZoneWidth + kOffsetX_RightZone, (self.frame.size.height - 20) / 2, 180, 20)];
        _textInput.tag = 3000;
        _textInput.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textInput.font = [UIFont systemFontOfSize:13];
        _textInput.textAlignment = NSTextAlignmentLeft;
        _textInput.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_textInput];
        self.chooseBtn = [GJChooseButton buttonWithType:UIButtonTypeCustom];
        self.chooseBtn.exclusiveTouch = YES;
        [self.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.chooseBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        
        UIImage     *grayArrow = [CPUtil getRightGrayArrowImage];
        UIImageView *indicator = [[UIImageView alloc] initWithImage:grayArrow];
        UIView      *buttonBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, 13, 0.5, 20)];
        [self.chooseBtn addSubview:buttonBorderView];
        self.chooseBtn.tag = NSIntegerMax - 1;
        self.chooseBtn.frame = CGRectMake(81, 0.5, self.width - 81.5, 45);
        indicator.frame = CGRectMake(MainScreenWidth - 18.5, 16.5, grayArrow.size.width, grayArrow.size.height);
        [self.chooseBtn setStyles];
        
        [buttonBorderView removeFromSuperview];
        [self.contentView addSubview:self.chooseBtn];
        [self.contentView addSubview:indicator];
        // shu line
        UIImageView *shuLine = [[UIImageView alloc] initWithFrame:(CGRect) {81, 13, 0.5, 20}];
        shuLine.backgroundColor = GJColor(216, 216, 216, 1);
        [self.contentView addSubview:shuLine];
        // line
        UIImageView *line = [[UIImageView alloc] initWithFrame:(CGRect) {13, 46 - 0.5, MainScreenWidth - 13, 0.5}];
        line.backgroundColor = GJColor(216, 216, 216, 1);
        [self.contentView addSubview:line];
        
    }
    return self;
}
*/
-(void)chooseBtnAction:(id)sender{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bottomBorder];
        
        [self.contentView addSubview:self.TopBorder];
        
        [self.contentView addSubview:self.downBorder];
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
        self.selectedBackgroundView.backgroundColor=RGBCOLOR(229, 229, 229);
        
        [self creatTheUI];
    }
    return self;
}

-(UIView *)bottomBorder
{
    if (!_bottomBorder) {
        _bottomBorder = [[GJCommonWidgetHelper sharedGJCommonWidgetHelper] createNormalBorderView];
        _bottomBorder.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_bottomBorder.po_frameBuilder setWidth:MainScreenWidth - 16];
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

-(void)creatTheUI{
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, kLeftZoneWidth, 43)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = kCPBlueColor;
    self.detailTextLabel.textColor = self.detailTextLabel.highlightedTextColor = [UIColor blackColor];
    _titleLabel.tag = 112120;
    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
    _textInput = [[UILabel alloc]initWithFrame:CGRectMake(kLeftZoneWidth + kOffsetX_RightZone, (self.frame.size.height - 20) / 2, 180, 20)];
    _textInput.tag = 3000;
    _textInput.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textInput.font = [UIFont systemFontOfSize:13];
    _textInput.textAlignment = NSTextAlignmentLeft;
    _textInput.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_textInput];
    
    UIImage     *grayArrow = [CPUtil getRightGrayArrowImage];
    UIImageView *indicator = [[UIImageView alloc] initWithImage:grayArrow];
    indicator.frame = CGRectMake(MainScreenWidth - 18.5, 16.5, grayArrow.size.width, grayArrow.size.height);
    [self.contentView addSubview:indicator];

    /*
    self.chooseBtn = [GJChooseButton buttonWithType:UIButtonTypeCustom];
    self.chooseBtn.exclusiveTouch = YES;
    [self.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.chooseBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    UIImage     *grayArrow = [CPUtil getRightGrayArrowImage];
    UIImageView *indicator = [[UIImageView alloc] initWithImage:grayArrow];
    UIView      *buttonBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, 13, 0.5, 20)];
    [self.chooseBtn addSubview:buttonBorderView];
    self.chooseBtn.tag = NSIntegerMax - 1;
    self.chooseBtn.frame = CGRectMake(81, 0.5, self.width - 81.5, 45);
    indicator.frame = CGRectMake(MainScreenWidth - 18.5, 16.5, grayArrow.size.width, grayArrow.size.height);
    [self.chooseBtn setStyles];
    
    [buttonBorderView removeFromSuperview];
    [self.contentView addSubview:self.chooseBtn];
    [self.contentView addSubview:indicator];
    // shu line
    UIImageView *shuLine = [[UIImageView alloc] initWithFrame:(CGRect) {81, 13, 0.5, 20}];
    shuLine.backgroundColor = GJColor(216, 216, 216, 1);
    [self.contentView addSubview:shuLine];
     */
}
 // Configure the view for the selected state


@end
