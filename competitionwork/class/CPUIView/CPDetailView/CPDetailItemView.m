//
//  CPDetailItemView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-14.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPDetailItemView.h"
#import "UIView+Addition.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#define InfoColor [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0f]
#define OrangeColor [UIColor colorWithRed:0xf7/255.0 green:0x7f/255.0 blue:0x00/255.0 alpha:1.0f]
#define GreenColor [UIColor colorWithRed:85/255.0 green:187/255.0 blue:34/255.0 alpha:1.0f]
#define BlackColor [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0f]

@implementation CPDetailItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation CPPostDetailAttrsView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 0)]) {
        
        self.backgroundColor = GJColor(255, 255, 255, 1);
        if (dataDict && [dataDict count] > 0) {
            
            int height = 13;
            
            NSArray *attrArray = [dataDict objectForKey:@"attr"];
            
            int i = 0;
            
            
            for (NSDictionary *attrDict in attrArray) {
                
                NSString *value = (NSString *)[attrDict allValues][0];
                NSString *key = (NSString *)[attrDict allKeys][0];
                UILabel *laName = [[UILabel alloc] initWithFrame:CGRectMake(13, height, 75, 28)] ;
                [laName setTextColor:GrayColor];
                [laName setFont:[UIFont systemFontOfSize:14]];
                [laName setText:key];
                [laName sizeToFit];
                laName.backgroundColor = [UIColor clearColor];
                [self addSubview:laName];
                
                UILabel *laValue = [[UILabel alloc] initWithFrame:CGRectMake(90, height, 200, 28)] ;
                [laValue setFont:[UIFont systemFontOfSize:14]];
                [laValue setText:value];
                [laValue setTextColor:BlackColor];
                [laValue setNumberOfLines:0];
                [laValue setLineBreakMode:UILineBreakModeWordWrap];
                laValue.backgroundColor = [UIColor clearColor];
                [self addSubview:laValue];
                [laValue sizeToFit];
                height += laValue.height + 10;
                
                i++;
            }
            
            height = height - 10 + 13;
            
            self.height = height;
        }
        
        
    }
    return self;
}

@end

@implementation CPDetailEntersView



-(instancetype)initWithData:(NSArray *)dataDict{
    if (self = [super initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100)]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.EntersDict = dataDict;
        
        _labelNumber = [[UILabel alloc]init];
        
        _labelNumber.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_labelNumber];
        
        UILabel * moreLabel = [[UILabel alloc]init];
        
        moreLabel.text = @"查看更多";
        
        moreLabel.font = [UIFont systemFontOfSize:12];
        
        moreLabel.textColor = kCPBlueColor;
        
        [moreLabel sizeToFit];
        
        [self addSubview:moreLabel];
        
        [[moreLabel.po_frameBuilder alignToTopInSuperviewWithInset:8]alignRightInSuperviewWithInset:8];
        
        
    }
    return self;
}

-(void)layoutSubviews{
    
    _labelNumber.text =  [NSString stringWithFormat:@"已经报名参加%lu个人",(unsigned long)self.EntersDict.count];
    [_labelNumber sizeToFit];
    [[_labelNumber.po_frameBuilder alignToTopInSuperviewWithInset:8]alignLeftInSuperviewWithInset:8];
    
    [self.EntersDict enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView * imageFace = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        NSString * url = self.EntersDict[idx][@"avatar"];
        [imageFace setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
        
        [self addSubview:imageFace];
        
        imageFace.layer.masksToBounds = YES;
        imageFace.layer.cornerRadius = 25.0;
        
        [[imageFace.po_frameBuilder alignToTopInSuperviewWithInset:35] setX:8+(imageFace.width + 8) * idx];
        
    }];
    
}



@end























