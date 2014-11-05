//
//  CPAPIBaseHelper.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-10-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPAPIBaseHelper.h"
#import "GJError.h"
#import "JSONKit.h"
#import "NSObject+YAJL.h"
#import "CPDESCode.h"

@implementation CPAPIBaseHelper

-(id)init
{
    if (self=[super init]) {
        _httpClient=[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:[self.class baseURL]]];
    }
    return self;
}


-(void)postDataToInterface:(NSString *)interface params:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed
{
    if (!interface) {
        return;
    }
    NSMutableDictionary *newParams=[NSMutableDictionary dictionaryWithDictionary:params];
    newParams[@"interface"]=interface;
    newParams[@"src"] = @"ios";
    NSString *path=[NSString stringWithFormat:@"?interface=%@",interface];
    [self postDataFromPath:path params:newParams whenSuccess:success andFailed:failed];
    
}
-(void)postDataFromPath:(NSString *)path params:(NSDictionary *)params whenSuccess:(APIHelperLoadSuccessBlock)success andFailed:(APIHelperLoadFailedBlock)failed
{
    
    
    NSMutableDictionary *dataParams=[NSMutableDictionary dictionaryWithCapacity:params.count];
    NSMutableDictionary *normalParams=[NSMutableDictionary dictionaryWithDictionary:params];
    NSMutableDictionary *severParams =  [NSMutableDictionary dictionaryWithCapacity:3];
    NSMutableString *mutableString=[NSMutableString stringWithCapacity:30];
    NSMutableString *paramsMutableString=[NSMutableString stringWithCapacity:30];

    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSData class]]) {
            dataParams[key]=obj;
            [normalParams removeObjectForKey:key];
        }
        else
        {
            [mutableString appendFormat:@"&%@=%@",key,obj];
        }
    }];
    
    
    NSString * postTime = [self getRequestTime];
    
    NSString * requestPamam = [normalParams JSONString];
    
    NSString * tokenStr = [NSString stringWithFormat:@"%@%@%@%@",APPID,APPKEY,postTime,requestPamam];
    
    NSString * postToken = [CPDESCode md5:tokenStr];
    
    [severParams setObject:APPID forKey:@"appid"];
    [severParams setObject:postTime forKey:@"time"];
    [severParams setObject:postToken forKey:@"token"];
    
    [severParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
         [paramsMutableString appendFormat:@"&%@=%@",key,obj];
        
    }];
    
    [normalParams addEntriesFromDictionary:severParams];

    DLog(@"normal params %@",normalParams);
    
    /*
     **
     */
//    NSString *url=[[NSString stringWithFormat:@"%@?%@%@",path,mutableString,paramsMutableString] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];//中文转义


    
//    NSMutableDictionary* headers = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                    @"json2",@"contentformat",
//                                    nil];
    path = @"http://dev.worldjingsai.com/api/contest/lists?uid=1&page=1&c_class=1&c_level=1&univs_id=1001&limit=20&token=5416A7D7024A3E7D0F25541590F3DF59&appid=1001&time=1414827313";
//    url = @"http://dev.worldjingsai.com/api/contest/lists?&uid=1&page=1&c_class=1&c_level=1&univs_id=1001&limit=20&token=5416A7D7024A3E7D0F25541590F3DF59&appid=1001&time=414827313";
    
    /*
    NSMutableURLRequest *req=[self.httpClient requestWithMethod:@"POST" path:path parameters:normalParams];
    [req setAllHTTPHeaderFields:headers];
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:req];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        DLog(@"objectFromJSONString = %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        id responseDictionary = [responseObject yajl_JSON];
        success(responseDictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        NSString * description = error.localizedDescription;
        NSDictionary *dic =[[NSDictionary alloc]init];
        dic = error.userInfo;
        failed(dic);
    }];
    
    [operation start];
    
    
    return;
    */
    
    
    
    /*
     **
     */
    
    

    
//    NSString *url=[[NSString stringWithFormat:@"%@%@",path,mutableString] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];//中文转义
    NSMutableURLRequest *afRequest = [self.httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:normalParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [dataParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [formData appendPartWithFileData:obj name:key fileName:[NSString stringWithFormat:@"attachment-%@.jpg",key] mimeType:@"image/jpeg"];
        }];
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:afRequest];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        DLog(@"请求路径->:%@ - 参数:%@",operation.request.URL,normalParams);
        DLog(@"请求结果JSON：……%@",operation.responseString);
        
        NSDictionary *responseDic = [responseObject yajl_JSON];
        DLog(@"请求结果 - > :%@",responseDic);
        NSNumber *code=responseDic[@"code"];
        NSString *msg=responseDic[@"msg"];
        if (code && [code intValue] != 0) {
            
            DLog(@"请求失败，message :%@",msg);
            
            if(failed)
            {
                [self runAtMainthread:^{
                    if(failed){
                        GJError* myError = [[GJError alloc]initWithDisplayMessage:msg];
                        failed(myError);
                    }
                }];
            }
            return ;
        }
        NSObject *data=responseDic[@"data"];
        
        DLog(@"请求成功，数据:%@",data);
        [self runAtMainthread:^{
            if(success){
                success(data);
            }
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求路径->:%@ - 参数:%@",operation.request.URL,params);
        DLog(@"请求失败，原因:%@",error);
        [self runAtMainthread:^{
            GJError* myError = [[GJError alloc]initWithDisplayMessage:@"哎呀，网络不给力，请稍后再试。"];
            if(failed){
                failed(myError);
            }
        }];
        
    }];
    
    [operation start];
     
    
    /*
     [self.httpClient postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     
     IFLog(@"请求路径->:%@ - 参数:%@",operation.request.URL,params);
     IFLog(@"请求结果JSON：……%@",operation.responseString);
     
     NSDictionary *responseDic=[operation.responseString objectFromJSONString];
     IFLog(@"请求结果 - > :%@",responseDic);
     NSNumber *code=responseDic[@"code"];
     NSString *msg=responseDic[@"msg"];
     IFLog(@"message :%@",msg);
     if (code && [code intValue] != 0) {
     if(failed)
     {
     [self runOnMainThread:^{
     if(failed){
     IFError* myError = [[IFError alloc]initWithInitialError:nil];
     myError.messageToDisplay = msg;
     failed(myError);
     }
     }];
     }
     return ;
     }
     NSObject *data=responseDic[@"data"];
     
     IFLog(@"请求成功，数据:%@",data);
     [self runOnMainThread:^{
     if(success){
     success(data);
     }
     }];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     IFLog(@"请求路径->:%@ - 参数:%@",operation.request.URL,params);
     IFLog(@"请求失败，原因:%@",error);
     [self runOnMainThread:^{
     IFHttpError* err = [[IFHttpError alloc]initWithInitialError:error];
     #warning fill in messageToDisplay
     err.statusCode = operation.response.statusCode;
     //            err.messageToDisplay
     if(failed){
     failed(err);
     }
     }];
     }];
     */
}

-(NSString*)getRequestTime{
    
    NSDate * dateTime = [NSDate date];
    
    NSString * dateStr = [NSString stringWithFormat:@"%ld",(long)[dateTime timeIntervalSince1970]];
    
    return dateStr;
}


-(void)runAtMainthread:(void(^)(void))block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}


@end
