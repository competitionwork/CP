//
//  PeopleHeadView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-6.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "PeopleHeadView.h"
#import "CPUserInforCenter.h"

@interface PeopleHeadView ()

@property (nonatomic,strong) UIImageView *backGroundImage;

@property (nonatomic,strong) UIImageView *peopleHeadView;

@property (nonatomic,strong) UIImageView *sexImage;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *ageLabel;

@end

@implementation PeopleHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        CPPeopleInforCenterModel *people = [[CPUserInforCenter sharedInstance]getPeopleData];
        
        [self addSubview:self.backGroundImage];
        
        [self addSubview:self.peopleHeadView];
        
        [self addSubview:self.nameLabel];
        [self setNameLabelStr:people.real_name];
        
        [self addSubview:self.sexImage];
        
        [self addSubview:self.ageLabel];
        [self setAgeLabelStr:@"22岁  水瓶座"];
    }
    
    return self;
}


-(UIImageView *)backGroundImage{
    
    if (!_backGroundImage) {
        
        _backGroundImage = [[UIImageView alloc]initWithFrame:self.bounds];
        _backGroundImage.image = [UIImage imageNamed:@"CenterBack"];
        
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

-(UIImageView *)sexImage{
    
    if (!_sexImage) {
        _sexImage = [[UIImageView alloc]init];
    }
    
    return _sexImage;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
        
    }
    return _nameLabel;
}

-(void)setNameLabelStr:(NSString *)name{
    
    if (_nameLabel.text != name) {
        _nameLabel.text = name;
        [_nameLabel sizeToFit];
        [self layoutSubviews];
    }
}

-(UILabel *)ageLabel{
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc]init];
        _ageLabel.textColor = [UIColor whiteColor];
        _ageLabel.font = [UIFont systemFontOfSize:14];
    }
    return _ageLabel;
}

-(void)setAgeLabelStr:(NSString *)age{
    
    if (_ageLabel.text != age) {
        _ageLabel.text = age;
        [_ageLabel sizeToFit];
        [self layoutSubviews];
    }
}

-(void)layoutSubviews{
    
    [[self.peopleHeadView.po_frameBuilder alignToTopInSuperviewWithInset:8]centerHorizontallyInSuperview];
    
    [[self.nameLabel.po_frameBuilder alignToBottomOfView:self.peopleHeadView offset:5]centerHorizontallyInSuperview];
    
    UIImage * sex = [UIImage imageNamed:@"nan"];
    self.sexImage.image = sex;
    [[[[self.sexImage.po_frameBuilder setHeight:sex.size.height/2]setWidth:sex.size.width/2]alignToBottomOfView:self.nameLabel offset:8]setX:self.nameLabel.centerX - 50];
    
    [[self.ageLabel.po_frameBuilder alignRightOfView:self.sexImage offset:5]setY:self.sexImage.frame.origin.y];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
