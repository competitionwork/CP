//
//  CPAPIHelper_userURL.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-1.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPAPIBaseHelper.h"
@interface CPAPIHelper_userURL : CPAPIBaseHelper
+ (instancetype)sharedInstance;
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(login);
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(reg);
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(regprofile);
@end
