//
//  CPDynamicViewController.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-10-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPDynamicViewController.h"
#import "CPLoginView.h"
#import "AppDelegate.h"
#import "CPMastCompetitionCell.h"
#import "CPFunctionCollectionCell.h"
#import "CPMainViewController.h"
#import "CPUserInforCenter.h"
#import "CPDailyEssenceVC.h"
#import "CPAttentionView.h"
#import "CPHotViewVC.h"

#import "CPDetailViewController.h"//详情页调试
#import "CPAttentionView.h"
#import "CPAboutVC.h"


//推荐类cell
#define kCPSECTIONONECELLIDENTIFIER @"1"

//功能类cell
#define kCPSECTIONTWOCELLIDENTIFIER @"2"

@interface CPDynamicViewController ()

@property (nonatomic,strong) UICollectionView *colletionView;

@property (nonatomic,strong) NSArray *DataArray;

@property (nonatomic,strong) NSArray *founctionData;

@end

@implementation CPDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    self.title = @"环球竞赛网";
    [self showLoginView];
    [self setNavigationLeftButton:self withSelector:nil withImage:nil withHImgae:nil];
    [self creatTheData];
    [self layoutCollectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.colletionView.frame = CGRectMake(0, 0, MainScreenWidth, self.view.height);
}

-(void)showLoginView{
    
    AppDelegate * app = [AppDelegate sharedAppDelegate];
    
    if (!app.userInforCenter.isLoginSuccess) {
    
        CPLoginView * loginView = [[CPLoginView alloc]initWithNibName:nil bundle:nil];
//        [[CPUserInforCenter sharedInstance]loadUserInforData];
//        CPDetailViewController * loginView = [[CPDetailViewController alloc]initWithNibName:nil bundle:nil];
//        CPAttentionView * attention = [[CPAttentionView alloc]init];
//        CPAboutVC * about = [[CPAboutVC alloc]init];
        
        [self.navigationController pushViewController:loginView animated:NO];
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate * app = [AppDelegate sharedAppDelegate];
    [app.MastVC showBottomBar];
}

-(void)layoutCollectionView{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    self.colletionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight) collectionViewLayout:layout];
    _colletionView.multipleTouchEnabled = NO;
    _colletionView.exclusiveTouch = YES;
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.backgroundColor = [UIColor whiteColor];
    
    [_colletionView registerClass:[CPMastCompetitionCell class] forCellWithReuseIdentifier:kCPSECTIONONECELLIDENTIFIER];
    [_colletionView registerClass:[CPFunctionCollectionCell class] forCellWithReuseIdentifier:kCPSECTIONTWOCELLIDENTIFIER];

    [self.view addSubview:_colletionView];
    
}

#define mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 6;
            break;
        case 1:
            return 6;
            break;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"";
    if (indexPath.section == 0) {
        
        Identifier = kCPSECTIONONECELLIDENTIFIER;
        
    }else if (indexPath.section == 1){
        
        Identifier = kCPSECTIONTWOCELLIDENTIFIER;
        
    }
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqualToString: kCPSECTIONONECELLIDENTIFIER]) {
        
        NSDictionary * ItemDict = [self.DataArray objectAtIndex:indexPath.row];
        
        CPMastCompetitionCell * competitionCell = (CPMastCompetitionCell*)cell;
        
        competitionCell.titleLabel.text = ItemDict[@"title"];
        competitionCell.backGroundImage.backgroundColor = [self colorWithHexString:ItemDict[@"bgNormalColor"]];
        competitionCell.backGroundImage.image = [UIImage imageNamed:ItemDict[@"back_image"]];
        
    }else if ([cell.reuseIdentifier isEqualToString:kCPSECTIONTWOCELLIDENTIFIER]){
        
        NSDictionary * ItemDict = [self.founctionData objectAtIndex:indexPath.row];
        
        CPFunctionCollectionCell * competitionCell = (CPFunctionCollectionCell*)cell;
        
        competitionCell.titleLabel.text = ItemDict[@"title"];
        competitionCell.iconImage.backgroundColor = [UIColor clearColor];
        competitionCell.iconImage.image = [UIImage imageNamed:ItemDict[@"back_image"]];

    }
    
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (section == 0) {
        
        edge = UIEdgeInsetsMake(5, 10, 0, 10);
        
    }else if (section == 1){
        
        edge = UIEdgeInsetsMake(30, 10, 0, 10);
        
    }
    
    return edge;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize  size = CGSizeMake(0, 0);
    
    if (indexPath.section == 0) {
        
        size = CGSizeMake((MainScreenWidth - 40)/3, 70);
        
    }else if (indexPath.section == 1){
        
        size = CGSizeMake((MainScreenWidth - 40)/3, 100);
        
    }
    
    return size;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 ) {
        
        if (indexPath.row == 0) {
            
            CPDailyEssenceVC * VC = [[CPDailyEssenceVC alloc]initWithNibName:nil bundle:nil];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.row == 1){
            
            CPHotViewVC * attentionView = [[CPHotViewVC alloc]init];
            attentionView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:attentionView animated:YES];
            
        }else if (indexPath.row == 2){
            CPAttentionView * attentionView = [[CPAttentionView alloc]init];
            attentionView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:attentionView animated:YES];
        }
    }else{
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        NSDictionary * dict = [self.DataArray objectAtIndex:indexPath.row];
        
        CPMainViewController * mastVC = [[CPMainViewController alloc]init];
        mastVC.DefaultFilter = [NSDictionary dictionaryWithObject:dict[@"type"] forKey:@"type"];
        mastVC.hidesBottomBarWhenPushed = YES;
        mastVC.title = dict[@"title"];
        [self.navigationController pushViewController:mastVC animated:YES];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return  ([UIColor blackColor]);
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return ([UIColor blackColor]);
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

-(void)creatTheData{
    

    self.DataArray  = @[@{@"title":@"程序设计",@"bgNormalColor":@"4877ff",@"bgClickColor":@"476fe3",@"back_image":@"六宫格二_03",@"type":@"2"},
                        @{@"title":@"数学建模",@"bgNormalColor":@"2bdffc",@"bgClickColor":@"30ace0",@"back_image":@"六宫格二_05",@"type":@"1"},
                        @{@"title":@"机器人",@"bgNormalColor":@"8f79ff",@"bgClickColor":@"8370e2",@"back_image":@"六宫格二_07",@"type":@"4"},
                        @{@"title":@"电子&自动化",@"bgNormalColor":@"20c968",@"bgClickColor":@"25b462",@"back_image":@"六宫格二_13",@"type":@"5"},
                        @{@"title":@"计算机&信息技术",@"bgNormalColor":@"f4c300",@"bgClickColor":@"d9af09",@"back_image":@"六宫格二_15",@"type":@"6"},
                        @{@"title":@"工程机械",@"bgNormalColor":@"ee5c2e",@"bgClickColor":@"d45831",@"back_image":@"六宫格二_16",@"type":@"9"},
                        ];
    
    self.founctionData  = @[
                        @{@"title":@"每日精华",@"bgNormalColor":@"2bdffc",@"bgClickColor":@"30ace0",@"back_image":@"mast_2"},
                        @{@"title":@"热门竞赛",@"bgNormalColor":@"20c968",@"bgClickColor":@"25b462",@"back_image":@"mast_1"},
                        @{@"title":@"我关注的竞赛",@"bgNormalColor":@"f4c300",@"bgClickColor":@"d9af09",@"back_image":@"mast_5"},
                         @{@"title":@"排名",@"bgNormalColor":@"8f79ff",@"bgClickColor":@"8370e2",@"back_image":@"mast_3"},
                        @{@"title":@"发布竞赛",@"bgNormalColor":@"ee5c2e",@"bgClickColor":@"d45831",@"back_image":@"mast_6"},
                        @{@"title":@"校园大使",@"bgNormalColor":@"4877ff",@"bgClickColor":@"476fe3",@"back_image":@"mast_4"},
                        ];

    
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
