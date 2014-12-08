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

@property (nonatomic,strong) NSMutableArray *itemImages;

@property (nonatomic,strong) NSMutableArray *itemLabels;

@end

@implementation CPMastViewController
@synthesize tabbarView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBar.barStyle = UIBarStyleBlackOpaque;
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


-(NSMutableArray *)itemImages{
    if (!_itemImages) {
        _itemImages = [[NSMutableArray alloc]init];
    }
    return _itemImages;
}

-(NSMutableArray *)itemLabels{
    if (!_itemLabels) {
        _itemLabels = [[NSMutableArray alloc]init];
    }
    return _itemLabels;
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
    
    tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight - 49, MainScreenWidth, 49)];
    tabbarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabbarView];
    
    UIView * topBorder=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 0.5)];
    topBorder.backgroundColor = RGBCOLOR(179, 179, 179);
    [self.tabbarView addSubview:topBorder];
    
    NSArray * images = @[@"jj1",@"lt1",@"wd1"];
    NSArray * imageHights = @[@"jj2",@"lt2",@"wd2"];
    NSArray * titleStr = @[@"竞赛",@"首页",@"个人中心"];
    
    for (int i = 0; i<images.count; i++) {
                
        NSString * backImage = [images objectAtIndex:i];
        NSString * hightImage = [imageHights objectAtIndex:i];
        
        UIImageView * itemImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:backImage]];
        itemImage.highlightedImage = [UIImage imageNamed:hightImage];
        
        UILabel * itemLabel = [[UILabel alloc]init];
        itemLabel.text = [titleStr objectAtIndex:i];
        itemLabel.font = [UIFont systemFontOfSize:10];
        [itemLabel sizeToFit];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.highlightedTextColor = GJColor(30, 114, 214, 1);
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0+(i*(MainScreenWidth/3)), (49-30)/2, MainScreenWidth/3, 30);
        
        button.tag = i;
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:button];
        
        
        [button addSubview:itemImage];
        [self.itemImages addObject:itemImage];
        [[[[itemImage.po_frameBuilder setHeight:23.5] setWidth:22.5]alignToTopInSuperviewWithInset:0]centerHorizontallyInSuperview];
        
        [button addSubview:itemLabel];
        [self.itemLabels addObject:itemLabel];
        [[itemLabel.po_frameBuilder alignToBottomOfView:itemImage offset:2]centerHorizontallyInSuperview];
    }
}

-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed{
    [super setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
    
    self.tabBar.alpha = 0;

    if (hidesBottomBarWhenPushed) {
        
        [UIView animateWithDuration:0.27 animations:^{
            self.tabbarView.alpha = 0;
        }];

    }else{
        self.tabbarView.alpha = 1;
    }
}

-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed withAnimation:(BOOL)animation{
    [super setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];

    if (hidesBottomBarWhenPushed) {
        
        if (animation) {
            
            [UIView animateWithDuration:0.27 animations:^{
                self.tabbarView.alpha = 0;
            }];

        }else{
            self.tabbarView.alpha = 0;
        }
        
    }else{
        
        if (animation) {
            
            [UIView animateWithDuration:0.27 animations:^{
                
                self.tabbarView.alpha = 1;
                
            }];

        }else{
            
            self.tabbarView.alpha = 1;

        }
    }

    
}

-(void)hidesBottomBar{
    
    [UIView animateWithDuration:0.27 animations:^{
        self.tabbarView.alpha = 0;
    }];

    
}

-(void)showBottomBar{
    self.tabbarView.alpha = 1;
}

-(void)selectedTab:(UIButton*)button{
    
    self.selectedIndex = button.tag;
        
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    
    [super setSelectedIndex:selectedIndex];
    
    [self changeTheItemsState:self.selectedIndex];

}

-(void)changeTheItemsState:(NSInteger)index{
 
    [self.itemImages enumerateObjectsUsingBlock:^(UIImageView * obj, NSUInteger idx, BOOL *stop) {
       
        if (idx == index) {
            obj.highlighted = YES;
        }else{
            obj.highlighted = NO;
        }
        
    }];
    
    [self.itemLabels enumerateObjectsUsingBlock:^(UILabel * obj, NSUInteger idx, BOOL *stop) {
        
        if (idx == index) {
            obj.highlighted = YES;
        }else{
            obj.highlighted = NO;
        }
        
    }];
    
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
