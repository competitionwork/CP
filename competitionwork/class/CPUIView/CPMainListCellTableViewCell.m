//
//  CPMainListCellTableViewCell.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPMainListCellTableViewCell.h"
#import "UIView+POViewFrameBuilder.h"

/**
 * 间隙数据
 */
static CGFloat SpaceToLeft          = 8;    // 距离左侧边缘的空白距离
static CGFloat SpaceToRight         = 8;    // 距离右侧边缘的空白距离
static CGFloat imageWidth           = 80;   // 图片的宽度
static CGFloat imageHeight          = 60;   // 图片的高度
static CGFloat SpaceForLabel        = 8;    // Label之间间隔
static CGFloat SpaceForLabelAndIcon = 5;    // label和icon的间距

#define TitleFont           [UIFont systemFontOfSize:14]
#define GrayFont            [UIFont systemFontOfSize:12]
#define PriceFont           [UIFont systemFontOfSize:12]
#define TianLvFont          [UIFont systemFontOfSize:12]

@implementation CPMainListCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.backgroundColor = CPHighLightedColor;
        
        self.clipsToBounds = YES;
        
        self.left1Label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.left1Label.textAlignment = NSTextAlignmentLeft;
        self.left1Label.backgroundColor = [UIColor clearColor];
        self.left1Label.font = TitleFont;
        self.left1Label.textColor = TitleColor;
        [self.contentView addSubview:self.left1Label];
        
        self.left2Label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.left2Label.textAlignment = NSTextAlignmentLeft;
        self.left2Label.backgroundColor = [UIColor clearColor];
        self.left2Label.font = PriceFont;
        self.left2Label.textColor = TitleColor;
        [self.contentView addSubview:self.left2Label];
        
        
        self.left3Label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.left3Label.textAlignment = NSTextAlignmentLeft;
        self.left3Label.backgroundColor = [UIColor clearColor];
        self.left3Label.font = GrayFont;
        self.left3Label.textColor = GrayColor;
        [self.contentView addSubview:self.left3Label];
        
        self.left4Label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.left4Label.textAlignment = NSTextAlignmentLeft;
        self.left4Label.backgroundColor = [UIColor clearColor];
        self.left4Label.font = GrayFont;
        self.left4Label.textColor = GrayColor;
        [self.contentView addSubview:self.left4Label];
        
        self.attentionView = [[AttentionView alloc]initWithFrame:CGRectMake(0, 0, 64, 85)];
        [self.contentView addSubview:self.attentionView];
        
    }
    return self;
}

#pragma mark -
#pragma mark - 设置数据
- (void)setContent:(NSDictionary *)aContent {
    _content = aContent;
    _attentionView.content = _content[@"entiyDict"];
    [self setNeedsLayout];
}



-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)awakeFromNib
{
    // Initialization code
}


#pragma mark -
#pragma mark - layout subviews diffrent case
- (void)layoutSubviews {
    [super layoutSubviews];
    //默认隐藏
    [self hiddenSubviewDefault];
    [self layoutWitDefal];
    
}

-(void)layoutWitDefal{
    
    NSString *labelText = nil;
    
    [[[_left1Label.po_frameBuilder setSizeWithWidth:150 height:20] alignLeftInSuperviewWithInset:SpaceToLeft] setY:[self spaceToTop:_content]-4];
    _left1Label.text = [_content objectForKey:@"left1"];
    
    labelText = _content[@"left2"];
    [[[[_left2Label.po_frameBuilder setHeight:16] setWidth:[self widthForLabel:_left2Label withText:labelText]] alignLeftInSuperviewWithInset:SpaceToLeft] setY:[self yForLabelOfLine2:_content]];
    _left2Label.text = labelText;
    
    labelText = _content[@"left3"];
    CGFloat width3 = [self widthForLabel:_left3Label withText:[_content objectForKey:@"left3"]];
    _left3Label.text = labelText;
    [[[_left3Label.po_frameBuilder setSizeWithWidth:width3 height:16] alignLeftInSuperviewWithInset:SpaceToLeft] setY:[self yForLabelOfLine3:_content]];
    
    labelText = _content[@"left4"];
    CGFloat width4 = [self widthForLabel:_left4Label withText:[_content objectForKey:@"left4"]];
    _left4Label.text = labelText;
    [[[_left4Label.po_frameBuilder setSizeWithWidth:width4 height:16] alignLeftInSuperviewWithInset:SpaceToLeft] setY:[self yForLabelOfLine3:_content] +20];
        
    [_attentionView.po_frameBuilder alignRightInSuperviewWithInset:SpaceToRight];

}

- (void)hiddenSubviewDefault {
}

#pragma mark -
#pragma mark - 判断每一行的y坐标
// 第二行label的y
- (CGFloat)yForLabelOfLine2:(NSDictionary *)aContent {
    CGFloat y = 35;
    return y;
}

// 第三行label的y
- (CGFloat)yForLabelOfLine3:(NSDictionary *)aContent {
    CGFloat y = 57;
    return y;
}

// title的最大宽度
- (CGFloat)remainWidthForLeft1Label:(NSDictionary *)aContent {
    CGFloat remainWidth = 320 - SpaceToLeft - SpaceToRight;
    return remainWidth;
}

- (CGFloat)widthForLabel:(UILabel *)label withText:(NSString *)text {
    CGSize size = [text sizeWithFont:label.font constrainedToSize:(CGSize){CGFLOAT_MAX,CGRectGetHeight(label.frame)} lineBreakMode:label.lineBreakMode];
    return size.width;
}

#pragma mark -
#pragma mark - 计算距离
// 根据大类Id判断标题行距离顶部的距离
- (CGFloat)spaceToTop:(NSDictionary *)aContent {
    CGFloat space = 12.5;

    return space;
}

// 根据大类Id判断距离底部的距离
- (CGFloat)spaceToBottom:(NSDictionary *)aContent {
    CGFloat space = 14.0;
    return space;
}

@end
