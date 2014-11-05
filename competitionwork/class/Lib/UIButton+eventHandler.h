//
//  UIButton+eventHandler.h
//  xinyongka
//
//  Created by liruiqin on 13-12-18.
//  Copyright (c) 2013年 ruiq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^handlerBlock)(void);
@interface UIButton (eventHandler)

- (void)addEventHandler:(handlerBlock)clickBlock forControlEvents:(UIControlEvents)event;
@end
