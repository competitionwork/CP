//
//  CPEssenceTableViewCell.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-10.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPEssenceTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

-(void)setleftImagewithUrl:(NSString*)url;

@end
