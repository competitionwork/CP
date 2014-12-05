//
//  GJUserCenterHeadViewCell.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-5.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "GJUserCenterHeadViewCell.h"

@interface GJUserCenterHeadViewCell ()

@end

@implementation GJUserCenterHeadViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.sexImage];
        _sexImage.image = [UIImage imageNamed:@"投递简历-选中"];
    }
    return self;
}

-(UIImageView *)sexImage{
    if (!_sexImage) {
        _sexImage = [[UIImageView alloc]init];
    }
    return _sexImage;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [[self.imageView.po_frameBuilder alignLeftInSuperviewWithInset:8]centerVerticallyInSuperview];
    [[[self.textLabel.po_frameBuilder alignRightOfView:self.imageView offset:5]alignToTopInSuperviewWithInset:5]setHeight:25];
    [[[[self.sexImage.po_frameBuilder alignToBottomOfView:self.textLabel offset:5]alignRightOfView:self.imageView offset:8]setHeight:20]setWidth:20];
    
}


+(CGFloat)heightForRow{
    return 80;
}

@end
