//
//  GJFilterOptionListHotBrandCell.m
//  HouseRent
//
//  Created by liruiqin on 13-12-17.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJFilterOptionListHotBrandCell.h"
#import "UIImageView+AFNetworking.h"

#define kItemMargin 8
#define kLabelTag 987
#define kImageTag 789
#define kItemSize CGSizeMake(60, 80)
#define kItemImageSize CGSizeMake(60, 60)
#define kItemColumnCount 4

@interface GJFilterOptionListHotBrandCell ()

@property(nonatomic) NSMutableArray *items;


@end
@implementation GJFilterOptionListHotBrandCell

+(CGFloat)cellHeightForData:(id)data
{
    NSArray *arr=data;
    if (arr.count==0) {
        return 0.0;
    }
    NSInteger linesCount = ceilf(arr.count*1.0/kItemColumnCount);
    return linesCount * ( kItemSize.height + kItemMargin ) + kItemMargin * 2;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.items=[NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

-(UIView *)createItem
{
    UIView *contentView=[[UIView alloc] initWithFrame:CGRectZero];
    [contentView.po_frameBuilder setSize:kItemSize];
    contentView.backgroundColor=[UIColor clearColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [imgView.po_frameBuilder setSize:kItemImageSize];
    [contentView addSubview:imgView];
    imgView.tag=kImageTag;
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.layer.borderWidth = 0.5;
    imgView.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    label.textColor = [UIColor blackColor];
    [label.po_frameBuilder setWidth:MIN(label.frame.size.width, 65)];
    label.tag = kLabelTag;
    [contentView addSubview:label];
    [[label.po_frameBuilder alignToBottomInSuperviewWithInset:0] centerHorizontallyInSuperview];
    return contentView;
}

-(void)setNodes:(NSArray *)nodes
{
    _nodes = nodes;
    NSInteger lessCount=MAX(0,nodes.count-self.items.count);
    for (int idx = 0; idx <= lessCount; idx++) {
        [self.items addObject:[self createItem]];
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger lineCount = ceil(self.nodes.count / kItemColumnCount);
    
        for (NSInteger lineIdx = 0; lineIdx < lineCount; lineIdx++) {
            for (NSInteger columnIndex = 0; columnIndex < kItemColumnCount; columnIndex++) {
                NSInteger index = lineIdx * kItemColumnCount + columnIndex;
                GJOptionNode *node=self.nodes[index];
                UIView *contentView=self.items[index];
                UIImageView *imgView=(UIImageView *)[contentView viewWithTag:kImageTag];
                UILabel *label = (UILabel *)[contentView viewWithTag:kLabelTag];
                [imgView setImageWithURL:[NSURL URLWithString:node.userInfo[@"image"]]];
                label.text=node.displayText;
                [label sizeToFit];
                [[label.po_frameBuilder alignToBottomInSuperviewWithInset:0] centerHorizontallyInSuperview];
                [self addSubview:contentView];
                [contentView.po_frameBuilder alignLeftInSuperviewWithInset:kItemMargin+ kItemMargin * columnIndex + (kItemSize.width * columnIndex)];
                [contentView.po_frameBuilder alignToTopInSuperviewWithInset:kItemMargin + kItemMargin * lineIdx + (kItemSize.height * lineIdx)];
                contentView.tag=index;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
                [contentView addGestureRecognizer:tap];
            }
        }
}

- (void)itemClick:(UITapGestureRecognizer *)tap
{
    if (self.didSelectedNode) {
        self.didSelectedNode(self.nodes[tap.view.tag]);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
