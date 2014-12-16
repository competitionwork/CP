//
//  PeopleCenter.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-6.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "PeopleCenter.h"
#import "PeopleHeadView.h"
#import "CPEducationView.h"
#import "CPOccupationView.h"


@interface PeopleCenter ()

@end

@implementation PeopleCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroudGrayColor;    
    [self creatTheUIVIew];
    
}

-(void)creatTheUIVIew{
    
    PeopleHeadView * peopleHead = [[PeopleHeadView alloc]initWithFrame:CGRectMake(0 , 0, MainScreenWidth, 150)];
    [self.view addSubview:peopleHead];
    
    CPEducationView * education = [[CPEducationView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth - 16, 150) withData:nil];
    [self.view addSubview:education];
    [[education.po_frameBuilder alignToBottomOfView:peopleHead offset:15]centerHorizontallyInSuperview];
    
//    CPOccupationView * occupation = [[CPOccupationView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth - 16, 120) withData:nil];
//    [self.view addSubview:occupation];
//    [[occupation.po_frameBuilder alignToBottomOfView:education offset:15]centerHorizontallyInSuperview];
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
