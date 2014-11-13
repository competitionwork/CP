//
//  CPDetailViewController.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-13.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPDetailViewController.h"
#import "CPAPIHelper_severURL.h"
#import "CPDetailEntiy.h"

@interface CPDetailViewController ()
@property (nonatomic, strong) CPDetailEntiy * inforDataEntiy;


@end

@implementation CPDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self dowloadViewdata];
}
-(void)dowloadViewdata{
    
    NSDictionary * paramsDic = @{@"uid":@"123456",
                                 @"c_id":@"104"
                                 };
    
    
    [[CPAPIHelper_severURL sharedInstance]api_view_withParams:paramsDic whenSuccess:^(id result) {
        DLog(@"%@",result);
        
        self.inforDataEntiy = [[CPDetailEntiy alloc]init];
        
        [_inforDataEntiy reflectDataFromOtherObject:result[@"contest"]];
        
        [_inforDataEntiy reflectDataFromOtherObject:result];

        
        
        [self CreateDefaultDetailInfo];
        
    } andFailed:^(id err) {
        
    }];
}

-(void)CreateDefaultDetailInfo{
    
    
    
    
    
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
