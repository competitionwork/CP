//
//  CPAPIHelper_userURL.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-1.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPAPIHelper_userURL.h"

@implementation CPAPIHelper_userURL
+(instancetype)sharedInstance{
    
    static CPAPIHelper_userURL * Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[CPAPIHelper_userURL alloc]init];
    });
    
    return Instance;
}

-(void)api_login_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed{
    
    NSString * URL = [NSString stringWithFormat:@"%@login",[self.class baseURL]];
    
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
    
    NSString * URL = [NSString stringWithFormat:@"%@reg",[self.class baseURL]];
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

-(void)api_regprofile_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed{
    
    NSString * URL = [NSString stringWithFormat:@"%@regprofile",[self.class baseURL]];
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
    return @"http://apitest.worldjingsai.com/user/";
}

@end
