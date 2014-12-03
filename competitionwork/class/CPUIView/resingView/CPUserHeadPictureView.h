//
//  CPUserHeadPictureView.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-3.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HeadBlock)(UIImageView * image);

@interface CPUserHeadPictureView : UIView

@property (nonatomic,copy) HeadBlock Block;

-(UIImageView*)getHeadView;

-(void)setHeadWithImage:(UIImage*)image;

-(void)startAnimating;

-(void)stopAnimating;



@end
