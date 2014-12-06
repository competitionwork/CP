//
//  PeopleHeadView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-6.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "PeopleHeadView.h"

@interface PeopleHeadView ()

@property (nonatomic,strong) UIImageView *backGroundImage;

@property (nonatomic,strong) UIImageView *peopleHeadView;

@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation PeopleHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backGroundImage];
        
        [self addSubview:self.peopleHeadView];
        
        [self addSubview:self.nameLabel];
        
    }
    
    return self;
}


-(UIImageView *)backGroundImage{
    
    if (!_backGroundImage) {
        
        _backGroundImage = [[UIImageView alloc]initWithFrame:self.bounds];
        
    }
    return _backGroundImage;
}


-(UIImageView *)peopleHeadView{
    
    if (!_peopleHeadView) {
        
        _peopleHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _peopleHeadView.layer.masksToBounds = YES;
        _peopleHeadView.layer.cornerRadius = 40;
        _peopleHeadView.backgroundColor = [UIColor blackColor];
        _peopleHeadView.layer.borderColor = [UIColor whiteColor].CGColor;
        _peopleHeadView.layer.borderWidth = 3.0f;
        
    }
    
    return _peopleHeadView;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}



-(void)layoutSubviews{
    
    [[self.peopleHeadView.po_frameBuilder alignToTopInSuperviewWithInset:8]centerHorizontallyInSuperview];
    
    [[self.nameLabel.po_frameBuilder alignToBottomOfView:self.peopleHeadView offset:5]centerVerticallyInSuperview];
    self.nameLabel.text = @"";
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
