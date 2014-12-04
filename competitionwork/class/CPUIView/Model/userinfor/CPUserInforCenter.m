//
//  CPUserInforCenter.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUserInforCenter.h"

@implementation CPUserInforCenter

+(instancetype)sharedInstance{
    
    static CPUserInforCenter * Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[CPUserInforCenter alloc]init];
    });
    
    return Instance;
}

+(void)load{
    
    [[NSUserDefaults standardUserDefaults]objectForKey:KISLOGIN_SUCCESS];
    
}

@end
