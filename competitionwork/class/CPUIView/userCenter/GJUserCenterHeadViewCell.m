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
        
        [self.contentView addSubview:self.leftImage];
        
        [self.contentView addSubview:self.textStrLabel];
        
        [self.contentView addSubview:self.ageLabel];
        
    }
    return self;
}

-(UIImageView *)sexImage{
    if (!_sexImage) {
        _sexImage = [[UIImageView alloc]init];
    }
    return _sexImage;
}

-(UIImageView *)leftImage{
    
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _leftImage.layer.masksToBounds = YES;
        _leftImage.layer.cornerRadius = 25;
        _leftImage.backgroundColor = [UIColor blackColor];
        _leftImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _leftImage.layer.borderWidth = 3.0f;
    }
    return _leftImage;
}



-(UILabel *)textStrLabel{
    
    if (!_textStrLabel) {
        _textStrLabel = [[UILabel alloc]init];
        _textStrLabel.font = [UIFont systemFontOfSize:16];
    }
    return _textStrLabel;
    
}

-(UILabel *)ageLabel{
    
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc]init];
        _ageLabel.font = [UIFont systemFontOfSize:13];
        _ageLabel.textAlignment = NSTextAlignmentLeft;
        _ageLabel.textColor = [UIColor whiteColor];
    }
    return _ageLabel;

}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [[[[self.leftImage.po_frameBuilder setHeight:50]setWidth:50]alignLeftInSuperviewWithInset:8]centerVerticallyInSuperview];
    
    [[[[self.textStrLabel.po_frameBuilder setHeight:25] setWidth:200]alignRightOfView:self.leftImage offset:5]alignToTopInSuperviewWithInset:15];
    
    [[[[self.sexImage.po_frameBuilder setHeight:14]setWidth:32] alignToBottomOfView:self.textStrLabel offset:5]alignRightOfView:self.leftImage offset:8];
    
    [[[[self.ageLabel.po_frameBuilder setHeight:14]setWidth:20]alignToBottomOfView:self.textStrLabel offset:5]alignRightOfView:self.leftImage offset:21];
    
}


+(CGFloat)heightForRow{
    return 80;
}

@end
