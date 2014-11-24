//
//  CPMainViewController.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-10-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPMainViewController.h"
#import "GJFilterSingleLevelOptionSelectorView.h"
#import "GJFilterMultilevelOptionSelectorView.h"
#import "NSArray+linq.h"
#import "CPAPIHelper_severURL.h"
#import "CPPostDataRequestParam.h"
#import "CPListCellCommonEntiy.h"
#import "CPMainListCellModel.h"
#import "filterManage.h"
#import "CPDetailViewController.h"
#import "RefreshView.h"
#import "CPUIViewControllerClassify.h"
#import "CPLoginView.h"

@interface CPMainViewController ()<GJFilterViewDatasource,GJFilterViewDelegate,RefreshViewDelegate>
{
    BOOL isLoading;
}

@property(nonatomic,strong) GJOptionNode *rootNode;

@property (nonatomic, assign) UINavigationController * pushController;

@property(nonatomic,strong) NSMutableArray *postData;

@property(nonatomic,retain) GJOptionNode *rootFilterNode;

@property(nonatomic,strong) RefreshView * refreshView;

@property(nonatomic,assign) BOOL showRefreshLoadingView;




@end

@implementation CPMainViewController

@synthesize rootNode;
@synthesize pushController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBackColor;
    
    self.title = @"竞赛";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"按钮" style:UIBarButtonItemStyleDone target:self action:@selector(push)];
    
    [self.view addSubview:self.filterView];
    
    [self.filterView.po_frameBuilder alignToTopInSuperviewWithInset:64];
    
    //    [self download];
    
    [self.view addSubview:self.tabelView];
    self.tabelView.frame  = self.view.bounds;
    self.tabelView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    [self setListController:nil];
    self.tabelView.dataSource = self.listController;
    self.tabelView.delegate = self.listController;
    
    _refreshView = [[RefreshView alloc]initWithOwner:self.tabelView delegate:self];
    self.showRefreshLoadingView = YES;
    
    
    
    __weak typeof(self) weakself = self;
    
    [self.listController setClickIndex:^(CPListCellCommonEntiy * entiy) {
        [weakself clickListVeiwWithEntiy:entiy];
    }];
    
    [self.listController setScrollViewWillBeginDragging:^(UIScrollView *ScrollView) {
        [weakself scrollViewWillBeginDragging:ScrollView];
    }];
    
    [self.listController setScrollViewDidScroll:^(UIScrollView *ScrollView) {
        [weakself scrollViewDidScroll:ScrollView];
    }];
    
    [self.listController setScrollViewDidEndDraggingWillDecelerate:^(UIScrollView *ScrollView, BOOL decelerate) {
        [weakself scrollViewDidEndDragging:ScrollView willDecelerate:decelerate];
    }];
    
    [self reloadData];
    
    [self layoutSubvies];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)push{
    CPLoginView * login = [[CPLoginView alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}

- (void)refresh {
    
    [self loadDataByPageIndex:0];
}

-(void)reloadData
{
    [self loadFilterData];
}

-(void)loadFilterData
{
    
    filterManage * filterMg = [[filterManage alloc]init];
    
    NSArray *nodes=[filterMg nodesFromFilterData:nil];
    self.rootNode=[GJOptionNode nodeWithText:@"rootNode" value:nil];
    self.rootNode.subNodes=nodes;
    self.filterView.rootNode=self.rootNode;
    [self.filterView reloadData];
    
    [self refreashData];
    
    
}


-(void)clickListVeiwWithEntiy:(CPListCellCommonEntiy *)entiy {
    DLog(@"点击");
    
    CPDetailViewController * detalView = [[CPDetailViewController alloc]init];
    
    detalView.title = entiy.dataEntity[@"contest_name"];
    
    [self.navigationController pushViewController:detalView animated:YES];
    
}

#pragma mark - 新筛选项
-(GJFilterView *)filterView
{
    if (!_filterView) {
        _filterView = [[GJFilterView alloc] initWithDefaultStyle];
        _filterView.delegate = self;
        _filterView.datasource = self;
        _filterView.navigationController = self.pushController;
        _filterView.filterBar.hideMoreItem = NO;
    }
    
    return _filterView;
}


-(NSInteger)numberOfBarItemsShoudDisplayInFilterView:(GJFilterView *)filterView
{
    return MIN(3,[self.rootNode.subNodes where:^BOOL(GJOptionNode *target) {
        return target.hide == NO; // 不隐藏的筛选项数量
    }].count);
}

-(void)filterView:(GJFilterView *)filterView didSelectedNode:(GJOptionNode *)node atIndexOfBarItem:(NSInteger)index
{
    //    DLog(@"select : %@ - %@",node,node.filterOption);
    [self refresh];
}
-(Class)filterView:(GJFilterView *)filterView optionListClassAtIndex:(NSInteger)index
{
    GJOptionNode *subNode=[filterView.rootNode.subNodes where:^BOOL(GJOptionNode *target) {
        return target.hide == NO;
    }][index];
    if ([[[subNode.subNodes lastObject] subNodes] count]) {
        
        return [GJFilterMultilevelOptionSelectorView class];
    }
    return [GJFilterSingleLevelOptionSelectorView class];
}
-(void)filterViewDidRefresh:(GJFilterView *)filterView withRootNode:(GJOptionNode *)theRootNode withKeyWord:(NSString *)keyWord
{
    self.rootNode = theRootNode;
    self.filterView.rootNode = self.rootNode;
    [self.filterView reloadData];
    
    [self refresh];
}
- (NSString *)filterKeyWord
{
    return  @"";
}

-(NSArray *)filterParamsFromOptionNode:(GJOptionNode *)RootNode
{
    NSMutableArray *filterParams=[NSMutableArray arrayWithCapacity:4];
    void(^addValue)(id val)=^(id val){
        if ([val isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic=val;
            if (![[dic[@"value"] description] isEqualToString:@"-1"]) {
                [filterParams addObject:val];
            }
        }
    };
    [RootNode.subNodes enumerateObjectsUsingBlock:^(GJOptionNode *subNode, NSUInteger idx, BOOL *stop) {
        
        __weak GJOptionNode *n=subNode.selectedNode;
        if ([[n.value[@"name"] description] isEqualToString:@"latlng"] ) { // 附近的node需要在范围里加上经纬度
            NSMutableDictionary *newValue = [NSMutableDictionary dictionaryWithDictionary:n.value];
            NSString *str = newValue[@"value"];
            if ([str componentsSeparatedByString:@","].count == 1) { //判断里边是否已经加过经纬度了
//                newValue[@"value"] = [NSString stringWithFormat:@"%@,%@",loc,newValue[@"value"]];
//                n.value = newValue;
            }
        }
        if (n) {
            addValue(n.superNode.value);
            addValue(n.value);
        }
        else if(subNode.value)
        {
            addValue(subNode.value);
        }
    }];
    return filterParams;
}



#define mark - tabel的代理


-(void)setListController:(CPMainListViewController *)listController
{
    
    if (!listController) {
        _listController = [[CPMainListViewController alloc]init];
    }
    else
    {
        _listController = listController;
    }
    self.tabelView.dataSource = _listController;
    self.tabelView.delegate = _listController;
    
    
    
}


-(void)refreashData
{
    [self loadDataByPageIndex:0];
}

-(void)loadDataByPageIndex:(NSUInteger)pageIndex
{
    [_refreshView startLoading];
    //    self.listDataRequestParam.currentPageIndex = pageIndex;
    //
    //    self.listDataRequestParam.queryParams.pageIndex = NSStringFromInt(pageIndex);
    
    NSArray * paramArray = [self filterParamsFromOptionNode:self.rootNode];
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionaryWithCapacity:0];
    [paramArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
       
        [paramDict setObject:obj[@"value"] forKey:obj[@"name"]];
        
    }];
    
    [self loadDataByParam:paramDict];
}

-(void)loadDataByParam:(NSDictionary *)param
{
    
    isLoading = YES;
    
    NSDictionary * params = @{@"uid": @"1",
                              @"c_class" : NSStringFromInt(1),
                              @"c_level" : NSStringFromInt(1),
                              @"c_level" : NSStringFromInt(1),
                              @"page" : NSStringFromInt(1),
                              @"limit":NSStringFromInt(20),
                              @"univs_id":NSStringFromInt(1001)
                              };
    
    [[CPAPIHelper_severURL sharedInstance] api_lists_withParams:params whenSuccess:^(NSDictionary * result) {
        
        isLoading = NO;
        
        [_refreshView stopLoading];
        
        DLog(@">>>>>>> : %@",@"获取数据成功!");
        
        DLog(@"%@",result);
        
        for (int i = 0; i< [result[@"contests"] count]; i++) {
            
            CPMainListCellModel * modelObject = [[CPMainListCellModel alloc]init];
            
            [modelObject reflectDataFromOtherObject:result];
            [modelObject reflectDataFromOtherObject:result[@"contests"]];
            DLog(@"modelObject = %@",modelObject);
            
        }
        
        
        [self loadDataSuccess:result forPageIndex:0];
        
        
    } andFailed:^(id err) {
        
        //        [self loadFilterData];
        
        DLog(@">>>>>>> : %@ , %@",@"获取数据失败",err);
        
        DLog(@"%@",err);
        
    }];
    
}

-(void)loadDataSuccess:(id)result forPageIndex:(NSUInteger)pageIndex
{
    
    NSArray *postdata = result[@"contests"];
    NSInteger totalCount = [result[@"all_num"] integerValue];
    if (pageIndex && self.postData.count > 0) {
        [self.postData removeAllObjects];
    }
    [self.postData addObjectsFromArray:postdata];
    
    
    NSMutableArray *data = [NSMutableArray array];
    for (NSDictionary *dic in self.postData) {
        CPListCellCommonEntiy *entity = [[CPListCellCommonEntiy alloc] init];
        entity.cellStyle = CPPostListCellStyleNormal;
        entity.dataEntity = dic;
        [data addObject:entity];
        
    }
    self.listController.listCellData = data;
    
    self.tabelView.backgroundColor = MainBackColor;
    [self.tabelView reloadData];
}


-(void)loadDataFailed:(NSError *)error
{
    
}

-(NSMutableArray *)postData
{
    if (!_postData) {
        _postData = [NSMutableArray array];
    }
    return _postData;
}



-(UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    }
    return _tabelView;
}


-(void)layoutSubvies
{
    //    [self.view insertSubview:self.tabelView belowSubview:self.filterView];
    [self.view bringSubviewToFront:_filterView];
    
    if (1) {
        [[self.tabelView.po_frameBuilder setHeight:MainScreenHeight - 44] setY:104];
    }
    else {
        [[self.tabelView.po_frameBuilder setHeight:MainScreenHeight - 44 - self.filterView.frame.size.height] alignToBottomOfView:self.filterView offset:0];
    }
}



// -----------------------------------------------------------------------
#pragma mark - ScrollViewDelegate
// -----------------------------------------------------------------------

// 刚拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_refreshView scrollViewWillBeginDragging:scrollView];
}

// 拖动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refreshView scrollViewDidScroll:scrollView];
    if (!isLoading) {
        if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
            self.showRefreshLoadingView = NO;
        }
    }
}

// 拖动结束后
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_refreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)refreshViewDidCallBack {
    [self loadDataByPageIndex:0];
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



/*
 {
 code = 0;
 data =     {
 contests =         (
 {
 "contest_end_time" = 1415420795;
 "contest_id" = 103;
 "contest_name" = "2015\U7b2c\U4e8c\U5c4a\U9ad8\U6559\U793e\U676f\U5168\U56fd\U5927\U5b66\U751f\U6570\U5b66\U5efa\U6a21\U7ade\U8d5b\U5927\U8fde\U5927\U5b66\U8d5b\U533a";
 "contest_start_time" = 1415415795;
 "is_follow" = 0;
 organiser = "\U6559\U80b2\U90e8";
 "regist_end_time" = 1414961149;
 "regist_start_time" = 1414870441;
 },
 {
 "contest_end_time" = 1415420795;
 "contest_id" = 105;
 "contest_name" = "2014\U6311\U6218\U676f\U521b\U4e1a\U5927\U8d5b\U5168\U56fd\U603b\U51b3\U8d5b";
 "contest_start_time" = 1415415795;
 "is_follow" = 0;
 organiser = "\U6559\U80b2\U90e8\Uff0c\U79d1\U6280\U53d1\U5c55\U4e2d\U5fc3";
 "regist_end_time" = 1414961149;
 "regist_start_time" = 1414870441;
 },
 {
 "contest_end_time" = 1415420795;
 "contest_id" = 104;
 "contest_name" = "2015\U7b2c\U516d\U5c4a\U5168\U56fd\U5927\U5b66\U751f\U673a\U5668\U4eba\U5927\U8d5b";
 "contest_start_time" = 1415415795;
 "is_follow" = 1;
 organiser = "\U6559\U80b2\U90e8\Uff0c\U673a\U5668\U4eba";
 "regist_end_time" = 1414961149;
 "regist_start_time" = 1414870441;
 }
 );
 };
 msg = "";
 }
 */
