//
//  CPPersonalTableViewCell.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPPersonalTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *textInput;

@property (nonatomic,strong) NSString *placeHolder;

@property(nonatomic,getter = isHiddenBottomBorder) BOOL hiddenBottomBorder;

@property(nonatomic,getter = isHiddenTopBorder) BOOL hiddenTopBorder;

@property(nonatomic,getter = isHiddenDownBorder) BOOL hiddenDownBorder;

@property (nonatomic,strong) NSString *Number;

@end
