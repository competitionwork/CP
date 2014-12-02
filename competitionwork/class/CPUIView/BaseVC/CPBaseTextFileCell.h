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
} CPTEXEVIEMODEL;


@class CPBaseLabelCellModel;

@interface CPBaseTextFileCell : UIView
-(instancetype)initWithFrame:(CGRect)frame andEntity:(CPBaseLabelCellModel*)entity withModel:(CPTEXEVIEMODEL)model;
-(NSString *)textString;

@end

@interface CPBaseLabelCellModel : NSObject

@property (nonatomic, strong) NSString * pleceHolde;

@property (nonatomic, strong) UIImage * image;

@end
