//
//  CPLoginView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-23.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPLoginView.h"
#import "CPBaseLoginView.h"
#import "CPAPIHelper_userURL.h"
#import "CPResingVC.h"

@interface CPLoginView ()

@property (nonatomic, strong) CPBaseLoginView * userNameView;

@property (nonatomic, strong) CPBaseLoginView * passwordView;

@property (nonatomic, strong) UIButton * logonButton;

@end

@implementation CPLoginView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBackButton:self withSelector:@selector(goBackModel)];
    self.view.backgroundColor = MainBackColor;
    [self creatTheVIew];
}

-(void)goBackModel{
    
    if (self.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)creatTheVIew{
    
    UIImageView * imageTitleView = [[UIImageView alloc]initWithImage:nil];
    imageTitleView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:imageTitleView];
    [[[[imageTitleView.po_frameBuilder setHeight:100]setWidth:200]alignToTopInSuperviewWithInset:20] centerHorizontallyInSuperview];
    
    
    CPBaseLabelCellModel * name = [[CPBaseLabelCellModel alloc]init];
    name.pleceHolde = @"用户名称";
    name.image = [UIImage imageNamed:@"tabbar_home_selected"];
    self.userNameView = [[CPBaseLoginView alloc]initWithFrame:CGRectMake(0, 100, MainScreenWidth-50, 50) andEntity:name withModel:CPTEXEVIEWUP];
    [self.view addSubview:self.userNameView];
    [[self.userNameView.po_frameBuilder alignToBottomOfView:imageTitleView offset:20]centerHorizontallyInSuperview];
    
    
    CPBaseLabelCellModel * password = [[CPBaseLabelCellModel alloc]init];
    password.pleceHolde = @"密码";
    password.image = [UIImage imageNamed:@"tabbar_home_selected"];
    self.passwordView = [[CPBaseLoginView alloc]initWithFrame:CGRectMake(0, 100, MainScreenWidth-50, 50) andEntity:password withModel:CPTEXEVIEWDOWN];
    [self.view addSubview:self.passwordView];
    [[[[self.passwordView.po_frameBuilder alignToBottomOfView:self.userNameView offset:1]setHeight:50]setWidth:MainScreenWidth - 50]centerHorizontallyInSuperview];
    
    
    self.logonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logonButton.frame = CGRectMake(13, 22, MainScreenWidth - 26, 40);
    _logonButton.titleLabel.font = [UIFont systemFontOfSize:16];
    UIImage *uprightBtn = [UIImage imageNamed:@"按钮-绿"];
    UIImage *huprightBtn = [UIImage imageNamed:@"按钮-绿-点击"];
    [_logonButton setBackgroundImage:[uprightBtn stretchableImageWithLeftCapWidth:floorf(uprightBtn.size.width / 2) topCapHeight:uprightBtn.size.height / 2] forState:UIControlStateNormal];
    [_logonButton setBackgroundImage:[huprightBtn stretchableImageWithLeftCapWidth:floorf(huprightBtn.size.width / 2) topCapHeight:huprightBtn.size.height / 2] forState:UIControlStateHighlighted];
    [_logonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_logonButton setTitle:@"登录" forState:UIControlStateNormal];
    [_logonButton addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logonButton];
    [[self.logonButton.po_frameBuilder alignToBottomOfView:self.passwordView offset:30]centerHorizontallyInSuperview];
    
    
    UIButton * resingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 50)];
    [resingBtn setTitle:@"注册" forState:UIControlStateNormal];
    [resingBtn setTitleColor:GJColor(128, 128, 128, 1) forState:UIControlStateNormal];
    UIImage *backImage = [UIImage imageNamed:@"文字点击态高度固定48"];
    [resingBtn setBackgroundImage:[backImage stretchableImageWithLeftCapWidth:backImage.size.width / 2 topCapHeight:backImage.size.height / 2] forState:UIControlStateHighlighted];
    [resingBtn addTarget:self action:@selector(resingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resingBtn];
    [[[[resingBtn.po_frameBuilder alignToBottomOfView:_logonButton offset:50]alignRightInSuperviewWithInset:40] setHeight:30]setWidth:50];
    
}

-(void)resingAction:(id)sender{
    
    CPResingVC * resingV = [[CPResingVC alloc]init];
    
    [self.navigationController pushViewController:resingV animated:YES];
    
}

-(void)loginPressed:(id)sender{
    DLog(@"点击登录");
    //    NSDictionary * parmat = @{@"email":self.userNameView.textString,
    //                              @"password":self.passwordView.textString,
    //                              };
    NSDictionary * parmat = @{@"email":@"2345@qq.com",
                              @"password":@"245464546fsfsseg",
                              };
    
    __weak typeof(*&self) weakSelf = self;
    
    [[CPAPIHelper_userURL sharedInstance]api_login_withParams:parmat whenSuccess:^(id result) {
        
        [weakSelf goBackModel];
        
    } andFailed:^(id err) {
        
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
