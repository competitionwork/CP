//
//  GJOptionNode.m
//  HouseRent
//
//  Created by liruiqin on 13-12-2.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "GJOptionNode.h"

@implementation GJOptionNode
+(instancetype)nodeWithText:(NSString *)title value:(NSString *)val
{
    return [self nodeWithText:title value:val subNodes:nil superNode:nil userInfo:nil selectedNode:nil];
}
+(instancetype)nodeWithText:(NSString*)title value:(NSString*)val subNodes:(NSArray*)sNodes superNode:(GJOptionNode*)superNode
{
    return [self nodeWithText:title value:val subNodes:sNodes superNode:superNode userInfo:nil selectedNode:nil];
}
+(instancetype)nodeWithText:(NSString *)title value:(NSString *)val subNodes:(NSArray *)sNodes superNode:(GJOptionNode *)superNode userInfo:(NSDictionary *)uinfo selectedNode:(GJOptionNode *)selectedNode
{
    GJOptionNode *node=[[GJOptionNode alloc] init];
    node.displayText=title;
    node.value=val;
    node.subNodes=sNodes;
    node.superNode=superNode;
    node.userInfo=uinfo;
    node.selectedNode=selectedNode;
    return node;
}

-(id)init
{
    if (self=[super init]) {
        _uuid = arc4random();
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[self init]) {
        
        self.displayText = [aDecoder decodeObjectForKey:@"displayText"];
        self.value = [aDecoder decodeObjectForKey:@"value"];
        self.superNode = [aDecoder decodeObjectForKey:@"superNode"];
        self.subNodes = [aDecoder decodeObjectForKey:@"subNodes"];
        self.userInfo = [aDecoder decodeObjectForKey:@"userInfo"];
        self.selectedNode = [aDecoder decodeObjectForKey:@"selectedNode"];
        self.selected = [aDecoder decodeBoolForKey:@"selected"];
        self.hide = [aDecoder decodeBoolForKey:@"hide"];
        self.uuid = [aDecoder decodeInt64ForKey:@"uuid"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.displayText forKey:@"displayText"];
    [aCoder encodeObject:self.value forKey:@"value"];
    [aCoder encodeObject:self.superNode forKey:@"superNode"];
    [aCoder encodeObject:self.subNodes forKey:@"subNodes"];
    [aCoder encodeObject:self.userInfo forKey:@"userInfo"];
    [aCoder encodeObject:self.selectedNode forKey:@"selectedNode"];
    [aCoder encodeBool:self.selected forKey:@"selected"];
    [aCoder encodeBool:self.hide forKey:@"hide"];
    [aCoder encodeInt64:self.uuid forKey:@"uuid"];
}

-(BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:self.class]) {
        GJOptionNode *n=object;
        if ([[n.value description] isEqualToString:[self.value description]] && [n.displayText isEqualToString:self.displayText] ) {
            return YES;
        }
    }
    return NO;
}
-(void)setSelected:(BOOL)selected
{
    if (selected) {
        self.superNode.selected=YES;
    }
    _selected=selected;
}
-(void)setSubNodes:(NSArray *)subNodes
{
    _subNodes=subNodes;
    [_subNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[GJOptionNode class]]) {
            [obj setSuperNode:self];
        }
        else {
            [_subNodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:[GJOptionNode class]]) {
                    [obj setSuperNode:self];
                }
            }];
        }
    }];
}

-(id)copyWithZone:(NSZone *)zone
{
    GJOptionNode *copyNode=[[[self class] allocWithZone:zone] init];
    copyNode->_displayText=[_displayText copy];
    copyNode.selectedNode=[_selectedNode copy];
    copyNode->_subNodes=[_subNodes copy];
    copyNode->_superNode=[_superNode copy];
    copyNode->_selected=_selected;
    copyNode->_value=[_value copy];
    copyNode->_userInfo=[_userInfo copy];
    return copyNode;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"---->>:node:%@ -selected:%d  - value:%@ - selected node :%@ \r<<-----",self.displayText,self.isSelected,self.value,self.selectedNode.displayText];
}

@end
