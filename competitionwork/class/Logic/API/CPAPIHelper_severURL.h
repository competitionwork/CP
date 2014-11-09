//
//  CPAPIHelper_severURL.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-1.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPAPIBaseHelper.h"
@interface CPAPIHelper_severURL : CPAPIBaseHelper
+ (instancetype)sharedInstance;
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(lists)
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(add_follow)
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(cancle_follow)
@end
