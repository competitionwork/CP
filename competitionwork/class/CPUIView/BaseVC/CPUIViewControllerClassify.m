//
//  CPUIViewControllerClassify.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-25.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUIViewControllerClassify.h"



@interface UIViewController(Navigation)

-(void)setNavigationLeftButton:(UIViewController *)target withSelector:(SEL)selector withImage:(NSString *)imgName withHImgae:(NSString *)hImageName;
-(void)setNavigationLeftButton:(UIViewController *)target withSelector:(SEL)selector withTitle:(NSString *)titleString;
-(void)setNavigationRightButton:(UIViewController *)target withSelector:(SEL)selector withTitle:(NSString *)titleString;
-(void)setNavigationRightButton:(UIViewController *)target withSelector:(SEL)selector withImage:(NSString *)imgName withHImgae:(NSString *)hImageName;

@end