//
//  GJListTagView.m
//  HouseRent
//
//  Created by Tracy on 14-4-4.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJListTagView.h"
#import "UIView+Addition.h"

#define TagColor    GJColor(38,38,38,1)
#define TagFont     [UIFont systemFontOfSize:12]
#define SpageForTag 4

static NSInteger imageViewTag = 100;
static NSInteger textLabelTag = 1010;

@implementation GJListTagView

- (id)init {
    self = [super init];
    if (self) {
        [self initTagView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initTagView];
    }
    return self;
}

- (void)initTagView {
    self.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < 10; i ++) {
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        backImageView.tag = imageViewTag + i;
        [self addSubview:backImageView];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.textAlignment = UITextAlignmentCenter;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = TagFont;
        textLabel.textColor = TagColor;
        textLabel.tag = textLabelTag + i;
        [self addSubview:textLabel];
    }
}

- (void)setPageType:(GJData_Type)aPageType {
    _pageType = aPageType;
    [self setNeedsLayout];
}

- (void)setLabelsData:(NSArray *)aLabelsData {
    _labelsData = aLabelsData;
    [self setNeedsLayout];
}

//showPage            =>  展示页面,（0：列表、详情页都展示，1：仅列表页展 示,2：仅详情页展示）
- (BOOL)factorForType:(int)showPage {
    if (_pageType == GJData_Detail) {
        return showPage == 0 || showPage == 2;
    } else {
        return showPage == 0 || showPage == 1;
    }
}

- (void)resetSubviews {
    for (int i = 0; i < 10; i ++) {
        UIImageView *backImageView = (UIImageView *)[self viewWithTag:imageViewTag + i];
        backImageView.hidden = YES;
        UILabel *textLabel = (UILabel *)[self viewWithTag:textLabelTag + i];
        textLabel.hidden = YES;
    }
}

/*
 text                =>  标签名字 (string)
 bgcolorIndex        =>  对应客户端背景图颜色值 (int)
 showPage            =>  展示页面,（0：列表、详情页都展示，1：仅列表页展 示,2：仅详情页展示）
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    [self resetSubviews];
    int x = 0;
    for (int i = 0; i < _labelsData.count; i ++) {
        NSDictionary *dict = [_labelsData objectAtIndex:i];
        NSString *text = [dict[@"text"] description];
        int bgcolorIndex = [dict[@"bgcolorIndex"] intValue];
        int showPage = [dict[@"showPage"] intValue];
        if ([self factorForType:showPage]) {
            CGFloat labelWidth = [self widthForTag:text];
            NSString *imageName = [NSString stringWithFormat:@"tag_index_%d",bgcolorIndex];
            UIImage *image = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:7 topCapHeight:7];
            UIImageView *backImageView = (UIImageView *)[self viewWithTag:imageViewTag + i];
            backImageView.hidden = NO;
            [backImageView setImage:image];
            backImageView.frame = (CGRect){x,0,labelWidth,14};
            UILabel *textLabel = (UILabel *)[self viewWithTag:textLabelTag + i];
            textLabel.hidden = NO;
            textLabel.frame = (CGRect){x,0,labelWidth,14};
            textLabel.textAlignment = UITextAlignmentCenter;
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.font = TagFont;
            textLabel.textColor = TagColor;
            textLabel.text = text;
            x += labelWidth+SpageForTag;
        }
    }
    
    [self setSize:CGSizeMake(x-SpageForTag,16)];
    
}

- (CGFloat)widthForTag:(NSString *)text {
    CGSize size = [text sizeWithFont:TagFont constrainedToSize:(CGSize){CGFLOAT_MAX,16}];
    return size.width+3;
}

// 列表标签页宽度
+ (CGFloat)widthForListData:(NSArray *)labelData {
    int x = 0;
    for (int i = 0; i < labelData.count; i ++) {
        NSDictionary *dict = [labelData objectAtIndex:i];
        NSString *text = [dict[@"text"] description];
        int showPage = [dict[@"showPage"] intValue];
        if (showPage == 0 || showPage == 1) {
            CGFloat labelWidth = [text sizeWithFont:TagFont constrainedToSize:(CGSize){CGFLOAT_MAX,16}].width+3;
            x += labelWidth+SpageForTag;
        }
    }
    return x-SpageForTag;
}

// 详情标签页宽度
+ (CGFloat)widthForDetailData:(NSArray *)labelData {
    int x = 0;
    for (int i = 0; i < labelData.count; i ++) {
        NSDictionary *dict = [labelData objectAtIndex:i];
        NSString *text = [dict[@"text"] description];
        int showPage = [dict[@"showPage"] intValue];
        if (showPage == 0 || showPage == 2) {
            CGFloat labelWidth = [text sizeWithFont:TagFont constrainedToSize:(CGSize){CGFLOAT_MAX,16}].width+3;
            x += labelWidth+SpageForTag;
        }
    }
    return x-SpageForTag;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
