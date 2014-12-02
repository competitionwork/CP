//
//  CPUIViewControllerClassify.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-25.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIViewController(CPNavigation)

-(void)setNavigationLeftButton:(UIViewController *)target withSelector:(SEL)selector withImage:(NSString *)imgName withHImgae:(NSString *)hImageName;
-(void)setNavigationLeftButton:(UIViewController *)target withSelector:(SEL)selector withTitle:(NSString *)titleString;
-(void)setNavigationRightButton:(UIViewController *)target withSelector:(SEL)selector withTitle:(NSString *)titleString;
-(void)setNavigationRightButton:(UIViewController *)target withSelector:(SEL)selector withImage:(NSString *)imgName withHImgae:(NSString *)hImageName;

@end

@interface CPNavigationBar : UINavigationBar


-(UIImage*)getImagePingPu:(UIImage*)image;
+(UINavigationController*)NavigationControllerWithGJBar;
@end