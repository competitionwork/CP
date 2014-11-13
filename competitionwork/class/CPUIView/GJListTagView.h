//
//  GJListTagView.h
//  HouseRent
//
//  Created by Tracy on 14-4-4.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJListTagView : UIView

@property (nonatomic, strong) NSArray *labelsData;

@property (nonatomic, assign) BOOL isFromDetail;

// 默认列表页
@property (nonatomic, assign) GJData_Type pageType;


+ (CGFloat)widthForListData:(NSArray *)labelData;
+ (CGFloat)widthForDetailData:(NSArray *)labelData;
@end
