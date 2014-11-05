//
//  GJFilterMultilevelWithSectionOptionSelectorView.m
//  HouseRent
//
//  Created by liruiqin on 13-12-19.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJFilterMultilevelWithSectionOptionSelectorView.h"
#import "UIView+borders.h"

@interface GJFilterMultilevelWithSectionOptionSelectorView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) NSArray *_nodes;
@property(nonatomic,weak) id<GJFilterOptionListSelectorDelegate> _optionListDelegate;

@property(nonatomic) UITableView *leftOptionList;
@property(nonatomic) UITableView *rightOptionList;
@property(nonatomic,weak) GJOptionNode *selectedLeftNode;
@property(nonatomic,weak) GJOptionNode *lastLeftNode;

@property(nonatomic) NSMutableDictionary *data;
@property(nonatomic) NSMutableArray *sectionTitles;
@property(nonatomic) NSInteger selectedLeftOptionIndex;
@property(nonatomic) NSInteger selectedLeftOptionSectionIndex;


@end
@implementation GJFilterMultilevelWithSectionOptionSelectorView
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
    @try {
        if (self._nodes.count > 0) {
            NSInteger leftRowIndex=0;
            NSInteger rightRowIndex=0;
            
            NSMutableDictionary *nodeData = [NSMutableDictionary dictionaryWithCapacity:50];
            NSMutableArray *hotNodes = [NSMutableArray arrayWithCapacity:12];
            NSMutableArray *buxianNodes = [NSMutableArray arrayWithCapacity:1];
            
            NSString *allSectionKey = @"全部";
            NSString *hotSectionKey = @"热门";
            NSString *chars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            
            for (int idx = 0; idx < chars.length; idx++) {
                NSMutableArray *tmpNodes = [NSMutableArray arrayWithCapacity:10];
                NSString *key = [chars substringWithRange:NSMakeRange(idx, 1)];
                nodeData[key] = tmpNodes;
            }
            NSString *selectedLeftSection;
            for (NSInteger idx = 0; idx<self._nodes.count; idx++) {
                GJOptionNode *node=self._nodes[idx];
                NSString *key = node.userInfo[@"fl"];
                if (node.isSelected) {
                    self.selectedLeftNode=node;
                    self.lastLeftNode=node;
                    for (NSInteger subIdx = 0; subIdx<self._nodes.count; subIdx++) {
                        GJOptionNode *subNode=self.selectedLeftNode.subNodes[subIdx];
                        if (subNode.isSelected) {
                            rightRowIndex=subIdx;
                            leftRowIndex=idx;
                            break;
                        }
                    }
                    if ([node.userInfo[@"hot"] boolValue]) {
                        selectedLeftSection = @"热门";
                    }
                    else if ([node.displayText isEqualToString:@"不限"]) {
                        selectedLeftSection = @"全部";
                    }
                    else {
                        selectedLeftSection = key;
                    }
                }
                if ([node.userInfo[@"hot"] boolValue]) {
                    [hotNodes addObject:node];
                }
                else if ([node.displayText isEqualToString:@"不限"]) {
                    [buxianNodes addObject:node];
                }
                else {
                    NSMutableArray *nodesInDic = nodeData[key];
                    [nodesInDic addObject:node];
                }
            }
            self.data = nodeData;
            self.sectionTitles = [NSMutableArray arrayWithArray:[self.data.allKeys sortedArrayUsingSelector:@selector(compare:)]];
            nodeData[hotSectionKey] = hotNodes;
            nodeData[allSectionKey] = buxianNodes;
            [self.sectionTitles insertObject:hotSectionKey atIndex:0];
            [self.sectionTitles insertObject:allSectionKey atIndex:0];
            self.selectedLeftOptionSectionIndex = [self.sectionTitles indexOfObject:selectedLeftSection];
            NSArray *tobeQuerySelectable = self.data[selectedLeftSection];
            [tobeQuerySelectable enumerateObjectsUsingBlock:^(GJOptionNode *obj, NSUInteger idx, BOOL *stop) {
                if (obj.isSelected) {
                    self.selectedLeftOptionIndex = idx;
                }
            }];

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
        }
            
    }
    @catch (NSException *exception) {
        DLog(@"车系列表解析出错--->\n%@",exception);
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
-(GJOptionNode*)nodeForTable:(UITableView*)tableview andIndex:(NSIndexPath *)index
{
    if (tableview==self.leftOptionList) {
        NSString *sectionKey = self.sectionTitles[index.section];
        NSArray *nodes = self.data[sectionKey];
        return nodes[index.row];
    }
    else
    {
        return self.selectedLeftNode.subNodes[index.row];
    }
}
#pragma mark - table view methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.leftOptionList) {
        return self.sectionTitles.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.leftOptionList && section != 0) {
        return 22.0;
    }
    return 0.0;
}   
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.leftOptionList) {
        return self.sectionTitles[section];
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.rightOptionList) {
        return nil;
    }
    NSString* title = [self tableView:tableView titleForHeaderInSection:section];
        
	if(title == nil) return nil;
	//UIImage *img = [UIImage imageNamed:@"选城标签bg.png"];
	UIView *gview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    gview.backgroundColor = [UIColor colorWithRed:0x255/255.0 green:0x255/255.0 blue:0x255/255.0 alpha:0.8];
	
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 22)];
	label.backgroundColor = [UIColor clearColor];
	label.text = title;
	label.textColor = [UIColor colorWithRed:0x55/255.0 green:0xbb/255.0 blue:0x22/255.0 alpha:1.0];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.75];
    label.shadowOffset = CGSizeMake(0, 1);
	[gview addSubview:label];
	
    UIImageView *shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"切换城市-分割线.png"]];
    shadowView.frame = CGRectMake(0, 22, 320, 1);
    shadowView.backgroundColor = [UIColor clearColor];
    [gview addSubview:shadowView];
    
	return gview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=nil;
    GJOptionNode *node=[self nodeForTable:tableView andIndex:indexPath];
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
            
            CGFloat x = 30;
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, cell.bounds.size.width-x-10, cell.bounds.size.height-2)];
            lbl.font = [UIFont systemFontOfSize:15.0f];
            lbl.backgroundColor = [UIColor clearColor];
            //lbl.highlightedTextColor = [UIColor colorWithRed:0x40/255.0 green:0x40/255.0 blue:0x40/255.0 alpha:1.0f];
            lbl.textColor = [UIColor colorWithRed:0x40/255.0 green:0x40/255.0 blue:0x40/255.0 alpha:1.0f];
            lbl.tag = 999;
            [cell.contentView addSubview:lbl];
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            [cell.contentView addSubview:imgView];
            [[imgView.po_frameBuilder setSizeWithWidth:44 height:44] alignLeftInSuperviewWithInset:6];
            imgView.tag = 9898;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
        }
        UILabel *labelText=(UILabel *)[cell.contentView viewWithTag:999];
        labelText.text=node.displayText;
        
        if (indexPath.row == self.selectedLeftOptionIndex && indexPath.section == self.selectedLeftOptionSectionIndex) {
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
        NSArray *array = self.data[self.sectionTitles[section]];
        return array.count;
    }
    else if (tableView==self.rightOptionList)
    {
        return self.selectedLeftNode.subNodes.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftOptionList) {
        self.selectedLeftOptionIndex = indexPath.row;
        self.selectedLeftOptionSectionIndex = indexPath.section;
        self.selectedLeftNode=[self nodeForTable:tableView andIndex:indexPath];
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
