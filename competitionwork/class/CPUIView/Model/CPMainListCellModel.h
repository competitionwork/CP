//
//  CPMainListCellModel.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPBaseModeObject.h"
@interface CPMainListCellModel : CPBaseModeObject
@property (nonatomic,strong) NSString *all_num;

@property (nonatomic,strong) NSString *contest_end_time;
@property (nonatomic,strong) NSString *contest_id;
@property (nonatomic,strong) NSString *contest_name;
@property (nonatomic,strong) NSString *contest_start_time;
@property (nonatomic,strong) NSString *is_follow;
@property (nonatomic,strong) NSString *organiser;
@property (nonatomic,strong) NSString *regist_end_time;
@property (nonatomic,strong) NSString *regist_start_time;

@end

/*
{
    "all_num" = 6;
    contests =     (
                    {
                        "contest_end_time" = 1415602010;
                        "contest_id" = 103;
                        "contest_name" = "2015\U7b2c\U4e8c\U5c4a\U9ad8\U6559\U793e\U676f\U5168\U56fd\U5927\U5b66\U751f\U6570\U5b66\U5efa\U6a21\U7ade\U8d5b\U5927\U8fde\U5927\U5b66\U8d5b\U533a";
                        "contest_start_time" = 1415597010;
                        "is_follow" = 0;
                        organiser = "\U6559\U80b2\U90e8";
                        "regist_end_time" = 1415142364;
                        "regist_start_time" = 1415051656;
                    }
                    );
}
*/