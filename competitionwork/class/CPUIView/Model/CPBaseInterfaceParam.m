//
//  CPBaseInterfaceParam.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseInterfaceParam.h"
#import "NSObject+GJExtand.h"

@implementation CPBaseInterfaceParam

+(instancetype)paramWithDictionary:(NSDictionary *)dic
{
    return [[self alloc] initWithDictionary:dic];
}

-(id)init
{
    if (self = [super init]) {
        //        self.masterId = GJMasterIdUnkwon;
        //        self.majorId = kGJUndefineIntValue;
    }
    return self;
}

-(instancetype)initWithQueryParams:(NSString *)queryParams
{
    return [self initWithDictionary:[queryParams objectFromJSONString]];
}

-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        if (dic.allKeys.count == 1) {
            [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([key isNSString] && [obj isNSDictionary]) {
                    _interface = key;
                    _params = obj;
                }
                else {
                    DLog(@"错误的字典数据!");
                }
            }];
        }
        if (_params) {
            [[self allPropertyNames] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { // 初始化实体类属性
                id value = _params[obj];
                if (value) {
                    [self setValue:value forKeyPath:obj];
                }
            }];
        }
    }
    return self;
}

-(void)setMasterId:(NSInteger)masterId
{
    self.categoryId = NSStringFromInt(masterId);
}
-(NSInteger)masterId
{
    return [self.categoryId intValue];
}

-(void)setMajorId:(int)majorId
{
    self.majorCategoryScriptIndex = NSStringFromInt(majorId);
}
-(int)majorId
{
    return [self.majorCategoryScriptIndex intValue];
}

@end
