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

@interface CPAttentionView ()

@property(nonatomic,strong) UITableView * tabelView;

@property(nonatomic,strong) NSMutableArray * attentionData;

@property(nonatomic,strong) CPMainListViewController * listVC;

@end

@implementation CPAttentionView

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.tabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tabelView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.tabelView];
    self.tabelView.delegate = self.listVC;
    self.tabelView.dataSource = self.listVC;
    
    
}

-(void)loadTheAttentionData{
    
}


@end
