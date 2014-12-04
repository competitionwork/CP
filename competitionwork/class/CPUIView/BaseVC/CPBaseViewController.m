//
//  CPBaseViewController.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-25.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPBaseViewController.h"
#import "CPUIViewControllerClassify.h"
#import "AppDelegate.h"

@interface CPBaseViewController ()

@end

@implementation CPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackButton:self withSelector:@selector(goBack)];
    
    [self.navigationController.navigationBar setBackgroundImage:getimagePINGPU([UIImage imageNamed:@"title平铺X64"]) forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(BOOL)hidesBottomBarWhenPushed{
    
    AppDelegate * app = [AppDelegate sharedAppDelegate];
    
    if ([super hidesBottomBarWhenPushed]) {
        [app.MastVC setHidesBottomBarWhenPushed:YES];
    }else{
        [app.MastVC setHidesBottomBarWhenPushed:NO];
    }
    
    
    return [super hidesBottomBarWhenPushed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static inline UIImage* getimagePINGPU(UIImage *image)
{
    UIGraphicsBeginImageContext(CGSizeMake(MainScreenWidth, image.size.height));
    [image drawAsPatternInRect:CGRectMake(0, 0, MainScreenWidth, image.size.height)];
    UIImage * bac_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return bac_image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
