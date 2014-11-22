//
//  CPUserCenterListVeiw.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUserCenterListVeiw.h"
#import "GJUserCenterListViewCell.h"
#import "CPListCellEntity.m"
#import "UIView+borders.h"
@implementation CPUserCenterListVeiw

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(242, 242, 242);
        self.clipsToBounds = YES;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdntifier = @"userCenterCell";
    
    GJUserCenterListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdntifier];
    
    if (!cell) {
        cell = [[GJUserCenterListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdntifier];
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 44)];
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    CPListCellEntity * entity = self.listData[indexPath.section][indexPath.row];
    
    cell.textLabel.text = @"个人中心";//entity.title;
//    cell.imageView.image = entity.image;
    
    [cell setBorderIn:UIViewBorderPositionBottom];
    
    return cell;
    
}














@end
