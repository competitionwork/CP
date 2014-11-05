//
//  UIButton+eventHandler.m
//  xinyongka
//
//  Created by liruiqin on 13-12-18.
//  Copyright (c) 2013年 ruiq. All rights reserved.
//

#import "UIButton+eventHandler.h"

@interface RQBlockInvoker : NSObject
+(instancetype)blockInvokerWithBlock:(void(^)(void))blk;
@property(nonatomic,copy) void(^block)(void);
-(void)invoke;
@end
@implementation RQBlockInvoker
+(instancetype)blockInvokerWithBlock:(void (^)(void))blk
{
    RQBlockInvoker *bInvoker=[[RQBlockInvoker alloc] init];
    bInvoker.block=blk;
    return bInvoker;
}
-(void)invoke
{
    if (self.block) {
        self.block();
    }
}
@end
@implementation UIButton (eventHandler)

-(NSMutableDictionary *)eventHandlers
{
    static NSMutableDictionary *handlers;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handlers=[NSMutableDictionary dictionaryWithCapacity:5];
    });
    return handlers;
}
-(NSString *)eventKeyFrom:(UIControlEvents)eventType
{
    return [NSString stringWithFormat:@"%lu-eventType-%d",(unsigned long)[self hash],eventType];
}
-(void)addEventHandler:(handlerBlock)clickBlock forControlEvents:(UIControlEvents)event
{
    if (!clickBlock) {
        return;
    }
    NSString *eventType=[self eventKeyFrom:event];
    __strong RQBlockInvoker *invoker=[self eventHandlers][eventType];
    if (invoker) {
        [self removeTarget:invoker action:@selector(invoke) forControlEvents:event];
        invoker.block = clickBlock;
    } else {
        invoker=[RQBlockInvoker blockInvokerWithBlock:clickBlock];
    }
    [self addTarget:invoker action:@selector(invoke) forControlEvents:event];
    [self eventHandlers][eventType]=invoker;
}

@end
