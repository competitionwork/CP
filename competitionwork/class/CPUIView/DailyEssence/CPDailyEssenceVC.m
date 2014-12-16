//
//  CPDailyEssenceVC.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-10.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPDailyEssenceVC.h"
#import "CPEssenceTableViewCell.h"
#import "CPAPIHelper_journalURL.h"
#import "CPUserInforCenter.h"

@interface CPDailyEssenceVC ()

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *essenceData;

@end

@implementation CPDailyEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"每日精华";
    [self downLoadTheEssenceData];
    [self.view addSubview:self.myTableView];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



-(void)downLoadTheEssenceData{
    
    NSDictionary * params = @{@"type":@"hot",
                              @"class_id":@"0",
                              @"keyword_id":@"",
                              @"page":@"1",
                              @"limit":@"20",
                              };
    
    [[CPAPIHelper_journalURL sharedInstance]api_lists_withParams:params whenSuccess:^(id result) {
        DLog(@"api_lists_withParams = %@",result);
        
        if (result) {
            [self.essenceData addObjectsFromArray:result[@"journals"]];
            [self.myTableView reloadData];
        }
    } andFailed:^(id err) {
        
    }];
    
}

-(UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _myTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.essenceData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"essenceCell";
    CPEssenceTableViewCell * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CPEssenceTableViewCell" owner:self options:nil]lastObject];
    }
    
    NSDictionary * item = [self.essenceData objectAtIndex:indexPath.row];
    
    [cell setleftImagewithUrl:item[@"avatar"]];
    
    cell.titleLabel.text = item[@"title"];
    cell.authorLabel.text = item[@"univs_name"];
    cell.timeLabel.text = item[@"create_time"];
    
    cell.hiddenTopBorder = indexPath.row == 0?NO:YES;
    cell.hiddenBottomBorder = indexPath.row == (self.essenceData.count - 1);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CPUserInforModel * user = [[CPUserInforCenter sharedInstance]getUsetData];
    
    NSDictionary * item = [self.essenceData objectAtIndex:indexPath.row];
    
    NSDictionary * params = @{@"journal_id":item[@"journal_id"],
                              @"uid":user.uid,
                              };
    
    [[CPAPIHelper_journalURL sharedInstance]api_view_withParams:params whenSuccess:^(id result) {
        DLog(@"%@",result);
        
        if(result){
            UIWebView * Web = [[UIWebView alloc]initWithFrame:self.view.bounds];
            [Web loadHTMLString:[result description]baseURL:nil];
            [self.view addSubview:Web];
        }
    } andFailed:^(id err) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)essenceData{
    
    if (!_essenceData) {
        _essenceData = [[NSMutableArray alloc]init];
    }
    return _essenceData;
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
