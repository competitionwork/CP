//
//  CPAPIHelper_setting.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPAPIBaseHelper.h"
@interface CPAPIHelper_setting : CPAPIBaseHelper

+(instancetype)sharedInstance;

kDefineAPIMethodWithInterfaceWithSuccessAndFailed(ajax_avatar);

@end
