//
//  CPUserCenterVC.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUserCenterVC.h"
#import "CPUserCenterListVeiw.h"
#import "CPListCellEntity.h"



@interface CPUserCenterVC ()

@property (nonatomic,strong) NSArray * centerListData;

@property (nonatomic,strong) CPUserCenterListVeiw * ListView;
@end

@implementation CPUserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatTheUserCenterListView];
}


-(void)creatTheUserCenterListView{
    
    [self.view addSubview:self.ListView];
    
    
    self.centerListData = @[
                            @[
                                [CPListCellEntity listCellWithTitle:@"我是学霸" imageName:@"tabbar_home" target:self callback:@selector(Account) userinfo:nil],
                                
                                
                                ],
                            @[
                                [CPListCellEntity listCellWithTitle:@"账户" imageName:@"tabbar_home" target:self callback:@selector(Account) userinfo:nil],
                                [CPListCellEntity listCellWithTitle:@"消息与提醒" imageName:@"tabbar_home" target:self callback:@selector(Account) userinfo:nil],
                                [CPListCellEntity listCellWithTitle:@"用户反馈" imageName:@"tabbar_home" target:self callback:@selector(Account) userinfo:nil],
                                [CPListCellEntity listCellWithTitle:@"关于环球竞赛网" imageName:@"tabbar_home" target:self callback:@selector(Account) userinfo:nil]
                                ]
                            ];
    self.ListView.listData = self.centerListData;
    [self.ListView reloadDate];
    
    
}

-(void)Account{
    
    DLog(@"点击了账户");
}


-(CPUserCenterListVeiw *)ListView{
    if (!_ListView) {
        _ListView =[[CPUserCenterListVeiw alloc]initWithFrame:self.view.bounds];
        
        __weak typeof(self) weakSelf = self;
        
        [_ListView setListDidClick:^(CPListCellEntity * Entity, NSIndexPath *index) {
            [weakSelf ifNeedLogin:Entity];
        }];
        
    }
    return _ListView;
}

-(void)ifNeedLogin:(CPListCellEntity *)entity {
    if ([entity.target respondsToSelector:entity.callBack]) {
        [entity.target performSelectorInBackground:entity.callBack withObject:nil];
    }
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