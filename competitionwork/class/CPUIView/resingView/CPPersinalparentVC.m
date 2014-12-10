//
//  CPPersinalparentVC.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPPersinalparentVC.h"
#import "GJHRDMCustomModalViewController.h"
#import "CPUIViewControllerClassify.h"

@interface CPPersinalparentVC ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation CPPersinalparentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

-(void)goBack{
    
    if (self.customModalViewController) {
        [self.customModalViewController dismissRootViewControllerWithCompletion:^{
            
        }];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
 
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.persinalArray?self.persinalArray.count:1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"parentCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    CPPersinalparentModel * item = [self.persinalArray objectAtIndex:indexPath.row  ];
    cell.textLabel.text =item.Title;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CPPersinalparentModel * item = [self.persinalArray objectAtIndex:indexPath.row];
    
    if (self.persinalclickBlock) {
        
        _persinalclickBlock(item);

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

@implementation CPPersinalparentModel



@end
