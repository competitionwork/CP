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

#import "CPAPIHelper_severURL.h"
#import "CPAPIHelper_schoolURL.h"

#import "CPUserInforCenter.h"

@interface CPPersonalInformationVC ()

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *DataArray;

@property (nonatomic,strong) CPBaseButton *personalButton;

@property (nonatomic,strong) NSMutableArray *schoolArray;

@property (nonatomic,strong) NSMutableArray *academyArray;

@property (nonatomic,strong) NSMutableArray *yearArray;

@property (nonatomic,strong) NSMutableArray *classesArray;



@end

@implementation CPPersonalInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"信息填写";
    
    [self updateTheShoolData];
    
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
    cell.Number = item[@"number"];
    
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
    
    
    [self GetSchoolDataIndex:indexPath] ;
    
}

-(void)showViewWith:(NSIndexPath*)indexPath andArray:(NSArray*)data{
    
    CPPersinalparentVC * con = [[CPPersinalparentVC alloc]initWithNibName:nil
                                                               bundle:nil];
    con.hidesBottomBarWhenPushed = YES;
    con.persinalArray = data;
    con.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:con];
    navController.navigationBarHidden = NO;
    
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    GJHRDMCustomModalViewController * model = [[GJHRDMCustomModalViewController alloc] initWithRootViewController:navController  parentViewController:app.window.rootViewController];
    model.delegate = self;
    [model presentRootViewControllerWithPresentationStyle:GJHRDMCustomModalViewControllerPresentPartScreen controllercompletion:^{
        
    }];
    
    __weak typeof(*&self) weakSelf = self;

    
    __block NSMutableDictionary * item = [self.DataArray objectAtIndex:indexPath.row];
    
    [con setPersinalclickBlock:^(CPPersinalparentModel * data){
        
        [model dismissRootViewControllerWithCompletion:^{
            
        }];
        
        [item setObject:data.Title forKey:@"Input"];
        [item setObject:data.number forKey:@"number"];

        
        [weakSelf.tableView reloadData];
        
    }];

}


-(void)uploadThePersonalinformation{
    DLog(@"按钮按下");
    
    CPUserInforModel * userInfor =[[CPUserInforCenter sharedInstance]getUsetData];
    

    
    NSDictionary * param = @{@"uid":userInfor.uid,
                             @"utoken":userInfor.utoken,
                             @"school_id":[self.DataArray objectAtIndex:0][@"number"],
                             @"college_id":[self.DataArray objectAtIndex:1][@"number"],
                             @"degree_id":[self.DataArray objectAtIndex:2][@"number"],
                             @"begin_year":[self.DataArray objectAtIndex:3][@"number"],
                             @"c_ classes":[self.DataArray objectAtIndex:4][@"number"]
                             };
    
    
    
    [[CPAPIHelper_userURL sharedInstance]api_regprofile_withParams:param whenSuccess:^(id result) {
//        if (result[@"code"]&&[result[@"code"] intValue] == 0 ) {
        
            [self returnToRootView];

//        }else{
//            [CPSystemUtil showAlertViewWithAlertString:result[@"message"]];
//        }
        DLog(@"信息%@",result);
    } andFailed:^(id err) {
        
    }];
    
    
}

-(void)returnToRootView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)creatData{
    
    NSArray * array = @[@{@"title":@"选择学校",@"Input":@"清华大学",@"number":@"1001"},
                       @{@"title":@"选择院系",@"Input":@"中国语音文学系",@"number":@"1001001"},
                       @{@"title":@"入学时间",@"Input":@"2014年",@"number":@"2014"},
                       @{@"title":@"学    历",@"Input":@"大学生",@"number":@"5"},
                       @{@"title":@"竞赛选择",@"Input":@"数学建模",@"number":@"1"},
                      ];
    NSMutableArray * muarray = [[NSMutableArray alloc]initWithCapacity:0];
    [array enumerateObjectsUsingBlock:^(NSDictionary *  obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:obj];
        [muarray addObject:dict];
    }];
    
    self.DataArray = muarray;
    
    
}

-(void)GetSchoolDataIndex:(NSIndexPath*)IndexPath{
    
    switch (IndexPath.row) {
        case 0:{
            
            [[CPAPIHelper_schoolURL sharedInstance]api_get_univs_withParams:nil whenSuccess:^(id result) {
                DLog(@"api_get_univs_withParams = %@",result);
                if (result && result[@"univs"] ) {
                    self.schoolArray = [[NSMutableArray alloc]init];
                    NSDictionary * dictResult = result[@"univs"];
                    [dictResult enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id key, id obj, BOOL *stop) {
                        
                        CPPersinalparentModel * model = [[CPPersinalparentModel alloc]init];
                        model.Title = obj;
                        model.number = key;
                        
                        [self.schoolArray addObject:model];
                        
                    }];
                    
                    
                }
                [self showViewWith:IndexPath andArray:self.schoolArray];

                
            } andFailed:^(id err) {
                
            }];

        }
            break;
        case 1:{
            
            NSDictionary* item = [self.DataArray objectAtIndex:IndexPath.row-1];
            NSDictionary * dictParams = @{@"univs_id":item[@"number"],
                                          };
            
            
            [[CPAPIHelper_schoolURL sharedInstance]api_get_academy_withParams:dictParams whenSuccess:^(id result) {
                DLog(@"api_get_acadamy_withParams = %@",result);
                if (result && result[@"academys"] ) {
                    self.academyArray = [[NSMutableArray alloc]init];
                    NSDictionary * dictResult = result[@"academys"];
                    [dictResult enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id key, id obj, BOOL *stop) {
                        
                        CPPersinalparentModel * model = [[CPPersinalparentModel alloc]init];
                        model.Title = obj;
                        model.number = key;
                        
                        [self.academyArray addObject:model];
                        
                    }];
                    
                    
                }
                [self showViewWith:IndexPath andArray:self.academyArray];
                
            } andFailed:^(id err) {
                
            }];
        }
            break;
        case 2:{
            
            self.yearArray = [[NSMutableArray alloc]init];
            
            for (int i = 2014; i >= 2001; i--) {
                
                CPPersinalparentModel * model = [[CPPersinalparentModel alloc]init];
                model.Title = [NSString stringWithFormat:@"%d年",i];
                model.number = NSStringFromInt(i);
                [self.yearArray addObject:model];
            }
            
            [self showViewWith:IndexPath andArray:self.yearArray];

            
        }
            break;
        case 3:{
            
            NSArray * array = @[@"专科生",@"本科生",@"研究生",@"博士生",@"更高"];
            
            NSMutableArray * showArray = [[NSMutableArray alloc]init];
            [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
                
                CPPersinalparentModel * model = [[CPPersinalparentModel alloc]init];
                model.Title = obj;
                int intnumber = idx + 5;
                model.number = [NSString stringWithFormat:@"%d",intnumber];
                [showArray addObject:model];
            }];
            
            [self showViewWith:IndexPath andArray:showArray];
                
            }
            break;
        case 4:{
            
            [[CPAPIHelper_severURL sharedInstance]api_get_category_withParams:nil whenSuccess:^(id result) {
                
                DLog(@"api_get_category_withParams = %@",result);
                if (result && result[@"classes"] && !self.classesArray) {
                    self.classesArray = [[NSMutableArray alloc]init];
                    NSDictionary * dictResult = result[@"classes"];
                    [dictResult enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id key, id obj, BOOL *stop) {
                        
                        CPPersinalparentModel * model = [[CPPersinalparentModel alloc]init];
                        model.Title = obj;
                        model.number = key;
                        
                        [self.classesArray addObject:model];
                        
                    }];
                    
                    
                }
                [self showViewWith:IndexPath andArray:self.classesArray];
                


                
            } andFailed:^(id err) {
                
            }];
                
            }
            break;
        default:
            break;
    }
    
   
}


-(void)updateTheShoolData{
    
    
    

    
    
}

/*
code = 0;
data =     {
    univs =         {
        1001 = "清华大学";
        1002 = "北京大学";
        1003 = "中国人民大学";
        1004 = "北京航空航天大学";
        1005 = "北京邮电大学";
        1006 = "北京师范大学";
        1007 = "中国传媒大学";
        1008 = "北京语言大学";
        1009 = "北京科技大学";
        1010 = "中国农业大学";
        1011 = "北京理工大学";
        1012 = "北京林业大学";
        1013 = "北京交通大学";
        1014 = "中国矿业大学（北京）";
        1015 = "北京信息科技大学";
        1016 = "北京工业大学";
        1017 = "北京化工大学";
        1018 = "中国政法大学";
        1019 = "对外经贸大学";
        1020 = "中央民族大学";
    };
};
msg = "";
*/
@end
