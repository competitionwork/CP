//
//  CPPostDataRequestParam.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPBaseInterfaceParam.h"
#import "GJOptionNode.h"

@interface CPPostDataRequestParam : CPBaseInterfaceParam


// 晒选项字段
@property(nonatomic,strong) NSMutableArray *queryFilters;

// 搜索字段
@property(nonatomic,copy) NSString *keyword;

@property(nonatomic,strong) GJOptionNode *filterNode;


/* 通用字段
 cityScriptIndex
 categoryId
 majorCategoryScriptIndex
 district_id
 street_id
 latlng
 title
 */
@property(nonatomic,copy) NSString *showType;
@property(nonatomic,copy) NSString *district_id;
@property(nonatomic,copy) NSString *street_id;
@property(nonatomic,copy) NSString *latlng;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *pageIndex;
@property(nonatomic,copy) NSString *pageSize;
@property(nonatomic,copy) NSString *customerId;


@end
