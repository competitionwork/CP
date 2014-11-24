//
//  CPMainViewController.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-10-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJFilterView.h"
#import "CPMainListViewController.h"
@interface CPMainViewController : CPBaseViewController

@property (nonatomic,strong) GJFilterView *filterView;

@property (nonatomic,strong) CPMainListViewController * listController;

@property (nonatomic,strong) UITableView * tabelView;

@end
