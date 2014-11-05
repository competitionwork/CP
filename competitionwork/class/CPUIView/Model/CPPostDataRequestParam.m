//
//  CPPostDataRequestParam.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPPostDataRequestParam.h"

@implementation CPPostDataRequestParam

-(id)init
{
    if (self = [super init]) {
        _queryFilters = [NSMutableArray array];
        _showType = @"0";
        _pageIndex = @"0";
        _pageSize = @"20";
    }
    return self;
}



@end
