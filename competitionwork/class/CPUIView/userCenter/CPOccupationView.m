//
//  CPOccupationView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-7.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPOccupationView.h"
#import "CPUserInforCenter.h"
@interface CPOccupationView ()

@property (nonatomic,strong) PeopleCoreModel *myModel;

@property (nonatomic,strong) UIImageView * imageBlock ;

@property (nonatomic,strong) UILabel *muBiaoLabel;

@property (nonatomic,strong) UILabel *zhuanTaiLabel;

@end

@implementation CPOccupationView

-(instancetype)initWithFrame:(CGRect)frame withData:(PeopleCoreModel*)model{
    
    if (self = [super initWithFrame:frame]) {
        
        CPPeopleInforCenterModel * user = [[CPUserInforCenter sharedInstance]getPeopleData];
        
        self.myModel = model;
        
        self.backgroundColor = [UIColor whiteColor];
        [self CreatNormalView];
        
        [self addSubview:self.muBiaoLabel];
        [self setMuBiaoLabelStr:[NSString stringWithFormat:@"家乡:%@",user.hometown_province]];
        
        [self addSubview:self.zhuanTaiLabel];
        [self setZhuanTaiLabelStr:[NSString stringWithFormat:@"住址:%@",user.address_province]];
        
    }
    
    return self;
}

-(void)CreatNormalView{
    
    self.imageBlock = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的列表色块"]];
    _imageBlock.frame = CGRectMake(0, 0, _imageBlock.frame.size.width/2, _imageBlock.frame.size.height/2);
    [self addSubview:_imageBlock];
    
    UILabel * labelBlock = [[UILabel alloc]initWithFrame:_imageBlock.bounds];
    labelBlock.text = @"信息";
    labelBlock.textAlignment = NSTextAlignmentCenter;
    labelBlock.textColor = [UIColor whiteColor];
    [_imageBlock addSubview:labelBlock];
    
    
    UILabel * educationLabel = [[UILabel alloc]init];
    educationLabel.text = @"Occupation";
    educationLabel.font = [UIFont fontWithName:@"Marion" size:32];
    educationLabel.textColor = GJColor(149, 183, 194, 1);
    [educationLabel sizeToFit];
    [self addSubview:educationLabel];
    [[educationLabel.po_frameBuilder alignRightOfView:_imageBlock offset:15]alignToTopInSuperviewWithInset:15];
    
}

-(UILabel *)muBiaoLabel{
    
    if (!_muBiaoLabel) {
        _muBiaoLabel = [[UILabel alloc]init];
        _muBiaoLabel.font = [UIFont systemFontOfSize:16];
        _muBiaoLabel.textColor = [UIColor grayColor];
        
    }
    return _muBiaoLabel;
}

-(UILabel *)zhuanTaiLabel{
    
    if (!_zhuanTaiLabel) {
        _zhuanTaiLabel = [[UILabel alloc]init];
        _zhuanTaiLabel.font = [UIFont systemFontOfSize:16];
        _zhuanTaiLabel.textColor = [UIColor grayColor];
        
    }
    return _zhuanTaiLabel;

}

-(void)setMuBiaoLabelStr:(NSString *)muBiao{
    
    if (_muBiaoLabel.text != muBiao) {
        _muBiaoLabel.text = muBiao;
        [_muBiaoLabel sizeToFit];
        [_muBiaoLabel.po_frameBuilder setWidth:200];
        [self layoutSubviews];
    }

}

-(void)setZhuanTaiLabelStr:(NSString *)zhuanTai{
    
    if (_zhuanTaiLabel.text != zhuanTai) {
        _zhuanTaiLabel.text = zhuanTai;
        [_zhuanTaiLabel sizeToFit];
        [_zhuanTaiLabel.po_frameBuilder setWidth:200];
        [self layoutSubviews];
    }

}

-(void)layoutSubviews{
    
    [[self.muBiaoLabel.po_frameBuilder alignRightOfView:self.imageBlock offset:16]alignToBottomOfView:self.imageBlock offset:3];
    
    [[self.zhuanTaiLabel.po_frameBuilder alignToBottomOfView:self.muBiaoLabel offset:5]setX:self.muBiaoLabel.frame.origin.x];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
