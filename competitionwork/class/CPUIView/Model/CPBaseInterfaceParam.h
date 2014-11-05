//
//  CPBaseInterfaceParam.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJBaseAPIInvokeCondition.h"
#import "JSONKit.h"

#define kGJUndefineIntValue -123456789 // 未赋值的int属性值
#define kGJUndefineStringValue @"为初始化字符串" // 未赋值的字符串属性值

@interface CPBaseInterfaceParam : GJBaseAPIInvokeCondition

+(instancetype)paramWithDictionary:(NSDictionary *)dic;

// 大类id
@property(nonatomic,assign) NSInteger masterId;

// 小类id
@property(nonatomic,assign) int majorId;

// 接口接受的大类id
@property(nonatomic,copy) NSString *categoryId;

// 接口接受的小类id
@property(nonatomic,copy) NSString *majorCategoryScriptIndex;

// 城市id
@property(nonatomic,copy) NSString *cityScriptIndex;

// 对应接口
@property(nonatomic,readonly) NSString *interface;

// 各小类对应的字段(应该是服务器下发，本地不能进行修改的),详情查看"客户端搜索接口整理.xls"
@property(nonatomic,readonly) NSDictionary *params;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
-(instancetype)initWithQueryParams:(NSString *)queryParams;




@end
