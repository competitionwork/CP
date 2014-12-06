//
//  CPEducationView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-6.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPEducationView.h"
#import "PeopleCoreModel.h"

@interface CPEducationView ()

@property (nonatomic,strong) PeopleCoreModel *myModel;

@property (nonatomic,strong) UIImageView * imageBlock ;

@property (nonatomic,strong) UILabel *schoolLabel;

@property (nonatomic,strong) UILabel *leveLabel;

@property (nonatomic,strong) UILabel *studentLabel;

@property (nonatomic,strong) UILabel *specializedLabel;

@property (nonatomic,strong) UILabel *classLabel;

@end


@implementation CPEducationView

-(instancetype)initWithFrame:(CGRect)frame withData:(PeopleCoreModel*)model{
    
    if (self = [super initWithFrame:frame]) {
        
        self.myModel = model;
        
        self.backgroundColor = [UIColor whiteColor];
        [self CreatNormalView];
        
        [self addSubview:self.schoolLabel];
        [self setSchoolLabelStr:@"北京理工大学珠海学院 信工程系999999"];
        
        [self addSubview:self.leveLabel];
        [self setLeveLabelStr:@"2014级"];
        
        [self addSubview:self.studentLabel];
        [self setStudentLabelStr:@"大学生"];
        
        [self addSubview:self.specializedLabel];
        [self setSpecializedLabelStr:@"计算机专业"];

        [self addSubview:self.classLabel];
        [self setClassLabelStr:@"学生会主席"];

        
    }
    
    return self;
}

-(void)CreatNormalView{
    
    self.imageBlock = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的列表色块"]];
    _imageBlock.frame = CGRectMake(0, 0, _imageBlock.frame.size.width/2, _imageBlock.frame.size.height/2);
    [self addSubview:_imageBlock];
    
    UILabel * labelBlock = [[UILabel alloc]initWithFrame:_imageBlock.bounds];
    labelBlock.text = @"教育";
    labelBlock.textAlignment = NSTextAlignmentCenter;
    labelBlock.textColor = [UIColor whiteColor];
    [_imageBlock addSubview:labelBlock];
    
    
    UILabel * educationLabel = [[UILabel alloc]init];
    educationLabel.text = @"Education";
    educationLabel.font = [UIFont fontWithName:@"Marion" size:32];
    educationLabel.textColor = GJColor(149, 183, 194, 1);
    [educationLabel sizeToFit];
    [self addSubview:educationLabel];
    [[educationLabel.po_frameBuilder alignRightOfView:_imageBlock offset:15]alignToTopInSuperviewWithInset:15];

}

-(UILabel *)schoolLabel{
    
    if (!_schoolLabel) {
        _schoolLabel = [[UILabel alloc]init];
        _schoolLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _schoolLabel;
}

-(UILabel *)leveLabel{
    
    if (!_leveLabel) {
        _leveLabel = [[UILabel alloc]init];
        _leveLabel.font = [UIFont systemFontOfSize:16];
        _leveLabel.textColor = [UIColor grayColor];
        
    }
    return _leveLabel;
}

- (UILabel *)studentLabel{
    
    if (!_studentLabel) {
        _studentLabel = [[UILabel alloc]init];
        _studentLabel.font = [UIFont systemFontOfSize:16];
        _studentLabel.textColor = [UIColor grayColor];
        
    }
    return _studentLabel;
}

-(UILabel *)specializedLabel{
    
    if (!_specializedLabel) {
        _specializedLabel = [[UILabel alloc]init];
        _specializedLabel.font = [UIFont systemFontOfSize:16];
        _specializedLabel.textColor = [UIColor grayColor];
        
    }
    return _specializedLabel;

}

-(UILabel *)classLabel{
    
    if (!_classLabel) {
        _classLabel = [[UILabel alloc]init];
        _classLabel.font = [UIFont systemFontOfSize:16];
        _classLabel.textColor = [UIColor grayColor];
        
    }
    return _classLabel;
    
}

-(void)setSchoolLabelStr:(NSString *)school{
    
    if (_schoolLabel.text != school) {
        _schoolLabel.text = school;
        [_schoolLabel sizeToFit];
        [_schoolLabel.po_frameBuilder setWidth:(self.width - _imageBlock.size.width -16) ];
        [self layoutSubviews];
    }
    
}

-(void)setLeveLabelStr:(NSString *)leve{
    
    if (_leveLabel.text != leve) {
        _leveLabel.text = leve;
        [_leveLabel sizeToFit];
        [_leveLabel.po_frameBuilder setWidth:70];
        [self layoutSubviews];
    }

}

-(void)setStudentLabelStr:(NSString *)student{
    
    if (_studentLabel.text != student) {
        _studentLabel.text = student;
        [_studentLabel sizeToFit];
        [_studentLabel.po_frameBuilder setWidth:70];
        [self layoutSubviews];
    }

}

-(void)setSpecializedLabelStr:(NSString *)specialized{
    
    if (_specializedLabel.text != specialized) {
        _specializedLabel.text = specialized;
        [_specializedLabel sizeToFit];
        [_specializedLabel.po_frameBuilder setWidth:70];
        [self layoutSubviews];
    }

}

-(void)setClassLabelStr:(NSString *)class{
 
    if (_classLabel.text != class) {
        _classLabel.text = class;
        [_classLabel sizeToFit];
        [_classLabel.po_frameBuilder setWidth:70];
        [self layoutSubviews];
    }

}

-(void)layoutSubviews{
    
    [[self.schoolLabel.po_frameBuilder alignRightOfView:self.imageBlock offset:16]alignToBottomOfView:self.imageBlock offset:3];
    
    [[self.leveLabel.po_frameBuilder alignToBottomOfView:self.schoolLabel offset:5]setX:self.schoolLabel.frame.origin.x];
    
    [[self.studentLabel.po_frameBuilder alignToBottomOfView:self.schoolLabel offset:5]alignRightOfView:self.leveLabel offset:8];
    
    [[self.specializedLabel.po_frameBuilder alignToBottomOfView:self.studentLabel offset:5]setX:self.schoolLabel.frame.origin.x];

    [[self.classLabel.po_frameBuilder alignToBottomOfView:self.studentLabel offset:5]alignRightOfView:self.specializedLabel offset:8];


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
