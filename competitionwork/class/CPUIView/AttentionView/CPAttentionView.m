//
//  CPAttentionView.m
//  competitionwork
//
//  Created by hjj on 14-12-11.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPAttentionView.h"
#import "CPMainListCellModel.h"
#import "CPListCellCommonEntiy.h"
#import "CPMainListViewController.h"
#import "CPListCellCommonEntiy.h"
#import "CPDetailViewController.h"
#import "CPAPIHelper_severURL.h"
#import "CPUserInforCenter.h"
#import "UIView+TipViewForUsual.h"

@interface CPAttentionView ()

@property(nonatomic,strong) UITableView * tabelView;

@property(nonatomic,strong) NSMutableArray * attentionData;

@property(nonatomic,strong) CPMainListViewController * listVC;

@end

@implementation CPAttentionView

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"我关注的竞赛";
    
    self.tabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tabelView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    self.tabelView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tabelView];
    
    self.tabelView.delegate = self.listVC;
    self.tabelView.dataSource = self.listVC;
    
    __weak typeof(self) weakself = self;
    
    [self.listVC setClickIndex:^(CPListCellCommonEntiy * entiy) {
        [weakself clickListVeiwWithEntiy:entiy];
    }];
    
    [self loadTheAttentionData];
    
}

-(CPMainListViewController *)listVC{
    
    if (!_listVC) {
        _listVC = [[CPMainListViewController alloc]init];
    }
    return _listVC;
}

-(NSMutableArray *)attentionData{
    
    if (!_attentionData) {
        _attentionData = [[NSMutableArray alloc]init];
    }
    return _attentionData;
}

-(void)loadTheAttentionData{
    
    [self.view showTipView:TipViewLoading withText:@"努力加载中..." forEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    CPUserInforModel * userInfor = [[CPUserInforCenter sharedInstance]getUsetData];
    NSDictionary * parmars = @{@"uid":userInfor.uid,
                                    @"page":@"1",
                                    @"limit":@"100"
                                    };
    
    [[CPAPIHelper_severURL sharedInstance]api_myfocus_withParams:parmars whenSuccess:^(id result) {
        [self.view hideTipView];
        
        if (result) {
            
            [self loadDataSuccess:result forPageIndex:1];
        }
        
    } andFailed:^(id err) {
        
    }];
}


-(void)loadDataSuccess:(id)result forPageIndex:(NSUInteger)pageIndex{
    
    NSArray *postdata = result[@"contests"];
//    NSInteger totalCount = [result[@"total_page"] integerValue];
    
    [self.attentionData addObjectsFromArray:postdata];

    
    NSMutableArray *data = [NSMutableArray array];
    for (NSDictionary *dic in self.attentionData) {
        CPListCellCommonEntiy *entity = [[CPListCellCommonEntiy alloc] init];
        entity.cellStyle = CPPostListCellStyleNormal;
        entity.dataEntity = dic;
        [data addObject:entity];
        
    }
    
    self.listVC.listCellData = data;
    [self.tabelView reloadData];
    
}

-(void)clickListVeiwWithEntiy:(CPListCellCommonEntiy *)entiy {
    
    DLog(@"点击");
    
    CPDetailViewController * detalView = [[CPDetailViewController alloc]init];
    
    detalView.title = entiy.dataEntity[@"contest_name"];
    
    detalView.listEntiy = entiy;
    
    detalView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detalView animated:YES];
    
}

@end
