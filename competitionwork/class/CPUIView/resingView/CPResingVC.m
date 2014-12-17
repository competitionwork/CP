//
//  CPResingVC.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPResingVC.h"
#import "CPResingBaseCellView.h"
#import "CPBaseButton.h"
#import "CPUserHeadPictureView.h"
#import "CPCheckBox.h"
#import "CPAPIHelper_setting.h"
#import "CPPersonalInformationVC.h"
#import "CPDESCode.h"
#import "CPAPIHelper_userURL.h"
#import "CPUserInforCenter.h"
#import "GJError.h"
#import "UIView+TipViewForUsual.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface CPResingVC ()

@property (nonatomic,strong) UIScrollView *myScrollView;

@property (nonatomic,strong) CPUserHeadPictureView *headView;

@property (nonatomic,strong) CPResingBaseCellView *mailView;

@property (nonatomic, strong) CPResingBaseCellView * maneView;

@property (nonatomic,strong) CPResingBaseCellView *ConfirmationView;

@property (nonatomic,strong) CPResingBaseCellView *Password;

@property (nonatomic,strong) CPResingBaseCellView *PasswordAgain;

@property (nonatomic,strong) CPBaseButton *resingButton;

@property (nonatomic,strong) UIImagePickerController *pickerController;

@property (nonatomic,strong) CPCheckBox *checkBox;


@end


@implementation CPResingVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotification];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self creatTheUI];
}

-(UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    }
    return _myScrollView;
}

-(void)creatTheUI{
    
    [self.view addSubview:self.myScrollView];
    
    self.headView = [[CPUserHeadPictureView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100)];
    self.headView.hidden = YES;
    self.headView.userInteractionEnabled = NO;
    __weak typeof(*&self) weakSelf = self;
    
    [self.headView setBlock:^(UIImageView * image){
        
        [weakSelf touchHeadView];
        
    }];
    
    [self.myScrollView addSubview:self.headView];
    
    
    
    
    
    NSArray * arrayPleceholde = @[@"请输入邮箱",
                                  @"请输入真实姓名",
                                  @"请输入手机号码",
                                  @"请输入密码",
                                  @"请再次输入密码",
                                  ];
    [arrayPleceholde enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CPTEXEVIEMODEL textModel = CPTEXEVIEWMIN;
        
        if (idx == 0) {
            
            textModel = CPTEXEVIEWUP;
            
        }else if (idx == arrayPleceholde.count - 1){
            
            textModel = CPTEXEVIEWDOWN;
            
        }
        
        
        
        CPBaseLabelCellModel * model = [[CPBaseLabelCellModel alloc]init];
        model.pleceHolde = (NSString*)obj;
        
        CPResingBaseCellView * resingView = [[CPResingBaseCellView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 45) andEntity:model withModel:textModel];
        [resingView setTextFontMunber:14];
        [resingView setDelegateWith:self];
        [self.myScrollView addSubview:resingView];
        
        switch (idx) {
            case 0:{
                self.mailView = resingView;
                [[self.mailView.po_frameBuilder alignToTopInSuperviewWithInset:130]centerHorizontallyInSuperview];

            }
                break;
            case 1:{
                self.maneView = resingView;
                [[self.maneView.po_frameBuilder alignToBottomOfView:self.mailView offset:1]centerHorizontallyInSuperview];
            }
                break;
            case 2:{
                self.ConfirmationView = resingView;
                [[self.ConfirmationView.po_frameBuilder alignToBottomOfView:self.maneView offset:1]centerHorizontallyInSuperview];
            }
                break;
            case 3:{
                self.Password = resingView;
                [[self.Password.po_frameBuilder alignToBottomOfView:self.ConfirmationView offset:1]centerHorizontallyInSuperview];
            }
                break;
            case 4:{
                self.PasswordAgain = resingView;
                [[self.PasswordAgain.po_frameBuilder alignToBottomOfView:self.Password  offset:1]centerHorizontallyInSuperview];
            }
                break;
            default:
                break;
        }

        
    }];
    

    
    
    UILabel * textLabel = [[UILabel alloc]init];
    textLabel.text = @"我已阅读并同意";
    textLabel.font = [UIFont systemFontOfSize:13];
    [textLabel sizeToFit];
    
    [self.myScrollView addSubview:textLabel];
    [[textLabel.po_frameBuilder alignToBottomOfView:self.PasswordAgain offset:8]alignLeftInSuperviewWithInset:30];
    
    UILabel * textColocrLabel = [[UILabel alloc]init];
    textColocrLabel.text = @"使用条款与私隐策略";
    textColocrLabel.font = [UIFont systemFontOfSize:13];
    textColocrLabel.textColor = GJColor(40, 120, 212, 1);
    [textColocrLabel sizeToFit];
    
    [self.myScrollView addSubview:textColocrLabel];
    [[textColocrLabel.po_frameBuilder alignRightOfView:textLabel offset:20]setY:textLabel.frame.origin.y];
    
    /*选择按钮*/
    self.checkBox = [[CPCheckBox alloc]initWithFrame:CGRectMake(8, textLabel.frame.origin.y, 15, 15)];
    [self.myScrollView addSubview:self.checkBox];
    
    self.resingButton = [CPBaseButton buttonWithType:UIButtonTypeCustom];
    [self.resingButton setStylesWithTitle:@"注册"];
    
    
    [self.resingButton setBlock:^(UIButton * btn){
        [weakSelf touchResing:btn];
    }];
    [self.myScrollView addSubview:self.resingButton];
    
    [[self.resingButton.po_frameBuilder alignToBottomOfView:self.PasswordAgain offset:40]centerHorizontallyInSuperview];
    
    self.myScrollView.contentSize = CGSizeMake(MainScreenWidth, self.resingButton.frame.origin.y +self.resingButton.height +30);
    
    
}

-(void)touchHeadView{
    
    __weak typeof(*&self) weakSelf = self;
    
    UIActionSheet * action = [[UIActionSheet alloc]initWithTitle:nil delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择照片", nil];
    [action showInView:[[UIApplication sharedApplication]keyWindow]];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    

    
    if (buttonIndex == 0) {

        self.pickerController = [[UIImagePickerController alloc]init];
        self.pickerController.delegate = self;
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.pickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        self.pickerController.allowsEditing = YES;
        [self.pickerController viewWillAppear:YES];
        [self.pickerController viewWillDisappear:YES];
        [self.navigationController presentViewController:self.pickerController animated:YES completion:^{
            
        }];
        
        
    }else if (buttonIndex == 1){
        
        int status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusDenied) {
        }
        
        self.pickerController = [[UIImagePickerController alloc]init];
        self.pickerController.delegate = self;
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        self.pickerController.allowsEditing = YES;
        [self.pickerController viewWillAppear:YES];
        [self.pickerController viewWillDisappear:YES];
        [self.navigationController presentViewController:self.pickerController animated:YES completion:^{
            
        }];

    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.pickerController.allowsEditing = NO;
    UIImage                 *headImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self.headView setHeadWithImage:headImage];
    [self.pickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)touchResing:(id)sender{
    
    NSMutableDictionary * dictParmars = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [dictParmars setObject:[[self.mailView textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
    [dictParmars setObject:[[self.maneView textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"real_name"];
    [dictParmars setObject:[[self.ConfirmationView textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"tel"];
    [dictParmars setObject:[CPDESCode md5:[[self.Password textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] forKey:@"password"];
    [dictParmars setObject:[CPDESCode md5:[[self.PasswordAgain textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] forKey:@"password_c"];

//    [dictParmars setObject:@"1" forKey:@"sex"];
//    [dictParmars setObject:@"12345@qq.com" forKey:@"email"];
//    [dictParmars setObject:@"张三" forKey:@"real_name"];
//    [dictParmars setObject:@"13000000000" forKey:@"tel"];
//    [dictParmars setObject:[CPDESCode md5:[[self.Password textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] forKey:@"password"];
//    [dictParmars setObject:[CPDESCode md5:@"h123456"] forKey:@"password_c"];
    
    if (![self.checkBox getSelectCheckBox]) {
        [CPSystemUtil showAlertViewWithAlertString:@"请阅读并同意"];
        return;
    }
    
    [self.view showTipView:TipViewLoading withText:KLODING_STR forEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

    [[CPAPIHelper_userURL sharedInstance]api_reg_withParams:dictParmars whenSuccess:^(id result) {
        [self.view hideTipView];
        DLog(@"reg==%@",result);
        if (result&&result[@"user"]) {
            
            CPUserInforModel * user = [[CPUserInforCenter sharedInstance]getUsetData];
            user.uid = result[@"user"][@"uid"];
            user.sex = result[@"user"][@"sex"];
            user.email = result[@"user"][@"email"];
            user.real_name = result[@"user"][@"real_name"];
            user.utoken = result[@"user"][@"utoken"];
            
            CPPersonalInformationVC * personal = [[CPPersonalInformationVC alloc]init];
            [self.navigationController pushViewController:personal animated:YES];

            [[CPUserInforCenter sharedInstance]setIsLoginSuccess:YES];

        }else{
            [CPSystemUtil showAlertViewWithAlertString:result[@"msg"]];
        }


    } andFailed:^(GJError* err) {
        
        [CPSystemUtil showAlertViewWithAlertString:err.DisplayMessage];
        
    }];
    

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{

    
}



-(void)registerForKeyboardNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardBeHide:) name:UIKeyboardDidHideNotification object:nil];
    
}

-(void)keyboardWasShown:(NSNotification*)notification{
    
    NSDictionary * dictInfor = [notification userInfo];
    
    CGSize size = [[dictInfor objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue].size;
    
//    CGRect rect = self.myScrollView.frame;
//    rect.size.height = rect.size.height - size.height;
//    self.myScrollView.frame = rect;
    
}


-(void)keyboardBeHide:(NSNotification*)notification{
    
    NSDictionary * dictInfor = [notification userInfo];
    
    CGSize size = [[dictInfor objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue].size;
    
//    CGRect rect = self.myScrollView.frame;
//    rect.size.height = rect.size.height + size.height;
//    self.myScrollView.frame = rect;
}





-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}












@end
