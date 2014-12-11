//
//  CPBaseCell.h
//  competitionwork
//
//  Created by hjj on 14-12-11.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPBaseCell : UITableViewCell
@property(nonatomic,getter = isHiddenBottomBorder) BOOL hiddenBottomBorder;
@property(nonatomic,getter = isHiddenTopBorder) BOOL hiddenTopBorder;
@property(nonatomic,getter = isHiddenDownBorder) BOOL hiddenDownBorder;
@end
