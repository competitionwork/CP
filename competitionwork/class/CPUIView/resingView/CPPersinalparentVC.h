//
//  CPPersinalparentVC.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PersinalClickBlock)(id dict);

@interface CPPersinalparentVC : CPBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *persinalArray;

@property (nonatomic,copy) PersinalClickBlock persinalclickBlock;

@end
