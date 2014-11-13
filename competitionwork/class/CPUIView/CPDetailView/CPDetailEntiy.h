//
//  CPDetailEntiy.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-13.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPBaseModeObject.h"
@interface CPDetailEntiy : CPBaseModeObject
@property (nonatomic,strong) NSString *benefit;
@property (nonatomic,strong) NSString *bonus;
@property (nonatomic,strong) NSString *contest_class;
@property (nonatomic,strong) NSString *contest_cycle;
@property (nonatomic,strong) NSString *contest_end_time;
@property (nonatomic,strong) NSString *contest_id;
@property (nonatomic,strong) NSString *contest_keyword;
@property (nonatomic,strong) NSString *contest_level;
@property (nonatomic,strong) NSString *contest_name;
@property (nonatomic,strong) NSString *contest_short_name;
@property (nonatomic,strong) NSString *contest_start_time;
@property (nonatomic,strong) NSString *contest_url;
@property (nonatomic,strong) NSString *enter_count;
@property (nonatomic,strong) NSString *is_follow;
@property (nonatomic,strong) NSString *organiser;
@property (nonatomic,strong) NSString *parent_id;
@property (nonatomic,strong) NSString *regist_end_time;
@property (nonatomic,strong) NSString *regist_start_time;
@property (nonatomic,strong) NSDictionary *contest;
@property (nonatomic,strong) NSArray *enters;

@end
