//
//  UIImageView+xiaolvAnimation.m
//  HouseRent
//
//  Created by Tracy on 14-4-22.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "UIImageView+xiaolvAnimation.h"

@implementation UIImageView (xiaolvAnimation)
+ (UIImageView *)listViewRefreshAnimation {
    
    return [[UIImageView alloc]init];
    
    
    UIImageView *animationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaolvAnimation1"]];
    animationView.size = (CGSize){76,45};
    NSMutableArray *animationArr = [NSMutableArray array];
    for (int i = 1; i <= 7 ; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"xiaolvAnimation%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [animationArr addObject:image];
    }
    animationView.animationImages = animationArr;
    animationView.animationDuration = 1.2;
    return animationView;
}

+(UIImageView *)loadViewAnimation
{
    UIImageView *animationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"跑1"]];
    animationView.size = (CGSize){260/2,300/2};
    NSMutableArray *animationArr = [NSMutableArray array];
    for (int i = 1; i <= 4 ; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"跑%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [animationArr addObject:image];
    }
    animationView.animationImages = animationArr;
    animationView.animationDuration = 0.25;
    return animationView;
}
@end
