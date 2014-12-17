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

@property(nonatomic,strong) UIScrollView * scrollview;

@end

@implementation PeopleCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroudGrayColor;
    [self.view addSubview:self.scrollview];
    [self creatTheUIVIew];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.scrollview.frame = self.view.bounds;
}

-(UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    }
    return _scrollview;
}

-(void)creatTheUIVIew{
    
    PeopleHeadView * peopleHead = [[PeopleHeadView alloc]initWithFrame:CGRectMake(0 , 0, MainScreenWidth, 150)];
    [self.scrollview addSubview:peopleHead];
    
    CPEducationView * education = [[CPEducationView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth - 16, 150) withData:nil];
    [self.scrollview addSubview:education];
    [[education.po_frameBuilder alignToBottomOfView:peopleHead offset:15]centerHorizontallyInSuperview];
    
    CPOccupationView * occupation = [[CPOccupationView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth - 16, 120) withData:nil];
    [self.scrollview addSubview:occupation];
    [[occupation.po_frameBuilder alignToBottomOfView:education offset:15]centerHorizontallyInSuperview];
    
    self.scrollview.contentSize = CGSizeMake(MainScreenWidth, 480);
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
