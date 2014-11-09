//
//  filterManage.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-5.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "filterManage.h"
#import "GJOptionNode.h"

@implementation filterManage

-(NSArray*)returnFilterData{
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"CPfilters" ofType:@"plist"];
    
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray * array = dict[@"2"][@"filter"];
    
    return array;
    
}

#define mark Node的方法


- (NSArray *)nodesFromFilterData:(NSArray *)filterData
{
    
    filterData = @[@"type",@"leve",@"time"];
    
    NSInteger count=filterData.count;
    
    
    NSArray * arrayFiler = [self returnFilterData];
    
    
    NSMutableArray *nodeArray=[NSMutableArray arrayWithCapacity:count];
    for (int idx=0 ; idx < count; idx++) {
        __block GJOptionNode *tobeSelectedNode=nil;
        NSArray *filterItem=arrayFiler[idx][@"vs"];
        NSString *filterItemKey=filterData[idx];
        NSString *filterItemTitle=arrayFiler[idx][@"n"];
        NSDictionary *filterItemDictionary =arrayFiler[idx];
        __block NSString *filterItemValue = [filterItemDictionary[@"v"] description];
        
        
        NSArray *nodes = nil;
        
        nodes = [self nodeForNormalWithResult:filterItem withKeyName:filterItemKey withSelectedValue:filterItemValue];
        
        if (nodes.count>0) {
            for (GJOptionNode *tmpNode in nodes) {
                if (tmpNode.selected) {//找出默认选中的筛选项
                    tobeSelectedNode = tmpNode;
                    tobeSelectedNode.selected = YES;
                    [tmpNode.subNodes enumerateObjectsUsingBlock:^(GJOptionNode *obj, NSUInteger idx, BOOL *stop) {
                        if ([obj isSelected]) {
                            tobeSelectedNode = obj;
                            tobeSelectedNode.selected = YES;
                        }
                    }];
                }
            }
        }
        //服务器没有选中的筛选项,那么选中第一项
        if (!tobeSelectedNode) {
            GJOptionNode *node = nodes.firstObject;
            GJOptionNode *subNode = node.subNodes.firstObject;
            if (subNode) {
                tobeSelectedNode = subNode;
            }
            else {
                tobeSelectedNode = node;
            }
        }
        tobeSelectedNode.selected = YES;
        GJOptionNode *node=[GJOptionNode nodeWithText:filterItemTitle value:filterItemKey];
        node.selectedNode=tobeSelectedNode;
        node.subNodes=nodes;
        
        [nodeArray addObject:node];
    }
    return nodeArray;
}

- (NSArray *)nodeForNormalWithResult:(NSArray *)nodeArray withKeyName:(NSString *)kName withSelectedValue:(NSString *)sValue
{
    if([sValue isEqualToString:@"-1"]) {
        sValue = @"不限的值";
    }
    GJOptionNode *(^makeBuxianNode)(NSString *kn)=^(NSString *kName){
        GJOptionNode *znode=[[GJOptionNode alloc] init];
        NSDictionary *valueDic=[self nodeValueWithKeyName:kName operationKey:@"=" valueIndex:@"-1"];
        znode.value=valueDic;
        znode.displayText=@"不限";
        return znode;
    };
    GJOptionNode *(^makeMultiBuxianNode)(NSString *kn,BOOL multi)=^(NSString *kName,BOOL multi){
        GJOptionNode *znode=makeBuxianNode(kName);
        if (multi) {
            GJOptionNode *sNode = makeBuxianNode(kName);
            znode.subNodes = @[sNode];
        }
        return znode;
    };
    BOOL multiLevel =  [[nodeArray.lastObject objectForKey:@"c"] count] > 0;
    NSMutableArray *nodes=[NSMutableArray arrayWithCapacity:nodeArray.count];
    
    [nodeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *nodeDic=obj;
        GJOptionNode *node=[[GJOptionNode alloc] init];
        NSString *nodeValue=nodeDic[@"v"];
        NSString *text=nodeDic[@"n"];
        NSString *kn = nodeDic[@"f"]?:kName;
        NSDictionary *valueDic=[self nodeValueWithKeyName:kn operationKey:@"=" valueIndex:nodeValue];
        node.value=valueDic;
        node.displayText=text;
        NSArray *subNodeArray=nodeDic[@"c"];
        node.userInfo=nodeDic;
        NSMutableArray *subNodes=[NSMutableArray arrayWithCapacity:subNodeArray.count];
        [subNodeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger sidx, BOOL *stop) { //解析c数组
            NSDictionary *sDic=obj;
            GJOptionNode *subNode=[[GJOptionNode alloc] init];
            NSString *subnodeValue=sDic[@"v"];
            NSString *sText=sDic[@"n"];
            NSString *kn = sDic[@"f"]?:kName;
            NSDictionary *valueDic=[self nodeValueWithKeyName:kn operationKey:@"=" valueIndex:subnodeValue];
            subNode.value=valueDic;
            subNode.displayText=sText;
            subNode.userInfo=sDic;
            if ([subnodeValue isEqualToString:sValue]) {
                subNode.selected = YES;
            }
            [subNodes addObject:subNode];
        }];
        GJOptionNode *subFirstNode = subNodes.firstObject;
        if (![[subFirstNode.userInfo[@"v"] description] isEqualToString:@"-1"] && multiLevel) {
            [subNodes insertObject:makeBuxianNode(kName) atIndex:0];
        }
        if ([[nodeValue description] isEqualToString:sValue]) {
            node.selected = YES;
        }
        node.subNodes=subNodes;
        [nodes addObject:node];
    }];
    GJOptionNode *firstNode = nodes.firstObject;
    if (![firstNode.userInfo[@"v"] isEqualToString:@"-1"] && ![firstNode.displayText isEqualToString:@"不限"] && [firstNode.value isKindOfClass:[NSDictionary class]] && ![firstNode.value[@"name"] isEqualToString:@"latlng"]) {
        [nodes insertObject:makeMultiBuxianNode(kName,multiLevel) atIndex:0];
    }
    return nodes;
}

- (NSDictionary *)nodeValueWithKeyName:(NSString *)kName operationKey:(NSString *)oKey valueIndex:(NSString *)value
{
    NSString *theName=kName?:@"";
    NSString *theOperation=oKey?:@"=";
    NSString *theVal=value?:@"";
    NSDictionary *valueDic=@{@"name":theName,@"operator":theOperation,@"value":theVal};
    return valueDic;
}


@end
