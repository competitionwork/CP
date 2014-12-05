//
//  GJListMoreCell.m
//  HouseRent
//
//  Created by Tracy on 14-4-22.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJListMoreCell.h"
#import "UIImageView+xiaolvAnimation.h"


#define CellSelectGetMoreInfoTip      @"获取更多信息"
#define CellIsLoadingString           @"努力加载中..."

@interface GJListMoreCell() {

}
// 动态小驴图
@property (nonatomic) UIImageView *animationView;

// 加载信息
@property (nonatomic) UILabel *messageLabel;
@end

@implementation GJListMoreCell

- (void)dealloc {
    self.animationView = nil;
    self.messageLabel = nil;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIView alloc] initWithFrame:(CGRect){0,0,MainScreenWidth,100}];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.frame = self.backgroundView.bounds;
        self.contentView.frame = self.backgroundView.bounds;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:(CGRect){0,0,MainScreenWidth,100}];
        self.selectedBackgroundView.backgroundColor = kButtonHightLightColor;
        
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        self.animationView = [UIImageView listViewRefreshAnimation];
        [self.contentView addSubview:_animationView];
        
        
        //message
        self.messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.textColor = GJColor(128, 128, 128, 1);
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.size = (CGSize){100,16};
        _messageLabel.text = CellSelectGetMoreInfoTip;
        _messageLabel.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_messageLabel];
        
    }
    return self;
}

- (void)setAnimationing:(BOOL)aAnimationing {
    _animationing = aAnimationing;
    [self setNeedsLayout];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [[[_animationView.po_frameBuilder centerInSuperview] setX:70 + (MainScreenWidth - 320) / 2] centerVerticallyInSuperview]; // 原seX＝70
    [[_messageLabel.po_frameBuilder centerInSuperview] alignRightOfView:_animationView offset:8];
    _messageLabel.bottom = _animationView.bottom-2;
    if (_animationing) {
        [_animationView startAnimating];
        _messageLabel.text = CellIsLoadingString;
    } else {
        [_animationView stopAnimating];
        _messageLabel.text = CellSelectGetMoreInfoTip;
    }
}

+ (CGFloat)heightForMoreCell:(NSInteger)masterId majorId:(NSInteger)majorId {
    CGFloat height = 100;
    return height;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
