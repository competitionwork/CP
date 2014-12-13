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
#import "AppDelegate.h"
#import "CPUtil.h"
#import "CPUserInforCenter.h"
#import "CPDESCode.h"

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
//    self.view.backgroundColor = MainBackColor;
    UIImageView * imageb = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageb.image = [UIImage imageNamed:@""];
    imageb.backgroundColor = GJColor(239, 238, 232, 1);
    [self.view addSubview:imageb];
    [self creatTheVIew];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate * app = [AppDelegate sharedAppDelegate];
    
    [app.MastVC hidesBottomBar];
    
    self.navigationController.navigationBarHidden = YES;
    
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
    
    UIImageView * imageTitleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"环球竞赛网"]];
    imageTitleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageTitleView];
    [[[[imageTitleView.po_frameBuilder setHeight:39.5]setWidth:182.5]alignToTopInSuperviewWithInset:55] centerHorizontallyInSuperview];
    
    UIImage * imageLabelBack = [UIImage imageNamed:@"登陆注册输入框"];
    UIImageView * imageLabelBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth-30, 100)];
    imageLabelBackView.image = [imageLabelBack stretchableImageWithLeftCapWidth:imageLabelBack.size.width/2 topCapHeight:imageLabelBack.size.height/2];;
    [self.view addSubview:imageLabelBackView];
    [[imageLabelBackView.po_frameBuilder alignToBottomOfView:imageTitleView offset:70]centerHorizontallyInSuperview];
    
    
    CPBaseLabelCellModel * name = [[CPBaseLabelCellModel alloc]init];
    name.pleceHolde = @"用户名称";
    name.image = [UIImage imageNamed:@"yhm"];
    self.userNameView = [[CPBaseLoginView alloc]initWithFrame:CGRectMake(0, 135, MainScreenWidth-30, 50) andEntity:name withModel:CPTEXEVIEWEMPTY];
    [self.view addSubview:self.userNameView];
    [[self.userNameView.po_frameBuilder alignToBottomOfView:imageTitleView offset:70]centerHorizontallyInSuperview];
    [self.userNameView setHiddenTopBorder:YES];
    [self.userNameView setDelegateWith:self];
    
    
    CPBaseLabelCellModel * password = [[CPBaseLabelCellModel alloc]init];
    password.pleceHolde = @"密码";
    password.image = [UIImage imageNamed:@"mm"];
    self.passwordView = [[CPBaseLoginView alloc]initWithFrame:CGRectMake(0, 100, MainScreenWidth-30, 50) andEntity:password withModel:CPTEXEVIEWEMPTY];
    self.passwordView.textField.secureTextEntry = YES;
    [self.view addSubview:self.passwordView];
    [[self.passwordView.po_frameBuilder alignToBottomOfView:self.userNameView offset:1]centerHorizontallyInSuperview];
    [self.passwordView setHiddenDownBorder:YES];
    [self.passwordView setDelegateWith:self];

    
    self.logonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logonButton.frame = CGRectMake(13, 22, MainScreenWidth - 26, 40);
    _logonButton.titleLabel.font = [UIFont systemFontOfSize:16];
    UIImage *uprightBtn = [UIImage imageNamed:@"qr"];
    UIImage *huprightBtn = [UIImage imageNamed:@"qr"];
    [_logonButton setBackgroundImage:[uprightBtn stretchableImageWithLeftCapWidth:floorf(uprightBtn.size.width / 2) topCapHeight:uprightBtn.size.height / 2] forState:UIControlStateNormal];
    [_logonButton setBackgroundImage:[huprightBtn stretchableImageWithLeftCapWidth:floorf(huprightBtn.size.width / 2) topCapHeight:huprightBtn.size.height / 2] forState:UIControlStateHighlighted];
    [_logonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_logonButton setTitle:@"登录" forState:UIControlStateNormal];
    [_logonButton addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logonButton];
    [[self.logonButton.po_frameBuilder alignToBottomOfView:self.passwordView offset:30]centerHorizontallyInSuperview];
    
    
    UIButton * resingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 80)];
    [resingBtn setTitle:@"" forState:UIControlStateNormal];
    [resingBtn setTitleColor:GJColor(128, 128, 128, 1) forState:UIControlStateNormal];
    UIImage *backImage = [UIImage imageNamed:@"文字点击态高度固定48"];
    [resingBtn setBackgroundImage:[backImage stretchableImageWithLeftCapWidth:backImage.size.width / 2 topCapHeight:backImage.size.height / 2] forState:UIControlStateHighlighted];
    [resingBtn addTarget:self action:@selector(resingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resingBtn];
    [[[[resingBtn.po_frameBuilder alignToBottomInSuperviewWithInset:0]alignRightInSuperviewWithInset:110] setHeight:30]setWidth:80];
    
    UILabel * labelResing = [[UILabel alloc]initWithFrame:resingBtn.frame];
    labelResing.font = [UIFont systemFontOfSize:12];
    NSMutableAttributedString * strAttributed = [[NSMutableAttributedString alloc]initWithString:@"注册新账户"];
    NSRange rage = {0,[strAttributed length]};
    [strAttributed addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:rage];
    labelResing.attributedText = strAttributed;
    labelResing.textAlignment = NSTextAlignmentCenter;
    labelResing.textColor = GJColor(128, 128, 128, 1);
    [self.view addSubview:labelResing];
    
    [self forgetsThePasswordButton];
}

-(void)forgetsThePasswordButton{
    
    UIButton * resingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 80)];
    [resingBtn setTitle:@"" forState:UIControlStateNormal];
    [resingBtn setTitleColor:GJColor(128, 128, 128, 1) forState:UIControlStateNormal];
    UIImage *backImage = [UIImage imageNamed:@"文字点击态高度固定48"];
    [resingBtn setBackgroundImage:[backImage stretchableImageWithLeftCapWidth:backImage.size.width / 2 topCapHeight:backImage.size.height / 2] forState:UIControlStateHighlighted];
    [resingBtn addTarget:self action:@selector(forgetsThePasswordTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resingBtn];
    [[[[resingBtn.po_frameBuilder alignToBottomInSuperviewWithInset:0]alignLeftInSuperviewWithInset:30] setHeight:30]setWidth:80];
    
    UILabel * labelResing = [[UILabel alloc]initWithFrame:resingBtn.frame];
    labelResing.font = [UIFont systemFontOfSize:12];
    labelResing.text = @"忘记密码";
    labelResing.textAlignment = NSTextAlignmentCenter;
    labelResing.textColor = GJColor(128, 128, 128, 1);
    [self.view addSubview:labelResing];

}

-(void)forgetsThePasswordTouch:(id)sender{
    
}

-(void)resingAction:(id)sender{
    
    CPResingVC * resingV = [[CPResingVC alloc]init];
    resingV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resingV animated:YES];
    
}

-(void)loginPressed:(id)sender{
    DLog(@"点击登录");
    //    NSDictionary * parmat = @{@"email":self.userNameView.textString,
    //                              @"password":self.passwordView.textString,
    //                              };
    
//    NSString * atr = @"hjj342155";
//    atr = [CPDESCode md5:atr];
//    NSDictionary * parmat = @{@"email":@"flag1",
//                              @"password":@"e67c10a4c8fbfc0c400e047bb9a056a1",
//                              };
//    NSDictionary * parmat = @{@"email":@"hjjwinner@163.com",
//                              @"password":atr,
//                              };
    
    NSMutableDictionary * dictParmars = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [dictParmars setObject:[[self.userNameView textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
    [dictParmars setObject:[CPDESCode md5:[[self.passwordView textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] forKey:@"password"];
    
#ifdef DEBUG 
//    [dictParmars setValuesForKeysWithDictionary:parmat];
#else
    
    if ([[self.userNameView textString]isEqualToString:@""] ) {
        [CPSystemUtil showAlertViewWithAlertString:@"请输入邮箱"];
    }else if ([[self.passwordView textString]isEqualToString:@""]){
        [CPSystemUtil showAlertViewWithAlertString:@"请输入密码"];

    }
    
#endif
    
    __weak typeof(*&self) weakSelf = self;
    
    [[CPAPIHelper_userURL sharedInstance]api_login_withParams:dictParmars whenSuccess:^(id result) {
        
        if ([result[@"code"]intValue]== 0) {
            
            CPUserInforModel * userInfor = [[CPUserInforModel alloc]init];
            
            [userInfor reflectDataFromOtherObject:result];
            
            [[CPUserInforCenter sharedInstance]setUserData:userInfor];
            
            [[CPUserInforCenter sharedInstance]loadUserInforData];
            
            [[CPUserInforCenter sharedInstance]setIsLoginSuccess:YES];
            
            [weakSelf goBackModel];

        }
        
        
    } andFailed:^(id err) {
        
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

/*
 
 {
 "data": {
 "uid": "400007",
 "utoken": "fqzGIQSW$~",
 "email": "496047736@qq.com",
 "real_name": "任立峰",
 "sex": "2",
 "univs_id": "1022",
 "univs_name": "",
 "group_type": "2",
 "gid": "3"
 },
 "code": 0,
 "msg": ""
 }
 */
