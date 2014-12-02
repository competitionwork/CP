//
//  CPUserHeadPictureView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUserHeadPictureView.h"

@interface CPUserHeadPictureView()

@property (nonatomic,strong) UIImageView *headImageV;

@property (nonatomic,strong) UILabel *headLabel;

@end

@implementation CPUserHeadPictureView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.headImageV];
        [self.headImageV.po_frameBuilder centerInSuperview];
        
        [self addSubview:self.headLabel];
        [[self.headLabel.po_frameBuilder alignToBottomOfView:self.headImageV offset:5] centerHorizontallyInSuperview];
        
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithImageView)];
        [self.headImageV addGestureRecognizer:tap];
        
    }
    return self;
}

-(UIImageView *)headImageV{
    if (!_headImageV) {
        
        _headImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"个人中心-头像列表"]];
        _headImageV.userInteractionEnabled = YES;
        
    }
    return _headImageV;
}


-(UILabel *)headLabel{
    if (!_headLabel) {
        
        _headLabel = [[UILabel alloc]init];
        _headLabel.text = @"上传头像";
        _headLabel.font = [UIFont systemFontOfSize:12];
        [_headLabel sizeToFit];
        _headLabel.textColor = [UIColor grayColor];
        
    }
    return _headLabel;
}

-(void)tapWithImageView{
    _Block(self.headImageV);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
