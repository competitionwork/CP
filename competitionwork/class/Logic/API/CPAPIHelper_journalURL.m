//
//  CPAPIHelper_journalURL.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-10.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPAPIHelper_journalURL.h"

@implementation CPAPIHelper_journalURL

+(instancetype)sharedInstance{
    
    static CPAPIHelper_journalURL * Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[CPAPIHelper_journalURL alloc]init];
    });
    
    return Instance;
}

-(void)api_lists_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed{
    
    NSString * URL = [NSString stringWithFormat:@"%@lists/",[self.class baseURL]];
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

-(void)api_view_withParams:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed

{
    NSString * URL = [NSString stringWithFormat:@"%@view/",[self.class baseURL]];
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
    
//    return @"http://apitest.worldjingsai.com/journal/";
    return [NSString stringWithFormat:@"%@/journal/",SEVERURL];

}

@end
