//
//  CPLoginView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-23.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPLoginView.h"
#import "CPBaseLoginView.h"
@interface CPLoginView ()

@end

@implementation CPLoginView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CPBaseLoginView * loginView = [[CPBaseLoginView alloc]initWithFrame:CGRectMake(100, 100, 200, 50) andEntity:nil withModel:CPTEXEVIEWONE];
    [self.view addSubview:loginView];
    
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
