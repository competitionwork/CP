//
//  GJFilterFullOptionListViewController.m
//  HouseRent
//
//  Created by liruiqin on 13-12-12.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJFilterFullOptionListViewController.h"
//#import "ZhidingConditionVC.h"
#import "GJChooseButton.h"
//#import "CityData.h"
//#import "GJOptionSelector.h"
//#import "GJOptionListView.h"
//#import "GJCSOption.h"
#import "NSArray+linq.h"
//#import "GJCheckBoxGroupView.h"

@interface GJFilterFullOptionListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) id<GJFilterFullOptionSelectorDelegate> _delegate;
@property(nonatomic,copy) GJOptionNode *_rootNode;
@property(nonatomic) UITableView *tableView;
@property(nonatomic) UIButton *buttonDone;
//@property(nonatomic) Street *currentStreet;
@property(nonatomic) BOOL bDistrictDone;

@property(nonatomic) BOOL fromErshou;
@property(nonatomic) NSString *baseTagId;
@property(nonatomic) NSString *baseTagTitle;
@property(nonatomic) NSArray  *baseTagArray;
@property(nonatomic) NSArray  *baseTagIdArray;
@property(nonatomic) NSString *erShouSelectIndex;
@property(nonatomic) NSUInteger ershouLeftIndex;
@property(nonatomic) NSUInteger ershouRightIndex;
@property(nonatomic,getter = isLoaded) BOOL loaded;
@property(nonatomic) NSArray *notHideNodes;

@end

@implementation GJFilterFullOptionListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title = @"高级筛选";
//    [self setNavigationCancelButton:self withSelector:@selector(backMethod:)];
//    self.view.backgroundColor = MainBackGroundColor;
    
    self.buttonDone=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:self.buttonDone];
    UIImage *finishImg = [UIImage imageNamed:@"buttonB高34.png"];
    UIImage *hFinishImg = [UIImage imageNamed:@"buttonB高34-点击态.png"];
    [self.buttonDone setTitle:@"进行筛选" forState:UIControlStateNormal];
    [self.buttonDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buttonDone.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.buttonDone setBackgroundImage:[finishImg stretchableImageWithLeftCapWidth:floorf(finishImg.size.width/2) topCapHeight:finishImg.size.height/2] forState:UIControlStateNormal];
    [self.buttonDone setBackgroundImage:[hFinishImg stretchableImageWithLeftCapWidth:floorf(hFinishImg.size.width/2) topCapHeight:hFinishImg.size.height/2] forState:UIControlStateHighlighted];
    [self.buttonDone addTarget:self action:@selector(doneFilter:) forControlEvents:UIControlEventTouchUpInside];
    [[[self.buttonDone.po_frameBuilder setSizeWithWidth:145 height:34] centerHorizontallyInSuperview] alignToBottomInSuperviewWithInset:70];

    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(11, 20, 299, 349) style:UITableViewStylePlain];
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
- (void)backMethod:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setOptionSelectorDelegate:(id<GJFilterFullOptionSelectorDelegate>)optionSelectorDelegate
{
    self._delegate=optionSelectorDelegate;
}

-(id<GJFilterFullOptionSelectorDelegate>)optionSelectorDelegate
{
    return self._delegate;
}
-(void)setRootNode:(GJOptionNode *)rootNode
{
//    self._rootNode = rootNode;
//    [self reloadData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 异步进行深拷贝
        NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:rootNode]; // 深拷贝
        NSData *myEncodedObject = [archiveCarPriceData copy];
        GJOptionNode *targetNode = [NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            self._rootNode = targetNode;
            self.notHideNodes = [targetNode.subNodes where:^BOOL(GJOptionNode *subtarget) {
                return subtarget.hide == NO;
            }];
            [self reloadData];
            self.loaded = YES;
            DLog(@"%p - %p",&__rootNode,&rootNode);
        });
    });
}
-(GJOptionNode *)rootNode
{
    return self._rootNode;
}

- (void)doneFilter:(UIButton *)button
{
    if (!self.isLoaded) {
        return;
    }
    if ([self.optionSelectorDelegate respondsToSelector:@selector(filterFullOptionSelector:endSelect:)]) {
        [self.optionSelectorDelegate filterFullOptionSelector:self endSelect:self.rootNode];
    }
    [self backMethod:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notHideNodes.count;
}
-(void)reloadData
{
    DLog(@"");
    [self.tableView reloadData];
    [self.tableView.po_frameBuilder setHeight:self.tableView.contentSize.height];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MainView";
    
	NSInteger index = [indexPath row];
	UITableViewCell *cell = nil;
    GJOptionNode *node=self.notHideNodes[index];
    
    // 是否显示有图框
    if ([node.value isEqualToString:@"image_count"]) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"image_count"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"image_count"];
                        
            UIImageView* bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 299, 52)];
            bgView.image = [[UIImage imageNamed:@"填写信息框.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:25];
            cell.backgroundView = bgView;
            cell.selectedBackgroundView = nil;
            
            UIImageView * bgLine = [[UIImageView alloc]initWithFrame:CGRectMake(1, 0, 80, cell.frame.size.height)];
            bgLine.image = [UIImage imageNamed:@"填写信息框-标题.png"];
            [cell.contentView addSubview:bgLine];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;
            
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 43)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:14];
            titleLabel.textColor = [UIColor colorWithRed:133.0/255.0 green:171.0/255.0 blue:114.0/255.0 alpha:1.0];
            titleLabel.tag = 112122;
            [cell.contentView addSubview:titleLabel];
            
//            CheckBox *checkBox = [[CheckBox alloc] initWithFrame:CGRectMake(180, 5, 130, 34) withString:@"仅显示有图"];
//            checkBox.tag = 112121;
//            
//            [checkBox.label setFont:[UIFont boldSystemFontOfSize:14]];
//            [checkBox.label setTextColor:[UIColor colorWithRed:0x33/255.0 green:0x33/255. blue:0x33/255. alpha:1.0]];
//            [checkBox setTarget:self valueChangeSel:@selector(typeChanged:)];
//            [cell.contentView addSubview:checkBox];
        }
        
        NSString *title = node.displayText;
        if (title.length == 2) {
            title = [NSString stringWithFormat:@"%@       %@",[title substringWithRange:NSMakeRange(0, 1)],[title substringWithRange:NSMakeRange(1, 1)]];
        }
        else if (title.length == 3) {
            title = [NSString stringWithFormat:@"%@  %@  %@",[title substringWithRange:NSMakeRange(0, 1)],[title substringWithRange:NSMakeRange(1, 1)],[title substringWithRange:NSMakeRange(2, 1)]];
        }
        ((UILabel *)[cell.contentView viewWithTag:112122]).text = title;
//        CheckBox *checkBox=((CheckBox *)[cell.contentView viewWithTag:112121]);
//        checkBox.checked = (node.selected)?YES:NO;
//        checkBox.checkValue=node;
    }
    else if (node.subNodes.count<=3)
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"3OptionCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"3OptionCell"];
            
            UIImageView* bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 299, 52)];
            bgView.image = [[UIImage imageNamed:@"填写信息框.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:25];
            cell.backgroundView = bgView;
            cell.selectedBackgroundView = nil;
            
            UIImageView * bgLine = [[UIImageView alloc]initWithFrame:CGRectMake(1, 0, 80, cell.frame.size.height)];
            bgLine.image = [UIImage imageNamed:@"填写信息框-标题.png"];
            [cell.contentView addSubview:bgLine];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;
            
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 43)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:14];
            titleLabel.textColor = [UIColor colorWithRed:133.0/255.0 green:171.0/255.0 blue:114.0/255.0 alpha:1.0];
            titleLabel.tag = 112122;
            [cell.contentView addSubview:titleLabel];
            
//            GJCheckBoxGroupView *checkboxGroup=[[GJCheckBoxGroupView alloc] initWithFrame:CGRectZero];
//            checkboxGroup.tag=12321;
//            [cell.contentView addSubview:checkboxGroup];
//            [[[checkboxGroup.po_frameBuilder setSizeWithWidth:320-80-40 height:44] centerVerticallyInSuperview] alignRightInSuperviewWithInset:31];
        }
        
//        NSString *title = node.displayText;
//        GJCheckBoxGroupView *checkBox=((GJCheckBoxGroupView *)[cell.contentView viewWithTag:12321]);
//        [checkBox setSelectedIndexDidChange:^(NSInteger selectedIndex) {
//            [node.subNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                [obj setSelected:NO];
//            }];
//            GJOptionNode *selectedNode=node.subNodes[selectedIndex];
//            selectedNode.selected=YES;
//            node.selectedNode=selectedNode;
//            DLog(@"%@",node);
//            DLog(@"%@",node.subNodes[selectedIndex]);
//        }];
        __block NSInteger selectedIndex = 0; //[node.subNodes indexOfObject:node.selectedNode] != NSNotFound ? : 0;
        [node.subNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([node.selectedNode isEqual:obj]) {
                selectedIndex = idx;
            }
        }];
//        checkBox.currentSelectedIndex=selectedIndex;
//        NSArray *nodeTitles = [node.subNodes select:^id(GJOptionNode *target) {
//            return target.displayText;
//        }];
//        if (title.length == 2) {
//            title = [NSString stringWithFormat:@"%@       %@",[title substringWithRange:NSMakeRange(0, 1)],[title substringWithRange:NSMakeRange(1, 1)]];
//        }
//        else if (title.length == 3) {
//            title = [NSString stringWithFormat:@"%@  %@  %@",[title substringWithRange:NSMakeRange(0, 1)],[title substringWithRange:NSMakeRange(1, 1)],[title substringWithRange:NSMakeRange(2, 1)]];
//        }
//        ((UILabel *)[cell.contentView viewWithTag:112122]).text = title;
//        checkBox.itemTitles = nodeTitles;
    }
    else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
            UIImageView* bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 299, 52)];
            UIImageView* bgSelView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 299, 52)];
            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 299, 1)];
            if( indexPath.row == 0 )
            {
                bgView.image = [[UIImage imageNamed:@"更多框.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:22];
                bgSelView.image = [[UIImage imageNamed:@"点击灰色.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:3];
                lineView.image = [[UIImage imageNamed:@"更多框-封口.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:3];
            }
            else
            {
                bgView.image = [[UIImage imageNamed:@"更多框.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:22];
                bgSelView.image = [[UIImage imageNamed:@"点击灰色.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:3];
                lineView.image = [[UIImage imageNamed:@"更多框-封口.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:3];
            }
            cell.backgroundView = bgView;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            lineView.tag = 555;
            lineView.hidden = YES;
            [cell.contentView addSubview:lineView];
            UIImageView * bgLine = [[UIImageView alloc]initWithFrame:CGRectMake(1, 0, 80, cell.frame.size.height)];
            bgLine.image = [UIImage imageNamed:@"填写信息框-标题.png"];
            [cell.contentView addSubview:bgLine];

            // 创建cell左边筛选条件TitleLabel
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 43)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:14];
            titleLabel.textColor = [UIColor colorWithRed:133.0/255.0 green:171.0/255.0 blue:114.0/255.0 alpha:1.0];
            cell.detailTextLabel.textColor = cell.detailTextLabel.highlightedTextColor = [UIColor colorWithRed:0x33/255.0 green:0x33/255. blue:0x33/255. alpha:1.0];
            titleLabel.tag = 112120;
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:titleLabel];
            UILabel* textInput = [[UILabel alloc]initWithFrame:CGRectMake(97, (cell.frame.size.height-20)/2, 180, 20)];
            textInput.tag = 3000+indexPath.row;
            textInput.font = [UIFont boldSystemFontOfSize:14];
            textInput.textAlignment = UITextAlignmentLeft;
            textInput.backgroundColor = [UIColor clearColor];
            [cell addSubview:textInput];
            //add new state
            
            
            GJChooseButton *chooseBtn = [GJChooseButton buttonWithType:UIButtonTypeCustom];
            chooseBtn.tag = NSIntegerMax-1;
            chooseBtn.frame = CGRectMake(81, 2, cell.contentView.frame.size.width-105, cell.contentView.frame.size.height-4);
            [chooseBtn setStyles];
            [cell.contentView addSubview:chooseBtn];
            
        }
        //get buttton
        GJChooseButton *chooseBtn = (GJChooseButton *)[cell.contentView viewWithTag:NSIntegerMax-1];
        chooseBtn.tag = indexPath.row + 100;
        [chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *line = (UIImageView *)[cell.contentView viewWithTag:555];
        if (indexPath.row == self.rootNode.subNodes.count-1) {
            line.hidden = NO;
        }
        NSString *title = node.displayText;
        UILabel * labelInput = (UILabel*)[cell viewWithTag:3000+indexPath.row];
        NSString *selectedNodeText = node.selectedNode.displayText;
        if ([selectedNodeText isEqualToString:@"不限"] && ![node.selectedNode.superNode.displayText isEqualToString:title]) {
            labelInput.text = node.selectedNode.superNode.displayText;
        }
        else {
            labelInput.text = node.selectedNode.displayText;
        }
        if (title.length == 2) {
            title = [NSString stringWithFormat:@"%@       %@",[title substringWithRange:NSMakeRange(0, 1)],[title substringWithRange:NSMakeRange(1, 1)]];
        }
        else if (title.length == 3) {
            title = [NSString stringWithFormat:@"%@  %@  %@",[title substringWithRange:NSMakeRange(0, 1)],[title substringWithRange:NSMakeRange(1, 1)],[title substringWithRange:NSMakeRange(2, 1)]];
        }
        
        ((UILabel *)[cell.contentView viewWithTag:112120]).text = title;
    }
	return cell;

}
- (void)typeChanged:(id)sender {
//    CheckBox *checkBox = (CheckBox *)sender;
//    GJOptionNode *node=(GJOptionNode *)checkBox.checkValue;
//    node.selected=!node.selected;
//    if (node.selected && node.subNodes.count==2) {
//        node.selectedNode=[node.subNodes lastObject];
//    }
//    else {
//        node.selectedNode=nil;
//    }
}

- (void)chooseBtnAction:(GJChooseButton*)button
{/*
    NSInteger index=button.tag-100;
    DLog(@"%d",index);
    GJOptionNode *shownNode=self.notHideNodes[index];
    NSArray *nodes=shownNode.subNodes;
    NSMutableArray *tmpRows=[NSMutableArray arrayWithCapacity:nodes.count];
    NSMutableArray *hotNodes = [NSMutableArray arrayWithCapacity:20];
    [nodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        GJOptionNode *target=obj;
        GJOption *option=[[GJOption alloc] init];
        option.value=target.value;
        option.text=target.displayText;
        option.uuid = target.uuid;
        NSMutableArray *subOptions=[NSMutableArray arrayWithCapacity:target.subNodes.count];
        [target.subNodes enumerateObjectsUsingBlock:^(GJOptionNode *obj, NSUInteger idx, BOOL *stop) {
            GJOption *suboption=[[GJOption alloc] init];
            suboption.uuid = obj.uuid;
            suboption.value=[obj.value description];
            suboption.text=obj.displayText;
            [subOptions addObject:suboption];
        }];
        option.subOptions=subOptions;
        if ([target.userInfo[@"hot"] boolValue]) {
            [hotNodes addObject:option];
        }
        else {
            [tmpRows addObject:option];
        }
    }];
//    NSMutableArray *fullNodes = [NSMutableArray arrayWithArray:hotNodes];
//    [fullNodes addObjectsFromArray:tmpRows];
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(1, hotNodes.count)];
    [tmpRows insertObjects:hotNodes atIndexes:indexSet];
    GJOptionListView *optionListView=[[GJOptionListView alloc] initWithOptions:tmpRows withTitle:shownNode.displayText];
    optionListView.navigationController=self.navigationController;
    [optionListView setOptionDidSelect:^(NSInteger selectedIndex, GJOption *option) {
        DLog(@"%d",selectedIndex);
        DLog(@"%@",option.text);
        shownNode.selectedNode.selected = NO;
        shownNode.selectedNode.superNode.selected = NO;
        shownNode.selectedNode=nil;
        GJOptionNode *firstNode = nodes.firstObject; //判断选中的是不是不限
//        if ([option.text isEqualToString:firstNode.displayText] && [[option.value description] isEqualToString:[firstNode.value description]]) {
        if (option.uuid == firstNode.uuid) {
            firstNode.selected=YES;
            shownNode.selectedNode=firstNode;
        }
        else
        {
            [nodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                [obj setSelected:NO];
                GJOptionNode *n=obj;
                if (n.subNodes.count>1) {
                    [n.subNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger subidx, BOOL *stop) {
                        GJOptionNode *subSubNode=obj;
//                        if ([option.text isEqualToString:subSubNode.displayText] && [[option.value description] isEqualToString:[subSubNode.value description]]) {
                        if (option.uuid == subSubNode.uuid) {
                            subSubNode.selected=YES;
                            shownNode.selectedNode=subSubNode;
                        }
                        else
                        {
                            subSubNode.selected=NO;
                        }
                    }];
                }
                else {
//                    if ([option.text isEqualToString:n.displayText] && [[option.value description] isEqualToString:[n.value description]]) {
                    if (option.uuid == n.uuid) {
                        n.selected=YES;
                        shownNode.selectedNode=n;
                    }
                    else
                    {
                        n.selected=NO;
                    }
                }
            }];
        }
        [self.tableView reloadData];
        [[GJOptionSelector sharedInstance] dismissView];
    }];
    [optionListView setTitleButtonDidSelect:^(NSInteger tag) {
        if (tag==0) {
            [[GJOptionSelector sharedInstance] dismissView];
        }
    }];
    [[GJOptionSelector sharedInstance] presentModalView:optionListView upon:self.navigationController.view whenDismiss:nil];
*/
}

@end
