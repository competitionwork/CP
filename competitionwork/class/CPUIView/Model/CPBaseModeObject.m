//
//  CPBaseModeObject.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseModeObject.h"
#import <objc/runtime.h>
@implementation CPBaseModeObject

- (NSArray*)propertyKeys

{
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [keys addObject:propertyName];
        
    }
    
    free(properties);
    
    return keys;
    
}



- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource

{
    
    BOOL ret = NO;
    
    for (NSString *key in [self propertyKeys]) {
        
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
            
        }
        
        else
            
        {
            
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
            
        }
        
        if (ret) {
            
            id propertyValue = [dataSource valueForKey:key];
            
            //该值不为NSNULL，并且也不为nil
            
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                
                [self setValue:propertyValue forKey:key];
                
            }           
            
        }
        
    }
    
    return ret;
    
}
@end
