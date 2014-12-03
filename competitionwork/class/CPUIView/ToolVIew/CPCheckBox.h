//
//  CPCheckBox.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^checkBoxBlock)(void);

@interface CPCheckBox : UIView

@property (nonatomic,copy) checkBoxBlock checkBlock;

-(BOOL)getSelectCheckBox;

@end
