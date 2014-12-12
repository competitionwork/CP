//
//  CPUserCenterListVeiw.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUserCenterListVeiw.h"
#import "GJUserCenterListViewCell.h"
#import "CPListCellEntity.h"
#import "UIView+borders.h"
#import "GJUserCenterHeadViewCell.h"
#import "CPUserInforCenter.h"
#import "UIImageView+AFNetworking.h"

#define KCELLHIGHT 60

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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.clipsToBounds = NO;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 30)];
        [self addSubview:_tableView];
    }
    return _tableView;
}

-(void)setListData:(NSArray *)listData{
    if (_listData != listData) {
        _listData = listData;
    }
    self.groupedStyle = [_listData.lastObject isKindOfClass:[NSArray class]];
}

-(void)reloadDate{
    [self.tableView reloadData];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.tableView.po_frameBuilder setHeight:self.bounds.size.height-20];
}

-(BOOL)isLastCellInSection:(NSIndexPath *)indexpath
{
    NSInteger countOfRowsInSection = self.isGroupedStyle ? [self.listData[indexpath.section] count] : self.listData.count;
    return indexpath.row == countOfRowsInSection - 1;
}

-(CPListCellEntity *)entityOfCellAtIndex:(NSIndexPath *)indexpath
{
    return self.isGroupedStyle ? self.listData[indexpath.section][indexpath.row] : self.listData[indexpath.row];
}

#define mark tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.isGroupedStyle?self.listData.count:1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isGroupedStyle?[self.listData[section] count]:self.listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdntifier = @"userCenterCell";
    
    if (indexPath.section == 0) {
        
        GJUserCenterHeadViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdntifier];
        
        if (!cell) {
            cell = [[GJUserCenterHeadViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdntifier];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, KCELLHIGHT)];
            cell.backgroundView.backgroundColor = [UIColor whiteColor];
            cell.textLabel.backgroundColor = [UIColor clearColor];
        }
        
         CPPeopleInforCenterModel * userinfo = [[CPUserInforCenter sharedInstance]getPeopleData];
        
                
        cell.textStrLabel.text = userinfo.real_name;
        [cell.leftImage setImageWithURL:[NSURL URLWithString:userinfo.avatar] placeholderImage:nil];
        UIImage * sex = [UIImage imageNamed:@""];
        if ([userinfo.sex intValue]== 1) {
            sex = [UIImage imageNamed:@"sex1"];
        }else{
            sex = [UIImage imageNamed:@"sex2"];
        }
        cell.sexImage.image = sex;
        cell.ageLabel.text = @"24";
        
        cell.hiddenTopBorder = indexPath.row == 0?NO:YES;
        
        cell.hiddenBottomBorder = [self isLastCellInSection:indexPath];
        cell.hiddenDownBorder = ![self isLastCellInSection:indexPath];
        
        return cell;

    }else{
        GJUserCenterListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdntifier];
        
        if (!cell) {
            cell = [[GJUserCenterListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdntifier];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, KCELLHIGHT)];
            cell.backgroundView.backgroundColor = [UIColor whiteColor];
            cell.textLabel.backgroundColor = [UIColor clearColor];
        }
        
        CPListCellEntity * entity = [self entityOfCellAtIndex:indexPath];
        
        cell.titleLabel.text = entity.title;
        cell.leftImageView.image = entity.image;
        
        cell.hiddenTopBorder = indexPath.row == 0?NO:YES;
        
        cell.hiddenBottomBorder = [self isLastCellInSection:indexPath];
        cell.hiddenDownBorder = ![self isLastCellInSection:indexPath];
        
        return cell;
    }
    
    
    
 
    
    //    [cell setBorderIn:UIViewBorderPositionBottom];
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [GJUserCenterHeadViewCell heightForRow];
    }else{
        return [GJUserCenterListViewCell heightForRow];
    }
    
    return [GJUserCenterListViewCell heightForRow];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 20)];
    label.text = @" ";
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}


-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    DLog(@"");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.listDidClick) {
        self.listDidClick([self entityOfCellAtIndex:indexPath],indexPath);
    }
}







@end
