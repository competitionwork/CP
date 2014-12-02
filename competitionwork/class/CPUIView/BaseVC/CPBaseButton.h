//
//  CPBaseButton.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBlock)(UIButton*);

@interface CPBaseButton : UIButton

@property (nonatomic,copy) clickBlock Block;

-(void)setStylesWithTitle:(NSString*)title;

@end
