//
//  CPAPIHelper_schoolURL.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-9.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPAPIBaseHelper.h"

@interface CPAPIHelper_schoolURL : CPAPIBaseHelper

+(instancetype)sharedInstance;

/*获取学校接口*/
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(get_univs);

/*获取学院接口*/
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(get_acadamy);

@end
