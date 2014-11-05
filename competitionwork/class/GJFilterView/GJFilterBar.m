//
//  GJFilterBar.m
//  HouseRent
//
//  Created by liruiqin on 13-11-27.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJFilterBar.h"
#import "UIView+borders.h"

#define kMoreButtonWidth 50.0

@interface GJFilterBar ()
@property(atomic) NSMutableArray *items;
@property(nonatomic) GJFilterBarItem *moreItem;
@property(nonatomic) NSInteger countOfItems;

@end
@implementation GJFilterBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"标签平铺.png"]];
        backImageView.frame = CGRectMake(0, 0, 320, 40);
        [self addSubview:backImageView];
        
        _items=[NSMutableArray arrayWithCapacity:5];
        _moreItem=[[GJFilterBarItem alloc] initWithDefaultStyle];
        [_moreItem.textButton setTitle:@"筛选" forState:UIControlStateNormal];
        [_moreItem.po_frameBuilder setSizeWithWidth:kMoreButtonWidth height:self.frame.size.height];
        [_moreItem.textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _moreItem.textButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _moreItem.textButton.titleLabel.backgroundColor = [UIColor clearColor];
        _moreItem.textButton.titleLabel.textColor = [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0f];
        [_moreItem.textButton addTarget:self action:@selector(moreItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_moreItem.textButton setBackgroundImage:[UIImage imageNamed:@"点击灰色.png" withCapWidth:0.5 withCapHeight:20] forState:UIControlStateHighlighted];

        [self addSubview:_moreItem];
        _moreItem.hidden=_hideMoreItem;
    }
    return self;
}
-(GJFilterBarItem *)filterBarItemAtIndex:(NSInteger)index
{
    if (index>=self.items.count) {
        return nil;
    }
    return self.items[index];
}
-(void)reloadFilterData
{
    DLog(@"");
    [self.items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.items removeAllObjects];
    self.countOfItems=[self.datasource filterBarItemCount:self];
    for (int idx=0; idx<self.countOfItems; idx++) {
        GJFilterBarItem *item=(GJFilterBarItem*)[self.datasource filterBar:self barItemViewAtIndex:idx];
        [self.items addObject:item];
        [self addSubview:item];
        [item.textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        item.textButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        item.textButton.titleLabel.backgroundColor = [UIColor clearColor];
        item.textButton.titleLabel.textColor = [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0f];
        item.textButton.titleEdgeInsets=UIEdgeInsetsMake(0, 11, 0, 12);
        item.textButton.titleLabel.lineBreakMode=UILineBreakModeTailTruncation;
        [item.textButton addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        item.tag=idx;
        item.textButton.tag=idx;
        [item.textButton setBackgroundImage:[UIImage imageNamed:@"点击灰色.png" withCapWidth:0.5 withCapHeight:20] forState:UIControlStateHighlighted];

        UIImageView *iView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 12, 10)];
        iView.image = [UIImage imageNamed:@"标签箭头"];
        [item.textButton.titleLabel addSubview:iView];
        [[iView.po_frameBuilder centerVerticallyInSuperview] alignRightInSuperviewWithInset:-12];
        iView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
        item.textButton.titleLabel.clipsToBounds=NO;
    }
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.countOfItems) {
        
        CGFloat itemBarViewWidth=self.hideMoreItem?self.frame.size.width:self.frame.size.width-kMoreButtonWidth;
        CGFloat itemWidth=itemBarViewWidth/self.countOfItems;
        [self.items enumerateObjectsUsingBlock:^(GJFilterBarItem* item, NSUInteger idx, BOOL *stop) {
            /*
            [self addSubview:item];
            [item.textButton addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.tag=idx;
            item.textButton.tag=idx;
            */
            [[item.po_frameBuilder setWidth:itemWidth] alignLeftInSuperviewWithInset:itemWidth*idx];
            [item setBorderWithColor:RGBCOLOR(204, 204, 204) borderSize:CGSizeMake(24, 0.5) in:UIViewBorderPositionRight];
        }];
        [self.moreItem.po_frameBuilder alignRightInSuperviewWithInset:0];
        self.moreItem.hidden=self.hideMoreItem;
    }
}
-(void)itemClick:(UIButton*)button
{
    DLog(@"%d",button.tag);
    if ([self.delegate respondsToSelector:@selector(filterBar:barItemDidClickAtIndex:)]) {
        [self.delegate filterBar:self barItemDidClickAtIndex:button.tag];
    }
}

-(void)moreItemClick:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(filterBarMoreItemDidClick:)]) {
        [self.delegate filterBarMoreItemDidClick:self];
    }
}
@end
