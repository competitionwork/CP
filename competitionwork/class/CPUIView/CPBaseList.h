//
//  CPBaseList.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CPListCellCommonEntiy;

@interface CPBaseList : NSObject<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *listCellData;

-(CPListCellCommonEntiy *)listDataEntityAtIndex:(NSIndexPath *)indexpath;

@end
