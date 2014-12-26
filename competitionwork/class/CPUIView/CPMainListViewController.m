//
//  CPMainListViewController.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPMainListViewController.h"
#import "CPListCellCommonEntiy.h"
#import "CPMainListCellTableViewCell.h"
#import "CPDetailViewController.h"
#import "GJListMoreCell.h"

@implementation CPMainListViewController

@synthesize clickIndex;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    CPListCellCommonEntiy *cellEntity = [self listDataEntityAtIndex:indexPath];
//    NSDictionary *dic = cellEntity.dataEntity;
    

    if (clickIndex) {
        clickIndex(cellEntity);
    }

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count =  self.listCellData.count;
    
    if (_hasMoreData) {
        return ++count;
    }
    
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalCellId = @"xiaoquCell";
    static NSString *moreCellId = @"moreCell";

    NSDictionary *cellEntityDict = nil;
    CPListCellCommonEntiy * cellEntity = nil;
    
    if (indexPath.row == self.listCellData.count) {
        cellEntity = [[CPListCellCommonEntiy alloc]init];
        cellEntity.cellStyle = CPPostListCellStyleMoreCell;
        
    }else{
        
        cellEntityDict = [self listDataEntityAndKey:[self listDataEntityAtIndex:indexPath]];
        cellEntity = [self listDataEntityAtIndex:indexPath];
    }

    
    switch (cellEntity.cellStyle) {
        case CPPostListCellStyleNormal:
        {
            
            CPMainListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellId];
            if (!cell) {
                
                cell = [[CPMainListCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellId];
                
            }
            cell.content = cellEntityDict;
            
            return cell;
            
        }
            break;
        case CPPostListCellStyleMoreCell:
        {
            GJListMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId];
            if (!cell) {
                
                cell = [[GJListMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId];
                
            }
            return cell;
        }
            break;
        case CPPostListCellStyleLocationCell:
            
            break;
        case CPPostListCellStyleSearchAllCell:
            
            break;
        default:
            break;
    }
    
    return nil;
     
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSDictionary *)listDataEntityAndKey:(CPListCellCommonEntiy *)entiy
{
    NSDictionary * dictEntiy = entiy.dataEntity;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:[dictEntiy objectForKey:@"contest_name"] forKey:@"left1"];
    [dict setValue:@"举办方:" forKey:@"left2"];
    [dict setValue:[self registTimeFor:dictEntiy] forKey:@"left3"];
    [dict setValue:[self contestTimeFor:dictEntiy] forKey:@"left4"];
    [dict setValue:[dictEntiy objectForKey:@"organiser"] forKey:@"left5"];
    [dict setValue:dictEntiy forKey:@"entiyDict"];
    [dict setValue:[dictEntiy objectForKey:@"is_follow"] forKey:@"is_follow"];

    [dict setObject:[self returnState:dictEntiy] forKey:@"State"];
    
    
    return dict;
}


-(NSString *)registTimeFor:(NSDictionary*)Item{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    
    NSDate* registStart = [NSDate dateWithTimeIntervalSince1970:[[Item objectForKey:@"regist_start_time"] intValue]];
    NSString* startStr = [dateFormatter stringFromDate:registStart];
    
    NSDate* registEnd = [NSDate dateWithTimeIntervalSince1970:[[Item objectForKey:@"regist_end_time"] intValue]];
    NSString* endStr = [dateFormatter stringFromDate:registEnd];
    
    NSString * str = [NSString stringWithFormat:@"报名时间:%@-%@",startStr,endStr];
    
    return str;
}

-(NSString*)returnState:(NSDictionary*)Item{
    int time = [[NSDate date] timeIntervalSince1970];
    int startime = [[Item objectForKey:@"contest_end_time"] intValue];
    if (time > startime) {
        return @"1";
    }else{
        return @"2";
    }
    
}

-(NSString *)contestTimeFor:(NSDictionary*)Item{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    
    NSDate* registStart = [NSDate dateWithTimeIntervalSince1970:[[Item objectForKey:@"contest_start_time"] intValue]];
    NSString* startStr = [dateFormatter stringFromDate:registStart];
    
    NSDate* registEnd = [NSDate dateWithTimeIntervalSince1970:[[Item objectForKey:@"contest_end_time"] intValue]];
    NSString* endStr = [dateFormatter stringFromDate:registEnd];
    
    NSString * str = [NSString stringWithFormat:@"竞赛时间:%@-%@",startStr,endStr];
    
    return str;
}

// -----------------------------------------------------------------------
#pragma mark - ScrollViewDelegate
// -----------------------------------------------------------------------

// 刚拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.scrollViewWillBeginDragging) {
        _scrollViewWillBeginDragging(scrollView);
    }
}

// 拖动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollViewDidScroll) {
        _scrollViewDidScroll(scrollView);
    }

}

// 拖动结束后
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_scrollViewDidEndDraggingWillDecelerate) {
        _scrollViewDidEndDraggingWillDecelerate(scrollView,decelerate);
    }
}



@end
