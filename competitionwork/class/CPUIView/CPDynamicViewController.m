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
    [self showLoginView];
    [self setNavigationLeftButton:self withSelector:nil withImage:nil withHImgae:nil];
    [self creatTheData];
    [self layoutCollectionView];
}

-(void)showLoginView{
    
    AppDelegate * app = [AppDelegate sharedAppDelegate];
    
    if (!app.userInforCenter.isLoginSuccess) {
        
        CPLoginView * loginView = [[CPLoginView alloc]initWithNibName:nil bundle:nil];
        
        [self.navigationController pushViewController:loginView animated:NO];
        
    }
    
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
        
    }else if ([cell.reuseIdentifier isEqualToString:kCPSECTIONTWOCELLIDENTIFIER]){
        
        NSDictionary * ItemDict = [self.founctionData objectAtIndex:indexPath.row];
        
        CPFunctionCollectionCell * competitionCell = (CPFunctionCollectionCell*)cell;
        
        competitionCell.titleLabel.text = ItemDict[@"title"];
        competitionCell.iconImage.backgroundColor = [self colorWithHexString:ItemDict[@"bgNormalColor"]];
    }
//    cell.backgroundColor = [UIColor blueColor];
    
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
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    CPMainViewController * mastVC = [[CPMainViewController alloc]initWithNibName:nil bundle:nil];
    
//    AppDelegate * app = [AppDelegate sharedAppDelegate];
//    [app.MastVC setHidesBottomBarWhenPushed:YES];
    mastVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:mastVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    

    self.DataArray  = @[@{@"title":@"数学建模",@"bgNormalColor":@"4877ff",@"bgClickColor":@"476fe3"},
                        @{@"title":@"数学建模",@"bgNormalColor":@"2bdffc",@"bgClickColor":@"30ace0"},
                        @{@"title":@"数学建模",@"bgNormalColor":@"8f79ff",@"bgClickColor":@"8370e2"},
                        @{@"title":@"数学建模",@"bgNormalColor":@"20c968",@"bgClickColor":@"25b462"},
                        @{@"title":@"数学建模",@"bgNormalColor":@"f4c300",@"bgClickColor":@"d9af09"},
                        @{@"title":@"数学建模",@"bgNormalColor":@"ee5c2e",@"bgClickColor":@"d45831"},
                        ];
    
    self.founctionData  = @[@{@"title":@"聊天",@"bgNormalColor":@"4877ff",@"bgClickColor":@"476fe3"},
                        @{@"title":@"每日精华",@"bgNormalColor":@"2bdffc",@"bgClickColor":@"30ace0"},
                        @{@"title":@"排名",@"bgNormalColor":@"8f79ff",@"bgClickColor":@"8370e2"},
                        @{@"title":@"我关注的人",@"bgNormalColor":@"20c968",@"bgClickColor":@"25b462"},
                        @{@"title":@"我关注的竞赛",@"bgNormalColor":@"f4c300",@"bgClickColor":@"d9af09"},
                        @{@"title":@"发布竞赛",@"bgNormalColor":@"ee5c2e",@"bgClickColor":@"d45831"},
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
