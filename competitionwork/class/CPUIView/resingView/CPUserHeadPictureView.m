//
//  CPUserHeadPictureView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUserHeadPictureView.h"
#import "CPAPIHelper_setting.h"

@interface CPUserHeadPictureView()

@property (nonatomic,strong) UIImageView *headImageV;

@property (nonatomic,strong) UILabel *headLabel;

@property (nonatomic,strong) UIActivityIndicatorView *activityView;

@end

@implementation CPUserHeadPictureView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.headImageV];
        [self.headImageV.po_frameBuilder centerInSuperview];
        
        [self addSubview:self.headLabel];
        [[self.headLabel.po_frameBuilder alignToBottomOfView:self.headImageV offset:5] centerHorizontallyInSuperview];
        
        [self.headImageV addSubview:self.activityView];
        [self.activityView.po_frameBuilder centerInSuperview];
        
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

-(UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityView;
}

-(void)tapWithImageView{
    _Block(self.headImageV);
}

-(UIImageView *)getHeadView{
    return _headImageV;
}

-(void)setHeadWithImage:(UIImage*)image{
    
    _headImageV.image = image;
    [[_headImageV.po_frameBuilder setHeight:64]setWidth:64];
    _headImageV.layer.masksToBounds =YES;
    _headImageV.layer.cornerRadius =32.0;
    _headImageV.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImageV.layer.borderWidth =3.0f;
    _headImageV.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _headImageV.layer.shouldRasterize =YES;
    _headImageV.clipsToBounds = YES;
    
    self.headLabel.text = @"";
    [self.activityView startAnimating];
    
    [self upLoadTheHeadImage:_headImageV.image];
}

-(void)startAnimating{
    
    [self.activityView startAnimating];
    
}

-(void)stopAnimating{
    
    [self.activityView stopAnimating];
    
}

-(void)upLoadTheHeadImage:(UIImage*)headimage{
    
    NSData *imageData = UIImageJPEGRepresentation(headimage, 0.8);
    
    NSDictionary * params = @{@"uid":@"2345",
                              @"utoken":@"143436sfds",
                              @"user_file":imageData,
                              
                              };

    __weak typeof(*&self) weakSelf = self;
    
    [[CPAPIHelper_setting sharedInstance]api_ajax_avatar_withParams:params whenSuccess:^(id result) {
        DLog(@"image up =%@",result);
        [weakSelf.activityView stopAnimating];
    } andFailed:^(id err) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
