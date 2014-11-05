//
//  NSObject+GJExtand.h
//  HouseRent
//
//  Created by liruiqin on 14-4-12.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GJExtand)

@property(nonatomic,readonly) BOOL isNSString;
@property(nonatomic,readonly) BOOL isNSDictionary;
@property(nonatomic,readonly) BOOL isNSArray;
@property(nonatomic,readonly) BOOL isNSSet;
@property(nonatomic,readonly) BOOL isNSNumber;
@property(nonatomic,readonly) BOOL isNSValue;

-(NSDictionary *)toDictionary;

@end
