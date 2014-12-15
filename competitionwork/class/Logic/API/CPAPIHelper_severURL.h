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
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(view)

/*获取竞赛类型接口*/
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(get_category)

/*获取我关注的竞赛*/
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(myfocus)

/*热门竞赛*/
kDefineAPIMethodWithInterfaceWithSuccessAndFailed(hot_contest)

@end
