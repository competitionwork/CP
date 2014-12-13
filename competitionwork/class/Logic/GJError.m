//
//  GJError.m
//  HouseRent
//
//  Created by liruiqin on 13-11-18.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJError.h"

@implementation GJError
-(id)initWithDisplayMessage:(NSString *)message
{
    return [self initWithDisplayMessage:message withErrorCode:-1];
}
-(id)initWithDisplayMessage:(NSString *)message withErrorCode:(NSInteger)code
{
    if (self=[super initWithDomain:@"ganji.com" code:code userInfo:nil]) {
        self.DisplayMessage=message;
    }
    return self;
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"<errorCode:%ld - reason:%@>",(long)self.code,self.DisplayMessage];
}
@end
