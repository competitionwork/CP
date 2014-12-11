//
//  CPEssenceTableViewCell.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-10.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPEssenceTableViewCell.h"
#import "UIImageView+AFNetworking.h"
@implementation CPEssenceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.authorLabel.textColor = kCPBlueColor;
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        self.authorLabel.textColor = kCPBlueColor;
    }
    return self;
}

-(void)setleftImagewithUrl:(NSString*)url{
    
    url = [NSString stringWithFormat:@"%@%@",IMAGE_URL,url];
    
    [self.leftImage setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

- (void)awakeFromNib {
    // Initialization code
    self.authorLabel.textColor = kCPBlueColor;

}

-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
