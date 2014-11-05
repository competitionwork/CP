//
//  GJOptionNode.h
//  HouseRent
//
//  Created by liruiqin on 13-12-2.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJOptionNode : NSObject<NSCopying,NSMutableCopying,NSCoding>
+(instancetype)nodeWithText:(NSString*)title value:(NSString*)val;
+(instancetype)nodeWithText:(NSString*)title value:(NSString*)val subNodes:(NSArray*)sNodes superNode:(GJOptionNode*)superNode;
+(instancetype)nodeWithText:(NSString*)title value:(NSString*)val subNodes:(NSArray*)sNodes superNode:(GJOptionNode*)superNode userInfo:(NSDictionary*)uinfo selectedNode:(GJOptionNode*)selectedNode;

@property (nonatomic, copy) NSString *displayText;
@property (nonatomic ,strong) id value;
@property (nonatomic, weak) GJOptionNode *superNode;
@property (nonatomic, strong) NSArray *subNodes;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic, getter = isHide) BOOL hide;
@property (nonatomic,weak) GJOptionNode *selectedNode;
@property(nonatomic) NSUInteger uuid;

@end
