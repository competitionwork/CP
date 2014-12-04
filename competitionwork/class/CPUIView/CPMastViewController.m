//
//  CPMastViewController.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-10-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPMastViewController.h"
#import "CPMainViewController.h"
#import "CPDynamicViewController.h"
#import "CPUserCenterVC.h"
@interface CPMastViewController ()

@property (nonatomic, retain) UIView * tabbarView;

@end

@implementation CPMastViewController
@synthesize tabbarView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.view.backgroundColor = [UIColor yellowColor];
    [self _initTabbar];
    [self _initViewController];
    self.selectedIndex = 1;
    // Do any additional setup after loading the view.
}



-(void)_initViewController{
    CPMainViewController * home = [[CPMainViewController alloc]init];
    CPDynamicViewController * dynamic = [[CPDynamicViewController alloc]init];
    CPUserCenterVC * userCenter = [[CPUserCenterVC alloc]init];
    
    NSArray * views = @[home,dynamic,userCenter];
    NSMutableArray * viewControllers = [[NSMutableArray alloc]initWithCapacity:3];
    
    for (UIViewController * viewController in views) {
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        [viewControllers addObject:nav];
    }
    
    self.viewControllers = viewControllers;
    
}


-(void)_initTabbar{
    
    tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight - 49-20, MainScreenWidth, 49)];
    
    [self.view addSubview:tabbarView];
    
    UIImageView * tabbargroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_background.png"]];
    tabbargroundImage.frame = tabbarView.bounds;
    [tabbarView addSubview:tabbargroundImage];
    
    
    NSArray * images = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_message_center.png"];
    NSArray * imageHights = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_message_center_highlighted.png"];
    
    for (int i = 0; i<images.count; i++) {
        NSString * backImage = [images objectAtIndex:i];
        NSString * hightImage = [imageHights objectAtIndex:i];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0+(i*(MainScreenWidth/3)), (49-30)/2, MainScreenWidth/3, 30);
        
        button.tag = i;
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:button];
    }
}
-(void)selectedTab:(UIButton*)button{
    self.selectedIndex = button.tag;
    
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
