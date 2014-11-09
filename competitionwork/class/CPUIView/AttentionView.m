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

@interface AttentionView ()


@property (nonatomic) UIButton *AttentionButton;


@end


@implementation AttentionView
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        self.AttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.AttentionButton];
        self.AttentionButton.frame = self.bounds;
        [[self.AttentionButton.po_frameBuilder setWidth:63.5] setX:0.5];
        [self.AttentionButton setImage:[UIImage imageNamed:@"列表页-电话"] forState:UIControlStateNormal];
        [self.AttentionButton setImage:[UIImage imageNamed:@"列表页-电话-点击"] forState:UIControlStateHighlighted];
        self.AttentionButton.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (UIImage *)buttonHightlightedImage {
    UIImageView *view = [[UIImageView alloc] initWithFrame:(CGRect){0,0,64,85}];
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

-(void)layoutSubviews{
    [super layoutSubviews];
    
   __weak typeof(self) weakSelf = self;
    
    
    
    [self.AttentionButton setAction:kUIButtonBlockTouchInside withBlock:^{
        
        
        NSDictionary * params = @{@"uid":weakSelf.content[@"contest_id"],
                                  @"c_id":@""
                                  };
        
        DLog(@"点击关注%@",weakSelf.content);
        
        if (weakSelf.isFollow) {
            
            [[CPAPIHelper_severURL sharedInstance]api_add_follow_withParams:params whenSuccess:^(id result) {
                
                weakSelf.isFollow = !weakSelf.isFollow;
                
            } andFailed:^(id err) {
                
            }];

        }else{
            
            [[CPAPIHelper_severURL sharedInstance]api_cancle_follow_withParams:params whenSuccess:^(id result) {
                
                weakSelf.isFollow = !weakSelf.isFollow;

                
            } andFailed:^(id err) {
                
            }];
        }
        
        
    }];
}

+ (CGFloat)widthForPhoneView:(NSDictionary *)aContent {
    return 64;
}

@end
