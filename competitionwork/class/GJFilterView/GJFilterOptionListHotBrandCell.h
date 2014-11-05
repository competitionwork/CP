//
//  GJFilterOptionListHotBrandCell.h
//  HouseRent
//
//  Created by liruiqin on 13-12-17.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJOptionNode.h"
#import "UIButton+eventHandler.h"

@interface GJFilterOptionListHotBrandCell : UITableViewCell

@property(nonatomic) NSInteger numberOfColumn;
@property(nonatomic,weak) NSArray *nodes;
@property(nonatomic,copy) void(^didSelectedNode)(GJOptionNode* node);
+ (CGFloat)cellHeightForData:(id)data;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
