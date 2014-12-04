//
//  CPDynamicViewController.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-10-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPDynamicViewController.h"
#import "CPLoginView.h"
#import "AppDelegate.h"

@interface CPDynamicViewController ()

@end

@implementation CPDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    [self showLoginView];
    [self setNavigationLeftButton:self withSelector:nil withImage:nil withHImgae:nil];
}

-(void)showLoginView{
    
    AppDelegate * app = [AppDelegate sharedAppDelegate];
    
    if (!app.userInforCenter.isLoginSuccess) {
        
        CPLoginView * loginView = [[CPLoginView alloc]initWithNibName:nil bundle:nil];

        [self.navigationController pushViewController:loginView animated:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
