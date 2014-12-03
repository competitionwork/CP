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
#import <AssetsLibrary/AssetsLibrary.h>

@interface CPResingVC ()

@property (nonatomic,strong) CPUserHeadPictureView *headView;

@property (nonatomic, strong) CPResingBaseCellView * maneView;

@property (nonatomic,strong) CPResingBaseCellView *ConfirmationView;

@property (nonatomic,strong) CPResingBaseCellView *Password;

@property (nonatomic,strong) CPResingBaseCellView *PasswordAgain;

@property (nonatomic,strong) CPBaseButton *resingButton;

@property (nonatomic,strong) UIImagePickerController *pickerController;


@end


@implementation CPResingVC


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self creatTheUI];
}

-(void)creatTheUI{
    
    self.headView = [[CPUserHeadPictureView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100)];
    
    __weak typeof(*&self) weakSelf = self;
    
    [self.headView setBlock:^(UIImageView * image){
        
        [weakSelf touchHeadView];
        
    }];
    
    [self.view addSubview:self.headView];
    
    
    
    
    
    NSArray * arrayPleceholde = @[@"请输入真实姓名",
                                  @"请输入验证码",
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
        
        CPResingBaseCellView * resingView = [[CPResingBaseCellView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth-20, 45) andEntity:model withModel:textModel];
        [resingView setTextFontMunber:14];
        [self.view addSubview:resingView];
        
        switch (idx) {
            case 0:{
                self.maneView = resingView;
                [[self.maneView.po_frameBuilder alignToTopInSuperviewWithInset:110]centerHorizontallyInSuperview];
            }
                break;
            case 1:{
                self.ConfirmationView = resingView;
                [[self.ConfirmationView.po_frameBuilder alignToBottomOfView:self.maneView offset:1]centerHorizontallyInSuperview];
            }
                break;
            case 2:{
                self.Password = resingView;
                [[self.Password.po_frameBuilder alignToBottomOfView:self.ConfirmationView offset:1]centerHorizontallyInSuperview];
            }
                break;
            case 3:{
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
    
    [self.view addSubview:textLabel];
    [[textLabel.po_frameBuilder alignToBottomOfView:self.PasswordAgain offset:8]alignLeftInSuperviewWithInset:30];
    
    UILabel * textColocrLabel = [[UILabel alloc]init];
    textColocrLabel.text = @"使用条款与私隐策略";
    textColocrLabel.font = [UIFont systemFontOfSize:13];
    textColocrLabel.textColor = [UIColor blueColor];
    [textColocrLabel sizeToFit];
    
    [self.view addSubview:textColocrLabel];
    [[textColocrLabel.po_frameBuilder alignRightOfView:textLabel offset:20]setY:textLabel.frame.origin.y];
    
    self.resingButton = [CPBaseButton buttonWithType:UIButtonTypeCustom];
    [self.resingButton setStylesWithTitle:@"注册"];
    
    
    [self.resingButton setBlock:^(UIButton * btn){
        [weakSelf touchResing:btn];
    }];
    [self.view addSubview:self.resingButton];
    
    [[self.resingButton.po_frameBuilder alignToBottomOfView:self.PasswordAgain offset:40]centerHorizontallyInSuperview];
    
    
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
    
}



























@end
