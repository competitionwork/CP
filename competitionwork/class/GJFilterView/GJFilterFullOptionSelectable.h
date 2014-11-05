//
//  GJFilterFullOptionSelectable.h
//  HouseRent
//  更多（高级筛选）筛选条件选择接口
//  Created by liruiqin on 13-12-12.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJOptionNode.h"

@protocol GJFilterFullOptionSelectorDelegate;
@protocol GJFilterFullOptionSelectable <NSObject>

@property(nonatomic,weak) GJOptionNode *rootNode;
@property(nonatomic,weak) id<GJFilterFullOptionSelectorDelegate> optionSelectorDelegate;
- (void)reloadData;

@end
@protocol GJFilterFullOptionSelectorDelegate <NSObject>

- (void)filterFullOptionSelector:(id<GJFilterFullOptionSelectable>)selector endSelect:(GJOptionNode *)rootNode;

@end
