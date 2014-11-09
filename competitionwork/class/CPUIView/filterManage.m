//
//  filterManage.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-5.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "filterManage.h"

@implementation filterManage

-(NSArray*)returnFilterData{
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"CPfilters" ofType:@"plist"];
    
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray * array = dict[@"2"][@"filter"];
    
    return array;
    
}

@end
