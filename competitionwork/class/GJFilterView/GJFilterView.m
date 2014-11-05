//
//  GJFilterView.m
//  HouseRent
//
//  Created by liruiqin on 13-12-3.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJFilterView.h"
#import "GJFilterFullOptionListViewController.h"
#import "NSArray+linq.h"

#define kNotShownOptionList -1
#define kuaifilter 300.0
#define kuaifilterIphone5 340.0


@interface GJFilterView ()<GJFilterOptionListSelectorDelegate,GJFilterFullOptionSelectorDelegate>
@property(nonatomic) NSInteger displayBarItemCount;
@property(nonatomic,weak) NSArray *nodes;
@property(nonatomic) NSInteger indexOfShowingOptionList;
@property(nonatomic) UIView *maskView;
@property(nonatomic) UIImageView *iconView;
@property(nonatomic,weak) UIView *contentView;
@property(nonatomic,getter = isShowningList) BOOL showningList;
@property(nonatomic) NSArray *notHideNodes;
@end
@implementation GJFilterView
@synthesize filterBar=_filterBar;

-(id)initWithDefaultStyle
{
    self = [self initWithFrame:CGRectMake(0, 0, 320, 40)];
    if (self) {
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        _filterBar=[[GJFilterBar alloc] initWithFrame:self.bounds];
        _filterBar.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:_filterBar];
        _filterBar.delegate=self;
        _filterBar.datasource=self;
        _filterBar.hideMoreItem=NO;
        _indexOfShowingOptionList=kNotShownOptionList;
        [self reloadData];
        self.iconView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"快速筛选-三角.png"]];

    }
    return self;
}
-(void)setRootNode:(GJOptionNode *)rootNode
{
    _rootNode=rootNode;
    self.nodes=_rootNode.subNodes;
    self.notHideNodes = [_rootNode.subNodes where:^BOOL(GJOptionNode *target) {
        return target.hide == 0;
    }];
    [self reloadData];
}
-(void)reloadData
{
    self.filterBar.hideMoreItem=self.rootNode.subNodes.count<=3;
    [self hideViewWithTag:self.indexOfShowingOptionList];
    [self.filterBar reloadFilterData];

}
-(GJOptionNode*)nodeAtBarIndex:(NSInteger)index
{
    if (index<self.notHideNodes.count) {
        return self.notHideNodes[index];
    }
    return nil;
}
NSInteger optionListTag=65442;
-(void)showViewWithIndex:(NSInteger)index
{
    DLog(@"shown list view :%ld",index);
    [self hideViewWithTag:self.indexOfShowingOptionList];
    self.indexOfShowingOptionList=index;
    self.contentView=self.superview;
    
    Class optionListType=[self.datasource filterView:self optionListClassAtIndex:index];
    UIView<GJFilterOptionListSelectable> *optionList=(UIView<GJFilterOptionListSelectable>*)[self.contentView viewWithTag:optionListTag+index];
    if (!optionList) {
        optionList=[[optionListType alloc] initWithFrame:CGRectMake(0, 0, 300, iPhone5?kuaifilterIphone5:kuaifilter)];
        optionList.tag=optionListTag+index;
        optionList.hidden=YES;
        optionList.optionListSelectorDelegate=self;
        [self.contentView insertSubview:optionList belowSubview:self];
        [[optionList.po_frameBuilder centerHorizontallyInSuperview] alignToBottomOfView:self offset:self.iconView.image.size.height];
    }
    optionList.nodes=[self.notHideNodes[index] subNodes];
    optionList.hidden=NO;
    
    [self.iconView removeFromSuperview];
    [self.contentView addSubview:self.iconView];
    [self.iconView.po_frameBuilder alignToBottomOfView:self offset:2];
    UIView *barItem=[self.filterBar filterBarItemAtIndex:index];
    CGPoint iconPoint=CGPointMake(barItem.center.x, self.iconView.center.y);
    self.iconView.hidden=YES;
    if (!self.isShowningList) {
        optionList.alpha=0;
        [optionList.po_frameBuilder alignToTopOfView:self offset:0];
        [UIView animateWithDuration:0.2 animations:^{
            optionList.alpha=1;
            [optionList.po_frameBuilder alignToBottomOfView:self offset:self.iconView.image.size.height];
        } completion:^(BOOL finished) {
            
            self.iconView.hidden=NO;
            if (self.iconView.frame.origin.x==0) {
                self.iconView.center=iconPoint;
            }
            else
            {
                [UIView animateWithDuration:0.3 animations:^{
                    self.iconView.center=iconPoint;
                }];
            }
        }];
    }
    else
    {
        self.iconView.hidden=NO;
        if (self.iconView.frame.origin.x==0) {
            self.iconView.center=iconPoint;
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.iconView.center=iconPoint;
            }];
        }
    }

    
    if (!self.maskView) {
        self.maskView=[[UIView alloc] initWithFrame:self.contentView.bounds];
        self.maskView.backgroundColor=[UIColor blackColor];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewDidClick:)];
        [self.maskView addGestureRecognizer:tap];
    }

    self.maskView.frame=self.contentView.bounds;
    [self.contentView insertSubview:self.maskView belowSubview:optionList];
    [self.maskView.po_frameBuilder alignToBottomOfView:self offset:0];
    self.maskView.alpha=0.3;

}
-(void)hideViewWithTag:(NSInteger)index
{
    DLog(@"hide list view :%ld",(long)index);

    if (index==kNotShownOptionList) {
        return;
    }
    UIView *contentView=self.superview;
    UIView<GJFilterOptionListSelectable> *optionList=(UIView<GJFilterOptionListSelectable>*)[contentView viewWithTag:optionListTag+index];
    optionList.hidden=YES;
    self.indexOfShowingOptionList=kNotShownOptionList;
    self.iconView.hidden=YES;

    [self.maskView removeFromSuperview];
}

- (void)maskViewDidClick:(UITapGestureRecognizer*)tap
{
    if (tap.view==self.maskView) {
        [self hideViewWithTag:self.indexOfShowingOptionList];
        self.showningList=NO;
    }
}

#pragma mark - filter bar methods

-(void)filterBar:(GJFilterBar *)filterBar barItemDidClickAtIndex:(NSInteger)index
{
    if (self.indexOfShowingOptionList==index) {
        [self hideViewWithTag:index];
        self.indexOfShowingOptionList=kNotShownOptionList;
        self.showningList=NO;
    }
    else
    {
        [self showViewWithIndex:index];
        if (!self.isShowningList) {
            self.showningList=YES;
        }
    }
}
-(GJFilterBarItem *)filterBar:(GJFilterBar *)filterBar barItemViewAtIndex:(NSInteger)index
{
    GJFilterBarItem *item=[[GJFilterBarItem alloc] initWithDefaultStyle];
    GJOptionNode *node=[self nodeAtBarIndex:index];
    if (node.selectedNode) {
        NSString *selectedNodeValue = [[node.selectedNode.value objectForKey:@"value"] description];
        if (![node.selectedNode.displayText isEqualToString:@"不限"] && ![selectedNodeValue isEqualToString:@"-1"]) {
            [item.textButton setTitle:node.selectedNode.displayText forState:UIControlStateNormal];
        }
        else if (![node.selectedNode.superNode.displayText isEqualToString:@"不限"]) { //如果二级选择了不限，那么显示上一级的text
            [item.textButton setTitle:node.selectedNode.superNode.displayText forState:UIControlStateNormal];
        }
    else {
            [item.textButton setTitle:node.displayText forState:UIControlStateNormal];
        }
    }
    else
    {
        [item.textButton setTitle:node.displayText forState:UIControlStateNormal];
    }
    return item;
}
-(NSInteger)filterBarItemCount:(GJFilterBar *)filterBar
{
    if ([self.datasource respondsToSelector:@selector(numberOfBarItemsShoudDisplayInFilterView:)]) {
        return [self.datasource numberOfBarItemsShoudDisplayInFilterView:self];
    }
    return 3;
}
-(void)filterBarMoreItemDidClick:(GJFilterBar *)filterBar
{
    DLog(@"more button");
    [self hideViewWithTag:self.indexOfShowingOptionList];
    UIViewController<GJFilterFullOptionSelectable> *fullOptionList=[[GJFilterFullOptionListViewController alloc] initWithNibName:nil bundle:nil];
    fullOptionList.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:fullOptionList animated:YES];
    fullOptionList.optionSelectorDelegate=self;
    fullOptionList.rootNode=self.rootNode;
    [fullOptionList reloadData];
}
-(void)filterOptionListSelector:(UIView<GJFilterOptionListSelectable> *)selector didSelectNode:(GJOptionNode *)theNode
{
    [self nodeAtBarIndex:self.indexOfShowingOptionList].selectedNode=theNode;
    [self hideViewWithTag:self.indexOfShowingOptionList];
    self.showningList=NO;
    if ([self.delegate respondsToSelector:@selector(filterView:didSelectedNode:atIndexOfBarItem:)]) {
        [self.delegate filterView:self didSelectedNode:theNode atIndexOfBarItem:self.indexOfShowingOptionList];
    }
    [self reloadData];
}
-(void)filterFullOptionSelector:(id<GJFilterFullOptionSelectable>)selector endSelect:(GJOptionNode *)rootNode
{
    DLog(@"");
    if ([self.delegate respondsToSelector:@selector(filterViewDidRefresh:withRootNode:)]) {
        [self.delegate filterViewDidRefresh:self withRootNode:rootNode];
    }
}
@end
