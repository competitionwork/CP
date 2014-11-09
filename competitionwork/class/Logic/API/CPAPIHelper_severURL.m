//
//  CPAPIHelper_severURL.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-1.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPAPIHelper_severURL.h"

@implementation CPAPIHelper_severURL
+ (instancetype)sharedInstance
{
    static CPAPIHelper_severURL *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc] init];
    });
    return instance;
}

-(void)api_lists_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed{
    
    NSString * URL = [NSString stringWithFormat:@"%@lists",[self.class baseURL]];
    
    [self postDataFromPath:URL params:params whenSuccess:^(id result) {
        
        DLog(@"%@",result);
        if (success) {
            success(result);
        }
        
    } andFailed:^(id err) {
        
        DLog(@"%@",err);
        if (failed) {
            failed(err);
        }
        
    }];
    
}

-(void)api_add_follow_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed
{
    NSString * URL = [NSString stringWithFormat:@"%@add_follow",[self.class baseURL]];
    [self postDataFromPath:URL params:params whenSuccess:^(id result) {
        if (success) {
            success(result);
        }
    } andFailed:^(id err) {
        if (failed) {
            failed(err);
        }
    }];
}

-(void)api_cancle_follow_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed
{
    NSString * URL = [NSString stringWithFormat:@"%@cancle_follow",[self.class baseURL]];
    [self postDataFromPath:URL params:params whenSuccess:^(id result) {
        if (success) {
            success(result);
        }
    } andFailed:^(id err) {
        if (failed) {
            failed(err);
        }
    }];
}

+(NSString *)baseURL
{
    return @"http://dev.worldjingsai.com/api/contest/";
}

@end
