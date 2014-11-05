//
//  GJFilterOptionListSelectable.h
//  HouseRent
//
//  Created by liruiqin on 13-12-2.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJOptionNode.h"

@protocol GJFilterOptionListSelectorDelegate;

@protocol GJFilterOptionListSelectable <NSObject>

@property(nonatomic,weak) id<GJFilterOptionListSelectorDelegate> optionListSelectorDelegate;
@property(nonatomic,weak) NSArray *nodes;

@end
@protocol GJFilterOptionListSelectorDelegate <NSObject>

-(void)filterOptionListSelector:(UIView<GJFilterOptionListSelectable>*)selector didSelectNode:(GJOptionNode*)theNode;

@end