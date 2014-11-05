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

@implementation CPMainListViewController

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    CPListCellCommonEntiy *cellEntity = [self listDataEntityAtIndex:indexPath];
    NSDictionary *dic = cellEntity.dataEntity;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.listCellData.count;
    
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalCellId = @"xiaoquCell";
    CPListCellCommonEntiy *cellEntity = [self listDataEntityAndKey:[self listDataEntityAtIndex:indexPath]];
    
    switch (cellEntity.cellStyle) {
        case CPPostListCellStyleNormal:
        {
            
            CPMainListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellId];
            if (!cell) {
                
                cell = [[CPMainListCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellId];
                
            }
            cell.textLabel.text = cellEntity.title;

//            GetPostListCellFormate *formate = [GetPostListCellFormate shareFormate];
//            cell.content = [formate cellDictionaryForListWithContent:cellEntity.dataEntity withMasterId:GJMasterIdFangchan_7 withMajorId:101];
            
            //            cell.textLabel.text = NSStringFromFormat(@"%d", indexPath.row);
            return cell;
            
        }
            break;
        case CPPostListCellStyleMoreCell:
            
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
//    return [GJListCell heightForCell:GJMasterIdFangchan_7 withMajorId:101];
}

-(CPListCellCommonEntiy *)listDataEntityAndKey:(CPListCellCommonEntiy *)entiy
{
    NSDictionary * dictEntiy = entiy.dataEntity;
    entiy.title = [dictEntiy objectForKey:@"contest_name"];
    entiy.title = [dictEntiy objectForKey:@"contest_name"];

    
    return entiy;
}

@end
