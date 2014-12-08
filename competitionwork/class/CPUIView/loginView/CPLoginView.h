//
//  CPLoginView.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-23.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPBaseViewController.h"

typedef void(^loginBackBlock)(void);

@interface CPLoginView : CPBaseViewController

@property (nonatomic,copy) loginBackBlock loginBlock;

@end
