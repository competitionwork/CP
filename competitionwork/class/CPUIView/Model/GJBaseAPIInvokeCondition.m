//
//  GJBaseAPIInvokeCondition.m
//  HouseRent
//
//  Created by liruiqin on 13-11-11.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJBaseAPIInvokeCondition.h"
#import <objc/runtime.h>

@implementation GJBaseAPIInvokeCondition

-(id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(NSDictionary *)toDictionary
{
    NSArray *properties=[self allPropertyNames];
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:properties.count];
    [properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSObject *val=[self valueForKeyPath:obj];
        if(obj && [val isKindOfClass:[NSString class]] && [(NSString *)val length])
            dict[obj]=val;
    }];
    return dict;
}

-(NSArray*)propertiesInClass:(Class)aClass
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(aClass, &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
    
}

- (NSArray *)allPropertyNames
{
    char *rClass="NSObject";
    NSMutableArray *propertiesArray=[NSMutableArray arrayWithCapacity:20];
    Class targetClass=self.class;
    //    while (!strcmp(rClass,class_getName(targetClass))) {
    //        [propertiesArray addObject:[self propertiesInClass:targetClass]];
    //        targetClass=[targetClass superclass];
    //    }
    while (TRUE) {
        [propertiesArray addObjectsFromArray:[self propertiesInClass:targetClass]];
        targetClass=[targetClass superclass];
        if (strcmp(rClass,class_getName(targetClass))==0) {
            break;
        }
    }
    NSLog(@"all preperties name in class :%@ -  is :%@",self.class,propertiesArray);
    return propertiesArray;
}


@end
