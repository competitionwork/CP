//
//  CPUIViewControllerClassify.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-25.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>


@implementation UIViewController(CPNavigation)

-(void)setNavigationLeftButton:(UIViewController *)target withSelector:(SEL)selector withImage:(NSString *)imgName withHImgae:(NSString *)hImageName {
    UIImage *iconClickBg = [UIImage imageNamed:@"icon点击背景"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *iconImg = [UIImage imageNamed:imgName];
    UIImage *iconHimg = [UIImage imageNamed:hImageName];
    [btn setFrame:CGRectMake(0, 0, 43, 32)];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[iconClickBg stretchableImageWithLeftCapWidth:iconClickBg.size.width/2 topCapHeight:iconClickBg.size.height/2] forState:UIControlStateHighlighted];
    [btn setImage:iconImg forState:UIControlStateNormal];
    [btn setImage:iconHimg forState:UIControlStateHighlighted];
    
    [self setNavigationLeftView:btn];
}

-(void)setNavigationLeftButton:(UIViewController *)target withSelector:(SEL)selector withTitle:(NSString *)titleString;
{
    UIImage *img = [UIImage imageNamed:@"button34px.png"];
    UIImage *himg = [UIImage imageNamed:@"button34px-点击态.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect rect;
    if (titleString.length >2) {
        rect = CGRectMake(4, 0, 63, 34);
        [btn setFrame:rect];
    } else {
        rect = CGRectMake(4, 0, 55, 34);
        [btn setFrame:rect];
    }
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[img stretchableImageWithLeftCapWidth:floorf(img.size.width/2.0) topCapHeight:floorf(img.size.height/2.0)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[himg stretchableImageWithLeftCapWidth:floorf(himg.size.width/2.0) topCapHeight:floorf(himg.size.height/2.0)] forState:UIControlStateHighlighted];
    
    [btn setTitle:titleString forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font =  [UIFont systemFontOfSize:14];
    
    UIView *backButtonView = [[UIView alloc] initWithFrame:rect];
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, 3, 0);
    [backButtonView addSubview:btn];
    UIBarButtonItem* barBtn = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    target.navigationItem.leftBarButtonItem = barBtn;
    [self.navigationController.view setExclusiveTouch:YES];
}


-(void)setNavigationRightButton:(UIViewController *)target withSelector:(SEL)selector withImage:(NSString *)imgName withHImgae:(NSString *)hImageName{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *iconImg = [UIImage imageNamed:imgName];
    UIImage *iconHimg = [UIImage imageNamed:hImageName];
    [btn setFrame:CGRectMake(0, 0, 43, 32)];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:iconImg forState:UIControlStateNormal];
    [btn setImage:iconHimg forState:UIControlStateHighlighted];
    
    [self setNavigationRightView:btn];
}
- (void)setNavigationRightButton:(UIViewController *)target withSelector:(SEL)selector withTitle:(NSString *)titleString {
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect;
    if (titleString.length >2) {
        rect = CGRectMake(5, 0, 64, 32);
        [btn setFrame:rect];
        
        if (titleString.length > 3) {
            rect = CGRectMake(-4, 0, 64, 32);
            [btn setFrame:rect];
        }
        
        
    } else {
        rect = CGRectMake(5, 0, 55, 32);
        [btn setFrame:rect];
    }
    [btn setExclusiveTouch:YES];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:titleString forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:(UIControlStateHighlighted)];
    btn.titleLabel.font =  [UIFont systemFontOfSize:16];
    UIView *backButtonView = [[UIView alloc] initWithFrame:rect];
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, 3, 0);
    [backButtonView addSubview:btn];
    [self setNavigationRightView:backButtonView];
}


-(void)setNavigationLeftView:(UIView *)lView
{
    NSLog(@"%@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
    
    if (!lView) {
        lView = [[UIView alloc] init] ;
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lView] ;
}
-(void)setNavigationRightView:(UIView *)rView
{
    if (!rView) {
        rView = [[UIView alloc] init] ;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rView] ;
}

-(void)setNavigationLeftViewHidden:(BOOL)hide
{
    DLog(@"");
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        for (UIBarButtonItem * barButton in self.navigationItem.leftBarButtonItems) {
            barButton.customView.hidden = hide;
        }
    }
    self.navigationItem.leftBarButtonItem.customView.hidden = hide;
}
-(void)setNavigationRightViewHidden:(BOOL)hide
{
    DLog(@"");
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        for (UIBarButtonItem * barButton in self.navigationItem.rightBarButtonItems) {
            barButton.customView.hidden = hide;
        }
    }
    self.navigationItem.rightBarButtonItem.customView.hidden = hide;
}


@end