//
//  PeopleCenter.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-6.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "PeopleCenter.h"
#import "PeopleHeadView.h"
@interface PeopleCenter ()

@end

@implementation PeopleCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我是学霸";
    
    [self creatTheUIVIew];
    
}

-(void)creatTheUIVIew{
    
    PeopleHeadView * peopleHead = [[PeopleHeadView alloc]initWithFrame:CGRectMake(0 , 0, MainScreenWidth, 150)];
    [self.view addSubview:peopleHead];
    peopleHead.backgroundColor = [UIColor yellowColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
