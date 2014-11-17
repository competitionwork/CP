//
//  CPDetailItemView.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-14.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPDetailItemView : UIView

@end


@interface CPPostDetailAttrsView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

@interface CPDetailEntersView : UIView

@property (nonatomic, strong) UILabel *labelNumber;

@property (nonatomic, strong) NSArray * EntersDict;

-(instancetype)initWithData:(NSArray *)dataDict;


@end