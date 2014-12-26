//
//  AttentionView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-6.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "AttentionView.h"
#import "UIButton+Block.h"
#import "CPAPIHelper_severURL.h"
#import "CPUserInforCenter.h"

@interface AttentionView ()




@end


@implementation AttentionView
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        self.AttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.AttentionButton];
        self.AttentionButton.frame = self.bounds;
        [[[[[self.AttentionButton.po_frameBuilder setWidth:48.5] setHeight:23] setX:0.5]alignToTopInSuperviewWithInset:8]centerHorizontallyInSuperview];
        [self.AttentionButton setBackgroundImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        [self.AttentionButton setBackgroundImage:[UIImage imageNamed:@"已关注"] forState:UIControlStateHighlighted];
        [self.AttentionButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.AttentionButton setTitle:@"已关注" forState:UIControlStateHighlighted];
        self.AttentionButton.titleLabel.font = [UIFont systemFontOfSize:12];
        self.AttentionButton.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIImage *)buttonHightlightedImage {
    UIImageView *view = [[UIImageView alloc] initWithFrame:(CGRect){0,0,97,46}];
    view.backgroundColor = GJColor(229, 229, 229, 1);
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)setContent:(NSDictionary *)content{
    _content = content;
    [self setNeedsLayout];
}

-(void)setIsFollow:(BOOL)isFollow{
    _isFollow = isFollow;
    
    if (isFollow) {
        self.AttentionButton.highlighted = YES;
    }else{
        self.AttentionButton.highlighted = NO;
    }
    [self layoutSubviews];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
   __weak typeof(self) weakSelf = self;
    

    
    [self.AttentionButton setAction:kUIButtonBlockTouchInside withBlock:^{
        
        CPUserInforModel * userinfo = [[CPUserInforCenter sharedInstance]getUsetData];
        
        NSDictionary * params = @{@"uid":userinfo.uid,
                                  @"c_id":weakSelf.content[@"contest_id"]
                                  };
        
        DLog(@"点击关注%@",weakSelf.content);
        
        if (!weakSelf.isFollow) {
            
            [[CPAPIHelper_severURL sharedInstance]api_add_follow_withParams:params whenSuccess:^(id result) {
                
                weakSelf.isFollow = YES;
                weakSelf.AttentionButton.highlighted = YES;
                
            } andFailed:^(id err) {
                
            }];

        }else{
            
            [[CPAPIHelper_severURL sharedInstance]api_cancle_follow_withParams:params whenSuccess:^(id result) {
                
                weakSelf.isFollow = NO;
                weakSelf.AttentionButton.highlighted = NO;

                
            } andFailed:^(id err) {
                
            }];
        }
        
        
    }];
}

+ (CGFloat)widthForPhoneView:(NSDictionary *)aContent {
    return 64;
}

@end
