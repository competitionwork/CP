//
//  AttentionView.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-6.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttentionView : UIView

@property (nonatomic, assign) id target;

@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic) NSDictionary *content;


+ (CGFloat)widthForPhoneView:(NSDictionary *)aContent;

@end
