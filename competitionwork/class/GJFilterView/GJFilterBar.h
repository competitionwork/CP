//
//  GJFilterBar.h
//  HouseRent
//
//  Created by liruiqin on 13-11-27.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJOptionNode.h"
#import "GJFilterBarItem.h"

@protocol GJFilterBarDatasource;
@protocol GJFilterBarDelegate;
@interface GJFilterBar : UIView

@property(nonatomic) BOOL hideMoreItem;
@property(nonatomic,weak) id<GJFilterBarDatasource> datasource;
@property(nonatomic,weak) id<GJFilterBarDelegate> delegate;

-(void)reloadFilterData;
- (GJFilterBarItem *)filterBarItemAtIndex:(NSInteger)index;

@end
@protocol GJFilterBarDatasource <NSObject>

-(NSInteger)filterBarItemCount:(GJFilterBar*)filterBar ;
-(GJFilterBarItem*)filterBar:(GJFilterBar*)filterBar barItemViewAtIndex:(NSInteger)index;

@end
@protocol GJFilterBarDelegate <NSObject>

-(void)filterBar:(GJFilterBar*)filterBar barItemDidClickAtIndex:(NSInteger)index;
-(void)filterBarMoreItemDidClick:(GJFilterBar*)filterBar;


@end