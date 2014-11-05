//
//  GJFilterBarItem.h
//  HouseRent
//
//  Created by liruiqin on 13-12-3.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJOptionNode.h"

@interface GJFilterBarItem : UIView

@property(nonatomic) GJOptionNode *itemData;

@property(nonatomic) UIButton *textButton;


-(id)initWithDefaultStyle;

@end
