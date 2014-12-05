//
//  GJListMoreCell.h
//  HouseRent
//
//  Created by Tracy on 14-4-22.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJListMoreCell : UITableViewCell

@property (nonatomic, assign) BOOL animationing;


+ (CGFloat)heightForMoreCell:(NSInteger)masterId majorId:(NSInteger)majorId;
@end
