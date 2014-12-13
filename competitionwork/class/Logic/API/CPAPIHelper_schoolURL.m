//
//  CPAPIHelper_schoolURL.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-9.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPAPIHelper_schoolURL.h"

@implementation CPAPIHelper_schoolURL

+(instancetype)sharedInstance{
    
    static CPAPIHelper_schoolURL * Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[CPAPIHelper_schoolURL alloc]init];
    });
    
    return Instance;
}

-(void)api_get_academy_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed{
    
    NSString * URL = [NSString stringWithFormat:@"%@get_academy",[self.class baseURL]];
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

-(void)api_get_univs_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed{
    
    NSString * URL = [NSString stringWithFormat:@"%@get_univs",[self.class baseURL]];
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

+(NSString *)baseURL{
    
    return @"http://apitest.worldjingsai.com/school/";

}
@end
