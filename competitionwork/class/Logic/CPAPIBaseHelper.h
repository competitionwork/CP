//
//  CPAPIBaseHelper.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-10-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#define kNetworkDelay 0.0f

#define kDefineAPIMethodWithInterfaceWithSuccessAndFailed(interfaceName) \
\
- (void)api_##interfaceName##_withParams:(NSDictionary*)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed;

typedef void(^APIHelperLoadSuccessBlock)(id result);
typedef void(^APIHelperLoadFailedBlock)(id err);

@interface CPAPIBaseHelper : NSObject

@property(nonatomic,strong) AFHTTPClient *httpClient;
@property(nonatomic) BOOL isAlertUnConnectionReachabil;

-(void)postDataFromPath:(NSString *)path params:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed;


+(NSString*)baseURL;

@end
