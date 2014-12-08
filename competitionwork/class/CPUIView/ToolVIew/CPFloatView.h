//
//  CPFloatView.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-8.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPFloatView : UIImageView

-(id)initWithFrame:(CGRect)frame withMessage:(NSString*)message;
-(void)showInView:(UIView *)baseView;

@end

