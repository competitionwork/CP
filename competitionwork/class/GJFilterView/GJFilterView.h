//
//  GJFilterView.h
//  HouseRent
//
//  Created by liruiqin on 13-12-3.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJFilterBar.h"
#import "GJFilterOptionListSelectable.h"

@protocol GJFilterViewDatasource;
@protocol GJFilterViewDelegate;
@interface GJFilterView : UIView<GJFilterBarDatasource,GJFilterBarDelegate>

@property(nonatomic,readonly) GJFilterBar *filterBar;
@property(nonatomic,strong) GJOptionNode *rootNode;
@property(nonatomic,weak) id<GJFilterViewDatasource> datasource;
@property(nonatomic,weak) id<GJFilterViewDelegate> delegate;
@property(nonatomic,weak) UINavigationController *navigationController;

-(id)initWithDefaultStyle;

-(void)reloadData;

@end
@protocol GJFilterViewDatasource <NSObject>

-(GJFilterBarItem*)filterView:(GJFilterView*)filterView barItemAtIndex:(NSInteger)index;

-(Class)filterView:(GJFilterView*)filterView optionListClassAtIndex:(NSInteger)index;

-(NSInteger)numberOfBarItemsShoudDisplayInFilterView:(GJFilterView*)filterView;

@end
@protocol GJFilterViewDelegate <NSObject>

-(void)filterView:(GJFilterView*)filterView didSelectedNode:(GJOptionNode*)node atIndexOfBarItem:(NSInteger)index;

-(void)filterViewDidRefresh:(GJFilterView *)filterView withRootNode:(GJOptionNode *)theRootNode;

@end