//
//  CPUserInforCenter.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KISLOGIN_SUCCESS @"LoginSuccess"

@interface CPUserInforCenter : NSObject

@property (nonatomic) BOOL isLoginSuccess;

+(instancetype)sharedInstance;


@end
