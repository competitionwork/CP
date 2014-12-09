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
#import "CPDetailItemView.h"


@interface CPDetailViewController ()
@property (nonatomic, strong) CPDetailEntiy * inforDataEntiy;

@property (nonatomic, strong) UIScrollView * mainScrollView;


@end

@implementation CPDetailViewController
@synthesize mainScrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainScrollView];
    [[[mainScrollView.po_frameBuilder alignToTopInSuperviewWithInset:0]setWidth:MainScreenWidth]setHeight:MainScreenHeight];
    mainScrollView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = MainBackColor;
    
    [self dowloadViewdata];
}

-(void)dowloadViewdata{
    
    NSString * strId = @"104";
    
    if (self.listEntiy) {
        strId = _listEntiy.dataEntity[@"contest_id"];
//        strId = @"62";
    }
    
    NSDictionary * paramsDic = @{@"uid":@"123456",
                                 @"c_id":strId
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
    
    NSInteger high = 0;
    
    UIImageView * imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detal2"]];
    imageV.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:imageV];
    UIView * blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 30)];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.4f;
    [imageV addSubview:blackView];
    [blackView.po_frameBuilder alignToTopInSuperviewWithInset:170 - blackView.height];
    
    UILabel * headLabel = [[UILabel alloc]initWithFrame:blackView.frame];
    headLabel.text = self.title;
    headLabel.textColor = [UIColor whiteColor];
    headLabel.font = [UIFont boldSystemFontOfSize:12];
    [imageV addSubview:headLabel];
    
    [[[imageV.po_frameBuilder alignToTopInSuperviewWithInset:0]setWidth:MainScreenWidth]setHeight:170];
    
    high += [self EntersViewItemView:imageV.height];

    high +=[self formatDetailDataWithHight:270];
    
    [self.mainScrollView setContentSize:CGSizeMake(MainScreenWidth, high)];
}

-(NSInteger)EntersViewItemView:(NSInteger)height{
    
    if (_inforDataEntiy.enters) {
        
        CPDetailEntersView * entersView = [[CPDetailEntersView alloc]initWithData:_inforDataEntiy.enters];
        
        [self.mainScrollView addSubview:entersView];
        
        [entersView.po_frameBuilder alignToTopInSuperviewWithInset:height];
        
        [self addLineView:588/2 top:entersView.bottom];

        
        return entersView.height;

    }
    
    return 0;
}

-(NSInteger)formatDetailDataWithHight:(NSInteger)hight{
    
    NSMutableDictionary * dictAttrs = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableArray * arrayAttrs = [NSMutableArray arrayWithCapacity:0];
    
    if (_inforDataEntiy.contest_name) {
        [arrayAttrs addObject:@{@"竞赛全称":_inforDataEntiy.contest_name}];
    }
    if (_inforDataEntiy.contest_short_name) {
        [arrayAttrs addObject:@{@"竞赛简称":_inforDataEntiy.contest_short_name}];
    }
    
    [dictAttrs setObject:[self reBuildTitle:arrayAttrs] forKey:@"attr"];
    
    CPPostDetailAttrsView * AttrsView1 = [[CPPostDetailAttrsView alloc]initWithData:dictAttrs];
    
    [self.mainScrollView addSubview:AttrsView1];
    
    [AttrsView1.po_frameBuilder alignToTopInSuperviewWithInset:hight + 1];
    
    [self addLineView:588/2 top:AttrsView1.bottom];
    
    [arrayAttrs removeAllObjects];

    //
    if (_inforDataEntiy.regist_start_time) {
        [arrayAttrs addObject:@{@"报名时间":[self contestTimeFor:_inforDataEntiy.regist_start_time]}];
    }
    if (_inforDataEntiy.contest_start_time) {
        [arrayAttrs addObject:@{@"竞赛时间":[self contestTimeFor:_inforDataEntiy.contest_start_time]}];
    }
    if (_inforDataEntiy.organiser) {
        [arrayAttrs addObject:@{@"主办方":_inforDataEntiy.organiser}];
    }
    if (_inforDataEntiy.contest_cycle) {
        [arrayAttrs addObject:@{@"竞赛周期":_inforDataEntiy.contest_cycle}];
    }
    
    [dictAttrs setObject:[self reBuildTitle:arrayAttrs] forKey:@"attr"];
    
    CPPostDetailAttrsView * AttrsView2 = [[CPPostDetailAttrsView alloc]initWithData:dictAttrs];
    
    [self.mainScrollView addSubview:AttrsView2];
    
    [AttrsView2.po_frameBuilder alignToBottomOfView:AttrsView1 offset:1];

    [self addLineView:588/2 top:AttrsView2.bottom];
    
    [arrayAttrs removeAllObjects];
    
    ///
    if (_inforDataEntiy.contest_keyword) {
        [arrayAttrs addObject:@{@"关键词":[_inforDataEntiy.contest_keyword isEqualToString:@""]?@"竞赛":@"竞赛"}];
    }
    if (_inforDataEntiy.bonus) {
        [arrayAttrs addObject:@{@"总奖金":_inforDataEntiy.bonus}];
    }
    if (_inforDataEntiy.benefit) {
        [arrayAttrs addObject:@{@"竞赛诱惑":_inforDataEntiy.benefit}];
    }
    
    [dictAttrs setObject:[self reBuildTitle:arrayAttrs] forKey:@"attr"];
    
    CPPostDetailAttrsView * AttrsView3 = [[CPPostDetailAttrsView alloc]initWithData:dictAttrs];
    
    [self.mainScrollView addSubview:AttrsView3];
    
    [AttrsView3.po_frameBuilder alignToBottomOfView:AttrsView2 offset:1];
    
    [self addLineView:588/2 top:AttrsView3.bottom];
    
    [arrayAttrs removeAllObjects];
    
    ///
    if (_inforDataEntiy.contest_name) {
        [arrayAttrs addObject:@{@"竞赛简介":_inforDataEntiy.contest_name}];
    }
    
    [dictAttrs setObject:[self reBuildTitle:arrayAttrs] forKey:@"attr"];
    
    CPPostDetailAttrsView * AttrsView4 = [[CPPostDetailAttrsView alloc]initWithData:dictAttrs];
    
    [self.mainScrollView addSubview:AttrsView4];
    
    [AttrsView4.po_frameBuilder alignToBottomOfView:AttrsView3 offset:1];
    

    return (AttrsView4.origin.y + AttrsView4.frame.size.height);
}

/**
 *  重构title的字符串（其实就是给两个字或者三个字的title加空格）
 *
 *  @param array old array
 *
 *  @return new array
 */
- (NSMutableArray *)reBuildTitle:(NSMutableArray *)array
{
    
    NSMutableArray *attrArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        
        NSString *keyName = (NSString *)([dict allKeys][0]);
        
        
            if (keyName.length == 2) {
                
                NSMutableString *keyNameMu = [NSMutableString stringWithString:keyName];
                [keyNameMu insertString:@"       " atIndex:1];
                NSMutableDictionary *dictMu = [NSMutableDictionary dictionary];
                [dictMu setObject:[dict objectForKey:keyName] forKey:keyNameMu];
                [attrArray addObject:dictMu];
                
            }
            else if (keyName.length == 3)
            {
                NSMutableString *keyNameMu = [NSMutableString stringWithString:keyName];
                [keyNameMu insertString:@"  " atIndex:2];
                [keyNameMu insertString:@"  " atIndex:1];
                NSMutableDictionary *dictMu = [NSMutableDictionary dictionary];
                [dictMu setObject:[dict objectForKey:keyName] forKey:keyNameMu];
                [attrArray addObject:dictMu];
            }
            else
            {
                [attrArray addObject:dict];
            }
            
    }
    
    return attrArray;
}


- (void)addLineView:(float)width top:(float)top
{
    @try {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, top, width, 0.5)];
        lineView.layer.borderWidth = 0.25;
        lineView.layer.borderColor = GJColor(216, 216, 216, 1).CGColor;
        lineView.centerX = MainScreenWidth/2;
        [self.mainScrollView addSubview:lineView];
    }
    @catch (NSException *exception) {
        
    }
}

-(NSString *)contestTimeFor:(NSString*)time{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate* registStart = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString* startStr = [dateFormatter stringFromDate:registStart];
    
//    NSDate* registEnd = [NSDate dateWithTimeIntervalSince1970:[[Item objectForKey:@"contest_end_time"] intValue]];
//    NSString* endStr = [dateFormatter stringFromDate:registEnd];
    
    NSString * str = [NSString stringWithFormat:@"%@",startStr];
    
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIScrollView *)mainScrollView
{
    if (!mainScrollView) {
        mainScrollView = [[UIScrollView alloc]init];
    }
    return mainScrollView;
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
