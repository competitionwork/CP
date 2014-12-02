//
//  CPBaseLoginView.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-23.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

typedef enum {
    CPTEXEVIEWUP,
    CPTEXEVIEWDOWN,
    CPTEXEVIEWMIN,
    CPTEXEVIEWONE,
} CPTEXEVIEMODEL;

#import <UIKit/UIKit.h>

@class CPBaseLoginViewModel;

@interface CPBaseLoginView : UIView

-(instancetype)initWithFrame:(CGRect)frame andEntity:(CPBaseLoginViewModel*)entity withModel:(CPTEXEVIEMODEL)model;
-(NSString *)textString;


@end




@interface CPBaseLoginViewModel : NSObject

@property (nonatomic, strong) NSString * pleceHolde;

@property (nonatomic, strong) UIImage * image;

@end
