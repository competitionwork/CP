//
//  CPBaseTextFileCell.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    CPTEXEVIEWUP,
    CPTEXEVIEWDOWN,
    CPTEXEVIEWMIN,
    CPTEXEVIEWONE,
    CPTEXEVIEWEMPTY,
} CPTEXEVIEMODEL;


@class CPBaseLabelCellModel;

@interface CPBaseTextFileCell : UIView

@property (nonatomic, strong) UIView* bottomBorder;

@property(nonatomic,getter = isHiddenBottomBorder) BOOL hiddenBottomBorder;
@property(nonatomic,getter = isHiddenTopBorder) BOOL hiddenTopBorder;
@property(nonatomic,getter = isHiddenDownBorder) BOOL hiddenDownBorder;

-(instancetype)initWithFrame:(CGRect)frame andEntity:(CPBaseLabelCellModel*)entity withModel:(CPTEXEVIEMODEL)model;
-(NSString *)textString;
-(void)setTextFontMunber:(int)number;


@end

@interface CPBaseLabelCellModel : NSObject

@property (nonatomic, strong) NSString * pleceHolde;

@property (nonatomic, strong) UIImage * image;

@end
