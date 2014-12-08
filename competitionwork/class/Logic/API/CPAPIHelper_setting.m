//
//  CPAPIHelper_setting.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPAPIHelper_setting.h"

@implementation CPAPIHelper_setting

+(instancetype)sharedInstance{
    
    static CPAPIHelper_setting * Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[CPAPIHelper_setting alloc]init];
    });
    
    return Instance;
}

-(void)api_ajax_avatar_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed{
    
    NSString * URL = [NSString stringWithFormat:@"%@ajax_avatar/",[self.class baseURL]];
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

-(void)api_reg_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed{
    
    NSString * URL = [NSString stringWithFormat:@"%@reg/",[self.class baseURL]];
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
    return @"http://apitest.worldjingsai.com/settings/";
}

@end
