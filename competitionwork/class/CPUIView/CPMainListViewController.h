//
//  CPMainListViewController.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseList.h"
#import "RefreshView.h"
@interface CPMainListViewController : CPBaseList<UITableViewDataSource,UITableViewDelegate,RefreshViewDelegate>

@property (nonatomic) BOOL hasMoreData;

@property (nonatomic, copy) void(^clickIndex)(CPListCellCommonEntiy * clickEntiy);
@property (nonatomic, copy) void(^scrollViewWillBeginDragging)(UIScrollView * scrollView);
@property (nonatomic, copy) void(^scrollViewDidScroll)(UIScrollView * scrollView);
@property (nonatomic, copy) void(^scrollViewDidEndDraggingWillDecelerate)(UIScrollView * scrollView,BOOL decelerate);




@end


