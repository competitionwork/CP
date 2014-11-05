//
//  GJFilterMultilevelOptionSelectorView.m
//  GJFilterView_DEMO
//
//  Created by liruiqin on 13-12-4.
//  Copyright (c) 2013年 ruiq. All rights reserved.
//

#import "GJFilterMultilevelOptionSelectorView.h"

@interface GJFilterMultilevelOptionSelectorView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) NSArray *_nodes;
@property(nonatomic,weak) id<GJFilterOptionListSelectorDelegate> _optionListDelegate;

@property(nonatomic) UITableView *leftOptionList;
@property(nonatomic) UITableView *rightOptionList;
@property(nonatomic,weak) GJOptionNode *selectedLeftNode;
@property(nonatomic,weak) GJOptionNode *lastLeftNode;
@property(nonatomic) NSInteger selectedLeftOptionIndex;

@end
@implementation GJFilterMultilevelOptionSelectorView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.leftOptionList=[[UITableView alloc] initWithFrame:CGRectZero];
        self.rightOptionList=[[UITableView alloc] initWithFrame:CGRectZero];
        
        self.leftOptionList.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.rightOptionList.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        self.leftOptionList.backgroundColor=GJColor(250, 250, 250, 1);
        self.rightOptionList.backgroundColor=GJColor(242, 242, 242, 1);
        
//        self.leftOptionList.allowsMultipleSelection=YES;
        [self addSubview:self.leftOptionList];
        [self addSubview:self.rightOptionList];
        
        self.leftOptionList.delegate=self;
        self.leftOptionList.dataSource=self;
        
        self.rightOptionList.delegate=self;
        self.rightOptionList.dataSource=self;
        
        [self.leftOptionList.po_frameBuilder setSizeWithWidth:frame.size.width/2.0 height:frame.size.height];
        [[self.rightOptionList.po_frameBuilder setSizeWithWidth:frame.size.width/2.0 height:frame.size.height] alignRightOfView:self.leftOptionList offset:0];
    }
    return self;
}

-(void)setNodes:(NSArray *)nodes
{
    self._nodes=nodes;
    if (self._nodes.count > 0) {
        NSInteger leftRowIndex=0;
        NSInteger rightRowIndex=0;
        for (NSInteger idx = 0; idx<self._nodes.count; idx++) {
            GJOptionNode *node=self._nodes[idx];
            if (node.isSelected) {
                self.selectedLeftOptionIndex = idx;
                self.selectedLeftNode=node;
                self.lastLeftNode=node;
                if (self.selectedLeftNode.subNodes.count == 1) { // 判断是否选的是类似全北京这种只有一个子node的对象
                    GJOptionNode *subNode=self.selectedLeftNode.subNodes.lastObject;
                    subNode.selected = YES;
                    rightRowIndex=0;
                    leftRowIndex=idx;
                    break;
                }
                else {
                    for (NSInteger subIdx = 0; subIdx<self._nodes.count; subIdx++) {
                        if (subIdx < self.selectedLeftNode.subNodes.count) {
                            GJOptionNode *subNode=self.selectedLeftNode.subNodes[subIdx];
                            if (subNode.isSelected) {
                                rightRowIndex=subIdx;
                                leftRowIndex=idx;
                                break;
                            }
                        }
                    }
                }
            }
        }
        [self.leftOptionList reloadData];
        [self.rightOptionList reloadData];
        [self.rightOptionList layoutIfNeeded];
        [self.leftOptionList layoutIfNeeded];
        if (!self.selectedLeftNode || !self.lastLeftNode) {
            self.selectedLeftNode=self._nodes[0];
            self.lastLeftNode=self._nodes[0];
        }
        DLog(@"left node:%@",self.nodes[leftRowIndex]);
        DLog(@"right nodes:%@",self.selectedLeftNode.subNodes[rightRowIndex]);
        [self.rightOptionList reloadData];
        NSIndexPath *leftPath=[NSIndexPath indexPathForRow:leftRowIndex inSection:0];
        NSIndexPath *rightPath=[NSIndexPath indexPathForRow:rightRowIndex inSection:0];
        [self.leftOptionList selectRowAtIndexPath:leftPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self.rightOptionList selectRowAtIndexPath:rightPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }

}
-(NSArray *)nodes
{
    return self._nodes;
}
-(void)setOptionListSelectorDelegate:(id<GJFilterOptionListSelectorDelegate>)optionListSelectorDelegate
{
    self._optionListDelegate=optionListSelectorDelegate;
}
-(id<GJFilterOptionListSelectorDelegate>)optionListSelectorDelegate
{
    return self._optionListDelegate;
}
-(GJOptionNode*)nodeForTable:(UITableView*)tableview andIndex:(NSInteger)index
{
    if (tableview==self.leftOptionList) {
        return self.nodes[index];
    }
    else
    {
        return self.selectedLeftNode.subNodes[index];
    }
}
#pragma mark - table view methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=nil;
    GJOptionNode *node=[self nodeForTable:tableView andIndex:indexPath.row];
    if (tableView==self.leftOptionList) {
        static NSString *identifier = @"cellStyle1";
         cell= [tableView dequeueReusableCellWithIdentifier:identifier];
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
            
            CGFloat x = 25;
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, cell.bounds.size.width-x-10, cell.bounds.size.height-2)];
            lbl.font = [UIFont systemFontOfSize:15.0f];
            lbl.backgroundColor = [UIColor clearColor];
            //lbl.highlightedTextColor = [UIColor colorWithRed:0x40/255.0 green:0x40/255.0 blue:0x40/255.0 alpha:1.0f];
            lbl.textColor = [UIColor colorWithRed:0x40/255.0 green:0x40/255.0 blue:0x40/255.0 alpha:1.0f];
            lbl.tag = 999;
            [cell.contentView addSubview:lbl];
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            [cell.contentView addSubview:imgView];
            [[imgView.po_frameBuilder setSizeWithWidth:44 height:44] alignLeftInSuperviewWithInset:4];
            imgView.tag = 9898;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
        }
        UILabel *labelText=(UILabel *)[cell.contentView viewWithTag:999];
        labelText.text=node.displayText;
        
        if (indexPath.row == self.selectedLeftOptionIndex) {
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else
        {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        NSString *imgURL = node.userInfo[@"image"];
        UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:9898];
        if (imgURL.length > 0) {
//            [imgView setImageWithURL:[NSURL URLWithString:node.userInfo[@"image"]]];
            [imgView.po_frameBuilder setWidth:44];
            [labelText.po_frameBuilder alignRightOfView:imgView offset:4];
        }
        else {
            [imgView.po_frameBuilder setWidth:0];
            [labelText.po_frameBuilder alignLeftInSuperviewWithInset:10];
        }
        return cell;

    }
    else
    {
        static NSString *identifier = @"cellStyle2";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            UIView *aview = [[UIView alloc] initWithFrame:cell.bounds];
            aview.backgroundColor = [UIColor clearColor];
            UIImageView *selectView = [[UIImageView alloc] initWithFrame:(CGRect){0, 0, aview.frame.size.width, aview.frame.size.height-3}];
            //selectView.backgroundColor = GJColor(85, 187, 34, 1);
            selectView.image = [[UIImage imageNamed:@"右按钮点击.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:0];
            [aview addSubview:selectView];
            
            cell.backgroundColor = [UIColor clearColor];//GJColor(242, 242, 242, 1);
            cell.selectedBackgroundView = aview;
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, cell.bounds.size.height-2)];
            lbl.textColor = [UIColor colorWithRed:0x40/255.0 green:0x40/255.0 blue:0x40/255.0 alpha:1.0f];
//            lbl.highlightedTextColor = [UIColor whiteColor];
            lbl.font = [UIFont systemFontOfSize:15.0f];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.tag = 999;
            [cell.contentView addSubview:lbl];
            
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1.0f];
            cell.detailTextLabel.highlightedTextColor = [UIColor blackColor];
        }
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
    if (tableView==self.leftOptionList) {
        return self.nodes.count;
    }
    else if (tableView==self.rightOptionList)
    {
        return self.selectedLeftNode.subNodes.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftOptionList) {
        self.selectedLeftOptionIndex = indexPath.row;
        self.selectedLeftNode=self.nodes[indexPath.row];
        [self.rightOptionList reloadData];
    }
    else if (tableView==self.rightOptionList)
    {
        [self.selectedLeftNode.superNode.subNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj setSelected:NO];
        }];
        self.lastLeftNode.selected=NO;
        [self.lastLeftNode.subNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj setSelected:NO];
        }];

        [self.selectedLeftNode.subNodes[indexPath.row] setSelected:YES];
        self.lastLeftNode=self.selectedLeftNode;
        if ([self.optionListSelectorDelegate respondsToSelector:@selector(filterOptionListSelector:didSelectNode:)]) {
            [self.optionListSelectorDelegate filterOptionListSelector:self didSelectNode:self.selectedLeftNode.subNodes[indexPath.row]];
        }
        [self.leftOptionList reloadData];
    }
}



@end
