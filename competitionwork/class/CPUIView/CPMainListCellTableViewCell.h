//
//  CPMainListCellTableViewCell.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionView.h"


@interface CPMainListCellTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *content;


@property (nonatomic,strong) NSString * title;

@property (nonatomic,strong) NSString * sutitle;

@property (nonatomic,strong) NSString * enterTime;

@property (nonatomic,strong) NSString * matchTime;



@property (nonatomic, strong) UILabel *left1Label;

@property (nonatomic, strong) UILabel *left2Label;

@property (nonatomic, strong) UILabel *left3Label;

@property (nonatomic, strong) UILabel *left4Label;

@property (nonatomic, strong) AttentionView * attentionView;




@end
