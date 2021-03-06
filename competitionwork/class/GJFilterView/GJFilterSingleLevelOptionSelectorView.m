//
//  GJFilterSingleLevelOptionSelectorView.m
//  HouseRent
//
//  Created by liruiqin on 13-12-3.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJFilterSingleLevelOptionSelectorView.h"

@interface GJFilterSingleLevelOptionSelectorView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) NSArray *_nodes;
@property(nonatomic,weak) id<GJFilterOptionListSelectorDelegate> _optionListDelegate;

@end
@implementation GJFilterSingleLevelOptionSelectorView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.backgroundColor=GJColor(250, 250, 250, 1);
    }
    return self;
}
-(NSArray *)nodes
{
    return self._nodes;
}
-(void)setNodes:(NSArray *)nodes
{
    self._nodes=nodes;
    [self reloadData];
}
-(void)setOptionListSelectorDelegate:(id<GJFilterOptionListSelectorDelegate>)optionListSelectorDelegate
{
    self._optionListDelegate=optionListSelectorDelegate;
}
-(id<GJFilterOptionListSelectorDelegate>)optionListSelectorDelegate
{
    return self._optionListDelegate;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GJOptionNode *node=self.nodes[indexPath.row];
    
    static NSString *identifier = @"cellStyle1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        // 快捷白按钮.png
        // 快捷灰按钮.png
        UIImageView *normalView = [[UIImageView alloc] initWithFrame:cell.bounds];
        UIImage *image = [UIImage imageNamed:@"快捷白按钮.png"];
        normalView.image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:43/2];
        
        UIImageView *selectView = [[UIImageView alloc] initWithFrame:cell.bounds];
        image = [UIImage imageNamed:@"快速筛选A.png"];
        selectView.image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:43/2];
        
        cell.backgroundView = normalView;
        cell.selectedBackgroundView = selectView;
        
        CGFloat x = 20;

        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, cell.bounds.size.width-x-10, cell.bounds.size.height-2)];
        lbl.font = [UIFont systemFontOfSize:14.0f];
        lbl.backgroundColor = [UIColor clearColor];
        //lbl.highlightedTextColor = [UIColor colorWithRed:0x40/255.0 green:0x40/255.0 blue:0x40/255.0 alpha:1.0f];
        lbl.textColor = [UIColor colorWithRed:0x40/255.0 green:0x40/255.0 blue:0x40/255.0 alpha:1.0f];
        lbl.tag = 999;
        [cell.contentView addSubview:lbl];
        
        //cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
        //cell.detailTextLabel.textColor = [UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1.0f];
        //cell.detailTextLabel.highlightedTextColor = [UIColor blackColor];
    }
    
    UILabel *labelText=(UILabel *)[cell.contentView viewWithTag:999];
    labelText.text=node.displayText;
    if (node.isSelected) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }

    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nodes.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.nodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setSelected:NO];
    }];
    [self.nodes[indexPath.row] setSelected:YES];
    if ([self.optionListSelectorDelegate respondsToSelector:@selector(filterOptionListSelector:didSelectNode:)]) {
        [self.optionListSelectorDelegate filterOptionListSelector:self didSelectNode:self.nodes[indexPath.row]];
    }
}
@end
