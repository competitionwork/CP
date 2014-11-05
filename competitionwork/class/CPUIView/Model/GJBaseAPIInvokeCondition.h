//
//  GJBaseAPIInvokeCondition.h
//  HouseRent
//
//  Created by liruiqin on 13-11-11.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@interface GJBaseAPIInvokeCondition : NSObject

- (NSArray *)allPropertyNames;
-(NSDictionary *)toDictionary;
@end
