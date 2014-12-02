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

@interface CPLoginView ()

@property (nonatomic, strong) CPBaseLoginView * userNameView;

@property (nonatomic, strong) CPBaseLoginView * passwordView;

@property (nonatomic, strong) UIButton * logonButton;

@end

@implementation CPLoginView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MainBackColor;
    [self creatTheVIew];
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

}

-(void)loginPressed:(id)sender{
    DLog(@"点击登录");
//    NSDictionary * parmat = @{@"email":self.userNameView.textString,
//                              @"password":self.passwordView.textString,
//                              };
    NSDictionary * parmat = @{@"email":@"2345@qq.com",
                              @"password":@"245464546fsfsseg",
                              };
    
    [[CPAPIHelper_userURL sharedInstance]api_login_withParams:parmat whenSuccess:^(id result) {
        
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
