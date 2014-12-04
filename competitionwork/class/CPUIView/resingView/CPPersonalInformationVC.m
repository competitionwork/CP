//
//  CPPersonalInformationVC.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPPersonalInformationVC.h"
#import "CPPersonalTableViewCell.h"
#import "GJCommonWidgetHelper.h"
#import "CPBaseButton.h"
#import "CPAPIHelper_userURL.h"
#import "AppDelegate.h"
#import "CPPersinalparentVC.h"

@interface CPPersonalInformationVC ()

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *DataArray;

@property (nonatomic,strong) CPBaseButton *personalButton;


@end

@implementation CPPersonalInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"信息填写";

    [self creatData];
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * Identifier = @"Personal";
    CPPersonalTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[CPPersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    NSDictionary * item = [self.DataArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = item[@"title"];
    cell.textInput.text = item[@"Input"];
    
    if (indexPath.row == 0) {
        
        [cell setHiddenTopBorder:NO];
        
    }else if (indexPath.row == self.DataArray.count - 1) {
        
        [cell setHiddenBottomBorder:YES];
        [cell setHiddenDownBorder:NO];
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 70)];
    
    self.personalButton = [CPBaseButton buttonWithType:UIButtonTypeCustom];
    [self.personalButton setStylesWithTitle:@"完成"];
    [self.personalButton.po_frameBuilder centerInSuperview];
    
    __weak typeof(*&self) weakSelf = self;
    [self.personalButton setBlock:^(UIButton *btn){
        [weakSelf uploadThePersonalinformation];
    }];
    
    [backView addSubview:self.personalButton];
    
    return backView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self showViewWith:indexPath];
    
}

-(void)showViewWith:(NSIndexPath*)indexPath{
    
    CPPersinalparentVC * con = [[CPPersinalparentVC alloc]initWithNibName:nil
                                                               bundle:nil];
    con.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:con];
    navController.navigationBarHidden = NO;
    
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    GJHRDMCustomModalViewController * model = [[GJHRDMCustomModalViewController alloc] initWithRootViewController:navController  parentViewController:app.window.rootViewController];
    model.delegate = self;
    [model presentRootViewControllerWithPresentationStyle:GJHRDMCustomModalViewControllerPresentPartScreen controllercompletion:^{
        
    }];
    
    [con setPersinalclickBlock:^(id data){
        
        [model dismissRootViewControllerWithCompletion:^{
            
        }];
        
    }];

}


-(void)uploadThePersonalinformation{
    DLog(@"按钮按下");
    
    NSDictionary * param = @{@"uid":@"2345",
                             @"utoken":@"143436sfds",
                             @"school_id":@"1001",
                             @"college_id":@"1001001",
                             @"degree_id":@"5",
                             @"begin_year":@"2014",
                             };
    
    [[CPAPIHelper_userURL sharedInstance]api_regprofile_withParams:param whenSuccess:^(id result) {
        DLog(@"信息%@",result);
    } andFailed:^(id err) {
        
    }];
}

-(void)creatData{
    
    self.DataArray = @[@{@"title":@"选择学校",@"Input":@"清华大学"},
                       @{@"title":@"选择学校",@"Input":@"清华大学"},
                       @{@"title":@"选择学校",@"Input":@"清华大学"},
                       @{@"title":@"选择学校",@"Input":@"清华大学"},
                      ];
}




@end
