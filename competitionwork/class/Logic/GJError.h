//
//  GJError.h
//  HouseRent
//
//  Created by liruiqin on 13-11-18.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJError : NSError

@property(nonatomic,copy) NSString *DisplayMessage;

-(id)initWithDisplayMessage:(NSString*)message;
-(id)initWithDisplayMessage:(NSString*)message withErrorCode:(NSInteger)code;
@end
