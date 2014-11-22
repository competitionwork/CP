//
//  CPUserCenterListVeiw.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPListCellEntity.h"

@interface CPUserCenterListVeiw : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray * listData;

@property (nonatomic, strong) CPListCellEntity * entity;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, getter=isGroupedStyle) BOOL groupedStyle;

@property(nonatomic,copy) void(^listDidClick)(CPListCellEntity *cellEntity,NSIndexPath *indexpath);



-(void)reloadDate;

@end
