//
//  CPBaseList.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseList.h"
#import "CPListCellCommonEntiy.h"
@implementation CPBaseList

#pragma mark delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@">>>>>>> : %d",indexPath.row);
}

#pragma mark datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listCellData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%d",indexPath.row];
    return cell;
}

-(CPListCellCommonEntiy *)listDataEntityAtIndex:(NSIndexPath *)indexpath
{
    return self.listCellData[indexpath.row];
}

@end
