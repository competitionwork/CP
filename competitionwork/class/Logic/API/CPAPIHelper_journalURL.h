//
//  CPAPIHelper_journalURL.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-10.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPAPIBaseHelper.h"
@interface CPAPIHelper_journalURL : CPAPIBaseHelper

+(instancetype)sharedInstance;

kDefineAPIMethodWithInterfaceWithSuccessAndFailed(lists)

kDefineAPIMethodWithInterfaceWithSuccessAndFailed(view)

@end
